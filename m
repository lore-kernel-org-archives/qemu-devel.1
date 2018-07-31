Received: from eggs.gnu.org ([2001:4830:134:3::10]:33743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fkSIm-0002WP-CA
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fkSIh-00037M-D8
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:54:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fkSIh-00037E-4r
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:54:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id h15-v6so16137836wrs.7
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 03:54:46 -0700 (PDT)
References: <20180730201553.32423-1-richard.henderson@linaro.org>
	<20180730201553.32423-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180730201553.32423-2-richard.henderson@linaro.org>
Date: Tue, 31 Jul 2018 11:54:44 +0100
Message-ID: <87va8v8ykr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] linux-user: Disallow setting newsp for
 fork
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com


Richard Henderson <richard.henderson@linaro.org> writes:

> Or really, just clone devolving into fork.  This should not ever happen
> in practice.  We do want to reserve calling cpu_clone_regs for the case
> in which we are actually performing a clone.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  linux-user/syscall.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index dfc851cc35..5bf8d13de7 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6502,10 +6502,14 @@ static int do_fork(CPUArchState *env, unsigned in=
t flags, abi_ulong newsp,
>          pthread_mutex_destroy(&info.mutex);
>          pthread_mutex_unlock(&clone_lock);
>      } else {
> -        /* if no CLONE_VM, we consider it is a fork */
> +        /* If no CLONE_VM, we consider it is a fork.  */
>          if (flags & CLONE_INVALID_FORK_FLAGS) {
>              return -TARGET_EINVAL;
>          }
> +        /* As a fork, setting a new sp does not make sense.  */
> +        if (newsp) {
> +            return -TARGET_EINVAL;
> +        }
>
>          /* We can't support custom termination signals */
>          if ((flags & CSIGNAL) !=3D TARGET_SIGCHLD) {
> @@ -6520,7 +6524,6 @@ static int do_fork(CPUArchState *env, unsigned int =
flags, abi_ulong newsp,
>          ret =3D fork();
>          if (ret =3D=3D 0) {
>              /* Child Process.  */
> -            cpu_clone_regs(env, newsp);
>              fork_end(1);
>              /* There is a race condition here.  The parent process could
>                 theoretically read the TID in the child process before th=
e child


--
Alex Benn=C3=A9e
