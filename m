Received: from eggs.gnu.org ([209.51.188.92]:43104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj7kV-0005l6-DL
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj7Zq-0001VE-8p
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:07:20 -0500
Date: Mon, 14 Jan 2019 14:06:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114140616-mutt-send-email-mst@kernel.org>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 00/13] spapr: Add support for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On Fri, Jan 11, 2019 at 09:59:55PM +0100, Greg Kurz wrote:
> This allows to hotplug/unplug PHBs. I could successfully test:
> - hotplug/unplug with e1000 device to validate LSIs
> - hotplug/unplug with virtio-net device to validate MSIs
> - some simple migration scenarios
> 
> Changes in v2:
> - rebased on current ppc-for-4.0
> - added some preliminary cleanup
> - call unrealize from realize error path
> - advertise PHB hotplug in last patch
> - reworked phandle related code
> - sync LSIs to KVM
> 
> Please comment.

PCI things all look fine:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Pls merge through the sPAPR tree.


> --
> Greg
> 
> ---
> 
> Greg Kurz (5):
>       spapr: Rename xics to intc in interrupt controller agnostic code
>       spapr_pci: add PHB unrealize
>       spapr_irq: Expose the phandle of the interrupt controller
>       spapr_irq: Allow synchronization of a single irq state to KVM
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
>  hw/intc/spapr_xive.c          |   34 ++++++++-
>  hw/intc/xics_kvm.c            |   68 ++++++++++--------
>  hw/intc/xics_spapr.c          |   29 +++++++-
>  hw/pci/pcie.c                 |    2 -
>  hw/pci/shpc.c                 |    2 -
>  hw/ppc/spapr.c                |  156 ++++++++++++++++++++++++++++++++++++++++-
>  hw/ppc/spapr_drc.c            |   18 +++++
>  hw/ppc/spapr_events.c         |    5 +
>  hw/ppc/spapr_irq.c            |   45 ++++++++++++
>  hw/ppc/spapr_pci.c            |  122 +++++++++++++++++++++++++-------
>  hw/ppc/spapr_vio.c            |    2 -
>  hw/s390x/css-bridge.c         |    2 -
>  hw/s390x/s390-pci-bus.c       |    6 +-
>  hw/scsi/virtio-scsi.c         |    2 -
>  hw/scsi/vmw_pvscsi.c          |    2 -
>  hw/usb/dev-smartcard-reader.c |    2 -
>  include/hw/pci-host/spapr.h   |    8 ++
>  include/hw/ppc/spapr.h        |    4 +
>  include/hw/ppc/spapr_drc.h    |    8 ++
>  include/hw/ppc/spapr_irq.h    |    3 +
>  include/hw/ppc/spapr_xive.h   |    2 +
>  include/hw/ppc/xics.h         |    9 +-
>  include/hw/ppc/xics_spapr.h   |   39 ++++++++++
>  include/hw/qdev-core.h        |    3 -
>  28 files changed, 492 insertions(+), 98 deletions(-)
>  create mode 100644 include/hw/ppc/xics_spapr.h
