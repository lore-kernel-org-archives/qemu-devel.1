Received: from eggs.gnu.org ([2001:4830:134:3::10]:50021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIESP-0003YR-P7
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIENT-0002PL-9r
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 10:55:24 -0400
Date: Thu, 1 Nov 2018 15:55:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181101155512.27096830@redhat.com>
In-Reply-To: <dca74657-39f8-2e0a-8f43-a2a2dac5d25f@redhat.com>
References: <20181024101930.20674-1-david@redhat.com>
	<dca74657-39f8-2e0a-8f43-a2a2dac5d25f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/7] pci: hotplug handler reworks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org

On Wed, 31 Oct 2018 18:31:30 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 24.10.18 12:19, David Hildenbrand wrote:
> > This series reworks some pci hotplug handlers (except for s390, that will
> > require more work but is not required for now).
> > 
> > 1. Route all unplug calls via the hotplug handler when called from the
> >    unplug_request handler. This will be required to get multi-stage
> >    hotplug handlers running, but also makes sense on its own (just like we
> >    already did for some CPU/memory hotplug handlers).
> > 
> > 2. Introduce some pre_plug handlers where it makes sense already.
> > 
> > 3. Call the plug/pre_plug handler also for coldplugged devices. Especially
> >    pcihp is special as it overwrites hotplug handlers.
> > 
> > This series will not yet factor out pre_plug/plug/unplug from pci device
> > realize/unrealize functions, this will require more work but this
> > series is also required first to get it running.
> > 
> > David Hildenbrand (7):
> >   pcihp: perform check for bus capability in pre_plug handler
> >   pcihp: overwrite hotplug handler recursively from the start
> >   pcihp: route unplug via the hotplug handler
> >   pci/pcie: route unplug via the hotplug handler
> >   pci/shpc: move hotplug checks to preplug handler
> >   pci/shpc: route unplug via the hotplug handler
> >   spapr_pci: route unplug via the hotplug handler
> > 
> >  hw/acpi/pcihp.c                 | 40 +++++++++++++++++++++++-----
> >  hw/acpi/piix4.c                 | 39 ++++++++++++++-------------
> >  hw/pci-bridge/pci_bridge_dev.c  | 23 +++++++++++++++-
> >  hw/pci-bridge/pcie_pci_bridge.c | 23 +++++++++++++++-
> >  hw/pci/pcie.c                   | 10 ++++++-
> >  hw/pci/pcie_port.c              |  1 +
> >  hw/pci/shpc.c                   | 47 ++++++++++++++++++---------------
> >  hw/ppc/spapr_pci.c              | 33 ++++++++++++++---------
> >  include/hw/acpi/pcihp.h         |  5 ++++
> >  include/hw/pci/pcie.h           |  2 ++
> >  include/hw/pci/shpc.h           |  4 +++
> >  11 files changed, 165 insertions(+), 62 deletions(-)
> >   
> 
> Did some more testing. Can somebody have a look/pick up? Thanks!
Did a quick pass over series, patches overall looks good here is some other nits
that apply to series:
 * make more descriptive commit messages (important for history and for whoever comes later to read it)
 * I don't really like a mix of style in callbacks naming
    for ex: there is hotplug and then for unplug you add hot_unplug instead of hotunplug
    I'd prefer consistent approach in naming.
    (either use underscores or drop them or maybe drop 'hot' part as it's not only for hotplug anymore)
