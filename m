Received: from eggs.gnu.org ([2001:4830:134:3::10]:50702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1cP6w8-0008KK-3R
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1cP6w7-00076r-57
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:14:28 -0500
Received: from jessie.kos.to ([212.47.231.226]:41392 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1cP6w6-00076i-Uc
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:14:27 -0500
Date: Thu, 5 Jan 2017 12:14:25 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20170105121425.GD19094@kos.to>
References: <1480003738-8754-1-git-send-email-Lena.Djokic@rt-rk.com>
	<1480003738-8754-8-git-send-email-Lena.Djokic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1480003738-8754-8-git-send-email-Lena.Djokic@rt-rk.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] linux-user: Fix mq_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lena Djokic <Lena.Djokic@rt-rk.com>
Cc: qemu-devel@nongnu.org

On Thu, Nov 24, 2016 at 05:08:58PM +0100, Lena Djokic wrote:
> If fourth argument is NULL it should be passed without
> using lock_user function which would, in that case, return
> EFAULT, and system call supports passing NULL as fourth argument.

Thanks, applied to linux-user
 
> Signed-off-by: Lena Djokic <Lena.Djokic@rt-rk.com>
> ---
>  linux-user/syscall.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 3faf4f0..dad03e9 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11694,17 +11694,22 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_mq_open:
>          {
>              struct mq_attr posix_mq_attr;
> +            struct mq_attr *pposix_mq_attr;
>              int host_flags;
>  
>              host_flags = target_to_host_bitmask(arg2, fcntl_flags_tbl);
> -            if (copy_from_user_mq_attr(&posix_mq_attr, arg4) != 0) {
> -                goto efault;
> +            pposix_mq_attr = NULL;
> +            if (arg4) {
> +                if (copy_from_user_mq_attr(&posix_mq_attr, arg4) != 0) {
> +                    goto efault;
> +                }
> +                pposix_mq_attr = &posix_mq_attr;
>              }
>              p = lock_user_string(arg1 - 1);
>              if (!p) {
>                  goto efault;
>              }
> -            ret = get_errno(mq_open(p, host_flags, arg3, &posix_mq_attr));
> +            ret = get_errno(mq_open(p, host_flags, arg3, pposix_mq_attr));
>              unlock_user (p, arg1, 0);
>          }
>          break;
> -- 
> 2.7.4
> 
