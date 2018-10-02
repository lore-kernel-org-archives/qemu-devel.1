Received: from eggs.gnu.org ([2001:4830:134:3::10]:41879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g7Mj4-0006aT-A4
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g7Miy-0005fR-Kc
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:36:42 -0400
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-19-david@redhat.com>
	<20180927150141.60a6488a@redhat.com>
	<dc5d7b2d-5b51-2c0b-aac7-ebf04a4e7859@redhat.com>
	<20181001152443.2cca5c5e@redhat.com>
	<518ce438-7d6b-6f36-8bac-d834b21fb8bc@redhat.com>
	<20181002162345.7b0197bc@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <104f4d8a-28d0-1b1e-d0a8-2ecd036a445b@redhat.com>
Date: Tue, 2 Oct 2018 17:36:25 +0200
MIME-Version: 1.0
In-Reply-To: <20181002162345.7b0197bc@redhat.com>
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

>> Inside object_unparent(), the call flow of unrealize steps is defined.
>> By moving the "real unplug" part into "do_unplug" and therefor
>> essentially calling it when unrealizing, we could generalize this for
>> all unplug handlers.
>> I think, order of realization and therefore the order of hotplug handl=
er
>> calls is strictly defined already. Same applies to unrealization if we
>> would factor the essential parts out into e.g. "do_unplug". That order
>> is strictly encoded in device_set_realized() and bus_set_realized().
>=20
> I don't see any benefits in adding do_unplug() in this case,
> it would essentially replace hotplug_handler_unplug() in event origin
> point with object_unparent() and renaming unplug() to do_unplug().
>=20
> As result object_unparent() will start do more than unparenting and
> destroying the device and a point where unplug originates becomes
> poorly documented/lost for a reader among other object_unparent() calls=
.
>=20
> hotplug handlers are controller businesses and not the device one so
> hiding (generalizing) it inside of device.realize() doesn't look
> the right this to do, I'd rather keep these things separate as much
> as possible.

As long as we find another way to make this work I am happy. What I
propose here works (and in my view does not violate any concepts, it
just extends hotunplug handlers to device hierarchies getting
unplugged). But I also understand the potential problems you think we
could have in the future. Let's see if we can make your suggestion work.

> =20
>>> If I remember right, the suggested and partially implemented idea
>>> in one of your previous series was to override default hotplug
>>> handler with a machine one for plugged in device [1][2].
>>> However impl. wasn't exactly what I've suggested since it matches
>>> all memory-devices.
>>>
>>> 1) qdev: let machine hotplug handler to override bus hotplug handler
>>> 2) pc: route all memory devices through  the machine hotplug handler
>>>
>>> So lets reiterate, we have TYPE_VIRTIO_PMEM and TYPE_VIRTIO_PMEM_PCI
>>> the former implements TYPE_MEMORY_DEVICE interface and the later is
>>> a wrapper PCI/whatnot device shim.
>>> So when you plug that composite device you'd get 2 independent
>>> plug hooks called, which makes it unrelable/broken design. =20
>>
>> Can you elaborate why this is broken? I don't consider the
>> realize/unrealize order broken, and that is where we plug into. But ye=
s,
>> we logically plug a device hierarchy and therefore get a separate
>> hotplug handler calls.
>=20
> 1st:
>=20
> consider we have a composite device A that contains B explicitly
> manged by A (un)realizefn(). Now if we use your model of independent
> callbacks we have only following fixed plug flow possible:
>    a>realize()
>       ::device_set_realized()
>          a:realizefn()
>              b->realize()
>                ::device_set_realized()
>                    b:realizefn()
>                    hotplug_handler_plug(b) =3D> b_hotplug_callback
>              ...
>          hotplug_handler_plug(a) =3D> a_hotplug_callback
>=20
> that limits composite device wiring to external components to
> the only possible order

That why we have pre_plug, plug and post_plug handlers for I guess ...

>   1st: b_hotplug_callback() + 2nd: a_hotplug_callback
> and other way around for unplug()
>=20
> That however might not be order we need to do wiring/teardown though,
> depending on composite device and controllers it might be necessary to
> call callbacks in opposite order or mix both into one to do the wiring
> correctly. And to do that we would need drop (move) b_hotplug_callback(=
)
> into a_hotplug_callback(), i.e. make it the way I've originally suggest=
ed.
>=20
> hotplug callback call flow might be different in child_bus case
> (well, it's different in current code) and it might change in future
> (ex: I'm looking into dropping hotplug_handler_post_plug() and
> moving hotplug_handler_plug() to a later point to address the same
> issue as commits 25e89788/8449bcf94 but without post_plug callback).

.. however that sounds like a good idea, I was wondering the same why we
actually need the post_plug handler.

>=20
> It's more robust for devices do not depend heavily on specific order
> and define its plug sequence explicitly outside of device core.
> This way it won't break apart when device core code is amended.=20
>=20
> 2nd:
> from user point of view (and API) when composite device is created
> we are dealing with 1 device (even if it's composed of many others inte=
rnally,
> it's not an external user business). The same should apply to hotplug
> handlers. i.e. wire that device using whatever controllers are necessar=
y
> but do not jump through layers inside of device from external code
> which hotplug handlers are.

It somehow looks strange to have plug handler scattered all over
device_set_realize(), while unplug handlers are at a completely
different place and not involved in unrealize(). This makes one think
that hotplugging a device hierarchy works, while unplugging does
currently not work.

>=20
>>> My next question would be why TYPE_VIRTIO_PMEM_PCI can't implement=20
>>> TYPE_MEMORY_DEVICE interface and TYPE_VIRTIO_PMEM be a simple VIRTIO
>>> device without any hotplug hooks (so shim device would proxy all
>>> memory-device logic to its child)?
>>> /huh, then you don't need get_device_id() as well/ =20
>>
>> I had the same idea while going through different options. Then we wou=
ld
>> have to forward all calls directly to the child. We cannot reuse
>> TYPE_MEMORY_DEVICE, so we would either need a new interface or define
>> the functions we want manually for each such device.
> for all I care parent device could alias out its memory-device api to a=
 child
> or just outright access/call child internal APIs/members to do the job
> (that's what virtio devices often do), but that's the price to pay for
> ability to change type of the end device.
>=20
>>> That way using [2] and [1 - modulo it should match only concrete type=
]
>>> machine would be able to override hotplug handlers for TYPE_VIRTIO_PM=
EM_PCI
>>> and explicitly call machine + pci hotplug handlers in necessary order=
.
>>>
>>> flow would look like:
>>>   [acpi|shcp|native pci-e eject]-> =20
>>>        hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
>>>        hotplug_handler_unplug(hotplug_ctrl, dev, &local_err); ->
>>>             machine_unplug()
>>>                machine_virtio_pci_pmem_cb():=20
>>>                   // we now that's device has 2 stage hotplug handler=
s,
>>>                   // so we can arrange hotplug sequence in necessary =
order
>>>                   hotplug_ctrl2 =3D qdev_get_bus_hotplug_handler(dev)=
;
>>>
>>>                   //then do unplug in whatever order that's correct,
>>>                   // I'd assume tear down/stop PCI device first, flus=
hing
>>>                   // command virtio command queues and that unplug me=
mory itself.
>>>                   hotplug_handler_unplug(hotplug_ctrl2, dev, &local_e=
rr);
>>>                   memory_device_unplug()
>>>
>>> Similar logic applies to device_add/device_del paths, with a differen=
ce that
>>> origin point would be monitor/qmp. =20
>>
>> Let's see. User calls device_del(). That triggers an unplug_request. F=
or
>> virtio-pmem, there is nothing to do.
> virtio-pmem is not a concrete device though, it's just internal thingy
> inside of concrete device, the actual virtio-pmem-pci device is associa=
ted
> with a pci controller that notifies guest about unplug request using
> whatever hotplug method was configured for the controller (shpc/native =
pci-e/acpi).
>=20
>> eject hook is called by the guest. For now we do an object_unparent.
>> This would now be wrong. We would have to call a proper hotplug handle=
r
>> chain (I guess that's the refactoring you mentioned above).
> it works for typical pci devices but it won't work for composite
> ones that need access to controllers/resources not provided by
> it's direct parent. At minimum it should be object_unparent() wrapped
> into unplug() callback  callback set for the pci bus if we'd look for s=
hallow
> conversion. But I haven't looked in details...

I will do that during the next weeks. I'll resend the unrelated memory
device changes for now.

>=20
>>> Point is to have a single explicit callback chain that applies to a c=
oncrete
>>> device type. That way if ever change an ordering of calling plug call=
backs
>>> in qdev core, the expected for a device callback sequence would still
>>> remain in place ensuring that device (un)plugged as expected. =20
>>
>> I haven't tested yet if this will work, but I can give it a try. I
>> learned that in QEMU things often seem easier than they actually are :=
)
>>
>>>
>>> Also it should be easier to trace for a reader, than 2 disjoint callb=
acks of
>>> composite device (which only know to author of that device and then o=
nly
>>> till he/she remembers how that thing works). =20
>>
>> In my view it makes things slightly more complicated, because you have
>> to follow a hotplug handler chain that plugs devices via proxy devices=
.
>> (e.g. passing through TYPE_MEMORY_DEVICE calls to a child, and therefo=
re
>> essentially hotplugging the child), instead of only watching out for
>> which device get's hotplugged and finding exactly one hotplug handler.
>> Of course, for a device hierarchy, multiple devices get logically
>> hotplugged.
> it's child only from internal point of view (in virtio design it's
> virtio interface to share logic between different transports),
> users don't really care about it.
> It's job of proxy to forward data between external/internal world,
> unfortunately adds more boilerplate but that's how virtio has been
> designed.
> As for following explicitly defined hotplug handlers chain,
> it's explict and relevant parts are close to each other so it's easier
> to understand what's going on, than trying to figure out implicit
> callbacks sequence and how they are related.
>=20

So to summarize, you clearly favor a hotplug chain on a single device
over multiple hotplug handlers for separate devices in a device hierarchy=
.

--=20

Thanks,

David / dhildenb
