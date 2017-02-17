Received: from eggs.gnu.org ([2001:4830:134:3::10]:39758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cerU5-0001NF-QM
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cerU2-0005fA-M9
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:58:37 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cerU2-0005ez-I8
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:58:34 -0500
Received: by mail-qk0-x242.google.com with SMTP id u25so8527353qki.2
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 14:58:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170216173707.16209-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <459bd212-56e5-5771-34fe-2aa28be2ba96@amsat.org>
Date: Fri, 17 Feb 2017 19:58:30 -0300
MIME-Version: 1.0
In-Reply-To: <20170216173707.16209-1-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

On 02/16/2017 02:37 PM, Laurent Vivier wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
