Received: from eggs.gnu.org ([2001:4830:134:3::10]:52213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceQ4k-0004eX-Tp
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceQ4k-0003Rs-1l
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:42:38 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:33677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceQ4j-0003RD-RG
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:42:37 -0500
Received: by mail-wm0-x234.google.com with SMTP id t18so4946132wmt.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 09:42:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170216173707.16209-1-laurent@vivier.eu>
References: <20170216173707.16209-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 17:42:16 +0000
Message-ID: <CAFEAcA-b7Y4r-PJ32NyFyxcvT9kA6D-QJL2BEMU6ZJmCHiLO+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix fork()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 16 February 2017 at 17:37, Laurent Vivier <laurent@vivier.eu> wrote:
> Since commit 5ea2fc8 ("linux-user: Sanity check clone flags"),
> trying to run fork() fails with old distro on some architectures.
>
> This is the case with HP-PA and Debian 5 (Lenny).
>
> It fails on:
>
>          if ((flags & CSIGNAL) != TARGET_SIGCHLD) {
>              return -TARGET_EINVAL;
>          }
>
> because flags is 17, whereas on HP-PA, SIGCHLD is 18.
> 17 is the SIGCHLD value of my host (x86_64).
>
> It appears that for TARGET_NR_fork and TARGET_NR_vfork, QEMU calls
> do_fork() with SIGCHLD instead of TARGET_SIGCHLD.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f569f82..4d85355 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7680,7 +7680,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>          break;
>  #ifdef TARGET_NR_fork
>      case TARGET_NR_fork:
> -        ret = get_errno(do_fork(cpu_env, SIGCHLD, 0, 0, 0, 0));
> +        ret = get_errno(do_fork(cpu_env, TARGET_SIGCHLD, 0, 0, 0, 0));
>          break;
>  #endif
>  #ifdef TARGET_NR_waitpid
> @@ -10490,7 +10490,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>  #endif
>  #ifdef TARGET_NR_vfork
>      case TARGET_NR_vfork:
> -        ret = get_errno(do_fork(cpu_env, CLONE_VFORK | CLONE_VM | SIGCHLD,
> +        ret = get_errno(do_fork(cpu_env,
> +                        CLONE_VFORK | CLONE_VM | TARGET_SIGCHLD,
>                          0, 0, 0, 0));
>          break;
>  #endif

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
