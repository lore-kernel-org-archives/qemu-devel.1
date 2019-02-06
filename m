Received: from eggs.gnu.org ([209.51.188.92]:54374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grQuU-0006g1-M8
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1grQuT-0000VN-S7
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:22:54 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1grQuT-0000Df-Jn
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:22:53 -0500
Received: by mail-wm1-x342.google.com with SMTP id t200so3724365wmt.0
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 09:22:18 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-6-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-6-cota@braap.org>
Date: Wed, 06 Feb 2019 17:22:16 +0000
Message-ID: <871s4komrb.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/73] cpu: move run_on_cpu to
 cpus-common
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

> We don't pass a pointer to qemu_global_mutex anymore.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qom/cpu.h | 10 ----------
>  cpus-common.c     |  2 +-
>  cpus.c            |  5 -----
>  3 files changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 46e3c164aa..fe389037c5 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -768,16 +768,6 @@ void qemu_cpu_kick(CPUState *cpu);
>   */
>  bool cpu_is_stopped(CPUState *cpu);
>
> -/**
> - * do_run_on_cpu:
> - * @cpu: The vCPU to run on.
> - * @func: The function to be executed.
> - * @data: Data to pass to the function.
> - *
> - * Used internally in the implementation of run_on_cpu.
> - */
> -void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data =
data);
> -
>  /**
>   * run_on_cpu:
>   * @cpu: The vCPU to run on.
> diff --git a/cpus-common.c b/cpus-common.c
> index daf1531868..85a61eb970 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -127,7 +127,7 @@ static void queue_work_on_cpu(CPUState *cpu, struct q=
emu_work_item *wi)
>      cpu_mutex_unlock(cpu);
>  }
>
> -void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data =
data)
> +void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data dat=
a)
>  {
>      struct qemu_work_item wi;
>      bool has_bql =3D qemu_mutex_iothread_locked();
> diff --git a/cpus.c b/cpus.c
> index 42ea8cfbb5..755e4addab 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1234,11 +1234,6 @@ void qemu_init_cpu_loop(void)
>      qemu_thread_get_self(&io_thread);
>  }
>
> -void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data dat=
a)
> -{
> -    do_run_on_cpu(cpu, func, data);
> -}
> -
>  static void qemu_kvm_destroy_vcpu(CPUState *cpu)
>  {
>      if (kvm_destroy_vcpu(cpu) < 0) {


--
Alex Benn=C3=A9e
