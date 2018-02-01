Received: from eggs.gnu.org ([2001:4830:134:3::10]:51296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG3u-0000uY-Vj
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:42:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehG3r-0001yQ-RB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:42:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehG3r-0001xr-L2
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:41:59 -0500
References: <1517483068-18735-1-git-send-email-linzc@zju.edu.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ba84980-3629-4bfb-ae13-01ab330b089e@redhat.com>
Date: Thu, 1 Feb 2018 09:41:55 -0500
MIME-Version: 1.0
In-Reply-To: <1517483068-18735-1-git-send-email-linzc@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] vcpu: join vcpu thread after it exiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzc@zju.edu.cn>, qemu-devel@nongnu.org
Cc: crosthwaite.peter@gmail.com, rth@twiddle.net, linzhecheng <linzhecheng@huawei.com>

On 01/02/2018 06:04, linzhecheng wrote:
> As we create vcpu thread with QEMU_THREAD_JOINABLE mode,
> we should join it after it exiting to cleanup resources.
> 
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f290f48..5cc1ba2 100644
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

This is not needed because removing the node results in an immediate
return..

> diff --git a/cpus.c b/cpus.c
> index 2cb0af9..1890bfe 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1205,6 +1205,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
>      cpu->created = false;
>      qemu_cond_signal(&qemu_cpu_cond);
>      qemu_mutex_unlock_iothread();
> +    rcu_unregister_thread();
>      return NULL;
>  }
>  
> @@ -1759,6 +1760,7 @@ void cpu_remove_sync(CPUState *cpu)
>      cpu_remove(cpu);
>      while (cpu->created) {
>          qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
> +        qemu_thread_join(cpu->thread);
>      }
>  }
>  
> 

Thanks.  There are other issues in qemu_*_cpu_thread_fn, I'll send a
more complete series shortly.

Paolo
