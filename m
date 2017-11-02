Received: from eggs.gnu.org ([2001:4830:134:3::10]:34770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eAHuv-0003Fi-As
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eAHur-0000RO-CK
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:00:29 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eAHur-0000Qy-6Y
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:00:25 -0400
Received: by mail-wr0-x244.google.com with SMTP id z55so22319wrz.1
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 09:00:24 -0700 (PDT)
References: <1509634273-29111-1-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1509634273-29111-1-git-send-email-peter.maydell@linaro.org>
Date: Thu, 02 Nov 2017 16:00:22 +0000
Message-ID: <87wp38hdrd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cpu-exec: Exit exclusive region on longjmp
 from step_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Commit ac03ee5331612e44be narrowed the scope of the exclusive
> region so it only covers when we're executing the TB, not when
> we're generating it. However it missed that there is more than
> one execution path out of cpu_tb_exec -- if the atomic insn
> causes an exception then the code will longjmp out, skipping
> the code to end the exclusive region. This causes QEMU to hang
> the next time the CPU calls start_exclusive(), waiting for
> itself to exit the region.
>
> Move the "end the region" code out to the end of the
> function so that it is run for both normal exit and also
> for exit-via-longjmp.
>
> (For some reason this only reproduces for me with a clang
> optimized build, not a gcc debug build.)
>
> Fixes: ac03ee5331612e44beb393df2b578c951d27dc0d
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/tcg/cpu-exec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 4318441..ac316bb 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -256,9 +256,6 @@ void cpu_exec_step_atomic(CPUState *cpu)
>          trace_exec_tb(tb, pc);
>          cpu_tb_exec(cpu, tb);
>          cc->cpu_exec_exit(cpu);
> -        parallel_cpus =3D true;
> -
> -        end_exclusive();
>      } else {
>          /* We may have exited due to another problem here, so we need
>           * to reset any tb_locks we may have taken but didn't release.
> @@ -270,6 +267,9 @@ void cpu_exec_step_atomic(CPUState *cpu)
>  #endif
>          tb_lock_reset();
>      }
> +
> +    parallel_cpus =3D true;
> +    end_exclusive();

We assume sigsetjmp can never fail - we either set the jump or are
returning from a longjmp back. So we can never be in the position of
having not been through start_exclusive?

What happens for example if we fault during translation?

--
Alex Benn=C3=A9e
