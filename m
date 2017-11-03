Received: from eggs.gnu.org ([2001:4830:134:3::10]:50662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAd08-0002hM-FL
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAd07-0006mk-BS
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:31:16 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAd07-0006lj-2g
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:31:15 -0400
Received: by mail-wr0-x244.google.com with SMTP id y9so2684970wrb.2
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 07:31:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171103120703.15749-1-james.cowgill@mips.com>
References: <20171103120703.15749-1-james.cowgill@mips.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 14:30:53 +0000
Message-ID: <CAFEAcA-WuQyGfh_f6=xPMqj+Haa6-WrwUyB8_E1pAMLiv15KCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: James Cowgill <james.cowgill@mips.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>

On 3 November 2017 at 12:07, James Cowgill <james.cowgill@mips.com> wrote:
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

Seems like a good idea -- can we have the "why are we failing this"
in a comment as well as in the commit message, please?

thanks
-- PMM
