Received: from eggs.gnu.org ([2001:4830:134:3::10]:41521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH9ed-0001FO-7O
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH9du-0006L0-Uj
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:40:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gH9dt-00069N-7V
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:39:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id r10-v6so9207737wrv.6
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:39:32 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-1-cota@braap.org>
Date: Mon, 29 Oct 2018 15:39:29 +0000
Message-ID: <874ld4ahji.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 01/71] cpu: convert queued work to a
 QSIMPLEQ
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

> Instead of open-coding it.
>
> While at it, make sure that all accesses to the list are
> performed while holding the list's lock.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h |  6 +++---
>  cpus-common.c     | 25 ++++++++-----------------
>  cpus.c            | 14 ++++++++++++--
>  qom/cpu.c         |  1 +
>  4 files changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index dc130cd307..53488b202f 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -315,8 +315,8 @@ struct qemu_work_item;
>   * @mem_io_pc: Host Program Counter at which the memory was accessed.
>   * @mem_io_vaddr: Target virtual address at which the memory was accesse=
d.
>   * @kvm_fd: vCPU file descriptor for KVM.
> - * @work_mutex: Lock to prevent multiple access to queued_work_*.
> - * @queued_work_first: First asynchronous work pending.
> + * @work_mutex: Lock to prevent multiple access to @work_list.
> + * @work_list: List of pending asynchronous work.
>   * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all =
changes
>   *                        to @trace_dstate).
>   * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask=
).
> @@ -357,7 +357,7 @@ struct CPUState {
>      sigjmp_buf jmp_env;
>
>      QemuMutex work_mutex;
> -    struct qemu_work_item *queued_work_first, *queued_work_last;
> +    QSIMPLEQ_HEAD(, qemu_work_item) work_list;

Would:

  QSIMPLEQ_HEAD(work_list, qemu_work_item);

be neater?

>
>      CPUAddressSpace *cpu_ases;
>      int num_ases;
> diff --git a/cpus-common.c b/cpus-common.c
> index 98dd8c6ff1..a2a6cd93a1 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -107,7 +107,7 @@ void cpu_list_remove(CPUState *cpu)
>  }
>
>  struct qemu_work_item {
> -    struct qemu_work_item *next;
> +    QSIMPLEQ_ENTRY(qemu_work_item) node;
>      run_on_cpu_func func;
>      run_on_cpu_data data;
>      bool free, exclusive, done;
> @@ -116,13 +116,7 @@ struct qemu_work_item {
>  static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
>  {
>      qemu_mutex_lock(&cpu->work_mutex);
> -    if (cpu->queued_work_first =3D=3D NULL) {
> -        cpu->queued_work_first =3D wi;
> -    } else {
> -        cpu->queued_work_last->next =3D wi;
> -    }
> -    cpu->queued_work_last =3D wi;
> -    wi->next =3D NULL;
> +    QSIMPLEQ_INSERT_TAIL(&cpu->work_list, wi, node);
>      wi->done =3D false;
>      qemu_mutex_unlock(&cpu->work_mutex);
>
> @@ -314,17 +308,14 @@ void process_queued_cpu_work(CPUState *cpu)
>  {
>      struct qemu_work_item *wi;
>
> -    if (cpu->queued_work_first =3D=3D NULL) {
> +    qemu_mutex_lock(&cpu->work_mutex);
> +    if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
> +        qemu_mutex_unlock(&cpu->work_mutex);
>          return;
>      }
> -
> -    qemu_mutex_lock(&cpu->work_mutex);
> -    while (cpu->queued_work_first !=3D NULL) {
> -        wi =3D cpu->queued_work_first;
> -        cpu->queued_work_first =3D wi->next;
> -        if (!cpu->queued_work_first) {
> -            cpu->queued_work_last =3D NULL;
> -        }
> +    while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
> +        wi =3D QSIMPLEQ_FIRST(&cpu->work_list);
> +        QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
>          qemu_mutex_unlock(&cpu->work_mutex);
>          if (wi->exclusive) {
>              /* Running work items outside the BQL avoids the following d=
eadlock:
> diff --git a/cpus.c b/cpus.c
> index cce64874e6..6d86522031 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -88,9 +88,19 @@ bool cpu_is_stopped(CPUState *cpu)
>      return cpu->stopped || !runstate_is_running();
>  }
>
> +static inline bool cpu_work_list_empty(CPUState *cpu)
> +{
> +    bool ret;
> +
> +    qemu_mutex_lock(&cpu->work_mutex);
> +    ret =3D QSIMPLEQ_EMPTY(&cpu->work_list);
> +    qemu_mutex_unlock(&cpu->work_mutex);
> +    return ret;

This could just be:

  return QSIMPLEQ_EMPTY_ATOMIC(&cpu->work_list)

> +}
> +
>  static bool cpu_thread_is_idle(CPUState *cpu)
>  {
> -    if (cpu->stop || cpu->queued_work_first) {
> +    if (cpu->stop || !cpu_work_list_empty(cpu)) {
>          return false;
>      }
>      if (cpu_is_stopped(cpu)) {
> @@ -1509,7 +1519,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>              cpu =3D first_cpu;
>          }
>
> -        while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
> +        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
>
>              atomic_mb_set(&tcg_current_rr_cpu, cpu);
>              current_cpu =3D cpu;
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 20ad54d43f..c47169896e 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -373,6 +373,7 @@ static void cpu_common_initfn(Object *obj)
>      cpu->nr_threads =3D 1;
>
>      qemu_mutex_init(&cpu->work_mutex);
> +    QSIMPLEQ_INIT(&cpu->work_list);
>      QTAILQ_INIT(&cpu->breakpoints);
>      QTAILQ_INIT(&cpu->watchpoints);

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
