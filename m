Received: from eggs.gnu.org ([2001:4830:134:3::10]:39193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fTDtg-0004Tl-AX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 18:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fTDtb-000194-8j
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 18:05:44 -0400
Date: Thu, 14 Jun 2018 01:05:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180614005745-mutt-send-email-mst@kernel.org>
References: <20180608142442.0d97b7c6@redhat.com>
	<397d37ee-b3a8-dae0-37d1-fd3c942448c2@redhat.com>
	<20180608155432-mutt-send-email-mst@kernel.org>
	<d6966aa8-54e5-8036-3603-069fbbb88c2a@redhat.com>
	<20180608181004-mutt-send-email-mst@kernel.org>
	<a68853da-a664-84ae-c5bd-4e79b967bb65@redhat.com>
	<20180613174825.1eebef6c@redhat.com>
	<c84ffb85-628f-4ece-e231-d0d7d45144c9@redhat.com>
	<20180613212702-mutt-send-email-mst@kernel.org>
	<5d03c321-4121-a814-ef4f-c649125c0231@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d03c321-4121-a814-ef4f-c649125c0231@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/14] pc: prepare for multi stage
 hotplug handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On Wed, Jun 13, 2018 at 09:37:54PM +0200, David Hildenbrand wrote:
> >>>       [ ... specific to machine_foo wiring ...]
> >>>
> >>>       virtio_mem_plug() {
> >>>          [... some machine specific wiring ...]
> >>>
> >>>          bus_hotplug_ctrl = qdev_get_bus_hotplug_handler()
> >>>          bus_hotplug_ctrl->plug(bus_hotplug_ctrl, dev)
> >>>
> >>>          [... some more machine specific wiring ...]
> >>>       }
> >>>
> >>>       [ ... specific to machine_foo wiring ...]
> >>>
> >>> i.e. device itself doesn't participate in attaching to external entities,
> >>> those entities (machine or bus controller virtio device is attached to)
> >>> do wiring on their own within their own domain.
> >>
> >> I am fine with this, but Michael asked if this ("virtio_mem_plug()")
> >> could go via new DeviceClass functions. Michael, would that also work
> >> for your use case?
> > 
> > It's not virtio specifically, I'm interested in how this will work for
> > PCI generally.  Right now we call do_pci_register_device which
> > immediately makes it guest visible.
> 
> So you're telling me that a PCI device exposes itself to the system in
> pci_qdev_realize() instead of letting a hotplug handler handle that? My
> assumption is that the PCI bridge hotplug handler handles this.

Well given how things work in qemu that's not exactly
the case. See below.

> What am
> I missing?
> 
> I can see that e.g. for a virtio device the realize call chain is
> 
> pci_qdev_realize() -> virtio_pci_realize() -> virtio_XXX__pci_realize ->
> virtio_XXX_realize()
> 
> If any realization in pci_qdev_realize() fails, we do a
> do_pci_unregister_device().
> 
> So if it is true what you're saying than we're already exposing
> partially realized (and possibly unrealized again) devices via PCI. I
> *guess* because we're holding the iothread mutex this is okay and
> actually not visible.

For now but we need ability to have separate new commands for
realize and plug, so we will drop the mutex.

> And we only seem to be sending events in the PCI
> bridge hotplug handlers, so my assumption is that this is fine.

For core PCI, it's mostly just this line:

    bus->devices[devfn] = pci_dev;

which makes it accessible to pci config cycles.

But failover also cares about vfio, which seems to set up
e.g. irqfs on realize.




> > 
> > 
> >>
> >> -- 
> >>
> >> Thanks,
> >>
> >> David / dhildenb
> 
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
