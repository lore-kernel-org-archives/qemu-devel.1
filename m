Received: from eggs.gnu.org ([2001:4830:134:3::10]:51936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dor85-0006mm-5J
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dor71-0006l3-3h
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:09:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dor70-0006fK-Os
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:08:23 -0400
Date: Mon, 4 Sep 2017 10:08:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170904130814.GR7570@localhost.localdomain>
References: <20170901154542.5687-1-cascardo@canonical.com>
	<20170901161118.GQ7570@localhost.localdomain>
	<2ab3aaef-c6d7-ae3d-808b-f947dcb3ed1c@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab3aaef-c6d7-ae3d-808b-f947dcb3ed1c@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH] x86/acpi: build SRAT when memory hotplug
 is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Sep 04, 2017 at 09:38:47AM +0800, Dou Liyang wrote:
> Hi Eduardo, Thadeu,
> 
> At 09/02/2017 12:11 AM, Eduardo Habkost wrote:
> > On Fri, Sep 01, 2017 at 12:45:42PM -0300, Thadeu Lima de Souza Cascardo wrote:
> > > Linux uses SRAT to determine the maximum memory in a system, which is
> > > used to determine whether to use the swiotlb for IOMMU or not for a
> > > device that supports only 32 bits of addresses.
> > 
> > Do you have a pointer to the corresponding Linux code, for
> > reference?  Which SRAT entries Linux uses to make this decision?
> > 
> > > 
> > > When there is no NUMA configuration, qemu will not build SRAT. And when
> > > memory hotplug is done, some Linux device drivers start failing.
> > > 
> > > Tested by running with -m 512M,slots=8,maxmem=1G, adding the memory,
> > > putting that online and using the system. Without the patch, swiotlb is
> > > not used and ATA driver fails. With the patch, swiotlb is used, no
> > > driver failure is observed.
> > > 
> > > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > 
> > As far as I can see, this will only add APIC entries and a memory
> > affinity entry for the first 640KB (which would be obviously
> > wrong) if pcms->numa_nodes is 0.
> > 
> 
> In my opinion, this may also add the hotpluggable memory, and see the
> following commemts.
> 
>     /*
>      * Entry is required for Windows to enable memory hotplug in OS
>      * and for Linux to enable SWIOTLB when booted with less than
>            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      * 4G of RAM. Windows works better if the entry sets proximity
>      * to the highest NUMA node in the machine.
>      * Memory devices may override proximity set by this entry,
>      * providing _PXM method if necessary.
>      */
>     if (hotplugabble_address_space_size) {
>         numamem = acpi_data_push(table_data, sizeof *numamem);
>         build_srat_memory(numamem, pcms->hotplug_memory.base,
>                           hotplugabble_address_space_size, pcms->numa_nodes
> - 1,
>                           MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>     }

You are correct, I didn't see that part of the code.  If that's
the entry that's missing, the patch makes sense.  Thanks!

However, the resulting tables still don't look correct: it will
generate an entry assigned to NUMA node (uint32_t)-1 if no NUMA
nodes are configured elsewhere, some APIC entries, but no entries
for the rest of the memory.

Igor's suggestion to enable NUMA implicitly sounds safer to me.

> 
> 
> Thanks,
> 	dou.
> 
> > Once we apply the "Fix SRAT memory building in case of node 0
> > without RAM" patch from Dou Liyang, no memory affinity entries
> > will be generated if pcms->numa_nodes is 0.  Would this cause the
> > problem to happen again?
> > 
> 
> 
> 
> > 
> > > ---
> > >  hw/i386/acpi-build.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index 98dd424678..fb94249779 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -2645,6 +2645,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
> > >      GArray *tables_blob = tables->table_data;
> > >      AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
> > >      Object *vmgenid_dev;
> > > +    ram_addr_t hotplugabble_address_space_size =
> > > +        object_property_get_int(OBJECT(pcms), PC_MACHINE_MEMHP_REGION_SIZE,
> > > +                                NULL);
> > > 
> > >      acpi_get_pm_info(&pm);
> > >      acpi_get_misc_info(&misc);
> > > @@ -2708,7 +2711,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
> > >              build_tpm2(tables_blob, tables->linker);
> > >          }
> > >      }
> > > -    if (pcms->numa_nodes) {
> > > +    if (pcms->numa_nodes || hotplugabble_address_space_size) {
> > >          acpi_add_table(table_offsets, tables_blob);
> > >          build_srat(tables_blob, tables->linker, machine);
> > >          if (have_numa_distance) {
> > > --
> > > 2.11.0
> > > 
> > 
> 
> 

-- 
Eduardo
