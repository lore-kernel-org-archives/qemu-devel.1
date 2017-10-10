Received: from eggs.gnu.org ([2001:4830:134:3::10]:40755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e1wMD-0001Dc-M0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e1wM8-0000m3-4E
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:22:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e1wM7-0000kO-Ti
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:22:04 -0400
Date: Tue, 10 Oct 2017 18:22:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171010182143-mutt-send-email-mst@kernel.org>
References: <1507638879-200718-1-git-send-email-imammedo@redhat.com>
	<1507648660-201549-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507648660-201549-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] pc: make sure that plugged CPUs are of
 the same type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, groug@kaod.org

On Tue, Oct 10, 2017 at 05:17:40PM +0200, Igor Mammedov wrote:
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

Acked-by: Michael S. Tsirkin <mst@redhat.com>

IIUC Paolo's merging this.

> ---
> v2:
>   fix checkpatch error
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
> +    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
> +        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
> +                   ms->cpu_type);
> +        return;
> +    }
> +
>      /* if APIC ID is not set, set it based on socket/core/thread properties */
>      if (cpu->apic_id == UNASSIGNED_APIC_ID) {
>          int max_socket = (max_cpus - 1) / smp_threads / smp_cores;
> -- 
> 2.7.4
