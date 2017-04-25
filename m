Received: from eggs.gnu.org ([2001:4830:134:3::10]:32942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d31Xd-0001ax-8j
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d31Xc-0006MD-DJ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:34:09 -0400
Date: Tue, 25 Apr 2017 16:33:54 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170425143354.6ckotexdnik3deeo@kamzik.brq.redhat.com>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-5-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490189568-167621-5-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 04/23] hw/arm/virt: explicitly
 allocate cpu_index for cpus
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

On Wed, Mar 22, 2017 at 02:32:29PM +0100, Igor Mammedov wrote:
> Currently cpu_index is implicitly auto assigned during
> cpu.realize() time cpu_exec_realizefn()->cpu_list_add().
> 
> It happens to match index in possible_cpus so take
> control over it and make board initialize cpu_index
> to possible_cpus index explicitly. It will at least
> document that board is in control of it and when
> '-device cpu' support comes it will keep cpu_index
> stable regardless of order cpus are created so it won't
> break migration.
> Within this series it will be used for internal
> conversion from storing cpu_index based NUMA node
> bitmaps to property based mapping with possible_cpus,
> And will allow map cpu_index to a CPU entry in
> possible_cpus array.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/arm/virt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4de46b1..0cbcbc1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1364,6 +1364,7 @@ static void machvirt_init(MachineState *machine)
>      mc->possible_cpu_arch_ids(machine);
>      for (n = 0; n < machine->possible_cpus->len; n++) {
>          Object *cpuobj;
> +        CPUState *cs;
>  
>          if (n >= smp_cpus) {
>              break;
> @@ -1373,6 +1374,9 @@ static void machvirt_init(MachineState *machine)
>          object_property_set_int(cpuobj, machine->possible_cpus->cpus[n].arch_id,
>                                  "mp-affinity", NULL);
>  
> +        cs = CPU(cpuobj);
> +        cs->cpu_index = n;
> +
>          if (!vms->secure) {
>              object_property_set_bool(cpuobj, false, "has_el3", NULL);
>          }
> -- 
> 2.7.4
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
