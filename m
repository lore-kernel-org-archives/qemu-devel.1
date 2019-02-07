Received: from eggs.gnu.org ([209.51.188.92]:39618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grqSg-0006Xn-HX
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grqSf-00071V-G1
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:39:54 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1grqSf-0006y2-7d
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:39:53 -0500
Received: by mail-wr1-x443.google.com with SMTP id c8so1322652wrs.4
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 12:39:49 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-32-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-32-cota@braap.org>
Date: Thu, 07 Feb 2019 20:39:46 +0000
Message-ID: <87imxvmiy5.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 31/73] cpu: convert to cpu_halted
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

> This finishes the conversion to cpu_halted.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  cpus.c    | 8 ++++----
>  qom/cpu.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/cpus.c b/cpus.c
> index c4fa3cc876..aee129c0b3 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -204,7 +204,7 @@ static bool cpu_thread_is_idle(CPUState *cpu)
>      if (cpu_is_stopped(cpu)) {
>          return true;
>      }
> -    if (!cpu->halted || cpu_has_work(cpu) ||
> +    if (!cpu_halted(cpu) || cpu_has_work(cpu) ||
>          kvm_halt_in_kernel()) {
>          return false;
>      }
> @@ -1686,7 +1686,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
>
>      cpu->thread_id =3D qemu_get_thread_id();
>      cpu->created =3D true;
> -    cpu->halted =3D 0;
> +    cpu_halted_set(cpu, 0);
>      current_cpu =3D cpu;
>
>      hax_init_vcpu(cpu);
> @@ -1845,7 +1845,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>                   *
>                   * cpu->halted should ensure we sleep in wait_io_event
>                   */
> -                g_assert(cpu->halted);
> +                g_assert(cpu_halted(cpu));
>                  break;
>              case EXCP_ATOMIC:
>                  qemu_mutex_unlock_iothread();
> @@ -2342,7 +2342,7 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>          info->value =3D g_malloc0(sizeof(*info->value));
>          info->value->CPU =3D cpu->cpu_index;
>          info->value->current =3D (cpu =3D=3D first_cpu);
> -        info->value->halted =3D cpu->halted;
> +        info->value->halted =3D cpu_halted(cpu);
>          info->value->qom_path =3D object_get_canonical_path(OBJECT(cpu));
>          info->value->thread_id =3D cpu->thread_id;
>  #if defined(TARGET_I386)
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 2c05aa1bca..c5106d5af8 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -261,7 +261,7 @@ static void cpu_common_reset(CPUState *cpu)
>      }
>
>      cpu->interrupt_request =3D 0;
> -    cpu->halted =3D 0;
> +    cpu_halted_set(cpu, 0);
>      cpu->mem_io_pc =3D 0;
>      cpu->mem_io_vaddr =3D 0;
>      cpu->icount_extra =3D 0;


--
Alex Benn=C3=A9e
