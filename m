Received: from eggs.gnu.org ([2001:4830:134:3::10]:58454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTBar-0002Kl-G1
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 15:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTBan-0007Yk-Hs
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 15:38:09 -0400
References: <20180607154455.6eab4e24@redhat.com>
	<5dda6237-88d8-f0f8-58d2-af996368cea4@redhat.com>
	<20180608142442.0d97b7c6@redhat.com>
	<397d37ee-b3a8-dae0-37d1-fd3c942448c2@redhat.com>
	<20180608155432-mutt-send-email-mst@kernel.org>
	<d6966aa8-54e5-8036-3603-069fbbb88c2a@redhat.com>
	<20180608181004-mutt-send-email-mst@kernel.org>
	<a68853da-a664-84ae-c5bd-4e79b967bb65@redhat.com>
	<20180613174825.1eebef6c@redhat.com>
	<c84ffb85-628f-4ece-e231-d0d7d45144c9@redhat.com>
	<20180613212702-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5d03c321-4121-a814-ef4f-c649125c0231@redhat.com>
Date: Wed, 13 Jun 2018 21:37:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180613212702-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

>>>       [ ... specific to machine_foo wiring ...]
>>>
>>>       virtio_mem_plug() {
>>>          [... some machine specific wiring ...]
>>>
>>>          bus_hotplug_ctrl =3D qdev_get_bus_hotplug_handler()
>>>          bus_hotplug_ctrl->plug(bus_hotplug_ctrl, dev)
>>>
>>>          [... some more machine specific wiring ...]
>>>       }
>>>
>>>       [ ... specific to machine_foo wiring ...]
>>>
>>> i.e. device itself doesn't participate in attaching to external entit=
ies,
>>> those entities (machine or bus controller virtio device is attached t=
o)
>>> do wiring on their own within their own domain.
>>
>> I am fine with this, but Michael asked if this ("virtio_mem_plug()")
>> could go via new DeviceClass functions. Michael, would that also work
>> for your use case?
>=20
> It's not virtio specifically, I'm interested in how this will work for
> PCI generally.  Right now we call do_pci_register_device which
> immediately makes it guest visible.

So you're telling me that a PCI device exposes itself to the system in
pci_qdev_realize() instead of letting a hotplug handler handle that? My
assumption is that the PCI bridge hotplug handler handles this. What am
I missing?

I can see that e.g. for a virtio device the realize call chain is

pci_qdev_realize() -> virtio_pci_realize() -> virtio_XXX__pci_realize ->
virtio_XXX_realize()

If any realization in pci_qdev_realize() fails, we do a
do_pci_unregister_device().

So if it is true what you're saying than we're already exposing
partially realized (and possibly unrealized again) devices via PCI. I
*guess* because we're holding the iothread mutex this is okay and
actually not visible. And we only seem to be sending events in the PCI
bridge hotplug handlers, so my assumption is that this is fine.

>=20
>=20
>>
>> --=20
>>
>> Thanks,
>>
>> David / dhildenb


--=20

Thanks,

David / dhildenb
