Received: from eggs.gnu.org ([2001:4830:134:3::10]:53917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsuAz-0008Ah-Kw
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsuAw-0004hS-EZ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:13:13 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:49900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsuAw-0004h0-7n
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:13:10 -0400
Received: by mail-pf0-x231.google.com with SMTP id l188so1753604pfc.6
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 10:13:10 -0700 (PDT)
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
	<2f7283ca-6ecd-165f-c572-a0f2a781aba7@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cc5d79bb-a56a-08a6-c054-b194e6a5a833@linaro.org>
Date: Fri, 15 Sep 2017 10:13:06 -0700
MIME-Version: 1.0
In-Reply-To: <2f7283ca-6ecd-165f-c572-a0f2a781aba7@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/syscall.c: Handle SH4's
 exceptional alignment for p{read, write}64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, James Clarke <jrtc27@jrtc27.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Cc: Peter Maydell <peter.maydell@linaro.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 09/15/2017 08:41 AM, Philippe Mathieu-Daudé wrote:
> On 09/15/2017 03:58 AM, James Clarke wrote:
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1716767
>> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
> 
> Congratulations! You have won yourself a R: entry (Designated reviewer) in the
> "Linux user" and "SH4" sections of MAINTAINERS!
> 
>> ---
>>   linux-user/syscall.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 9b6364a266..24d6a81c21 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -10495,20 +10495,32 @@ abi_long do_syscall(void *cpu_env, int num,
>> abi_long arg1,
>>   #endif
>>   #ifdef TARGET_NR_pread64
>>       case TARGET_NR_pread64:
>> +#if defined(TARGET_SH4)
>> +        /* SH4 doesn't align register pairs, except for p{read,write}64 */
>> +        arg4 = arg5;
>> +        arg5 = arg6;
>> +#else
>>           if (regpairs_aligned(cpu_env)) {
>>               arg4 = arg5;
>>               arg5 = arg6;
>>           }
>> +#endif
> 
> I'd rather use arch_type from "sysemu/arch_init.h":
> 
>   case TARGET_NR_pwrite64:
>       /* SH4 doesn't align register pairs, except for p{read,write}64 */
>       if (arch_type == QEMU_ARCH_SH4 || regpairs_aligned(cpu_env)) {
>           arg4 = arg5;
>           arg5 = arg6;
>       }
> 
> What do you think?

I'd rather change the interface of regpairs_aligned to take the syscall number,
and add an instance for SH4 above.


r~
