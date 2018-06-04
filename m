Received: from eggs.gnu.org ([2001:4830:134:3::10]:38328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fPndl-0004dE-3u
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fPndi-0003x3-0L
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:27:09 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-5-david@redhat.com>
	<20180530150806.061c26b9@redhat.com>
	<5dcb16e5-b9b9-d07d-dfe3-98724e911f83@redhat.com>
	<20180531161310.52ea9507@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e451e0d6-a181-b027-cdb7-f44beb11b37c@redhat.com>
Date: Mon, 4 Jun 2018 13:27:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180531161310.52ea9507@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On 31.05.2018 16:13, Igor Mammedov wrote:
> On Wed, 30 May 2018 16:13:32 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 30.05.2018 15:08, Igor Mammedov wrote:
>>> On Thu, 17 May 2018 10:15:17 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>  =20
>>>> For multi stage hotplug handlers, we'll have to do some error handli=
ng
>>>> in some hotplug functions, so let's use a local error variable (exce=
pt
>>>> for unplug requests). =20
>>> I'd split out introducing local error into separate patch
>>> so patch would do a single thing.

I can do that if it makes review easier.

>>>  =20
>>>> Also, add code to pass control to the final stage hotplug handler at=
 the
>>>> parent bus. =20
>>> But I don't agree with generic
>>>  "} else if ("dev->parent_bus && dev->parent_bus->hotplug_handler) {"
>>> forwarding, it's done by 3/14 for generic case and in case of
>>> special device that needs bus handler called from machine one,
>>> I'd suggest to do forwarding explicitly for that device only
>>> like we do with acpi_dev. =20
>>
>> I decided to do it that way because it is generic and results in nicer
>> recovery handling (e.g. in case pc_dimm plug fails, we can simply
>> rollback all (for now MemoryDevice) previous plug operations).
> rollback should be managed by the caller of pc_dimm plug
> directly, so it's not relevant here.
>=20
>> IMHO, the resulting code is easier to read.
>>
>> From this handling it is clear that
>> "if we reach the hotplug handler, and it is not some special device
>> plugged by the machine (CPU, PC_DIMM), pass it on to the actual hotplu=
g
>> handler if any exists"
> I strongly disagree with that it's easier to deal with.
> You are basically duplicating already generalized code
> from qdev_get_hotplug_handler() back into boards.
>=20
> If a device doesn't have to be handled by machine handler,
> than qdev_get_hotplug_handler() must return its bus handler
> if any directly. So branch in question that your are copying
> is a dead one, pls drop it.

We forward selected (pc_get_hotpug_handler()) devices to the
right hotplug handler. Nothing wrong about that. I don't agree
with "basically duplicating already generalized code" wrong.
We have to forward at some place. Your idea simply places that
code at some other place.


But I think we have to get the general idea sorted out first.

What you have in mind (e.g. plug):

if (TYPE_MEMORY_DEVICE) {
	memory_device_plug();
	if (local_err) {
		goto out;
	}

	if (TYPE_PC_DIMM) {
		pc_dimm_plug(hotplug_dev, dev, &local_err);
	} else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
		hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err)=
;
	}
	if (local_err) {
		memory_device_unplug()
		goto out;
	}
} else if (TYPE_CPU)
...


What I have in mind (and implemented in this series):


if (TYPE_MEMORY_DEVICE) {
	memory_device_plug();
}
/* possibly other interfaces */
if (local_err) {
	error_handling();
	return;
}

if (TYPE_PC_DIMM) {
	pc_dimm_plug(hotplug_dev, dev, &local_err);
} ...
} else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
	hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &local_err);
}

if (local_err) {
	if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
		memory_device_unplug()
	}
	/* possibly other interfaces */
}
...


I claim that my variant is more generic because:
- it easily supports multiple interfaces (like MemoryDevice)
  per Device that need a hotplug handler call
- there is only one call to hotplug_handler_plug() in case we
  add similar handling for another device

Apart from that they do exactly the same thing.

--=20

Thanks,

David / dhildenb
