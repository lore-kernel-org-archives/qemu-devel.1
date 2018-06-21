Received: from eggs.gnu.org ([2001:4830:134:3::10]:50777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fW09Q-0002K5-3w
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fW09N-0003Tz-18
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:01:28 -0400
References: <20180620100825.22476-1-david@redhat.com>
	<20180620100825.22476-6-david@redhat.com>
	<0544e011-e909-6bca-e4ca-5a1caa141f4b@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <051d6c6f-13c9-589e-a8f9-cf1439f3b751@redhat.com>
Date: Thu, 21 Jun 2018 16:01:22 +0200
MIME-Version: 1.0
In-Reply-To: <0544e011-e909-6bca-e4ca-5a1caa141f4b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/7] s390x/tcg: implement SET CLOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 21.06.2018 15:14, Thomas Huth wrote:
> On 20.06.2018 12:08, David Hildenbrand wrote:
>> This allows a guest to change its TOD. We already take care of updatin=
g
>> all CKC timers from within S390TODClass.
>>
>> Use MO_ALIGN to load the operand manually - this will properly trigger=
 a
>> SPECIFICATION exception.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/helper.h      |  1 +
>>  target/s390x/insn-data.def |  3 +--
>>  target/s390x/misc_helper.c | 19 +++++++++++++++++++
>>  target/s390x/translate.c   |  9 +++++++++
>>  4 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
>> index 59cba86a27..97c60ca7bc 100644
>> --- a/target/s390x/helper.h
>> +++ b/target/s390x/helper.h
>> @@ -127,6 +127,7 @@ DEF_HELPER_4(diag, void, env, i32, i32, i32)
>>  DEF_HELPER_3(load_psw, noreturn, env, i64, i64)
>>  DEF_HELPER_FLAGS_2(spx, TCG_CALL_NO_RWG, void, env, i64)
>>  DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
>> +DEF_HELPER_FLAGS_2(sck, TCG_CALL_NO_RWG, i32, env, i64)
>>  DEF_HELPER_FLAGS_2(sckc, TCG_CALL_NO_RWG, void, env, i64)
>>  DEF_HELPER_FLAGS_2(sckpf, TCG_CALL_NO_RWG, void, env, i64)
>>  DEF_HELPER_FLAGS_1(stckc, TCG_CALL_NO_RWG, i64, env)
>> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
>> index 157619403d..5c6f33ed9c 100644
>> --- a/target/s390x/insn-data.def
>> +++ b/target/s390x/insn-data.def
>> @@ -997,8 +997,7 @@
>>  /* SET ADDRESS SPACE CONTROL FAST */
>>      C(0xb279, SACF,    S,     Z,   0, a2, 0, 0, sacf, 0)
>>  /* SET CLOCK */
>> -    /* ??? Not implemented - is it necessary? */
>> -    C(0xb204, SCK,     S,     Z,   0, 0, 0, 0, 0, 0)
>> +    C(0xb204, SCK,     S,     Z,   la2, 0, 0, 0, sck, 0)
>>  /* SET CLOCK COMPARATOR */
>>      C(0xb206, SCKC,    S,     Z,   0, m2_64a, 0, 0, sckc, 0)
>>  /* SET CLOCK PROGRAMMABLE FIELD */
>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>> index d5f9f5e1d3..c9712b9476 100644
>> --- a/target/s390x/misc_helper.c
>> +++ b/target/s390x/misc_helper.c
>> @@ -191,6 +191,25 @@ void tcg_s390_tod_updated(CPUState *cs, run_on_cp=
u_data opaque)
>>      helper_sckc(env, env->ckc);
>>  }
>> =20
>> +/* Set Clock */
>> +uint32_t HELPER(sck)(CPUS390XState *env, uint64_t tod_low)
>> +{
>> +    S390TODState *td =3D s390_get_tod();
>> +    S390TODClass *tdc =3D S390_TOD_GET_CLASS(td);
>> +    S390TOD tod =3D {
>> +        .high =3D 0,
>> +        .low =3D tod_low,
>> +    };
>> +    Error *err =3D NULL;
>> +
>> +    qemu_mutex_lock_iothread();
>> +    tdc->set(td, &tod, &err);
>> +    qemu_mutex_unlock_iothread();
>> +    g_assert(!err);
>=20
> I know it currently can't happen, but still, I think it would be nicer
> to use CC3 to tell the guest that something went wrong with the clock,
> instead of abort QEMU here.

Hmm, I thing I should either use error_abort here or do what you suggest.

However, CC=3D3 means "Clock in not-operational state".

And this implies that also STORE CLOCK and friends will have to fail and
that we have to present a machine check. Especially, once we would
implement the TOD-clock steering facility, CC=3D3 would not apply anymore=
.

So instead of faking something that is not architecturally correct, I
think we really should just quit QEMU, as we expect this to never fail.


>=20
>  Thomas
>=20


--=20

Thanks,

David / dhildenb
