Received: from eggs.gnu.org ([2001:4830:134:3::10]:43612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHtec-0001gN-MK
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHteb-0000n3-NB
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:38:34 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:35175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHteb-0000mk-Jb
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:38:33 -0500
Received: by mail-ua0-x236.google.com with SMTP id 12so39745251uas.2
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 06:38:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480003738-8754-7-git-send-email-Lena.Djokic@rt-rk.com>
References: <1480003738-8754-1-git-send-email-Lena.Djokic@rt-rk.com>
	<1480003738-8754-7-git-send-email-Lena.Djokic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 14:38:12 +0000
Message-ID: <CAFEAcA_s8NPptxdzsUXByA9uGFenF0++jF8P3TUVZUtQaOjABA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 6/7] linux-user: Fix syslog
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
> Third argument represents lenght not second.

typo: "length"

> If second argument is NULL it should be passed without
> using lock_user function which would, in that case, return
> EFAULT, and system call supports passing NULL as second argument.

Looking at the kernel code, it doesn't support NULL as the
second argument for the three actions here (READ, READ_CLEAR,
READ_ALL) -- they all fail EINVAL. So what we're doing here
is just returning a better errno. I think we can do
this more simply by just changing the current
                    if (len < 0) {
                        goto fail;
                    }

to "if (!arg2 || len < 0) {" (which is what the kernel code does).

(I think it would also be reasonable to consistently use "len"
and never "arg3" (the existing code has an odd mix of both);
if you want to do that cleanup you could add an extra patch for
it, but you don't have to.)

> Signed-off-by: Lena Djokic <Lena.Djokic@rt-rk.com>
> ---
>  linux-user/syscall.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 61c4126..3faf4f0 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9426,7 +9426,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>  #if defined(TARGET_NR_syslog)
>      case TARGET_NR_syslog:
>          {
> -            int len = arg2;
> +            int len = arg3;
>
>              switch (arg1) {
>              case TARGET_SYSLOG_ACTION_CLOSE:         /* Close log */
> @@ -9450,13 +9450,13 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                          goto fail;
>                      }
>                      ret = 0;
> -                    if (len == 0) {
> -                        break;
> -                    }
> -                    p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
> -                    if (!p) {
> -                        ret = -TARGET_EFAULT;
> -                        goto fail;
> +                    p = NULL;
> +                    if (arg2) {
> +                        p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
> +                        if (!p) {
> +                            ret = -TARGET_EFAULT;
> +                            goto fail;
> +                        }
>                      }
>                      ret = get_errno(sys_syslog((int)arg1, p, (int)arg3));
>                      unlock_user(p, arg2, arg3);
> --
> 2.7.4

thanks
-- PMM
