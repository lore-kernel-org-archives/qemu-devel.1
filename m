Received: from eggs.gnu.org ([2001:4830:134:3::10]:47021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dsvWu-00016Q-FV
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dsvWp-0000G8-II
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:39:56 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dsvWp-0000Ee-8N
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:39:51 -0400
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
	<2f7283ca-6ecd-165f-c572-a0f2a781aba7@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bd55c9d1-36f6-0a2b-8608-c58ce060737f@vivier.eu>
Date: Fri, 15 Sep 2017 20:39:43 +0200
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, James Clarke <jrtc27@jrtc27.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Le 15/09/2017 à 17:41, Philippe Mathieu-Daudé a écrit :
> On 09/15/2017 03:58 AM, James Clarke wrote:
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1716767
>> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
> 
> Congratulations! You have won yourself a R: entry (Designated reviewer)
> in the "Linux user" and "SH4" sections of MAINTAINERS!
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
>> +        /* SH4 doesn't align register pairs, except for
>> p{read,write}64 */
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

For the moment, arch_type is only available for system targets.

Laurent
