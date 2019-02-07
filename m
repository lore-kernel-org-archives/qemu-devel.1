Received: from eggs.gnu.org ([209.51.188.92]:40303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1griyN-0007Ak-K6
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1griyM-0003BQ-8v
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:40:07 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1griyL-0003Ax-Vh
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:40:06 -0500
Received: by mail-wr1-x444.google.com with SMTP id x10so11344697wrs.8
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 04:40:05 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-8-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-8-cota@braap.org>
Date: Thu, 07 Feb 2019 12:40:02 +0000
Message-ID: <87va1vn55p.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 07/73] cpu: make per-CPU locks an alias
 of the BQL in TCG rr mode
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

> Before we can switch from the BQL to per-CPU locks in
> the CPU loop, we have to accommodate the fact that TCG
> rr mode (i.e. !MTTCG) cannot work with separate per-vCPU
> locks. That would lead to deadlock since we need a single
> lock/condvar pair on which to wait for events that affect
> any vCPU, e.g. in qemu_tcg_rr_wait_io_event.
>
> At the same time, we are moving towards an interface where
> the BQL and CPU locks are independent, and the only requirement
> is that the locking order is respected, i.e. the BQL is
> acquired first if both locks have to be held at the same time.
>
> In this patch we make the BQL a recursive lock under the hood.
> This allows us to (1) keep the BQL and CPU locks interfaces
> separate, and (2) use a single lock for all vCPUs in TCG rr mode.
>
> Note that the BQL's API (qemu_mutex_lock/unlock_iothread) remains
> non-recursive.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qom/cpu.h |  2 +-
>  cpus-common.c     |  2 +-
>  cpus.c            | 90 +++++++++++++++++++++++++++++++++++++++++------
>  qom/cpu.c         |  3 +-
>  stubs/cpu-lock.c  |  6 ++--
>  5 files changed, 86 insertions(+), 17 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index fe389037c5..8b85a036cf 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -363,7 +363,7 @@ struct CPUState {
>      int64_t icount_extra;
>      sigjmp_buf jmp_env;
>
> -    QemuMutex lock;
> +    QemuMutex *lock;
>      /* fields below protected by @lock */
>      QemuCond cond;
>      QSIMPLEQ_HEAD(, qemu_work_item) work_list;
> diff --git a/cpus-common.c b/cpus-common.c
> index 99662bfa87..62e282bff1 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -171,7 +171,7 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, =
run_on_cpu_data data)
>      while (!atomic_mb_read(&wi.done)) {
>          CPUState *self_cpu =3D current_cpu;
>
> -        qemu_cond_wait(&cpu->cond, &cpu->lock);
> +        qemu_cond_wait(&cpu->cond, cpu->lock);
>          current_cpu =3D self_cpu;
>      }
>      cpu_mutex_unlock(cpu);
> diff --git a/cpus.c b/cpus.c
> index 755e4addab..c4fa3cc876 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -83,6 +83,12 @@ static unsigned int throttle_percentage;
>  #define CPU_THROTTLE_PCT_MAX 99
>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
>
> +static inline bool qemu_is_tcg_rr(void)
> +{
> +    /* in `make check-qtest', "use_icount && !tcg_enabled()" might be tr=
ue */
> +    return use_icount || (tcg_enabled() && !qemu_tcg_mttcg_enabled());
> +}
> +
>  /* XXX: is this really the max number of CPUs? */
>  #define CPU_LOCK_BITMAP_SIZE 2048
>
> @@ -98,25 +104,76 @@ bool no_cpu_mutex_locked(void)
>      return bitmap_empty(cpu_lock_bitmap, CPU_LOCK_BITMAP_SIZE);
>  }
>
> -void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
> +static QemuMutex qemu_global_mutex;
> +static __thread bool iothread_locked;
> +/*
> + * In TCG rr mode, we make the BQL a recursive mutex, so that we can use=
 it for
> + * all vCPUs while keeping the interface as if the locks were per-CPU.
> + *
> + * The fact that the BQL is implemented recursively is invisible to BQL =
users;
> + * the mutex API we export (qemu_mutex_lock_iothread() etc.) is non-recu=
rsive.
> + *
> + * Locking order: the BQL is always acquired before CPU locks.
> + */
> +static __thread int iothread_lock_count;
> +
> +static void rr_cpu_mutex_lock(void)
> +{
> +    if (iothread_lock_count++ =3D=3D 0) {
> +        /*
> +         * Circumvent qemu_mutex_lock_iothread()'s state keeping by
> +         * acquiring the BQL directly.
> +         */
> +        qemu_mutex_lock(&qemu_global_mutex);
> +    }
> +}
> +
> +static void rr_cpu_mutex_unlock(void)
> +{
> +    g_assert(iothread_lock_count > 0);
> +    if (--iothread_lock_count =3D=3D 0) {
> +        /*
> +         * Circumvent qemu_mutex_unlock_iothread()'s state keeping by
> +         * releasing the BQL directly.
> +         */
> +        qemu_mutex_unlock(&qemu_global_mutex);
> +    }
> +}
> +
> +static void do_cpu_mutex_lock(CPUState *cpu, const char *file, int line)
>  {
> -/* coverity gets confused by the indirect function call */
> +    /* coverity gets confused by the indirect function call */
>  #ifdef __COVERITY__
> -    qemu_mutex_lock_impl(&cpu->lock, file, line);
> +    qemu_mutex_lock_impl(cpu->lock, file, line);
>  #else
>      QemuMutexLockFunc f =3D atomic_read(&qemu_mutex_lock_func);
>
> +    f(cpu->lock, file, line);
> +#endif
> +}
> +
> +void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
> +{
>      g_assert(!cpu_mutex_locked(cpu));
>      set_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
> -    f(&cpu->lock, file, line);
> -#endif
> +
> +    if (qemu_is_tcg_rr()) {
> +        rr_cpu_mutex_lock();
> +    } else {
> +        do_cpu_mutex_lock(cpu, file, line);
> +    }
>  }
>
>  void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
>  {
>      g_assert(cpu_mutex_locked(cpu));
> -    qemu_mutex_unlock_impl(&cpu->lock, file, line);
>      clear_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
> +
> +    if (qemu_is_tcg_rr()) {
> +        rr_cpu_mutex_unlock();
> +        return;
> +    }
> +    qemu_mutex_unlock_impl(cpu->lock, file, line);
>  }
>
>  bool cpu_mutex_locked(const CPUState *cpu)
> @@ -1215,8 +1272,6 @@ static void qemu_init_sigbus(void)
>  }
>  #endif /* !CONFIG_LINUX */
>
> -static QemuMutex qemu_global_mutex;
> -
>  static QemuThread io_thread;
>
>  /* cpu creation */
> @@ -1876,8 +1931,6 @@ bool qemu_in_vcpu_thread(void)
>      return current_cpu && qemu_cpu_is_self(current_cpu);
>  }
>
> -static __thread bool iothread_locked =3D false;
> -
>  bool qemu_mutex_iothread_locked(void)
>  {
>      return iothread_locked;
> @@ -1896,6 +1949,8 @@ void qemu_mutex_lock_iothread_impl(const char *file=
, int line)
>
>      g_assert(!qemu_mutex_iothread_locked());
>      bql_lock(&qemu_global_mutex, file, line);
> +    g_assert(iothread_lock_count =3D=3D 0);
> +    iothread_lock_count++;
>      iothread_locked =3D true;
>  }
>
> @@ -1903,7 +1958,10 @@ void qemu_mutex_unlock_iothread(void)
>  {
>      g_assert(qemu_mutex_iothread_locked());
>      iothread_locked =3D false;
> -    qemu_mutex_unlock(&qemu_global_mutex);
> +    g_assert(iothread_lock_count > 0);
> +    if (--iothread_lock_count =3D=3D 0) {
> +        qemu_mutex_unlock(&qemu_global_mutex);
> +    }
>  }
>
>  static bool all_vcpus_paused(void)
> @@ -2127,6 +2185,16 @@ void qemu_init_vcpu(CPUState *cpu)
>          cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
>      }
>
> +    /*
> +     * In TCG RR, cpu->lock is the BQL under the hood. In all other mode=
s,
> +     * cpu->lock is a standalone per-CPU lock.
> +     */
> +    if (qemu_is_tcg_rr()) {
> +        qemu_mutex_destroy(cpu->lock);
> +        g_free(cpu->lock);
> +        cpu->lock =3D &qemu_global_mutex;
> +    }
> +
>      if (kvm_enabled()) {
>          qemu_kvm_start_vcpu(cpu);
>      } else if (hax_enabled()) {
> diff --git a/qom/cpu.c b/qom/cpu.c
> index be8393e589..2c05aa1bca 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -371,7 +371,8 @@ static void cpu_common_initfn(Object *obj)
>      cpu->nr_cores =3D 1;
>      cpu->nr_threads =3D 1;
>
> -    qemu_mutex_init(&cpu->lock);
> +    cpu->lock =3D g_new(QemuMutex, 1);
> +    qemu_mutex_init(cpu->lock);
>      qemu_cond_init(&cpu->cond);
>      QSIMPLEQ_INIT(&cpu->work_list);
>      QTAILQ_INIT(&cpu->breakpoints);
> diff --git a/stubs/cpu-lock.c b/stubs/cpu-lock.c
> index 3f07d3a28b..7406a66d97 100644
> --- a/stubs/cpu-lock.c
> +++ b/stubs/cpu-lock.c
> @@ -5,16 +5,16 @@ void cpu_mutex_lock_impl(CPUState *cpu, const char *fil=
e, int line)
>  {
>  /* coverity gets confused by the indirect function call */
>  #ifdef __COVERITY__
> -    qemu_mutex_lock_impl(&cpu->lock, file, line);
> +    qemu_mutex_lock_impl(cpu->lock, file, line);
>  #else
>      QemuMutexLockFunc f =3D atomic_read(&qemu_mutex_lock_func);
> -    f(&cpu->lock, file, line);
> +    f(cpu->lock, file, line);
>  #endif
>  }
>
>  void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
>  {
> -    qemu_mutex_unlock_impl(&cpu->lock, file, line);
> +    qemu_mutex_unlock_impl(cpu->lock, file, line);
>  }
>
>  bool cpu_mutex_locked(const CPUState *cpu)


--
Alex Benn=C3=A9e
