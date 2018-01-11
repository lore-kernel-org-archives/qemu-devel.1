Received: from eggs.gnu.org ([2001:4830:134:3::10]:42582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eZY5A-0004ec-Vv
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eZY56-0004aK-Th
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:19:28 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59693)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eZY56-0004ZZ-Jq
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:19:24 -0500
References: <20180111001720.16035-1-samuel.thibault@ens-lyon.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e2ef7466-a201-16d6-94aa-762cb12a1750@vivier.eu>
Date: Thu, 11 Jan 2018 09:19:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180111001720.16035-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2] linux-user: Add getcpu() support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Le 11/01/2018 à 01:17, Samuel Thibault a écrit :
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> ---
> Difference from v1: handle failure of put_user_u32 with goto efault;
> ---
>  linux-user/syscall.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 11c9116c4a..89d78b7b48 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -296,6 +296,8 @@ _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
>  #define __NR_sys_sched_setaffinity __NR_sched_setaffinity
>  _syscall3(int, sys_sched_setaffinity, pid_t, pid, unsigned int, len,
>            unsigned long *, user_mask_ptr);
> +#define __NR_sys_getcpu __NR_getcpu
> +_syscall3(int, sys_getcpu, unsigned *, cpu, unsigned *, node, void *, tcache);
>  _syscall4(int, reboot, int, magic1, int, magic2, unsigned int, cmd,
>            void *, arg);
>  _syscall2(int, capget, struct __user_cap_header_struct *, header,
> @@ -10403,6 +10405,20 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              ret = get_errno(sys_sched_setaffinity(arg1, mask_size, mask));
>          }
>          break;
> +    case TARGET_NR_getcpu:
> +        {
> +            unsigned cpu, node;
> +            ret = get_errno(sys_getcpu(arg1 ? &cpu : NULL,
> +                                       arg2 ? &node : NULL,
> +                                       NULL));

you must check for return status to avoid setting the values if there is
an error:

           if (!is_error(ret)) {

> +            if (arg1 && put_user_u32(cpu, arg1)) {
> +                goto efault;
> +            }
> +            if (arg2 && put_user_u32(node, arg2)) {
> +                goto efault;
> +            }

           }

> +        }
> +        break;
>      case TARGET_NR_sched_setparam:
>          {
>              struct sched_param *target_schp;
> 

Thanks,
Laurent
