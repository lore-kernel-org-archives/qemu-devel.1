Received: from eggs.gnu.org ([2001:4830:134:3::10]:54928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZcJa-0007Y9-Jp
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZcJX-00047p-H7
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:50:38 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZcJX-00046i-5b
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:50:35 -0500
Received: by mail-lf0-x242.google.com with SMTP id e203so2668015lfg.3
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 04:50:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
	<20180111082621.27295.81834.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b25fab83-2a39-67ee-8111-f8e2763021bd@redhat.com>
Date: Thu, 11 Jan 2018 13:50:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180111082621.27295.81834.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 15/30] cpus: push BQL lock to
 qemu_*_wait_io_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 11/01/2018 09:26, Pavel Dovgalyuk wrote:
> From: Alex Bennée <alex.bennee@linaro.org>
> 
> We only really need to grab the lock for initial setup (so we don't
> race with the thread-spawning thread). After that we can drop the lock
> for the whole main loop and only grab it for waiting for IO events.
> 
> There is a slight wrinkle for the round-robin TCG thread as we also
> expire timers which needs to be done under BQL as they are in the
> main-loop.
> 
> This is stage one of reducing the lock impact as we can drop the
> requirement of implicit BQL for async work and only grab the lock when
> we need to sleep on the cpu->halt_cond.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

qemu_hax_cpu_thread_fn and qemu_hvf_wait_io_event need to be updated
too, now.  However, they can just reuse qemu_kvm_wait_io_event.  I'll
send a patch shortly.

Paolo

> ---
>  accel/kvm/kvm-all.c   |    4 ----
>  cpus.c                |   27 ++++++++++++++++++++-------
>  target/i386/hax-all.c |    2 --
>  3 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f290f48..8d1d2c4 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1857,9 +1857,7 @@ int kvm_cpu_exec(CPUState *cpu)
>          return EXCP_HLT;
>      }
>  
> -    qemu_mutex_unlock_iothread();
>      cpu_exec_start(cpu);
> -
>      do {
>          MemTxAttrs attrs;
>  
> @@ -1989,8 +1987,6 @@ int kvm_cpu_exec(CPUState *cpu)
>      } while (ret == 0);
>  
>      cpu_exec_end(cpu);
> -    qemu_mutex_lock_iothread();
> -
>      if (ret < 0) {
>          cpu_dump_state(cpu, stderr, fprintf, CPU_DUMP_CODE);
>          vm_stop(RUN_STATE_INTERNAL_ERROR);
> diff --git a/cpus.c b/cpus.c
> index b4146a8..82dcbf8 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1149,6 +1149,8 @@ static bool qemu_tcg_should_sleep(CPUState *cpu)
>  
>  static void qemu_tcg_wait_io_event(CPUState *cpu)
>  {
> +    qemu_mutex_lock_iothread();
> +
>      while (qemu_tcg_should_sleep(cpu)) {
>          stop_tcg_kick_timer();
>          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
> @@ -1157,15 +1159,21 @@ static void qemu_tcg_wait_io_event(CPUState *cpu)
>      start_tcg_kick_timer();
>  
>      qemu_wait_io_event_common(cpu);
> +
> +    qemu_mutex_unlock_iothread();
>  }
>  
>  static void qemu_kvm_wait_io_event(CPUState *cpu)
>  {
> +    qemu_mutex_lock_iothread();
> +
>      while (cpu_thread_is_idle(cpu)) {
>          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
>      }
>  
>      qemu_wait_io_event_common(cpu);
> +
> +    qemu_mutex_unlock_iothread();
>  }
>  
>  static void qemu_hvf_wait_io_event(CPUState *cpu)
> @@ -1199,6 +1207,8 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
>  
>      /* signal CPU creation */
>      cpu->created = true;
> +    qemu_mutex_unlock_iothread();
> +
>      qemu_cond_signal(&qemu_cpu_cond);
>  
>      do {
> @@ -1241,10 +1251,10 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
>  
>      /* signal CPU creation */
>      cpu->created = true;
> +    qemu_mutex_unlock_iothread();
>      qemu_cond_signal(&qemu_cpu_cond);
>  
>      while (1) {
> -        qemu_mutex_unlock_iothread();
>          do {
>              int sig;
>              r = sigwait(&waitset, &sig);
> @@ -1255,6 +1265,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
>          }
>          qemu_mutex_lock_iothread();
>          qemu_wait_io_event_common(cpu);
> +        qemu_mutex_unlock_iothread();
>      }
>  
>      return NULL;
> @@ -1343,11 +1354,9 @@ static int tcg_cpu_exec(CPUState *cpu)
>  #ifdef CONFIG_PROFILER
>      ti = profile_getclock();
>  #endif
> -    qemu_mutex_unlock_iothread();
>      cpu_exec_start(cpu);
>      ret = cpu_exec(cpu);
>      cpu_exec_end(cpu);
> -    qemu_mutex_lock_iothread();
>  #ifdef CONFIG_PROFILER
>      tcg_time += profile_getclock() - ti;
>  #endif
> @@ -1407,6 +1416,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>              qemu_wait_io_event_common(cpu);
>          }
>      }
> +    qemu_mutex_unlock_iothread();
>  
>      start_tcg_kick_timer();
>  
> @@ -1416,6 +1426,9 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>      cpu->exit_request = 1;
>  
>      while (1) {
> +
> +        qemu_mutex_lock_iothread();
> +
>          /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
>          qemu_account_warp_timer();
>  
> @@ -1424,6 +1437,8 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>           */
>          handle_icount_deadline();
>  
> +        qemu_mutex_unlock_iothread();
> +
>          if (!cpu) {
>              cpu = first_cpu;
>          }
> @@ -1449,9 +1464,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>                      cpu_handle_guest_debug(cpu);
>                      break;
>                  } else if (r == EXCP_ATOMIC) {
> -                    qemu_mutex_unlock_iothread();
>                      cpu_exec_step_atomic(cpu);
> -                    qemu_mutex_lock_iothread();
>                      break;
>                  }
>              } else if (cpu->stop) {
> @@ -1492,6 +1505,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
>      current_cpu = cpu;
>  
>      hax_init_vcpu(cpu);
> +    qemu_mutex_unlock_iothread();
>      qemu_cond_signal(&qemu_cpu_cond);
>  
>      while (1) {
> @@ -1584,6 +1598,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>      cpu->created = true;
>      cpu->can_do_io = 1;
>      current_cpu = cpu;
> +    qemu_mutex_unlock_iothread();
>      qemu_cond_signal(&qemu_cpu_cond);
>  
>      /* process any pending work */
> @@ -1608,9 +1623,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>                  g_assert(cpu->halted);
>                  break;
>              case EXCP_ATOMIC:
> -                qemu_mutex_unlock_iothread();
>                  cpu_exec_step_atomic(cpu);
> -                qemu_mutex_lock_iothread();
>              default:
>                  /* Ignore everything else? */
>                  break;
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index 3ce6950..9fd60d9 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -513,11 +513,9 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
>  
>          hax_vcpu_interrupt(env);
>  
> -        qemu_mutex_unlock_iothread();
>          cpu_exec_start(cpu);
>          hax_ret = hax_vcpu_run(vcpu);
>          cpu_exec_end(cpu);
> -        qemu_mutex_lock_iothread();
>  
>          /* Simply continue the vcpu_run if system call interrupted */
>          if (hax_ret == -EINTR || hax_ret == -EAGAIN) {
> 
