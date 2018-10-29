Received: from eggs.gnu.org ([2001:4830:134:3::10]:34064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHAVP-00007a-LI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHAVJ-0005ag-7p
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:35:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHAVI-0005XM-Hm
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:35:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id l6-v6so9438578wrt.1
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 09:34:53 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-5-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-5-cota@braap.org>
Date: Mon, 29 Oct 2018 16:34:49 +0000
Message-ID: <87zhuw90eu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 05/71] cpu: move run_on_cpu to cpus-common
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

As discussed on IRC I don't fundamentally object to this being in
cpus-common given we have the other work queue stuff there. However
given it now lives there we should assert we are in system emulation
mode so if a user-mode instruction attempts to use one of the
_run_on_cpu() functions we break.

> ---
>  include/qom/cpu.h | 10 ----------
>  cpus-common.c     |  2 +-
>  cpus.c            |  5 -----
>  3 files changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 2fad537a4f..11cbf21f00 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -766,16 +766,6 @@ void qemu_cpu_kick(CPUState *cpu);
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
> index 71469c85ce..3fccee5585 100644
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
> index d0b7f8e02d..913db6a8a4 100644
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
