Received: from eggs.gnu.org ([2001:4830:134:3::10]:49993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAcyz-0001hy-14
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAcyv-0005ts-1y
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:30:05 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:62407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eAcyu-0005sk-P9
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:30:00 -0400
References: <20171103120703.15749-1-james.cowgill@mips.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <755effd6-c595-9487-75a6-073ade6be4bc@vivier.eu>
Date: Fri, 3 Nov 2017 15:29:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171103120703.15749-1-james.cowgill@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: return EINVAL from
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

Le 03/11/2017 à 13:07, James Cowgill a écrit :
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
>  linux-user/syscall.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d4497dec5d..43cd5fb2bb 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10482,6 +10482,10 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              break;
>          }
>  #endif
> +        case PR_GET_SECCOMP:
> +        case PR_SET_SECCOMP:
> +            ret = -TARGET_EINVAL;
> +            break;
>          default:
>              /* Most prctl options have no pointer arguments */
>              ret = get_errno(prctl(arg1, arg2, arg3, arg4, arg5));
> 

I think we should allow PR_GET_SECCOMP, and at least all the modes
except SECCOMP_MODE_FILTER for PR_SET_SECCOMP.

Thanks,
Laurent
