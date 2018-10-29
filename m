Received: from eggs.gnu.org ([2001:4830:134:3::10]:35104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH9NP-0001Tm-EV
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH9NJ-0004Hv-GW
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:22:47 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gH9NJ-000479-3X
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:22:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id p2-v6so8335056wmc.2
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:22:29 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-2-cota@braap.org>
Date: Mon, 29 Oct 2018 15:22:26 +0000
Message-ID: <877ei0aibx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 02/71] cpu: rename cpu->work_mutex to
 cpu->lock
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

> This lock will soon protect more fields of the struct. Give
> it a more appropriate name.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qom/cpu.h |  5 +++--
>  cpus-common.c     | 14 +++++++-------
>  cpus.c            |  4 ++--
>  qom/cpu.c         |  2 +-
>  4 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 53488b202f..b813ca28fa 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -315,7 +315,7 @@ struct qemu_work_item;
>   * @mem_io_pc: Host Program Counter at which the memory was accessed.
>   * @mem_io_vaddr: Target virtual address at which the memory was accesse=
d.
>   * @kvm_fd: vCPU file descriptor for KVM.
> - * @work_mutex: Lock to prevent multiple access to @work_list.
> + * @lock: Lock to prevent multiple access to per-CPU fields.
>   * @work_list: List of pending asynchronous work.
>   * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all =
changes
>   *                        to @trace_dstate).
> @@ -356,7 +356,8 @@ struct CPUState {
>      int64_t icount_extra;
>      sigjmp_buf jmp_env;
>
> -    QemuMutex work_mutex;
> +    QemuMutex lock;
> +    /* fields below protected by @lock */
>      QSIMPLEQ_HEAD(, qemu_work_item) work_list;
>
>      CPUAddressSpace *cpu_ases;
> diff --git a/cpus-common.c b/cpus-common.c
> index a2a6cd93a1..2913294cb7 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -115,10 +115,10 @@ struct qemu_work_item {
>
>  static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
>  {
> -    qemu_mutex_lock(&cpu->work_mutex);
> +    qemu_mutex_lock(&cpu->lock);
>      QSIMPLEQ_INSERT_TAIL(&cpu->work_list, wi, node);
>      wi->done =3D false;
> -    qemu_mutex_unlock(&cpu->work_mutex);
> +    qemu_mutex_unlock(&cpu->lock);
>
>      qemu_cpu_kick(cpu);
>  }
> @@ -308,15 +308,15 @@ void process_queued_cpu_work(CPUState *cpu)
>  {
>      struct qemu_work_item *wi;
>
> -    qemu_mutex_lock(&cpu->work_mutex);
> +    qemu_mutex_lock(&cpu->lock);
>      if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
> -        qemu_mutex_unlock(&cpu->work_mutex);
> +        qemu_mutex_unlock(&cpu->lock);
>          return;
>      }
>      while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
>          wi =3D QSIMPLEQ_FIRST(&cpu->work_list);
>          QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
> -        qemu_mutex_unlock(&cpu->work_mutex);
> +        qemu_mutex_unlock(&cpu->lock);
>          if (wi->exclusive) {
>              /* Running work items outside the BQL avoids the following d=
eadlock:
>               * 1) start_exclusive() is called with the BQL taken while a=
nother
> @@ -332,13 +332,13 @@ void process_queued_cpu_work(CPUState *cpu)
>          } else {
>              wi->func(cpu, wi->data);
>          }
> -        qemu_mutex_lock(&cpu->work_mutex);
> +        qemu_mutex_lock(&cpu->lock);
>          if (wi->free) {
>              g_free(wi);
>          } else {
>              atomic_mb_set(&wi->done, true);
>          }
>      }
> -    qemu_mutex_unlock(&cpu->work_mutex);
> +    qemu_mutex_unlock(&cpu->lock);
>      qemu_cond_broadcast(&qemu_work_cond);
>  }
> diff --git a/cpus.c b/cpus.c
> index 6d86522031..b2a9698dc0 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -92,9 +92,9 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
>  {
>      bool ret;
>
> -    qemu_mutex_lock(&cpu->work_mutex);
> +    qemu_mutex_lock(&cpu->lock);
>      ret =3D QSIMPLEQ_EMPTY(&cpu->work_list);
> -    qemu_mutex_unlock(&cpu->work_mutex);
> +    qemu_mutex_unlock(&cpu->lock);
>      return ret;
>  }
>
> diff --git a/qom/cpu.c b/qom/cpu.c
> index c47169896e..d0758c907d 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -372,7 +372,7 @@ static void cpu_common_initfn(Object *obj)
>      cpu->nr_cores =3D 1;
>      cpu->nr_threads =3D 1;
>
> -    qemu_mutex_init(&cpu->work_mutex);
> +    qemu_mutex_init(&cpu->lock);
>      QSIMPLEQ_INIT(&cpu->work_list);
>      QTAILQ_INIT(&cpu->breakpoints);
>      QTAILQ_INIT(&cpu->watchpoints);


--
Alex Benn=C3=A9e
