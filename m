Received: from eggs.gnu.org ([2001:4830:134:3::10]:48096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOlQ2-0004nu-G4
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOlPz-0003z0-DJ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:52:42 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:39466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOlPz-0003yS-6B
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:52:39 -0400
Received: by mail-pg0-x243.google.com with SMTP id w12-v6so10172970pgc.6
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 07:52:38 -0700 (PDT)
References: <20180601073050.8054-1-richard.henderson@linaro.org>
	<20180601073050.8054-2-richard.henderson@linaro.org>
	<caf6dd92-f5b5-b94b-708a-084c76f5ab46@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3670898b-e2a2-912d-4813-ff615eb42f52@linaro.org>
Date: Fri, 1 Jun 2018 07:52:34 -0700
MIME-Version: 1.0
In-Reply-To: <caf6dd92-f5b5-b94b-708a-084c76f5ab46@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/33] linux-user: Split out do_syscall1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu

On 06/01/2018 07:00 AM, Eric Blake wrote:
> On 06/01/2018 02:30 AM, Richard Henderson wrote:
>> There was supposed to be a single point of return for do_syscall
>> so that tracing works properly.  However, there are a few bugs
>> in that area.  It is significantly simpler to simply split out
>> an inner function to enforce this.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/syscall.c | 89 +++++++++++++++++++++++++++-----------------
>>   1 file changed, 54 insertions(+), 35 deletions(-)
>>
> 
>> @@ -7977,28 +7979,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long
>> arg1,
>>       void *p;
>>       char *fn;
>>   -#if defined(DEBUG_ERESTARTSYS)
> 
>> +abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>> +                    abi_long arg2, abi_long arg3, abi_long arg4,
>> +                    abi_long arg5, abi_long arg6, abi_long arg7,
>> +                    abi_long arg8)
>> +{
>> +    CPUState *cpu = ENV_GET_CPU(cpu_env);
>> +    abi_long ret;
>> +
>> +#if defined(DEBUG_ERESTARTSYS)
> 
> Code motion, but...
> 
>> +    /* Debug-only code for exercising the syscall-restart code paths
>> +     * in the per-architecture cpu main loops: restart every syscall
>> +     * the guest makes once before letting it through.
>> +     */
>> +    {
>> +        static bool flag;
>> +        flag = !flag;
>> +        if (flag) {
>> +            return -TARGET_ERESTARTSYS;
>> +        }
>> +    }
>> +#endif
>> +#ifdef DEBUG
> 
> ...it looks inconsistent to mix '#if defined()' with '#ifdef' in the same
> function.  Worth cleaning up while you do this refactoring?

Yes, I've been trying to remember to fix this as I go, but obviously missed some.


r~
> 
