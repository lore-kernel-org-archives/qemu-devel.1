Received: from eggs.gnu.org ([2001:4830:134:3::10]:58512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gToIg-0006mi-ME
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 08:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gToIc-0005oG-Nj
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 08:30:14 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gToIb-0005n7-9Y
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 08:30:10 -0500
Received: by mail-oi1-x241.google.com with SMTP id u18so10849418oie.10
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 05:30:09 -0800 (PST)
References: <20181130192216.26987-1-richard.henderson@linaro.org>
	<20181130192216.26987-3-richard.henderson@linaro.org>
	<cf30fb27-a5a3-6614-1053-351ffc8555c3@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ddd320c8-d637-906a-9477-21c72726cbc0@linaro.org>
Date: Mon, 3 Dec 2018 07:30:05 -0600
MIME-Version: 1.0
In-Reply-To: <cf30fb27-a5a3-6614-1053-351ffc8555c3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, qemu-s390x@nongnu.org

On 12/3/18 4:21 AM, David Hildenbrand wrote:
> On 30.11.18 20:22, Richard Henderson wrote:
>> This is a non-privileged instruction that was only implemented
>> for system mode.  However, the stck instruction is used by glibc,
>> so this was causing SIGILL for programs run under debian stretch.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/s390x/helper.h      |  2 +-
>>  target/s390x/misc_helper.c | 13 ++++++++++++-
>>  target/s390x/translate.c   |  2 ++
>>  target/s390x/insn-data.def | 11 ++++++-----
>>  4 files changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
>> index 018e9dd414..6260b50496 100644
>> --- a/target/s390x/helper.h
>> +++ b/target/s390x/helper.h
>> @@ -121,13 +121,13 @@ DEF_HELPER_4(cu41, i32, env, i32, i32, i32)
>>  DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
>>  DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
>>  DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
>> +DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
>>  
>>  #ifndef CONFIG_USER_ONLY
>>  DEF_HELPER_3(servc, i32, env, i64, i64)
>>  DEF_HELPER_4(diag, void, env, i32, i32, i32)
>>  DEF_HELPER_3(load_psw, noreturn, env, i64, i64)
>>  DEF_HELPER_FLAGS_2(spx, TCG_CALL_NO_RWG, void, env, i64)
>> -DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
>>  DEF_HELPER_FLAGS_2(sck, TCG_CALL_NO_RWG, i32, env, i64)
>>  DEF_HELPER_FLAGS_2(sckc, TCG_CALL_NO_RWG, void, env, i64)
>>  DEF_HELPER_FLAGS_2(sckpf, TCG_CALL_NO_RWG, void, env, i64)
>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>> index 3f91579570..c2940afecb 100644
>> --- a/target/s390x/misc_helper.c
>> +++ b/target/s390x/misc_helper.c
>> @@ -76,8 +76,19 @@ uint64_t HELPER(stpt)(CPUS390XState *env)
>>  #endif
>>  }
>>  
>> -#ifndef CONFIG_USER_ONLY
>> +#ifdef CONFIG_USER_ONLY
>> +/* Store Clock */
>> +uint64_t HELPER(stck)(CPUS390XState *env)
>> +{
>> +    struct timespec ts;
>> +    uint64_t ms;
>>  
>> +    clock_gettime(CLOCK_REALTIME, &ts);
>> +    ms = (ts.tv_nsec / 1000) + (ts.tv_sec * 100000ull);
>> +
>> +    return TOD_UNIX_EPOCH + ms;
> 
> In theory, the TOD can be completely controlled by the operating system
> (e.g. set the TOD to X). So for user space, there isn't really any
> guarantee about the values returned via stck.
> 
> E.g. in the PoP 4-51:
> 
> "4. A program using the clock value as a time-of-day
> and calendar indication must be consistent with
> the programming support under which the pro-
> gram is to be executed. [...]"

Ok, but then there's the matter of the CC result.  We currently hard-code this
as 0, meaning "clock is set", meaning it does have the real TOD value.

We could set CC as 1, meaning "clock is not set", meaning the value is only
good for relative computation.

Is this perhaps a bug in our system implementation as well?

What CC value is provided to userspace on real hardware?


r~
