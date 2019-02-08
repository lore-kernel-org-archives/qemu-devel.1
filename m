Received: from eggs.gnu.org ([209.51.188.92]:38649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs4Qt-0001Wc-5q
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs4Qr-0006xM-IK
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:34:58 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gs4Qr-0006qw-Aw
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:34:57 -0500
Received: by mail-wm1-x343.google.com with SMTP id g67so3010606wmd.2
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 03:34:48 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-70-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-70-cota@braap.org>
Date: Fri, 08 Feb 2019 11:34:45 +0000
Message-ID: <875ztums2y.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 69/73] cpu: rename all_cpu_threads_idle
 to qemu_tcg_rr_all_cpu_threads_idle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> This function is only called from TCG rr mode, so add
> a prefix to mark this as well as an assertion.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  cpus.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/cpus.c b/cpus.c
> index aee129c0b3..0d255c2655 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -211,10 +211,12 @@ static bool cpu_thread_is_idle(CPUState *cpu)
>      return true;
>  }
>
> -static bool all_cpu_threads_idle(void)
> +static bool qemu_tcg_rr_all_cpu_threads_idle(void)
>  {
>      CPUState *cpu;
>
> +    g_assert(qemu_is_tcg_rr());
> +
>      CPU_FOREACH(cpu) {
>          if (!cpu_thread_is_idle(cpu)) {
>              return false;
> @@ -692,7 +694,7 @@ void qemu_start_warp_timer(void)
>      }
>
>      if (replay_mode !=3D REPLAY_MODE_PLAY) {
> -        if (!all_cpu_threads_idle()) {
> +        if (!qemu_tcg_rr_all_cpu_threads_idle()) {
>              return;
>          }
>
> @@ -1325,7 +1327,7 @@ static void qemu_tcg_rr_wait_io_event(void)
>  {
>      CPUState *cpu;
>
> -    while (all_cpu_threads_idle()) {
> +    while (qemu_tcg_rr_all_cpu_threads_idle()) {
>          stop_tcg_kick_timer();
>          qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
>      }
> @@ -1659,7 +1661,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>              atomic_mb_set(&cpu->exit_request, 0);
>          }
>
> -        if (use_icount && all_cpu_threads_idle()) {
> +        if (use_icount && qemu_tcg_rr_all_cpu_threads_idle()) {
>              /*
>               * When all cpus are sleeping (e.g in WFI), to avoid a deadl=
ock
>               * in the main_loop, wake it up in order to start the warp t=
imer.


--
Alex Benn=C3=A9e
