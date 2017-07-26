Received: from eggs.gnu.org ([2001:4830:134:3::10]:53548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daDFy-0008E8-JT
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daDFu-0006At-RQ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:45:06 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1daDFu-00069X-Il
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:45:02 -0400
Received: by mail-pf0-x243.google.com with SMTP id q85so14369014pfq.2
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:45:02 -0700 (PDT)
References: <150100547373.27487.3154210751350595400.stgit@bahia>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <180bce1f-9da5-969e-df03-421f05285d00@ozlabs.ru>
Date: Wed, 26 Jul 2017 13:44:55 +1000
MIME-Version: 1.0
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-2.11 PATCH 00/26] spapr: add support for PHB
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 26/07/17 03:57, Greg Kurz wrote:
> This series is based on patches from Michel Roth posted in 2015:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2015-04/msg04246.html
> 
> It addresses comments made during the RFC review, and also provides a bunch
> of preliminary cleanup/fix patches. Since we have reached hard-freeze, this
> feature is provided by a new pseries-2.11 machine type, introduced by this
> series. It is based on David Gibson's ppc-for-2.10 branch, and I believe some
> of the preliminary fixes are eligible for 2.10.
> 
> Note that it also requires an updated SLOF that supports a new private hcall:
> KVMPPC_H_UPDATE_PHANDLE. This is needed because SLOF changes FDT phandles to
> Open Firmware phandles. Since the guest only sees the latter, QEMU must use
> the updated value when populating the FDT for the hotplugged PHB (otherwise
> the guest can't setup IRQs for the PCI devices). SLOF part is already upstream:
> 
> http://git.qemu.org/?p=SLOF.git;h=604d28cc3f791657414f8b21103921fa0147fc63
> 
> With these patches we support the following:
> 
> (qemu) device_add spapr-pci-host-bridge,index=2,id=phb2
> (qemu) device_add virtio-net-pci,id=hp2.0,bus=phb2.0
> (qemu) device_del hp2.0
> (qemu) device_del phb2
> 
> I could run some successful tests with a fedora25 guest:
> - hotplug PHB + migrate + unplug PHB
> - hotplug PHB + hotplug PCI device + unplug PHB => PCI device gets unplugged
> - migrate before OS starts + hotplug PHB => destination uses OF phandles
> - no regression observed with older machine types
> 
> All the patches are also available here:
> 
> https://github.com/gkurz/qemu/commits/spapr-hotplug-phb
> 
> Cheers,
> 
> --
> Greg
> 
> ---
> 
> Greg Kurz (14):
>       spapr: move spapr_create_phb() to core machine code
>       spapr_pci: use memory_region_add_subregion() with DMA windows
>       spapr_iommu: use g_strdup_printf() instead of snprintf()
>       spapr_drc: use g_strdup_printf() instead of snprintf()
>       spapr_iommu: convert TCE table object to realize()
>       spapr_pci: parent the MSI memory region to the PHB
>       spapr_drc: fix realize and unrealize
>       spapr_drc: add unrealize method to physical DRC class
>       spapr_iommu: unregister vmstate at unrealize time
>       spapr: add pseries-2.11 machine type

>       spapr_pci: introduce drc_id property
>       spapr: allow guest to update the XICS phandle
>       spapr_pci: drop abusive sanity check when migrating the LSI table
>       spapr: add hotplug hooks for PHB hotplug


This one did not make it to the lists.



> 
> Michael Roth (11):
>       spapr_drc: pass object ownership to parent/owner
>       spapr_iommu: pass object ownership to parent/owner
>       pci: allow cleanup/unregistration of PCI buses
>       qdev: store DeviceState's canonical path to use when unparenting
>       spapr_pci: add PHB unrealize
>       spapr: enable PHB hotplug for pseries-2.11>       spapr: create DR connectors for PHBs


>       spapr_events: add support for phb hotplug events
>       qdev: pass an Object * to qbus_set_hotplug_handler()
>       spapr_pci: provide node start offset via spapr_populate_pci_dt()
>       spapr_pci: add ibm, my-drc-index property for PHB hotplug
> 
> Nathan Fontenot (1):
>       spapr: populate PHB DRC entries for root DT node
> 
> 
>  hw/acpi/piix4.c               |    2 
>  hw/char/virtio-serial-bus.c   |    2 
>  hw/core/bus.c                 |   11 --
>  hw/core/qdev.c                |   15 ++-
>  hw/pci/pci.c                  |   33 +++++++
>  hw/pci/pcie.c                 |    2 
>  hw/pci/shpc.c                 |    2 
>  hw/ppc/spapr.c                |  205 ++++++++++++++++++++++++++++++++++++++++-
>  hw/ppc/spapr_drc.c            |   65 ++++++++++---
>  hw/ppc/spapr_events.c         |    3 +
>  hw/ppc/spapr_hcall.c          |   20 ++++
>  hw/ppc/spapr_iommu.c          |   22 +++-
>  hw/ppc/spapr_pci.c            |   86 +++++++++++++----
>  hw/s390x/css-bridge.c         |    2 
>  hw/s390x/s390-pci-bus.c       |    6 +
>  hw/scsi/virtio-scsi.c         |    2 
>  hw/scsi/vmw_pvscsi.c          |    2 
>  hw/usb/dev-smartcard-reader.c |    2 
>  include/hw/compat.h           |    3 +
>  include/hw/pci-host/spapr.h   |    9 +-
>  include/hw/pci/pci.h          |    3 +
>  include/hw/ppc/spapr.h        |   15 +++
>  include/hw/ppc/spapr_drc.h    |    8 ++
>  include/hw/qdev-core.h        |    4 -
>  24 files changed, 446 insertions(+), 78 deletions(-)
> 
> 


-- 
Alexey
