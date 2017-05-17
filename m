Received: from eggs.gnu.org ([2001:4830:134:3::10]:39708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dAtEm-0001hh-5V
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dAtEl-0003Dl-3i
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dAtEk-0003Dh-RC
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:19:11 -0400
References: <1494926884-10118-1-git-send-email-thuth@redhat.com>
	<20170516134202.boib4gasiq5itt56@aurel32.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0162f2c6-cb77-91ff-f77a-f03b27a7c1d1@redhat.com>
Date: Wed, 17 May 2017 09:18:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170516134202.boib4gasiq5itt56@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] target/s390x: Add support for the TEST
 BLOCK instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, mmarek@suse.com, mbenes@suse.cz, David Hildenbrand <david@redhat.com>

On 16.05.2017 15:42, Aurelien Jarno wrote:
> On 2017-05-16 11:28, Thomas Huth wrote:
>> TEST BLOCK was likely once used to execute basic memory
>> tests, but nowadays it's just a (slow) way to clear a page.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  target/s390x/helper.h      |  1 +
>>  target/s390x/insn-data.def |  2 ++
>>  target/s390x/mem_helper.c  | 12 ++++++++++++
>>  target/s390x/translate.c   | 10 ++++++++++
>>  4 files changed, 25 insertions(+)
>>
>> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
>> index 9102071..a5a3705 100644
>> --- a/target/s390x/helper.h
>> +++ b/target/s390x/helper.h
>> @@ -99,6 +99,7 @@ DEF_HELPER_FLAGS_4(lctl, TCG_CALL_NO_WG, void, env, =
i32, i64, i32)
>>  DEF_HELPER_FLAGS_4(lctlg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>>  DEF_HELPER_FLAGS_4(stctl, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>>  DEF_HELPER_FLAGS_4(stctg, TCG_CALL_NO_WG, void, env, i32, i64, i32)
>> +DEF_HELPER_2(testblock, void, env, i64)
>>  DEF_HELPER_FLAGS_2(tprot, TCG_CALL_NO_RWG, i32, i64, i64)
>>  DEF_HELPER_FLAGS_2(iske, TCG_CALL_NO_RWG_SE, i64, env, i64)
>>  DEF_HELPER_FLAGS_3(sske, TCG_CALL_NO_RWG, void, env, i64, i64)
>> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
>> index 075ff59..a6aba54 100644
>> --- a/target/s390x/insn-data.def
>> +++ b/target/s390x/insn-data.def
>> @@ -912,6 +912,8 @@
>>  /* STORE USING REAL ADDRESS */
>>      C(0xb246, STURA,   RRE,   Z,   r1_o, r2_o, 0, 0, stura, 0)
>>      C(0xb925, STURG,   RRE,   Z,   r1_o, r2_o, 0, 0, sturg, 0)
>> +/* TEST BLOCK */
>> +    C(0xb22c, TB,      RRE,   Z,   0, r2_o, 0, 0, testblock, 0)
>>  /* TEST PROTECTION */
>>      C(0xe501, TPROT,   SSE,   Z,   la1, a2, 0, 0, tprot, 0)
>> =20
>> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
>> index 675aba2..0349c10 100644
>> --- a/target/s390x/mem_helper.c
>> +++ b/target/s390x/mem_helper.c
>> @@ -933,6 +933,18 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r=
1, uint64_t a2, uint32_t r3)
>>      }
>>  }
>> =20
>> +void HELPER(testblock)(CPUS390XState *env, uint64_t addr)
>> +{
>> +    CPUState *cs =3D CPU(s390_env_get_cpu(env));
>> +    int i;
>> +
>> +    addr =3D get_address(env, 0, 0, addr) & ~0xfffULL;
>=20
> I guess you want to use ~TARGET_PAGE_MASK here.

Yes, that's better, thanks!

>> +    for (i =3D 0; i < TARGET_PAGE_SIZE; i +=3D 8) {
>> +        stq_phys(cs->as, addr + i, 0);
>> +    }
>> +    env->cc_op =3D 0;
>> +}
>> +
>=20
> From what I understand the resulting condition code should depends if
> the block is usable or not. Shouldn't there be a check to see if the
> address actually targets the RAM?

I just tried it under z/VM and KVM, and in case you specify an address
that does not point to valid RAM, you get an addressing exception
instead. So the CC=3D1 case was rather meant for memory blocks of valid
RAM which contain uncorrectable bit flip errors or something like that.
That does not make much sense for emulation, so CC=3D0 is the only useful
code that we can return here. But of course I've also got to add a check
for valid RAM and return an addressing exception here now, too...

 Thomas
