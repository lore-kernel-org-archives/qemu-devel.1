Received: from eggs.gnu.org ([2001:4830:134:3::10]:58874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAt4x-0003bI-8V
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAt4u-0001yO-2E
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:45:51 -0400
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-19-david@redhat.com>
	<20180927150141.60a6488a@redhat.com>
	<dc5d7b2d-5b51-2c0b-aac7-ebf04a4e7859@redhat.com>
	<20181001152443.2cca5c5e@redhat.com>
	<85d59b49-25d7-6485-843c-838324cbc52e@redhat.com>
	<20181008141904.17b601d3@redhat.com>
	<aa176072-87b1-9e13-6770-97dfc354a1ed@redhat.com>
	<20181008161229.5c6bce14@redhat.com>
	<94df76ad-36f8-ccaf-a5e6-7e60d254e4d1@redhat.com>
	<20181012102740.0f0d1e49@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b1a1a9fe-9110-d050-008a-cec3251471ce@redhat.com>
Date: Fri, 12 Oct 2018 10:45:41 +0200
MIME-Version: 1.0
In-Reply-To: <20181012102740.0f0d1e49@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 18/24] qdev: hotplug: provide do_unplug
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

>=20
> The correct order should be opposite to one that created a devices,
> i.e. unplug -> unrealize -> delete.
> Doing unplug stuff after device was unrealized looks outright wrong
> (essentially device doesn't exists anymore except memory where it's
> been located).

pre_plug -> realize -> plug

unplug -> unrealize -> post_unplug

doesn't look that wrong to me. But the problem seems to be that unplug
basically spans the whole unrealize phase (including the post_unplug
phase). So unplug should usually already contains the post_unplug part
as you noted below (when moving the object_unparent() part out).

>=20
>> As I already said that, the unplug/unplug_request handlers are very
>> different to the other handlers, as they actively delete(request to
>> delete) an object. In contrast to pre_plug/plug that don't create an
>> object but only wire it up while realizing the device.>
>>
>> That is the reason why we can't do stuff after calling the bus hotunpl=
ug
>> handler but only before it. We cannot really modify the calling order.
>=20
> There is nothing special in unplug handlers wrt plug ones, they all are
> external to the being created device. Theoretically we can move pre_plu=
g
> /plug from device_set_realize() to outer caller qdev_device_add() and
> nothing would change.

I guess at some point we should definitely move them out, this only
leads to confusion. (e.g. hotplug handlers getting called on device
within device hierarchies although we don't want this to be possible)

>=20
> The problem here is the lack of unplug handler for pci device so
> unplugging boils down to object_unparent() which will unrealize
> device (and in process unplug it) and then delete it.
> What we really need is to factor out unplug code from pci device
> unrealizefn(). Then ideally unplug controller could look like:
>  static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaq=
ue)
>  {
> +    hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> +    ... do some port specific unplug ...
> +    hotplug_handler_do_unplug(hotplug_ctrl, dev); // default pci devic=
e unplug or pmem specific
>      object_unparent(OBJECT(dev));
>  }
>=20
> where tear down and unrealize/delete parts are separated from each othe=
r.

That makes sense, but we would then handle it for all PCI devices via
the hotplug chain I guess. (otherwise a object_unparent would be missing)

[...]
>>
>> Do you have other ideas?
> I'd proceed with suggestions made earlier [1][2] on this thread.
> That should solve the issue at hand with out factoring out PCI unplug
> from old pci::unrealize(). One would have to introduce shim unplug
> handlers for pci/bridge/pcie that would call object_unparent(), but
> that's the extent of another shallow PCI re-factoring.
> Of cause that's assuming that sequence
>  1.  memory_device_unplug()
>  2.  pci_unplug()
> is correct in virtio-pmem-pci case.

That is indeed possible as long as the memory device part has to come
first. I'll give it a try.

I already started prototyping and found some other PCI hotplug handler
issues I have to solve first ....

--=20

Thanks,

David / dhildenb
