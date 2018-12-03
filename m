Received: from eggs.gnu.org ([2001:4830:134:3::10]:36428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gTpWQ-0007zM-I0
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gTpWM-000826-5X
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:48:30 -0500
References: <20181130192216.26987-1-richard.henderson@linaro.org>
	<20181130192216.26987-3-richard.henderson@linaro.org>
	<cf30fb27-a5a3-6614-1053-351ffc8555c3@redhat.com>
	<ddd320c8-d637-906a-9477-21c72726cbc0@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2b5c79bb-bd2d-09a4-a785-2297f394a87c@redhat.com>
Date: Mon, 3 Dec 2018 15:48:22 +0100
MIME-Version: 1.0
In-Reply-To: <ddd320c8-d637-906a-9477-21c72726cbc0@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 2/2] target/s390x: Implement STCK
 et al for CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, qemu-s390x@nongnu.org

On 03.12.18 14:30, Richard Henderson wrote:
> On 12/3/18 4:21 AM, David Hildenbrand wrote:
>> On 30.11.18 20:22, Richard Henderson wrote:
>>> This is a non-privileged instruction that was only implemented
>>> for system mode.  However, the stck instruction is used by glibc,
>>> so this was causing SIGILL for programs run under debian stretch.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  target/s390x/helper.h      |  2 +-
>>>  target/s390x/misc_helper.c | 13 ++++++++++++-
>>>  target/s390x/translate.c   |  2 ++
>>>  target/s390x/insn-data.def | 11 ++++++-----
>>>  4 files changed, 21 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
>>> index 018e9dd414..6260b50496 100644
>>> --- a/target/s390x/helper.h
>>> +++ b/target/s390x/helper.h
>>> @@ -121,13 +121,13 @@ DEF_HELPER_4(cu41, i32, env, i32, i32, i32)
>>>  DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
>>>  DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
>>>  DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
>>> +DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
>>> =20
>>>  #ifndef CONFIG_USER_ONLY
>>>  DEF_HELPER_3(servc, i32, env, i64, i64)
>>>  DEF_HELPER_4(diag, void, env, i32, i32, i32)
>>>  DEF_HELPER_3(load_psw, noreturn, env, i64, i64)
>>>  DEF_HELPER_FLAGS_2(spx, TCG_CALL_NO_RWG, void, env, i64)
>>> -DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
>>>  DEF_HELPER_FLAGS_2(sck, TCG_CALL_NO_RWG, i32, env, i64)
>>>  DEF_HELPER_FLAGS_2(sckc, TCG_CALL_NO_RWG, void, env, i64)
>>>  DEF_HELPER_FLAGS_2(sckpf, TCG_CALL_NO_RWG, void, env, i64)
>>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>>> index 3f91579570..c2940afecb 100644
>>> --- a/target/s390x/misc_helper.c
>>> +++ b/target/s390x/misc_helper.c
>>> @@ -76,8 +76,19 @@ uint64_t HELPER(stpt)(CPUS390XState *env)
>>>  #endif
>>>  }
>>> =20
>>> -#ifndef CONFIG_USER_ONLY
>>> +#ifdef CONFIG_USER_ONLY
>>> +/* Store Clock */
>>> +uint64_t HELPER(stck)(CPUS390XState *env)
>>> +{
>>> +    struct timespec ts;
>>> +    uint64_t ms;
>>> =20
>>> +    clock_gettime(CLOCK_REALTIME, &ts);
>>> +    ms =3D (ts.tv_nsec / 1000) + (ts.tv_sec * 100000ull);
>>> +
>>> +    return TOD_UNIX_EPOCH + ms;
>>
>> In theory, the TOD can be completely controlled by the operating syste=
m
>> (e.g. set the TOD to X). So for user space, there isn't really any
>> guarantee about the values returned via stck.
>>
>> E.g. in the PoP 4-51:
>>
>> "4. A program using the clock value as a time-of-day
>> and calendar indication must be consistent with
>> the programming support under which the pro-
>> gram is to be executed. [...]"
>=20
> Ok, but then there's the matter of the CC result.  We currently hard-co=
de this
> as 0, meaning "clock is set", meaning it does have the real TOD value.

Don't worry about cc/clock state handling. This is handling of old
machine generations and will not happen on real machines nowadays (as
far as I am aware). Clocks are always operating. CC is always 0.

"Not-Set State: When the power for the clock is
turned on, the clock is set to zero, and the clock
enters the not-set state. The clock is incremented
when in the not-set state. When the TOD-clock-steer-
ing facility is installed, the TOD clock is never
reported to be in the not-set state, as the TOD clock
is placed in the set state as part of the initial-
machine-loading (IML) process."

So this is really only handling for operating systems that want to get
the real time from the TOD (because with CC=3D1, the TOD would not match
an actual date). Not for user space! And not for recent machine generatio=
ns.

When the OS changes the tod (set clock), the TOD will still be in "set
state". User space has no guarantees here.

>=20
> We could set CC as 1, meaning "clock is not set", meaning the value is =
only
> good for relative computation.
>=20
> Is this perhaps a bug in our system implementation as well?

Don't think so, returning always 0 should be fine.

>=20
> What CC value is provided to userspace on real hardware?

It will always see CC=3D0 as far as I know.

E.g. in KVM, after migration the guest TOD might differ to the actual
system TOD. But we will still get CC=3D0.

CC !=3D 0 is a relict from the past.

I guess the important part here is not to confuse "CC=3D=3D0" with "the T=
OD
is synced to time source X". It is just internal state handling for
bringing up the clock source + error handling.

>=20
>=20
> r~
>=20


--=20

Thanks,

David / dhildenb
