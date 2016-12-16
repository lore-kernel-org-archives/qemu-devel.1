Received: from eggs.gnu.org ([2001:4830:134:3::10]:44039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHtfv-0002dC-VT
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHtfv-0001ox-9H
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:39:56 -0500
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:35791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHtfv-0001oV-5U
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:39:55 -0500
Received: by mail-ua0-x22d.google.com with SMTP id 12so39782756uas.2
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 06:39:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480003738-8754-8-git-send-email-Lena.Djokic@rt-rk.com>
References: <1480003738-8754-1-git-send-email-Lena.Djokic@rt-rk.com>
	<1480003738-8754-8-git-send-email-Lena.Djokic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 14:39:34 +0000
Message-ID: <CAFEAcA-Y8+QUuxT1sf84K_6WFEzU9diJRB=Jfa60SbxgoGitRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 24 November 2016 at 16:08, Lena Djokic <Lena.Djokic@rt-rk.com> wrote:
> If fourth argument is NULL it should be passed without
> using lock_user function which would, in that case, return
> EFAULT, and system call supports passing NULL as fourth argument.
>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
