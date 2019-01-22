Received: from eggs.gnu.org ([209.51.188.92]:45100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1glp4D-0006e6-Mo
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1glor7-0004wd-1t
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:44:14 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1glor6-0004vo-KE
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:44:12 -0500
Received: by mail-pf1-x441.google.com with SMTP id y126so11208929pfb.4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 21:44:12 -0800 (PST)
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7538b313-81b2-d036-ca12-5a2ad5ea8d2b@ozlabs.ru>
Date: Tue, 22 Jan 2019 16:44:02 +1100
MIME-Version: 1.0
In-Reply-To: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/19] spapr: Add support for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>



On 18/01/2019 04:14, Greg Kurz wrote:
> This allows to hotplug/unplug PHBs. I could successfully test:
> - using in-kernel XICS, emulated XICS and XIVE
> - using experimental in-kernel XIVE from Cedric
> - hotplug/unplug with e1000 device to validate LSIs
> - hotplug/unplug with virtio-net device to validate MSIs
> - some simple migration scenarios

> 
> Change in v3:
> - reworked phandle related code some more
> - disintricate allocation/"type setting" of interrupts
> - identify LSIs at machine init
> 
> Changes in v2:
> - rebased on current ppc-for-4.0



Is the tree available anywhere in git? It does not apply on today's
ppc-for-4.0 :-/




> - added some preliminary cleanup
> - call unrealize from realize error path
> - advertise PHB hotplug in last patch
> - reworked phandle related code
> - sync LSIs to KVM
> 
> Please comment.
> 
> --
> Greg
> 
> ---
> 
> Greg Kurz (11):
>       spapr: Rename xics to intc in interrupt controller agnostic code
>       xics: Disintricate allocation and type setting of interrupts
>       spapr/xive: Don't set irq type in spapr_xive_irq_claim()
>       spapr: Set irq type in a dedicated function
>       spapr: Identify LSIs of all possible PHBs at machine init
>       spapr_pci: add PHB unrealize
>       spapr: Factor out setting of "phandle" DT property to sPAPR irq frontend
>       spapr_xive: Cache device tree nodename in sPAPRXive
>       spapr: Expose the name of the interrupt controller node
>       spapr_irq: Expose the phandle of the interrupt controller
>       spapr: add hotplug hooks for PHB hotplug
> 
> Michael Roth (6):
>       spapr: create DR connectors for PHBs
>       spapr_events: add support for phb hotplug events
>       qdev: pass an Object * to qbus_set_hotplug_handler()
>       spapr_pci: provide node start offset via spapr_populate_pci_dt()
>       spapr_pci: add ibm, my-drc-index property for PHB hotplug
>       spapr: enable PHB hotplug for default pseries machine type
> 
> Nathan Fontenot (1):
>       spapr: populate PHB DRC entries for root DT node
> 
> Thomas Huth (1):
>       ppc: Move spapr-related prototypes from xics.h into a seperate header file
> 
> 
>  hw/acpi/pcihp.c               |    2 -
>  hw/acpi/piix4.c               |    2 -
>  hw/char/virtio-serial-bus.c   |    2 -
>  hw/core/bus.c                 |   11 +--
>  hw/core/machine.c             |    4 +
>  hw/intc/spapr_xive.c          |   35 ++++-----
>  hw/intc/xics.c                |   28 ++++++-
>  hw/intc/xics_kvm.c            |    1 
>  hw/intc/xics_spapr.c          |   10 +--
>  hw/pci/pcie.c                 |    2 -
>  hw/pci/shpc.c                 |    2 -
>  hw/ppc/pnv_psi.c              |    1 
>  hw/ppc/spapr.c                |  163 +++++++++++++++++++++++++++++++++++++++--
>  hw/ppc/spapr_drc.c            |   18 +++++
>  hw/ppc/spapr_events.c         |    9 ++
>  hw/ppc/spapr_irq.c            |  129 +++++++++++++++++++++++++++-----
>  hw/ppc/spapr_pci.c            |  124 ++++++++++++++++++++++++-------
>  hw/ppc/spapr_vio.c            |    4 +
>  hw/s390x/css-bridge.c         |    2 -
>  hw/s390x/s390-pci-bus.c       |    6 +-
>  hw/scsi/virtio-scsi.c         |    2 -
>  hw/scsi/vmw_pvscsi.c          |    2 -
>  hw/usb/dev-smartcard-reader.c |    2 -
>  include/hw/pci-host/spapr.h   |   11 ++-
>  include/hw/ppc/spapr.h        |    4 +
>  include/hw/ppc/spapr_drc.h    |    8 ++
>  include/hw/ppc/spapr_irq.h    |   16 +++-
>  include/hw/ppc/spapr_xive.h   |   13 +++
>  include/hw/ppc/xics.h         |   15 ++--
>  include/hw/ppc/xics_spapr.h   |   43 +++++++++++
>  include/hw/qdev-core.h        |    3 -
>  31 files changed, 545 insertions(+), 129 deletions(-)
>  create mode 100644 include/hw/ppc/xics_spapr.h
> 

-- 
Alexey
