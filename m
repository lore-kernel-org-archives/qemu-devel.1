Received: from eggs.gnu.org ([2001:4830:134:3::10]:59102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fsSpW-0006bw-Ih
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fsSpR-0004Ye-V7
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:05:46 -0400
Date: Wed, 22 Aug 2018 15:05:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180822150536.6d79a1e1@redhat.com>
In-Reply-To: <c88ef55d-738b-57bc-f00f-b4a4d7303bd6@redhat.com>
References: <1534931204-112747-1-git-send-email-imammedo@redhat.com>
	<c88ef55d-738b-57bc-f00f-b4a4d7303bd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: acpi: revert back to 1 SRAT entry for
 hotpluggable area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, haozhong.zhang@intel.com, qemu-stable@nongnu.org, ehabkost@redhat.com, mst@redhat.com, xiaoguangrong.eric@gmail.com, john.ji@intel.com

On Wed, 22 Aug 2018 12:06:26 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 08/22/18 11:46, Igor Mammedov wrote:
> > Commit
> >   10efd7e108 "pc: acpi: fix memory hotplug regression by reducing stub SRAT entry size"
> > attemped to fix hotplug regression introduced by
> >   848a1cc1e "hw/acpi-build: build SRAT memory affinity structures for DIMM devices"
> > 
> > fixed issue for Windows/3.0+ linux kernels, however it regressed 2.6 based
> > kernels (RHEL6) to the point where guest might crash at boot.
> > Reason is that 2.6 kernel discards SRAT table due too small last entry
> > which down the road leads to crashes. Hack I've tried in 10efd7e108 is also
> > not ACPI spec compliant according to which whole possible RAM should be
> > described in SRAT. Revert 10efd7e108 to fix regression for 2.6 based kernels.
> > 
> > With 10efd7e108 reverted, I've also tried splitting SRAT table statically
> > in different ways %/node and %/slot but Windows still fails to online
> > 2nd pc-dimm hot-plugged into node 0 (as described in 10efd7e108) and
> > sometimes even coldplugged pc-dimms where affected with static SRAT
> > partitioning.
> > The only known so far way where Windows stays happy is when we have 1
> > SRAT entry in the last node covering all hotplug area.
> > 
> > Revert 848a1cc1e until we come up with a way to avoid regression
> > on Windows with hotplug area split in several entries.
> > Tested this with 2.6/3.0 based kernels (RHEL6/7) and WS20[08/12/12R2/16]).
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CC: haozhong.zhang@intel.com
> > CC: mst@redhat.com
> > CC: qemu-stable@nongnu.org
> > CC: ehabkost@redhat.com
> > CC: lersek@redhat.com
> > ---
> >  hw/i386/acpi-build.c | 73 +++++++++-------------------------------------------
> >  1 file changed, 12 insertions(+), 61 deletions(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index e1ee8ae..1599caa 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -2251,64 +2251,6 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
> >  #define HOLE_640K_START  (640 * KiB)
> >  #define HOLE_640K_END   (1 * MiB)
> >  
> > -static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
> > -                                           uint64_t len, int default_node)
> > -{
> > -    MemoryDeviceInfoList *info_list = qmp_memory_device_list();
> > -    MemoryDeviceInfoList *info;
> > -    MemoryDeviceInfo *mi;
> > -    PCDIMMDeviceInfo *di;
> > -    uint64_t end = base + len, cur, size;
> > -    bool is_nvdimm;
> > -    AcpiSratMemoryAffinity *numamem;
> > -    MemoryAffinityFlags flags;
> > -
> > -    for (cur = base, info = info_list;
> > -         cur < end;
> > -         cur += size, info = info->next) {
> > -        numamem = acpi_data_push(table_data, sizeof *numamem);
> > -
> > -        if (!info) {
> > -            /*
> > -             * Entry is required for Windows to enable memory hotplug in OS
> > -             * and for Linux to enable SWIOTLB when booted with less than
> > -             * 4G of RAM. Windows works better if the entry sets proximity
> > -             * to the highest NUMA node in the machine at the end of the
> > -             * reserved space.
> > -             * Memory devices may override proximity set by this entry,
> > -             * providing _PXM method if necessary.
> > -             */
> > -            build_srat_memory(numamem, end - 1, 1, default_node,
> > -                              MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> > -            break;
> > -        }
> > -
> > -        mi = info->value;
> > -        is_nvdimm = (mi->type == MEMORY_DEVICE_INFO_KIND_NVDIMM);
> > -        di = !is_nvdimm ? mi->u.dimm.data : mi->u.nvdimm.data;
> > -
> > -        if (cur < di->addr) {
> > -            build_srat_memory(numamem, cur, di->addr - cur, default_node,
> > -                              MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> > -            numamem = acpi_data_push(table_data, sizeof *numamem);
> > -        }
> > -
> > -        size = di->size;
> > -
> > -        flags = MEM_AFFINITY_ENABLED;
> > -        if (di->hotpluggable) {
> > -            flags |= MEM_AFFINITY_HOTPLUGGABLE;
> > -        }
> > -        if (is_nvdimm) {
> > -            flags |= MEM_AFFINITY_NON_VOLATILE;
> > -        }
> > -
> > -        build_srat_memory(numamem, di->addr, size, di->node, flags);
> > -    }
> > -
> > -    qapi_free_MemoryDeviceInfoList(info_list);
> > -}
> > -
> >  static void
> >  build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
> >  {
> > @@ -2414,10 +2356,19 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
> >          build_srat_memory(numamem, 0, 0, 0, MEM_AFFINITY_NOFLAGS);
> >      }
> >  
> > +    /*
> > +     * Entry is required for Windows to enable memory hotplug in OS
> > +     * and for Linux to enable SWIOTLB when booted with less than
> > +     * 4G of RAM. Windows works better if the entry sets proximity
> > +     * to the highest NUMA node in the machine.
> > +     * Memory devices may override proximity set by this entry,
> > +     * providing _PXM method if necessary.
> > +     */
> >      if (hotplugabble_address_space_size) {
> > -        build_srat_hotpluggable_memory(table_data, machine->device_memory->base,
> > -                                       hotplugabble_address_space_size,
> > -                                       pcms->numa_nodes - 1);
> > +        numamem = acpi_data_push(table_data, sizeof *numamem);
> > +        build_srat_memory(numamem, machine->device_memory->base,
> > +                          hotplugabble_address_space_size, pcms->numa_nodes - 1,
> > +                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> >      }
> >  
> >      build_header(linker, table_data,
> >   
> 
> So this reverts both 10efd7e108 (which only moved the regression around)
> and the earlier 848a1cc1e (which had introduced the regression in the
> first place).
> 
> If I understand correctly, the issue that 848a1cc1e was meant to solve
> was that "-device nvdimm,node=..." could be passed by the user such that
> it lead to "proximity domain mismatch". (What was the higher-level goal
> with that BTW?)
> 
> However, that mismatch could as well be avoided by simply not passing
> such "node=..." properties. Is that right?
>
> If so, should we perhaps add another patch (temporarily), beyond this
> revert, that identifies the misconfig in question, and prints a warning
> about it?
not exactly, before the patch node=... influenced only _PXM which is supposed
to be evaluated after SRAT table and override whatever was in static table.

The patch, as I understood it, was about ACPI spec compliance where nvdimm SPA
in NFIT table should have a corresponding entry in SRAT table with
MEM_AFFINITY_NON_VOLATILE flag set.
Whether it solves any real issues aren't known to me and typically for
Intel contributed patches, author's email doesn't exists anymore so ...
And even if it fixes some new nvdimm issue, I'd rather have it broken
than regress memory hotplug that worked fine so far and wait for another
nvdimm patch that won't break existing features.

> Anyway the revert seems justified to me.
I've killed quite enough time trying to find out a way to keep
everyone happy, but alas it's time to give up and let interested
party to deal with regressions while introducing new stuff for
nvdimm, hence this revert.

> Acked-by: Laszlo Ersek <lersek@redhat.com>
> Thanks
> Laszlo
> 
