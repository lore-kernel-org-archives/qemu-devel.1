Received: from eggs.gnu.org ([2001:4830:134:3::10]:55539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsskf-0007c4-0Y
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsskb-0003Qe-S6
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:41:57 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsskb-0003QZ-Nk
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:41:53 -0400
Received: by mail-qk0-x241.google.com with SMTP id r66so1645822qke.4
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 08:41:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2f7283ca-6ecd-165f-c572-a0f2a781aba7@amsat.org>
Date: Fri, 15 Sep 2017 12:41:49 -0300
MIME-Version: 1.0
In-Reply-To: <20170915065821.16600-1-jrtc27@jrtc27.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: James Clarke <jrtc27@jrtc27.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Cc: Peter Maydell <peter.maydell@linaro.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 09/15/2017 03:58 AM, James Clarke wrote:
> Fixes: https://bugs.launchpad.net/qemu/+bug/1716767
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>

Congratulations! You have won yourself a R: entry (Designated reviewer) 
in the "Linux user" and "SH4" sections of MAINTAINERS!

> ---
>   linux-user/syscall.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9b6364a266..24d6a81c21 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10495,20 +10495,32 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>   #endif
>   #ifdef TARGET_NR_pread64
>       case TARGET_NR_pread64:
> +#if defined(TARGET_SH4)
> +        /* SH4 doesn't align register pairs, except for p{read,write}64 */
> +        arg4 = arg5;
> +        arg5 = arg6;
> +#else
>           if (regpairs_aligned(cpu_env)) {
>               arg4 = arg5;
>               arg5 = arg6;
>           }
> +#endif

I'd rather use arch_type from "sysemu/arch_init.h":

   case TARGET_NR_pwrite64:
       /* SH4 doesn't align register pairs, except for p{read,write}64 */
       if (arch_type == QEMU_ARCH_SH4 || regpairs_aligned(cpu_env)) {
           arg4 = arg5;
           arg5 = arg6;
       }

What do you think?

>           if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
>               goto efault;
>           ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
>           unlock_user(p, arg2, ret);
>           break;
>       case TARGET_NR_pwrite64:
> +#if defined(TARGET_SH4)
> +        /* SH4 doesn't align register pairs, except for p{read,write}64 */
> +        arg4 = arg5;
> +        arg5 = arg6;
> +#else
>           if (regpairs_aligned(cpu_env)) {
>               arg4 = arg5;
>               arg5 = arg6;
>           }
> +#endif

same here.

>           if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
>               goto efault;
>           ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
> --
> 2.13.2
> 
> 

Regards,

Phil.
