Received: from eggs.gnu.org ([2001:4830:134:3::10]:42224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f4QxG-0002t7-4v
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f4QxD-0001aG-3X
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:58:58 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f4QxC-0001YF-Tn
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:58:55 -0400
Received: by mail-wr0-x243.google.com with SMTP id s12so1685008wrc.8
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 05:58:54 -0700 (PDT)
References: <20180406123838.21249-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180406123838.21249-1-peter.maydell@linaro.org>
Date: Fri, 06 Apr 2018 13:58:51 +0100
Message-ID: <877epkcwz8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] cpus.c: ensure running CPU
 recalculates icount deadlines on timer expiry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>


Peter Maydell <peter.maydell@linaro.org> writes:

> When we run in TCG icount mode, we calculate the number of instructions
> to execute using tcg_get_icount_limit(), which ensures that we stop
> execution at the next timer deadline. However there is a bug where
> currently we do not recalculate that limit if the guest reprograms
> a timer so that the next deadline moves closer, and so we will
> continue execution until the original limit and fire the timer
> later than we should.
>
> Fix this bug in qemu_timer_notify_cb(): if we are currently running
> a VCPU in icount mode, we simply need to kick it out of the main
> loop and back to tcg_cpu_exec(), where it will recalculate the
> icount limit. If we are not currently running a VCPU, then we
> retain the existing logic for waking up a halted CPU.
>
> Cc: qemu-stable@nongnu.org
> Fixes: https://bugs.launchpad.net/qemu/+bug/1754038
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Thanks to Paolo for tracking down which function needed fixing!
>
>  cpus.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/cpus.c b/cpus.c
> index 2e6701795b..38eba8bff3 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -892,11 +892,19 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockTy=
pe type)
>          return;
>      }
>
> -    if (!qemu_in_vcpu_thread() && first_cpu) {
> +    if (qemu_in_vcpu_thread()) {
> +        /* A CPU is currently running; kick it back out to the
> +         * tcg_cpu_exec() loop so it will recalculate its
> +         * icount deadline immediately.
> +         */
> +        qemu_cpu_kick(current_cpu);

This is only totally true if whatever has caused the re-calculation has
ended the Translation Block, otherwise we won't finish until we've run a
few more instructions. I don't know if this could cause a problem if the
timeout was suddenly less than the remaining instructions in the block.

Anyway wording aside:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +    } else if (first_cpu) {
>          /* qemu_cpu_kick is not enough to kick a halted CPU out of
>           * qemu_tcg_wait_io_event.  async_run_on_cpu, instead,
>           * causes cpu_thread_is_idle to return false.  This way,
>           * handle_icount_deadline can run.
> +         * If we have no CPUs at all for some reason, we don't
> +         * need to do anything.
>           */
>          async_run_on_cpu(first_cpu, do_nothing, RUN_ON_CPU_NULL);
>      }


--
Alex Benn=C3=A9e
