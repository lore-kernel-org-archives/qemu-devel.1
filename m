Received: from eggs.gnu.org ([2001:4830:134:3::10]:37048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBnI2-0006Sl-Gz
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBnHx-0001he-Li
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:42:34 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:62402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eBnHx-0001gr-C1
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:42:29 -0500
References: <20171103120703.15749-1-james.cowgill@mips.com>
	<20171106180351.30749-1-james.cowgill@mips.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d04ef81c-a3e7-480e-ff4b-67fa443bcbfc@vivier.eu>
Date: Mon, 6 Nov 2017 20:41:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171106180351.30749-1-james.cowgill@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: return EINVAL from
 prctl(PR_*_SECCOMP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Cowgill <james.cowgill@mips.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org

Le 06/11/2017 à 19:03, James Cowgill a écrit :
> If an application tries to install a seccomp filter using
> prctl(PR_SET_SECCOMP), the filter is likely for the target instead of the host
> architecture. This will probably cause qemu to be immediately killed when it
> executes another syscall.
> 
> Prevent this from happening by returning EINVAL from both seccomp prctl
> calls. This is the error returned by the kernel when seccomp support is
> disabled.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1726394
> Signed-off-by: James Cowgill <james.cowgill@mips.com>
> ---
> Changes from v1:
> - add comment
> 
>  linux-user/syscall.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d4497dec5d..419991e834 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10482,6 +10482,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              break;
>          }
>  #endif
> +        case PR_GET_SECCOMP:
> +        case PR_SET_SECCOMP:
> +            /* Disable seccomp to prevent the target disabling syscalls we
> +             * need. */
> +            ret = -TARGET_EINVAL;
> +            break;
>          default:
>              /* Most prctl options have no pointer arguments */
>              ret = get_errno(prctl(arg1, arg2, arg3, arg4, arg5));
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
