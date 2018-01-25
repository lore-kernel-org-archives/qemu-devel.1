Received: from eggs.gnu.org ([2001:4830:134:3::10]:56874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eeeJN-0001IY-Cv
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 04:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eeeJI-0006nH-Gn
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 04:59:13 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eeeJI-0006mt-9y
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 04:59:08 -0500
Received: by mail-wm0-f65.google.com with SMTP id i186so13441834wmi.4
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 01:59:07 -0800 (PST)
References: <1516434868-24776-1-git-send-email-linzc@zju.edu.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c212a49-6b50-4753-58f5-25837f583a9d@redhat.com>
Date: Thu, 25 Jan 2018 10:59:03 +0100
MIME-Version: 1.0
In-Reply-To: <1516434868-24776-1-git-send-email-linzc@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vcpu: create vcpu thread with
 QEMU_THREAD_DETACHED mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzc@zju.edu.cn>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, crosthwaite.peter@gmail.com

On 20/01/2018 08:54, linzhecheng wrote:
> 1. If we create vcpu thread with QEMU_THREAD_JOINABLE mode,
> we will get memory leak when vcpu thread exits, which will happen
> when hot-unplug vcpus.
> 2. We should use QLIST_FOREACH_SAFE instead of QLIST_FOREACH
> if we need to remove the entry in QLIST.
> 
> Signed-off-by: linzhecheng <linzc@zju.edu.cn>
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 071f4f5..fd95b18 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -282,9 +282,9 @@ err:
>  
>  static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
>  {
> -    struct KVMParkedVcpu *cpu;
> +    struct KVMParkedVcpu *cpu, *next_cpu;
>  
> -    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
> +    QLIST_FOREACH_SAFE(cpu, &s->kvm_parked_vcpus, node, next_cpu) {
>          if (cpu->vcpu_id == vcpu_id) {
>              int kvm_fd;
>  
> diff --git a/cpus.c b/cpus.c
> index 2cb0af9..de3a96b 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1113,6 +1113,9 @@ static void qemu_kvm_destroy_vcpu(CPUState *cpu)
>          error_report("kvm_destroy_vcpu failed");
>          exit(EXIT_FAILURE);
>      }
> +    g_free(cpu->thread);
> +    g_free(cpu->halt_cond);
> +    g_free(cpu->cpu_ases);
>  }
>  
>  static void qemu_tcg_destroy_vcpu(CPUState *cpu)
> @@ -1205,6 +1208,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
>      cpu->created = false;
>      qemu_cond_signal(&qemu_cpu_cond);
>      qemu_mutex_unlock_iothread();
> +    rcu_unregister_thread();
>      return NULL;
>  }
>  
> @@ -1850,7 +1854,7 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
>      snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
>               cpu->cpu_index);
>      qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
> -                       cpu, QEMU_THREAD_JOINABLE);
> +                       cpu, QEMU_THREAD_DETACHED);
>      while (!cpu->created) {
>          qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
>      }
> 

This is dangerous, it risks introducing use-after-free bugs in the vCPU
thread.  Can you instead add a qemu_thread_join call where the vCPU goes
away (e.g. unrealize, I'm not sure)?

Thanks,

Paolo
