Received: from eggs.gnu.org ([2001:4830:134:3::10]:45367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1trE-0007Zq-Lv
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1trA-0006DZ-P2
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:42:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1trA-0006DB-Id
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:41:56 -0400
References: <1507638879-200718-1-git-send-email-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <542ba874-d38d-7510-be33-7b53b10d7251@redhat.com>
Date: Tue, 10 Oct 2017 14:41:19 +0200
MIME-Version: 1.0
In-Reply-To: <1507638879-200718-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: make sure that plugged CPUs are of the
 same type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, rth@twiddle.net, ehabkost@redhat.com, groug@kaod.org

On 10/10/2017 14:34, Igor Mammedov wrote:
> heterogeneous cpus are not supported and hotplugging different
> cpu model crashes QEMU:
> 
>   qemu-system-x86_64 -cpu qemu64 -smp 1,maxcpus=2
>   (qemu) device_add host-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,id=foo
>   (qemu) info cpus
>   error: failed to get MSR 0x38d
>   qemu-system-x86_64: target/i386/kvm.c:2121: kvm_get_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
>   Aborted (core dumped)
> 
> Gracefully fail hotplug process in case of user mistake.
> 
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/i386/pc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 05985d4..8e307f7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1876,8 +1876,15 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      CPUArchId *cpu_slot;
>      X86CPUTopoInfo topo;
>      X86CPU *cpu = X86_CPU(dev);
> +    MachineState *ms = MACHINE(hotplug_dev);
>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
>  
> +    if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
> +        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
> +                   ms->cpu_type);
> +        return;
> +    }
> +
>      /* if APIC ID is not set, set it based on socket/core/thread properties */
>      if (cpu->apic_id == UNASSIGNED_APIC_ID) {
>          int max_socket = (max_cpus - 1) / smp_threads / smp_cores;
> 

Queued, thanks!

Paolo
