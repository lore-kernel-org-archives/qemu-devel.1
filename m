Received: from eggs.gnu.org ([2001:4830:134:3::10]:46030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dsl2C-0000Iy-Gx
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dsl29-0007eu-DJ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:27:32 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dsl29-0007eJ-3J
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:27:29 -0400
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <269767d5-b02b-f3dc-235e-1d7629baf4d5@vivier.eu>
Date: Fri, 15 Sep 2017 09:27:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170915065821.16600-1-jrtc27@jrtc27.com>
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
To: James Clarke <jrtc27@jrtc27.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Maydell <peter.maydell@linaro.org>

Le 15/09/2017 à 08:58, James Clarke a écrit :
> Fixes: https://bugs.launchpad.net/qemu/+bug/1716767
> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
> ---
>  linux-user/syscall.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9b6364a266..24d6a81c21 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10495,20 +10495,32 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>  #endif
>  #ifdef TARGET_NR_pread64
>      case TARGET_NR_pread64:
> +#if defined(TARGET_SH4)
> +        /* SH4 doesn't align register pairs, except for p{read,write}64 */
> +        arg4 = arg5;
> +        arg5 = arg6;
> +#else
>          if (regpairs_aligned(cpu_env)) {
>              arg4 = arg5;
>              arg5 = arg6;
>          }
> +#endif
>          if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
>              goto efault;
>          ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
>          unlock_user(p, arg2, ret);
>          break;
>      case TARGET_NR_pwrite64:
> +#if defined(TARGET_SH4)
> +        /* SH4 doesn't align register pairs, except for p{read,write}64 */
> +        arg4 = arg5;
> +        arg5 = arg6;
> +#else
>          if (regpairs_aligned(cpu_env)) {
>              arg4 = arg5;
>              arg5 = arg6;
>          }
> +#endif
>          if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
>              goto efault;
>          ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
> --
> 2.13.2
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
