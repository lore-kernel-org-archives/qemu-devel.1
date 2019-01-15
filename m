Received: from eggs.gnu.org ([209.51.188.92]:60277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gjSiy-0001XP-So
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gjSir-000682-2k
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:42:02 -0500
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:41378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gjSik-0005rG-DY
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:41:50 -0500
Received: from player698.ha.ovh.net (unknown [10.109.143.220])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id D68E9DA94B
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 18:41:37 +0100 (CET)
Date: Tue, 15 Jan 2019 18:41:18 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190115184118.14ef2f0d@bahia.lan>
In-Reply-To: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 00/13] spapr: Add support for
 PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-ppc@nongnu.org, =?UTF-8?B?Q8Op?= =?UTF-8?B?ZHJpYw==?= Le Goater <clg@kaod.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 11 Jan 2019 21:59:55 +0100
Greg Kurz <groug@kaod.org> wrote:

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
> 

David,

I had enough remarks from Cedric to go for a v3. I expect to send
it shortly. Don't spend time on reviewing the v2.

Cheers,

--
Greg

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
> 
> 
