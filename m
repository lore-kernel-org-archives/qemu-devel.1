Received: from eggs.gnu.org ([2001:4830:134:3::10]:35388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQ6kj-0004fA-7T
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQ6ke-0001q7-CA
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:51:37 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-7-david@redhat.com>
	<20180605010840.GF5140@umbus.fritz.box>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fbd2d738-7356-e991-7c15-f9cc436a9378@redhat.com>
Date: Tue, 5 Jun 2018 09:51:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180605010840.GF5140@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/14] spapr: prepare for multi stage
 hotplug handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On 05.06.2018 03:08, David Gibson wrote:
> On Thu, May 17, 2018 at 10:15:19AM +0200, David Hildenbrand wrote:
>> For multi stage hotplug handlers, we'll have to do some error handling
>> in some hotplug functions, so let's use a local error variable (except
>> for unplug requests).
>>
>> Also, add code to pass control to the final stage hotplug handler at t=
he
>> parent bus.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/ppc/spapr.c | 54 +++++++++++++++++++++++++++++++++++++++++++------=
-----
>>  1 file changed, 43 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index ebf30dd60b..b7c5c95f7a 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3571,27 +3571,48 @@ static void spapr_machine_device_plug(HotplugH=
andler *hotplug_dev,
>>  {
>>      MachineState *ms =3D MACHINE(hotplug_dev);
>>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
>> +    Error *local_err =3D NULL;
>> =20
>> +    /* final stage hotplug handler */
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>          int node;
>> =20
>>          if (!smc->dr_lmb_enabled) {
>> -            error_setg(errp, "Memory hotplug not supported for this m=
achine");
>> -            return;
>> +            error_setg(&local_err,
>> +                       "Memory hotplug not supported for this machine=
");
>> +            goto out;
>>          }
>> -        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_P=
ROP, errp);
>> -        if (*errp) {
>> -            return;
>> +        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_P=
ROP,
>> +                                        &local_err);
>> +        if (local_err) {
>> +            goto out;
>>          }
>>          if (node < 0 || node >=3D MAX_NODES) {
>> -            error_setg(errp, "Invaild node %d", node);
>> -            return;
>> +            error_setg(&local_err, "Invaild node %d", node);
>> +            goto out;
>>          }
>> =20
>> -        spapr_memory_plug(hotplug_dev, dev, node, errp);
>> +        spapr_memory_plug(hotplug_dev, dev, node, &local_err);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE))=
 {
>> -        spapr_core_plug(hotplug_dev, dev, errp);
>> +        spapr_core_plug(hotplug_dev, dev, &local_err);
>> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>> +        hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &=
local_err);
>> +    }
>> +out:
>> +    error_propagate(errp, local_err);
>> +}
>> +
>> +static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
>> +                                        DeviceState *dev, Error **err=
p)
>> +{
>> +    Error *local_err =3D NULL;
>> +
>> +    /* final stage hotplug handler */
>> +    if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>=20
> As I think Igor said on the equivalent PC patch, I don't quite get
> this.  Isn't this already handled by the generic hotplug code picking
> up the bus's hotplug handler if the machine doesn't supply one?

See my reply to patch nr 4.

What we do is, we install the machine hotplug handler as an
"intermediate" hotplug handler.

E.g. if we have a VIRTIO based MemoryDevice, we have to initialize the
MemoryDevice specific stuff in the machine hotplug handler, but then
pass the device onto the last stage hotplug handler (which will
eventually attach it to a bus and notify the guest).

For PC_DIMM, the machine hotplug handler is already the last stage
hotplug handler. Everything is fine. If it is not a PC_DIMM, we have to
pass it on to the right last stage hotplug handler (e.g. using the bus).

So the generic hotplug code will alway pick up the machine hotplug
handler for MemoryDevices first, do the MemoryDevice specific stuff and
then pass on control to the "actual" hotplug handler.

Please note that this handling only applies to device types we "route"
through the machine hotplug handler, what we will initially only do for
MemoryDevices.

Just like for PC, I factored out the introduction of the local error
variable and will add a better description to the patch descriptions on
how this plays together.

--=20

Thanks,

David / dhildenb
