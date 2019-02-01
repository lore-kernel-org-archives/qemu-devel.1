Received: from eggs.gnu.org ([209.51.188.92]:32785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpY10-0004Hc-Ov
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpY0z-0005ST-8G
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:33:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpY0y-0005QO-Vu
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:33:49 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190201051806.53183-1-lifei1214@126.com>
	<20190201051806.53183-3-lifei1214@126.com>
Date: Fri, 01 Feb 2019 13:33:43 +0100
In-Reply-To: <20190201051806.53183-3-lifei1214@126.com> (Fei Li's message of
	"Fri, 1 Feb 2019 13:17:57 +0800")
Message-ID: <87sgx77kns.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 for-4.0 02/11] qemu_thread: supplement
 error handling for qemu_X_start_vcpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Fei Li <fli@suse.com>, Paolo Bonzini <pbonzini@redhat.com>

Fei Li <lifei1214@126.com> writes:

> From: Fei Li <fli@suse.com>
>
> The callers of qemu_init_vcpu() already passed the **errp to handle
> errors. In view of this, add a new Error parameter to qemu_init_vcpu()
> and all qemu_X_start_vcpu() functions called by qemu_init_vcpu() to
> propagate the error and let the further callers check it.
>
> Besides, make qemu_init_vcpu() return a Boolean value to let its
> callers know whether it succeeds.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  accel/tcg/user-exec-stub.c      |  3 +-
>  cpus.c                          | 74 +++++++++++++++++++--------------
>  include/qom/cpu.h               |  2 +-
>  target/alpha/cpu.c              |  4 +-
>  target/arm/cpu.c                |  4 +-
>  target/cris/cpu.c               |  4 +-
>  target/hppa/cpu.c               |  4 +-
>  target/i386/cpu.c               |  4 +-
>  target/lm32/cpu.c               |  4 +-
>  target/m68k/cpu.c               |  4 +-
>  target/microblaze/cpu.c         |  4 +-
>  target/mips/cpu.c               |  4 +-
>  target/moxie/cpu.c              |  4 +-
>  target/nios2/cpu.c              |  4 +-
>  target/openrisc/cpu.c           |  4 +-
>  target/ppc/translate_init.inc.c |  4 +-
>  target/riscv/cpu.c              |  4 +-
>  target/s390x/cpu.c              |  4 +-
>  target/sh4/cpu.c                |  4 +-
>  target/sparc/cpu.c              |  4 +-
>  target/tilegx/cpu.c             |  4 +-
>  target/tricore/cpu.c            |  4 +-
>  target/unicore32/cpu.c          |  4 +-
>  target/xtensa/cpu.c             |  4 +-
>  24 files changed, 108 insertions(+), 55 deletions(-)
>
> diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
> index a32b4496af..f8c38a375c 100644
> --- a/accel/tcg/user-exec-stub.c
> +++ b/accel/tcg/user-exec-stub.c
> @@ -10,8 +10,9 @@ void cpu_resume(CPUState *cpu)
>  {
>  }
>  
> -void qemu_init_vcpu(CPUState *cpu)
> +bool qemu_init_vcpu(CPUState *cpu, Error **errp)
>  {
> +    return true;
>  }
>  
>  /* User mode emulation does not support record/replay yet.  */
> diff --git a/cpus.c b/cpus.c
> index 843a0f06a2..4ed7d62e58 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1931,7 +1931,7 @@ void cpu_remove_sync(CPUState *cpu)
>  /* For temporary buffers for forming a name */
>  #define VCPU_THREAD_NAME_SIZE 16
>  
> -static void qemu_tcg_init_vcpu(CPUState *cpu)
> +static void qemu_tcg_init_vcpu(CPUState *cpu, Error **errp)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
>      static QemuCond *single_tcg_halt_cond;
> @@ -1961,17 +1961,20 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>              snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
>                   cpu->cpu_index);
>  
> -            /* TODO: let the callers handle the error instead of abort() here */
> -            qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
> -                               cpu, QEMU_THREAD_JOINABLE, &error_abort);
> +            if (qemu_thread_create(cpu->thread, thread_name,
> +                                   qemu_tcg_cpu_thread_fn, cpu,
> +                                   QEMU_THREAD_JOINABLE, errp) < 0) {
> +                return;
> +            }
>  
>          } else {
>              /* share a single thread for all cpus with TCG */
>              snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
> -            /* TODO: let the callers handle the error instead of abort() here */
> -            qemu_thread_create(cpu->thread, thread_name,
> -                               qemu_tcg_rr_cpu_thread_fn,
> -                               cpu, QEMU_THREAD_JOINABLE, &error_abort);
> +            if (qemu_thread_create(cpu->thread, thread_name,
> +                                   qemu_tcg_rr_cpu_thread_fn, cpu,
> +                                   QEMU_THREAD_JOINABLE, errp) < 0) {
> +                return;
> +            }
>  
>              single_tcg_halt_cond = cpu->halt_cond;
>              single_tcg_cpu_thread = cpu->thread;
> @@ -1989,7 +1992,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>      }
>  }
>  
> -static void qemu_hax_start_vcpu(CPUState *cpu)
> +static void qemu_hax_start_vcpu(CPUState *cpu, Error **errp)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
>  
> @@ -1999,15 +2002,16 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
>  
>      snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
>               cpu->cpu_index);
> -    /* TODO: let the further caller handle the error instead of abort() here */
> -    qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
> -                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
> +    if (qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
> +                           cpu, QEMU_THREAD_JOINABLE, errp) < 0) {
> +        return;
> +    }
>  #ifdef _WIN32
>      cpu->hThread = qemu_thread_get_handle(cpu->thread);
>  #endif
>  }
>  
> -static void qemu_kvm_start_vcpu(CPUState *cpu)
> +static void qemu_kvm_start_vcpu(CPUState *cpu, Error **errp)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
>  
> @@ -2016,12 +2020,11 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
>      qemu_cond_init(cpu->halt_cond);
>      snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
>               cpu->cpu_index);
> -    /* TODO: let the further caller handle the error instead of abort() here */
>      qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
> -                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
> +                       cpu, QEMU_THREAD_JOINABLE, errp);
>  }
>  
> -static void qemu_hvf_start_vcpu(CPUState *cpu)
> +static void qemu_hvf_start_vcpu(CPUState *cpu, Error **errp)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
>  
> @@ -2035,12 +2038,11 @@ static void qemu_hvf_start_vcpu(CPUState *cpu)
>  
>      snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
>               cpu->cpu_index);
> -    /* TODO: let the further caller handle the error instead of abort() here */
>      qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
> -                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
> +                       cpu, QEMU_THREAD_JOINABLE, errp);
>  }
>  
> -static void qemu_whpx_start_vcpu(CPUState *cpu)
> +static void qemu_whpx_start_vcpu(CPUState *cpu, Error **errp)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
>  
> @@ -2049,15 +2051,16 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
>      qemu_cond_init(cpu->halt_cond);
>      snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
>               cpu->cpu_index);
> -    /* TODO: let the further caller handle the error instead of abort() here */
> -    qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
> -                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
> +    if (qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
> +                           cpu, QEMU_THREAD_JOINABLE, errp) < 0) {
> +        return;
> +    }
>  #ifdef _WIN32
>      cpu->hThread = qemu_thread_get_handle(cpu->thread);
>  #endif
>  }
>  
> -static void qemu_dummy_start_vcpu(CPUState *cpu)
> +static void qemu_dummy_start_vcpu(CPUState *cpu, Error **errp)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
>  
> @@ -2066,16 +2069,16 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
>      qemu_cond_init(cpu->halt_cond);
>      snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
>               cpu->cpu_index);
> -    /* TODO: let the further caller handle the error instead of abort() here */
>      qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn,
> -                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
> +                       cpu, QEMU_THREAD_JOINABLE, errp);
>  }
>  
> -void qemu_init_vcpu(CPUState *cpu)
> +bool qemu_init_vcpu(CPUState *cpu, Error **errp)
>  {
>      cpu->nr_cores = smp_cores;
>      cpu->nr_threads = smp_threads;
>      cpu->stopped = true;
> +    Error *local_err = NULL;
>  
>      if (!cpu->as) {
>          /* If the target cpu hasn't set up any address spaces itself,
> @@ -2086,22 +2089,29 @@ void qemu_init_vcpu(CPUState *cpu)
>      }
>  
>      if (kvm_enabled()) {
> -        qemu_kvm_start_vcpu(cpu);
> +        qemu_kvm_start_vcpu(cpu, &local_err);
>      } else if (hax_enabled()) {
> -        qemu_hax_start_vcpu(cpu);
> +        qemu_hax_start_vcpu(cpu, &local_err);
>      } else if (hvf_enabled()) {
> -        qemu_hvf_start_vcpu(cpu);
> +        qemu_hvf_start_vcpu(cpu, &local_err);
>      } else if (tcg_enabled()) {
> -        qemu_tcg_init_vcpu(cpu);
> +        qemu_tcg_init_vcpu(cpu, &local_err);
>      } else if (whpx_enabled()) {
> -        qemu_whpx_start_vcpu(cpu);
> +        qemu_whpx_start_vcpu(cpu, &local_err);
>      } else {
> -        qemu_dummy_start_vcpu(cpu);
> +        qemu_dummy_start_vcpu(cpu, &local_err);
> +    }
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return false;
>      }
>  
>      while (!cpu->created) {
>          qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
>      }
> +
> +    return true;
>  }
>  
>  void cpu_stop_current(void)

If the qemu_FOO_init_vcpu() returned success / failure like their callee
qemu_thread_create() and their caller qemu_init_vcpu() do, then this
code would be simpler.

But it's not wrong, and we're at v11, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>

[...]
