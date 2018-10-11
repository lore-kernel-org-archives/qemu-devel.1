Received: from eggs.gnu.org ([2001:4830:134:3::10]:44284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAWg9-0005ff-4W
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAWg5-0007m3-4c
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:50:45 -0400
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-19-david@redhat.com>
	<20180927150141.60a6488a@redhat.com>
	<dc5d7b2d-5b51-2c0b-aac7-ebf04a4e7859@redhat.com>
	<20181001152443.2cca5c5e@redhat.com>
	<85d59b49-25d7-6485-843c-838324cbc52e@redhat.com>
	<20181008141904.17b601d3@redhat.com>
	<aa176072-87b1-9e13-6770-97dfc354a1ed@redhat.com>
	<20181008161229.5c6bce14@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <94df76ad-36f8-ccaf-a5e6-7e60d254e4d1@redhat.com>
Date: Thu, 11 Oct 2018 10:50:13 +0200
MIME-Version: 1.0
In-Reply-To: <20181008161229.5c6bce14@redhat.com>
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

On 08/10/2018 16:12, Igor Mammedov wrote:
> On Mon, 8 Oct 2018 14:41:50 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 08/10/2018 14:19, Igor Mammedov wrote:
>>> On Mon, 8 Oct 2018 13:47:53 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>  =20
>>>>> That way using [2] and [1 - modulo it should match only concrete ty=
pe]
>>>>> machine would be able to override hotplug handlers for TYPE_VIRTIO_=
PMEM_PCI
>>>>> and explicitly call machine + pci hotplug handlers in necessary ord=
er.
>>>>>
>>>>> flow would look like:
>>>>>   [acpi|shcp|native pci-e eject]-> =20
>>>>>        hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
>>>>>        hotplug_handler_unplug(hotplug_ctrl, dev, &local_err); ->
>>>>>             machine_unplug()
>>>>>                machine_virtio_pci_pmem_cb():=20
>>>>>                   // we now that's device has 2 stage hotplug handl=
ers,
>>>>>                   // so we can arrange hotplug sequence in necessar=
y order
>>>>>                   hotplug_ctrl2 =3D qdev_get_bus_hotplug_handler(de=
v);
>>>>>
>>>>>                   //then do unplug in whatever order that's correct=
,
>>>>>                   // I'd assume tear down/stop PCI device first, fl=
ushing
>>>>>                   // command virtio command queues and that unplug =
memory itself.
>>>>>                   hotplug_handler_unplug(hotplug_ctrl2, dev, &local=
_err);
>>>>>                   memory_device_unplug()
>>>>>    =20
>>>>
>>>> Looking into the details, this order is not possible. The unplug wil=
l
>>>> essentially do a device_unparent() leading to the whole hierarchy
>>>> getting destroyed. The memory_device part always has to come first. =
=20
>>>
>>> Question here is if there are anything that should be handled first o=
n
>>> virtio level before memory_device/pmem part is called?
>>> If there isn't it might be fine to swap the order of unplug sequence.
>>>  =20
>>
>> Was asking myself the same thing, but as we are effectively holding th=
e
>> iothread lock and the guest triggered the unplug, I guess it is fine t=
o
>> unregister the memory region at this point.
> It looks the same to me but I'm not familiar with virtio or PCI.
> I'd ask Michael if it's safe thing to do.

It is certainly cleaner to do it after the device was unrealized.

The only way I see is to provide a post_unplug handler that will be run
after unrealize(false), but before deleting the object(s).

As I already said that, the unplug/unplug_request handlers are very
different to the other handlers, as they actively delete(request to
delete) an object. In contrast to pre_plug/plug that don't create an
object but only wire it up while realizing the device.

That is the reason why we can't do stuff after calling the bus hotunplug
handler but only before it. We cannot really modify the calling order.

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 046d8f1f76..777a9486bf 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -885,6 +885,12 @@ static void device_set_realized(Object *obj, bool
value, Error **errp)
             local_errp =3D local_err ? NULL : &local_err;
             dc->unrealize(dev, local_errp);
         }
+
+        hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
+        if (hotplug_ctrl) {
+            hotplug_handler_post_unplug(hotplug_ctrl, dev);
+        }
+
         dev->pending_deleted_event =3D true;
         DEVICE_LISTENER_CALL(unrealize, Reverse, dev);
     }

At that point all devices are unrealized but still alive.

We can do what you imagined from there - make virtio-pmem-pci the memory
device and overwrite its hotplug handler. Call a handler chain (in case
we would have a pci post_unplug handler someday).

If we want to do something before unplug, we can use the current unplug
handler (via hotplug handler chain).

Do you have other ideas?

--=20

Thanks,

David / dhildenb
