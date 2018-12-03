Received: from eggs.gnu.org ([2001:4830:134:3::10]:58526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTpEO-0002O6-JW
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTpEL-0000iN-TL
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:29:52 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTpEL-0000hs-Me
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:29:49 -0500
Received: by mail-oi1-x243.google.com with SMTP id a77so11030987oii.5
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 06:29:49 -0800 (PST)
References: <20181130192216.26987-1-richard.henderson@linaro.org>
	<20181130192216.26987-3-richard.henderson@linaro.org>
	<34711f80-1959-32e0-e4e9-d22e003a5636@redhat.com>
	<75253fd5-7c6a-5a8e-fc18-14534a50bd03@linaro.org>
	<6895cef5-646a-8e51-2493-75b7805d33b0@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef698cec-f0b4-3775-3313-b26b95267599@linaro.org>
Date: Mon, 3 Dec 2018 08:29:45 -0600
MIME-Version: 1.0
In-Reply-To: <6895cef5-646a-8e51-2493-75b7805d33b0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-4.0 2/2] target/s390x:
 Implement STCK et al for CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com

On 12/3/18 8:02 AM, Thomas Huth wrote:
> On 2018-12-03 14:27, Richard Henderson wrote:
>> On 12/3/18 12:19 AM, Thomas Huth wrote:
>>> On 2018-11-30 20:22, Richard Henderson wrote:
>>>> This is a non-privileged instruction that was only implemented
>>>> for system mode.  However, the stck instruction is used by glibc,
>>>> so this was causing SIGILL for programs run under debian stretch.
>>>>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>  target/s390x/helper.h      |  2 +-
>>>>  target/s390x/misc_helper.c | 13 ++++++++++++-
>>>>  target/s390x/translate.c   |  2 ++
>>>>  target/s390x/insn-data.def | 11 ++++++-----
>>>>  4 files changed, 21 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
>>>> index 018e9dd414..6260b50496 100644
>>>> --- a/target/s390x/helper.h
>>>> +++ b/target/s390x/helper.h
>>>> @@ -121,13 +121,13 @@ DEF_HELPER_4(cu41, i32, env, i32, i32, i32)
>>>>  DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
>>>>  DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
>>>>  DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
>>>> +DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
>>>>  
>>>>  #ifndef CONFIG_USER_ONLY
>>>>  DEF_HELPER_3(servc, i32, env, i64, i64)
>>>>  DEF_HELPER_4(diag, void, env, i32, i32, i32)
>>>>  DEF_HELPER_3(load_psw, noreturn, env, i64, i64)
>>>>  DEF_HELPER_FLAGS_2(spx, TCG_CALL_NO_RWG, void, env, i64)
>>>> -DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
>>>>  DEF_HELPER_FLAGS_2(sck, TCG_CALL_NO_RWG, i32, env, i64)
>>>>  DEF_HELPER_FLAGS_2(sckc, TCG_CALL_NO_RWG, void, env, i64)
>>>>  DEF_HELPER_FLAGS_2(sckpf, TCG_CALL_NO_RWG, void, env, i64)
>>>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>>>> index 3f91579570..c2940afecb 100644
>>>> --- a/target/s390x/misc_helper.c
>>>> +++ b/target/s390x/misc_helper.c
>>>> @@ -76,8 +76,19 @@ uint64_t HELPER(stpt)(CPUS390XState *env)
>>>>  #endif
>>>>  }
>>>>  
>>>> -#ifndef CONFIG_USER_ONLY
>>>> +#ifdef CONFIG_USER_ONLY
>>>> +/* Store Clock */
>>>> +uint64_t HELPER(stck)(CPUS390XState *env)
>>>> +{
>>>> +    struct timespec ts;
>>>> +    uint64_t ms;
>>>
>>> May I suggest "us" for microseconds? "ms" makes me thing of
>>> "milliseconds"...
>>
>> Oops, think-o.
>>
>>>> +    clock_gettime(CLOCK_REALTIME, &ts);
>>>> +    ms = (ts.tv_nsec / 1000) + (ts.tv_sec * 100000ull);
>>>> +
>>>> +    return TOD_UNIX_EPOCH + ms;
>>>> +}
>>>
>>> Don't you need to shift the value around a little bit for getting the
>>> right format of the TOD clock? The microseconds are not starting with
>>> the lowest bit, the TOD clock has a higher resolution. See also the
>>> time2tod() macro in include/hw/s390x/tod.h ...
>>
>> That's for STCKE, which does use this routine and shift the result around.
> 
> STCKE certainly has even more bits ... but still, according to the PoP:
> 
> "The TOD clock nominally is incremented by adding a
> one in bit position 51 every microsecond."

I don't see that language within the description of STCK.  Perhaps it's
elsewhere in the PoO.  However you are right because STCK says "bit position 31
of the clock is incremented every 1.048576 seconds", and that amounts to
exactly the same thing.

Probably I should clean up STCKE at the same time, since it only wants a left
shift of 4 bits instead of 12...


r~
