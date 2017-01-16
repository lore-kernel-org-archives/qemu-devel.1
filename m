Received: from eggs.gnu.org ([2001:4830:134:3::10]:59942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT242-0000BN-VW
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT23z-0004Gz-SI
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:50:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cT23z-0004Go-JU
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:50:47 -0500
Date: Mon, 16 Jan 2017 15:50:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170116075043.GE30108@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-14-git-send-email-peterx@redhat.com>
	<7a8c721d-8a12-9727-feae-58103942fd55@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a8c721d-8a12-9727-feae-58103942fd55@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 13/14] intel_iommu: allow dynamic
 switch of IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Mon, Jan 16, 2017 at 02:20:31PM +0800, Jason Wang wrote:

[...]

> >diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >index fd75112..2596f11 100644
> >--- a/hw/i386/intel_iommu.c
> >+++ b/hw/i386/intel_iommu.c
> >@@ -1343,9 +1343,49 @@ static void vtd_handle_gcmd_sirtp(IntelIOMMUState *s)
> >      vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRTPS);
> >  }
> >+static void vtd_switch_address_space(VTDAddressSpace *as, bool iommu_enabled)
> 
> Looks like you can check s->dmar_enabled here?

Yes, we need to check old state in case we don't need a switch at all.
Actually I checked it...

> 
> >+{
> >+    assert(as);
> >+
> >+    trace_vtd_switch_address_space(pci_bus_num(as->bus),
> >+                                   VTD_PCI_SLOT(as->devfn),
> >+                                   VTD_PCI_FUNC(as->devfn),
> >+                                   iommu_enabled);
> >+
> >+    /* Turn off first then on the other */
> >+    if (iommu_enabled) {
> >+        memory_region_set_enabled(&as->sys_alias, false);
> >+        memory_region_set_enabled(&as->iommu, true);
> >+    } else {
> >+        memory_region_set_enabled(&as->iommu, false);
> >+        memory_region_set_enabled(&as->sys_alias, true);
> >+    }
> >+}

[...]

> >  /* Handle Translation Enable/Disable */
> >  static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
> >  {
> >+    if (s->dmar_enabled == en) {
> >+        return;
> >+    }
> >+

... here :) ... and ...

[...]

> >+        memory_region_init_alias(&vtd_dev_as->sys_alias, OBJECT(s),
> >+                                 "vtd_sys_alias", get_system_memory(),
> >+                                 0, memory_region_size(get_system_memory()));
> >          memory_region_init_io(&vtd_dev_as->iommu_ir, OBJECT(s),
> >                                &vtd_mem_ir_ops, s, "intel_iommu_ir",
> >                                VTD_INTERRUPT_ADDR_SIZE);
> >-        memory_region_add_subregion(&vtd_dev_as->iommu, VTD_INTERRUPT_ADDR_FIRST,
> >-                                    &vtd_dev_as->iommu_ir);
> >-        address_space_init(&vtd_dev_as->as,
> >-                           &vtd_dev_as->iommu, name);
> >+        memory_region_init(&vtd_dev_as->root, OBJECT(s),
> >+                           "vtd_root", UINT64_MAX);
> >+        memory_region_add_subregion_overlap(&vtd_dev_as->root,
> >+                                            VTD_INTERRUPT_ADDR_FIRST,
> >+                                            &vtd_dev_as->iommu_ir, 64);
> >+        address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, name);
> >+        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> >+                                            &vtd_dev_as->sys_alias, 1);
> >+        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> >+                                            &vtd_dev_as->iommu, 1);
> >+        vtd_switch_address_space(vtd_dev_as, s->dmar_enabled);

... here I also used vtd_switch_address_space() to setup the init
state of the regions (in order to share the codes). So how about I
rename vtd_switch_address_space() into something like
vtd_setup_address_space(), to avoid misunderstanding?

Thanks,

-- peterx
