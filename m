Received: from eggs.gnu.org ([2001:4830:134:3::10]:37210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1daSy1-0005wP-UZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 16:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1daSxv-0000ts-Q3
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 16:31:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1daSxv-0000sr-FK
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 16:31:31 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6QKTgK6049769
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 16:31:29 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxxuma70g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 16:31:29 -0400
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 26 Jul 2017 17:31:27 -0300
References: <150100547373.27487.3154210751350595400.stgit@bahia>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 17:31:17 -0300
MIME-Version: 1.0
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <07a10650-f216-99ea-fb48-286887279bf1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 00/26] spapr: add
 support for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

I've tested the patch set using Greg's Github branch. It worked fine in 
my tests
using a Fedora 26 and an Ubuntu 17.04 guests. I have two observations
though:

1 - This is not related to this patch set per se because it is 
reproducible on master, but
I think it is interfering with this new feature.  There is a 
warning/error message in
the kernel right after SLOF that goes:

(...)
  -> smp_release_cpus()
spinning_secondaries = 0
  <- smp_release_cpus()
Linux ppc64le
#1 SMP Mon Jul 1[    0.030450] pci 0000:00:02.0: of_irq_parse_pci: 
failed with rc=-22
[    0.030552] pci 0000:00:0f.0: of_irq_parse_pci: failed with rc=-22
[  OK  ] Started Security Auditing Service.
(...)

I get this same message after hotplugging a PCI device with this series, 
but the
hotplug shows up in the lspci as expected:

(qemu) device_add virtio-net-pci,id=hp2.0,bus=phb2.0
(qemu) [  412.233441] pci 0002:00:00.0: of_irq_parse_pci: failed with rc=-22


2 - when hotplugging the same PHB for the second time (device_add phb2,
device_del phb2, device_add phb2 again) the hotplug works but dmesg got 
spammed
by the messages:

(qemu) device_add spapr-pci-host-bridge,index=2,id=phb2
(qemu) [  378.309490] rpaphp: rpaphp_register_slot: slot[C131106] is 
already registered
[  378.309674] rpaphp: rpaphp_register_slot: slot[C131074] is already 
registered
[  378.309841] rpaphp: rpaphp_register_slot: slot[C131087] is already 
registered
[  378.310847] rpaphp: rpaphp_register_slot: slot[C131078] is already 
registered
( .... about 250+ messages like that )

Looks like device_del isn't cleaning up everything after the first hotplug.



Thanks,


Daniel


On 07/25/2017 02:57 PM, Greg Kurz wrote:
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
>        spapr: move spapr_create_phb() to core machine code
>        spapr_pci: use memory_region_add_subregion() with DMA windows
>        spapr_iommu: use g_strdup_printf() instead of snprintf()
>        spapr_drc: use g_strdup_printf() instead of snprintf()
>        spapr_iommu: convert TCE table object to realize()
>        spapr_pci: parent the MSI memory region to the PHB
>        spapr_drc: fix realize and unrealize
>        spapr_drc: add unrealize method to physical DRC class
>        spapr_iommu: unregister vmstate at unrealize time
>        spapr: add pseries-2.11 machine type
>        spapr_pci: introduce drc_id property
>        spapr: allow guest to update the XICS phandle
>        spapr_pci: drop abusive sanity check when migrating the LSI table
>        spapr: add hotplug hooks for PHB hotplug
>
> Michael Roth (11):
>        spapr_drc: pass object ownership to parent/owner
>        spapr_iommu: pass object ownership to parent/owner
>        pci: allow cleanup/unregistration of PCI buses
>        qdev: store DeviceState's canonical path to use when unparenting
>        spapr_pci: add PHB unrealize
>        spapr: enable PHB hotplug for pseries-2.11
>        spapr: create DR connectors for PHBs
>        spapr_events: add support for phb hotplug events
>        qdev: pass an Object * to qbus_set_hotplug_handler()
>        spapr_pci: provide node start offset via spapr_populate_pci_dt()
>        spapr_pci: add ibm, my-drc-index property for PHB hotplug
>
> Nathan Fontenot (1):
>        spapr: populate PHB DRC entries for root DT node
>
>
>   hw/acpi/piix4.c               |    2
>   hw/char/virtio-serial-bus.c   |    2
>   hw/core/bus.c                 |   11 --
>   hw/core/qdev.c                |   15 ++-
>   hw/pci/pci.c                  |   33 +++++++
>   hw/pci/pcie.c                 |    2
>   hw/pci/shpc.c                 |    2
>   hw/ppc/spapr.c                |  205 ++++++++++++++++++++++++++++++++++++++++-
>   hw/ppc/spapr_drc.c            |   65 ++++++++++---
>   hw/ppc/spapr_events.c         |    3 +
>   hw/ppc/spapr_hcall.c          |   20 ++++
>   hw/ppc/spapr_iommu.c          |   22 +++-
>   hw/ppc/spapr_pci.c            |   86 +++++++++++++----
>   hw/s390x/css-bridge.c         |    2
>   hw/s390x/s390-pci-bus.c       |    6 +
>   hw/scsi/virtio-scsi.c         |    2
>   hw/scsi/vmw_pvscsi.c          |    2
>   hw/usb/dev-smartcard-reader.c |    2
>   include/hw/compat.h           |    3 +
>   include/hw/pci-host/spapr.h   |    9 +-
>   include/hw/pci/pci.h          |    3 +
>   include/hw/ppc/spapr.h        |   15 +++
>   include/hw/ppc/spapr_drc.h    |    8 ++
>   include/hw/qdev-core.h        |    4 -
>   24 files changed, 446 insertions(+), 78 deletions(-)
>
>
