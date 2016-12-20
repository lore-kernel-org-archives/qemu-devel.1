Received: from eggs.gnu.org ([2001:4830:134:3::10]:39169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJBrI-0002OB-NG
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 23:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJBrF-000683-IE
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 23:17:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cJBrF-00067P-A9
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 23:16:57 -0500
Date: Tue, 20 Dec 2016 12:16:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161220041650.GA22006@pxdev.xzpeter.org>
References: <1482158486-18597-1-git-send-email-peterx@redhat.com>
	<20161219233012.GF23176@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161219233012.GF23176@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: allow dynamic switch of IOMMU
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Tue, Dec 20, 2016 at 10:30:12AM +1100, David Gibson wrote:

[...]

> > +static void vtd_switch_address_space(IntelIOMMUState *s, bool enabled)
> > +{
> > +    GHashTableIter iter;
> > +    VTDBus *vtd_bus;
> > +    VTDAddressSpace *as;
> > +    int i;
> > +
> > +    g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
> > +    while (g_hash_table_iter_next (&iter, NULL, (void**)&vtd_bus)) {
> > +        for (i = 0; i < X86_IOMMU_PCI_DEVFN_MAX; i++) {
> > +            as = vtd_bus->dev_as[i];
> > +            if (as == NULL) {
> > +                continue;
> > +            }
> > +            trace_vtd_switch_address_space(pci_bus_num(vtd_bus->bus),
> > +                                           VTD_PCI_SLOT(i), VTD_PCI_FUNC(i),
> > +                                           enabled);
> > +            if (enabled) {
> > +                memory_region_add_subregion_overlap(&as->root, 0,
> > +                                                    &as->iommu, 2);
> > +            } else {
> > +                memory_region_del_subregion(&as->root, &as->iommu);
> 
> Why not use memory_region_set_enabled() rather than actually
> adding/deleting the subregion?

Good idea, thanks. :-)

[...]

> > @@ -2343,15 +2378,47 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
> >          vtd_dev_as->devfn = (uint8_t)devfn;
> >          vtd_dev_as->iommu_state = s;
> >          vtd_dev_as->context_cache_entry.context_cache_gen = 0;
> > +
> > +        /*
> > +         * When DMAR is disabled, memory region relationships looks
> > +         * like:
> > +         *
> > +         * 0000000000000000-ffffffffffffffff (prio 0, RW): vtd_root
> > +         *  0000000000000000-ffffffffffffffff (prio 1, RW): vtd_sys_alias
> > +         *  00000000fee00000-00000000feefffff (prio 64, RW): intel_iommu_ir
> > +         *
> > +         * When DMAR is disabled, it becomes:
> > +         *
> > +         * 0000000000000000-ffffffffffffffff (prio 0, RW): vtd_root
> > +         *  0000000000000000-ffffffffffffffff (prio 2, RW): intel_iommu
> > +         *  0000000000000000-ffffffffffffffff (prio 1, RW): vtd_sys_alias
> > +         *  00000000fee00000-00000000feefffff (prio 64, RW): intel_iommu_ir
> > +         *
> > +         * The intel_iommu region is dynamically added/removed.
> > +         */
> >          memory_region_init_iommu(&vtd_dev_as->iommu, OBJECT(s),
> >                                   &s->iommu_ops, "intel_iommu", UINT64_MAX);
> 
> I'm almost certain UINT64_MAX is wrong here.  For one thing it would
> collide with PCI BARs.  For another, I can't imagine that the IOMMU
> page tables can really span an entire 2^64 space.

Could you explain why here device address space has things to do with
PCI BARs? I thought BARs are for CPU address space only (so that CPU
can access PCI registers via MMIO manner), am I wrong?

I think we should have a big enough IOMMU region size here. If device
writes to invalid addresses, IMHO we should trap it and report to
guest. If we have a smaller size than UINT64_MAX, how we can trap this
behavior and report for the whole address space (it should cover [0,
2^64-1])?

> 
> > +        memory_region_init_alias(&vtd_dev_as->sys_alias, OBJECT(s),
> > +                                 "vtd_sys_alias", get_system_memory(),
> > +                                 0, memory_region_size(get_system_memory()));
> 
> I strongly suspect using memory_region_size(get_system_memory()) is
> also incorrect here.  System memory has size UINT64_MAX, but I'll bet
> you you can't actually access all of that via PCI space (again, it
> would collide with actual PCI BARs).  I also suspect you can't reach
> CPU MMIO regions via the PCI DMA space.

Hmm, sounds correct.

However if so we will have the same problem if without IOMMU? See
pci_device_iommu_address_space() - address_space_memory will be the
default if we have no IOMMU protection, and that will cover e.g. CPU
MMIO regions as well.

> 
> So, I think you should find out what this limit actually is and
> restrict the alias to that window.

/me needs some more reading to figure this out. Still not quite
familiar with the whole VM memory regions. Hints are welcomed...

> 
> >          memory_region_init_io(&vtd_dev_as->iommu_ir, OBJECT(s),
> >                                &vtd_mem_ir_ops, s, "intel_iommu_ir",
> >                                VTD_INTERRUPT_ADDR_SIZE);
> > -        memory_region_add_subregion(&vtd_dev_as->iommu, VTD_INTERRUPT_ADDR_FIRST,
> > -                                    &vtd_dev_as->iommu_ir);
> > -        address_space_init(&vtd_dev_as->as,
> > -                           &vtd_dev_as->iommu, "intel_iommu");
> > +        memory_region_init(&vtd_dev_as->root, OBJECT(s),
> > +                           "vtd_root", UINT64_MAX);
> > +        memory_region_add_subregion_overlap(&vtd_dev_as->root,
> > +                                            VTD_INTERRUPT_ADDR_FIRST,
> > +                                            &vtd_dev_as->iommu_ir, 64);
> > +        address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, name);
> > +        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> > +                                            &vtd_dev_as->sys_alias, 1);
> > +        if (s->dmar_enabled) {
> > +            memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> > +                                                &vtd_dev_as->iommu, 2);
> > +        }
> 
> Hmm.  You have the IOMMU translated region overlaying the
> direct-mapped alias.  You enable and disable the IOMMU subregion, but
> you always leave the direct mapping enabled.  You might get away with
> this because the size of the IOMMU region is UINT64_MAX, which will
> overlay everything - but as above, I think that's wrong.  If that's
> changed then guest devices may be able to access portions of the raw
> address space outside the IOMMU mapped region, which could break the
> guest's expectations of device isolation.
> 
> I think it would be much safer to disable the system memory alias when
> the IOMMU is enabled.

Reasonable. Will adopt.

Thanks!

-- peterx
