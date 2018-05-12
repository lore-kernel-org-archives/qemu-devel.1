Received: from eggs.gnu.org ([2001:4830:134:3::10]:38597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fHXef-0002fK-T8
	for qemu-devel@nongnu.org; Sat, 12 May 2018 12:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fHXec-0001uh-RG
	for qemu-devel@nongnu.org; Sat, 12 May 2018 12:45:57 -0400
References: <20180511131953.12905-1-david@redhat.com>
	<20180511131953.12905-5-david@redhat.com>
	<f0ca94ed-ff7a-c08b-fea9-8d7e513a2519@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e5ce6c3d-6586-b5d5-1ef8-83097f10402b@redhat.com>
Date: Sat, 12 May 2018 18:45:50 +0200
MIME-Version: 1.0
In-Reply-To: <f0ca94ed-ff7a-c08b-fea9-8d7e513a2519@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/17] pc: route all memory devices
 through the machine hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On 12.05.2018 16:47, Paolo Bonzini wrote:
> On 11/05/2018 15:19, David Hildenbrand wrote:
>> +    if (dev->parent_bus) {
>> +        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>> +            return HOTPLUG_HANDLER(machine);
>> +        }
>> +    }
>> +
>=20
> How do you get here with a MemoryDevice that has !dev->parent_bus?
>=20

Excellent question :)

This is for now (for pc and spapr) a theoretical case, but I
included it to make all hotplug handler look alike and also show for
other potential device (interfaces) how it should be handled.

I'll give you the s390x example I had in mind:

s390x cannot hotplug dimms. dimms, however are busless devices that
implement the MemoryDevice interface.

If we would simply always indicate this way that we have a hotplug
handler, e.g. the check in qdev_device_add() would not trigger:

...
if (bus) {
    qdev_set_parent_bus(dev, bus);
} else if (qdev_hotplug && !qdev_get_machine_hotplug_handler(dev)) {
    /* No bus, no machine hotplug handler --> device is not hotpluggable =
*/
    error_setg(&err, "Device '%s' can not be hotplugged on this machine",
               driver);
    goto err_del_dev;
}
...

So the rational is "if its a busless device and I (the machine)
am not able to fully plug it, I must also not partially plug it."

However, right now I am not sure (due to qdev_hotplug) if this
is enough.


> Thanks,
>=20
> Paolo
>=20


--=20

Thanks,

David / dhildenb
