Received: from eggs.gnu.org ([2001:4830:134:3::10]:56345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d344f-000144-S0
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d344f-00034l-2n
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:16:25 -0400
Date: Tue, 25 Apr 2017 19:16:13 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170425171613.sfsjxu6jjuelq54f@kamzik.brq.redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-9-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490189568-167621-9-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 08/23] virt-arm: add node-id
 property to CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, Mar 22, 2017 at 02:32:33PM +0100, Igor Mammedov wrote:
> it will allow switching from cpu_index to property based
> numa mapping in follow up patches.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/arm/virt.c    | 15 +++++++++++++++
>  target/arm/cpu.c |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 8748d25..68d44f3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1365,6 +1365,7 @@ static void machvirt_init(MachineState *machine)
>      for (n = 0; n < machine->possible_cpus->len; n++) {
>          Object *cpuobj;
>          CPUState *cs;
> +        int node_id;
>  
>          if (n >= smp_cpus) {
>              break;
> @@ -1377,6 +1378,20 @@ static void machvirt_init(MachineState *machine)
>          cs = CPU(cpuobj);
>          cs->cpu_index = n;
>  
> +        node_id = numa_get_node_for_cpu(cs->cpu_index);
> +        if (node_id == nb_numa_nodes) {
> +            /* by default CPUState::numa_node was 0 if it's not set via CLI
> +             * keep it this way for now but in future we probably should
> +             * refuse to start up with incomplete numa mapping */
> +             node_id = 0;

Do other architectures already abort on incomplete numa? If so, it'd be
nice to do that for mach-virt sooner than later. I guess we just need
another compat variable for 2.9 and older machine types.  I think libvirt
always supplies all cpu-node mappings, if any, so there shouldn't be an
issue with it.

Thanks,
drew
