Received: from eggs.gnu.org ([2001:4830:134:3::10]:49989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOrP6-0008To-EW
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 17:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOrP1-0001hv-Dp
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 17:16:08 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOrP1-0001dw-7a
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 17:16:03 -0400
Received: by mail-pf0-x241.google.com with SMTP id e9-v6so13057767pfi.4
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 14:16:03 -0700 (PDT)
References: <20180531041822.5761-1-richard.henderson@linaro.org>
	<20180531041822.5761-2-richard.henderson@linaro.org>
	<dbd7a0dd-a6db-e9ca-d9fd-7ae5e75efdb4@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b24055e5-614f-a2bc-1326-476e1a4db777@linaro.org>
Date: Fri, 1 Jun 2018 14:15:59 -0700
MIME-Version: 1.0
In-Reply-To: <dbd7a0dd-a6db-e9ca-d9fd-7ae5e75efdb4@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: Implement signals for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: shorne@gmail.com

On 06/01/2018 01:45 PM, Laurent Vivier wrote:
> Le 31/05/2018 à 06:18, Richard Henderson a écrit :
>> All of the existing code was boilerplate from elsewhere,
>> and would crash the guest upon the first signal.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  linux-user/openrisc/target_syscall.h |  23 +--
>>  linux-user/openrisc/signal.c         | 210 +++++++++++----------------
>>  linux-user/signal.c                  |   2 +-
>>  target/openrisc/cpu.c                |   1 +
>>  4 files changed, 87 insertions(+), 149 deletions(-)
>>
> ...
>> @@ -148,11 +102,8 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>>                      target_siginfo_t *info,
>>                      target_sigset_t *set, CPUOpenRISCState *env)
>>  {
> ...
>> @@ -160,47 +111,32 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>>          goto give_sigsegv;
>>      }
>>  
>> -    info_addr = frame_addr + offsetof(struct target_rt_sigframe, info);
>> -    __put_user(info_addr, &frame->pinfo);
>> -    uc_addr = frame_addr + offsetof(struct target_rt_sigframe, uc);
>> -    __put_user(uc_addr, &frame->puc);
>> +    tswap_siginfo(&frame->info, info);
>>  
>> -    if (ka->sa_flags & SA_SIGINFO) {
>> -        tswap_siginfo(&frame->info, info);
>> -    }
> 
> Why do you remove the "ka->sa_flags & SA_SIGINFO"?

I thought it was unconditional for rt signals, which are the only ones that
openrisc has.  It's definitely odd, since the kernel also checks that flag, but
unconditionally points r4 to the (possibly uninitialized) siginfo_t.

>> -    /*err |= copy_to_user(frame->uc.tuc_sigmask, set, sizeof(*set));*/
> 
> other targets have something like:
> 
>     for (i = 0; i < TARGET_NSIG_WORDS; i++) {
>         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
>     }
> 
> to match kernel
> 
>         err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
> 
> Do we need it?

Yes, this is my mistake.


r~
