Received: from eggs.gnu.org ([2001:4830:134:3::10]:43806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1eBnf6-0006Y3-0e
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1eBnf2-0001uT-1z
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:06:23 -0500
Received: from jessie.kos.to ([212.47.231.226]:50070 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1eBnf1-0001u1-RL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:06:19 -0500
Date: Mon, 6 Nov 2017 20:06:18 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20171106200618.GD19281@kos.to>
References: <20171103120703.15749-1-james.cowgill@mips.com>
	<20171106180351.30749-1-james.cowgill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171106180351.30749-1-james.cowgill@mips.com>
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
To: James Cowgill <james.cowgill@mips.com>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On Mon, Nov 06, 2017 at 06:03:51PM +0000, James Cowgill wrote:
> If an application tries to install a seccomp filter using
> prctl(PR_SET_SECCOMP), the filter is likely for the target instead of the host
> architecture. This will probably cause qemu to be immediately killed when it
> executes another syscall.
> 
> Prevent this from happening by returning EINVAL from both seccomp prctl
> calls. This is the error returned by the kernel when seccomp support is
> disabled.

Thanks, applied to linux-user
 
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
> -- 
> 2.15.0
> 
> 
