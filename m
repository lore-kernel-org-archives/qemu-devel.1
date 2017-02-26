Received: from eggs.gnu.org ([2001:4830:134:3::10]:37218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1chydM-0003ZK-7w
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 08:13:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1chydH-0006iS-L2
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 08:13:04 -0500
References: <20170216085857.23501-1-snaipe@diacritic.io>
	<20170217085800.28873-1-snaipe@diacritic.io>
	<20170217085800.28873-2-snaipe@diacritic.io>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <00cd6802-c213-3212-5f29-ebef0a4dfa5e@vivier.eu>
Date: Sun, 26 Feb 2017 14:12:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170217085800.28873-2-snaipe@diacritic.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] syscall: fixed mincore(2) not failing
 with ENOMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Franklin Snaipe Mathieu <snaipe@diacritic.io>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, snaipe@arista.com, Riku Voipio <riku.voipio@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Le 17/02/2017 à 09:58, Franklin Snaipe Mathieu a écrit :
> From: "Franklin \"Snaipe\" Mathieu" <snaipe@diacritic.io>
> 
> The current implementation of the mincore(2) syscall sets errno to
> EFAULT when the region identified by the first two parameters is
> invalid.
> 
> This goes against the man page specification, where mincore(2) should
> only fail with EFAULT when the third parameter is an invalid address;
> and fail with ENOMEM when the checked region does not point to mapped
> memory.
> 
> Signed-off-by: Franklin "Snaipe" Mathieu <snaipe@diacritic.io>
> Cc: Riku Voipio <riku.voipio@linaro.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  linux-user/syscall.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9be8e9530e..733e0009e1 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11061,11 +11061,16 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_mincore:
>          {
>              void *a;
> +            ret = -TARGET_ENOMEM;
> +            a = lock_user(VERIFY_READ, arg1, arg2, 0);
> +            if (!a) {
> +                goto fail;
> +            }
>              ret = -TARGET_EFAULT;
> -            if (!(a = lock_user(VERIFY_READ, arg1,arg2, 0)))
> -                goto efault;
> -            if (!(p = lock_user_string(arg3)))
> +            p = lock_user_string(arg3);
> +            if (!p) {
>                  goto mincore_fail;
> +            }
>              ret = get_errno(mincore(a, arg2, p));
>              unlock_user(p, arg3, ret);
>              mincore_fail:
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
