Received: from eggs.gnu.org ([209.51.188.92]:38906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs7Ep-00064g-2B
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs7Eo-0004mA-3C
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:34:43 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gs7En-0004ln-P4
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:34:42 -0500
Received: by mail-wm1-x344.google.com with SMTP id p6so3602375wmc.1
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 06:34:41 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-72-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-72-cota@braap.org>
Date: Fri, 08 Feb 2019 14:34:39 +0000
Message-ID: <87zhr6l56o.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 71/73] cpus-common: release BQL earlier
 in run_on_cpu
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

> After completing the conversion to per-CPU locks, there is no need
> to release the BQL after having called cpu_kick.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  cpus-common.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/cpus-common.c b/cpus-common.c
> index 62e282bff1..1241024b2c 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -145,6 +145,11 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func,=
 run_on_cpu_data data)
>          return;
>      }
>
> +    /* We are going to sleep on the CPU lock, so release the BQL */
> +    if (has_bql) {
> +        qemu_mutex_unlock_iothread();
> +    }
> +
>      wi.func =3D func;
>      wi.data =3D data;
>      wi.done =3D false;
> @@ -153,21 +158,6 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func,=
 run_on_cpu_data data)
>
>      cpu_mutex_lock(cpu);
>      queue_work_on_cpu_locked(cpu, &wi);
> -
> -    /*
> -     * We are going to sleep on the CPU lock, so release the BQL.
> -     *
> -     * During the transition to per-CPU locks, we release the BQL _after_
> -     * having kicked the destination CPU (from queue_work_on_cpu_locked =
above).
> -     * This makes sure that the enqueued work will be seen by the CPU
> -     * after being woken up from the kick, since the CPU sleeps on the B=
QL.
> -     * Once we complete the transition to per-CPU locks, we will release
> -     * the BQL earlier in this function.
> -     */
> -    if (has_bql) {
> -        qemu_mutex_unlock_iothread();
> -    }
> -
>      while (!atomic_mb_read(&wi.done)) {
>          CPUState *self_cpu =3D current_cpu;


--
Alex Benn=C3=A9e
