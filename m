Received: from eggs.gnu.org ([2001:4830:134:3::10]:33824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRC0M-0000SB-RW
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRC0G-000873-PC
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:40:14 -0400
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-9-david@redhat.com>
	<20180608092545.52133d91.cohuck@redhat.com>
	<6a2bf8b2-5b15-d2ec-39e4-7afaf981fa3f@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e553a053-b1e1-997b-27de-33f4e1c959b3@redhat.com>
Date: Fri, 8 Jun 2018 09:40:04 +0200
MIME-Version: 1.0
In-Reply-To: <6a2bf8b2-5b15-d2ec-39e4-7afaf981fa3f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 8/8] s390x: local error handling in
 hotplug handler functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>

On 08.06.2018 09:27, Christian Borntraeger wrote:
>=20
>=20
> On 06/08/2018 09:25 AM, Cornelia Huck wrote:
>> On Thu,  7 Jun 2018 18:52:18 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> Let's introduce and use local error variables in the hotplug handler
>>> functions.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  hw/s390x/s390-virtio-ccw.c | 11 ++++++++---
>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index 7ae5fb38dd..29ea50a177 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -434,18 +434,23 @@ static void s390_machine_reset(void)
>>>  static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
>>>                                       DeviceState *dev, Error **errp)
>>>  {
>>> +    Error *local_err =3D NULL;
>>> +
>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>> -        s390_cpu_plug(hotplug_dev, dev, errp);
>>> +        s390_cpu_plug(hotplug_dev, dev, &local_err);
>>>      }
>>> +    error_propagate(errp, local_err);
>>>  }
>>> =20
>>>  static void s390_machine_device_unplug_request(HotplugHandler *hotpl=
ug_dev,
>>>                                                 DeviceState *dev, Err=
or **errp)
>>>  {
>>> +    Error *local_err =3D NULL;
>>> +
>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>> -        error_setg(errp, "CPU hot unplug not supported on this machi=
ne");
>>> -        return;
>>> +        error_setg(&local_err, "CPU hot unplug not supported on this=
 machine");
>>>      }
>>> +    error_propagate(errp, local_err);
>>>  }
>>> =20
>>>  static CpuInstanceProperties s390_cpu_index_to_props(MachineState *m=
s,
>>
>> Just seeing this patch by itself, it does not really make much sense.
>> Even if this is a split out clean-up series, I'd prefer this to go
>> together with a patch that actually adds something more to the
>> plug/unplug functions.
>=20
> +1. It is hard to see the "why". Maybe a better patch description could=
 help here?
>=20

When checking for an error (*errp) we should make sure that we don't
dereference the NULL pointer. I will be doing that in the future (memory
devices), but as you both don't seem to like this patch, I'll drop it
for now.

--=20

Thanks,

David / dhildenb
