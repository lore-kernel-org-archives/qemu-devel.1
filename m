Received: from eggs.gnu.org ([2001:4830:134:3::10]:48519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHttl-00082S-2e
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHttk-0000fH-8u
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:54:13 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:36395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHttk-0000f5-4V
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:54:12 -0500
Received: by mail-ua0-x22b.google.com with SMTP id 3so24791844uaz.3
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 06:54:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480003738-8754-3-git-send-email-Lena.Djokic@rt-rk.com>
References: <1480003738-8754-1-git-send-email-Lena.Djokic@rt-rk.com>
	<1480003738-8754-3-git-send-email-Lena.Djokic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 14:53:51 +0000
Message-ID: <CAFEAcA_1Z+W_dDg68PEeYjTwBXM+=uLSXvF9LkzOp5JBPzj=Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 2/7] linux-user: Fix inotify_init1
 support
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
> This commit adds necessary conversion of argument passed to inotify_init1.
> inotify_init1 flags can be IN_NONBLOCK and IN_CLOEXEC which rely on O_NONBLOCK
> and O_CLOEXEC and those can have different values on different platforms.
>
> Signed-off-by: Lena Djokic <Lena.Djokic@rt-rk.com>
> ---
>  linux-user/syscall.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f5d9a26..41873ca 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11625,7 +11625,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>  #ifdef CONFIG_INOTIFY1
>  #if defined(TARGET_NR_inotify_init1) && defined(__NR_inotify_init1)
>      case TARGET_NR_inotify_init1:
> -        ret = get_errno(sys_inotify_init1(arg1));
> +        ret = get_errno(sys_inotify_init1(target_to_host_bitmask(arg1,
> +                                          fcntl_flags_tbl)));
>          break;
>  #endif
>  #endif

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
