Received: from eggs.gnu.org ([209.51.188.92]:45635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1giz8W-0000PP-AB
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1giz8V-0000s2-FV
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:06:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51142
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1giz8U-0000qp-As
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:06:26 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0E9wcdV078880
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 05:06:24 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q0pskm5rb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 05:06:24 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Mon, 14 Jan 2019 10:06:22 -0000
Reply-To: pmorel@linux.ibm.com
References: <20190110210358.24035-1-david@redhat.com>
	<4988f58e-4bc5-c622-53b7-cfda758304e1@redhat.com>
	<20190111103828.058ccc6c.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 14 Jan 2019 11:06:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190111103828.058ccc6c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <c30709c1-9348-e4c9-22bb-95d6183163f3@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] s390x/pci: Send correct event on
 hotplug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 11/01/2019 10:38, Cornelia Huck wrote:
> On Fri, 11 Jan 2019 08:16:41 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 10.01.19 22:03, David Hildenbrand wrote:
>>> Comit 2c28c490571f ("s390x/pci: let pci devices start in configured m=
ode")
>>> changed the initial state of zPCI devices from ZPCI_FS_STANDBY to
>>> ZPCI_FS_DISABLED (a.k.a. configured). However we still only send a
>>> HP_EVENT_RESERVED_TO_STANDBY event to the guest, indicating a wrong
>>> state.
>>>
>>> Let's send a HP_EVENT_TO_CONFIGURED event instead, to match the actua=
l
>>> state the device is in.
>>>
>>> This fixes hotplugged devices having to be enabled explicitly in the
>>> guest e.g. via echo 1 > /sys/bus/pci/slots/00000000/power.
>>>
>>> Fixes: 2c28c490571f ("s390x/pci: let pci devices start in configured =
mode")
>>> Report-by: Cornelia Huck <cohuck@redhat.com>
>=20
> Cool, works for me as well.
>=20
> Tested-by: Cornelia Huck <cohuck@redhat.com>
>=20
> Do we want to cc:stable? Probably not, as it's more annoying than
> critical, and pci hotplug does not seem to be much used on s390x.
>=20
>>
>> If this patch is the right thing to do, then
>>
>> 1. s/Report-by/Reported-by/
>> 2. Dropping the "." from the subject
>>
>> (yes, it was late)
>=20
> :) Can do while applying.
>=20
>>
>> I wonder if we should do both events sequentially, but as I don't have
>> access to the architecture I have to rely on that this works :)
>=20
> Yep, let's wait for feedback from folks with architecture access.
>=20

Works fine on the architecture too.

Seems the logical thing to do for me.

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>


>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   hw/s390x/s390-pci-bus.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>> index 15759b6514..7f911b216a 100644
>>> --- a/hw/s390x/s390-pci-bus.c
>>> +++ b/hw/s390x/s390-pci-bus.c
>>> @@ -899,7 +899,7 @@ static void s390_pcihost_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>>>           }
>>>  =20
>>>           if (dev->hotplugged) {
>>> -            s390_pci_generate_plug_event(HP_EVENT_RESERVED_TO_STANDB=
Y,
>>> +            s390_pci_generate_plug_event(HP_EVENT_TO_CONFIGURED ,
>>>                                            pbdev->fh, pbdev->fid);
>>>           }
>>>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVIC=
E)) {
>>>   =20
>>
>>
>=20
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
