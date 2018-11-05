Received: from eggs.gnu.org ([2001:4830:134:3::10]:51032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJdOm-0000K1-Td
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJdOe-0006IT-Or
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:50:26 -0500
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-3-david@redhat.com>
	<20181105122148.2eae5288.cohuck@redhat.com>
	<3ba91b23-fbea-edce-3f2e-d3405cb3b4f7@redhat.com>
	<a836fc7f-ab55-a51e-26ed-4d0dfd721737@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a7da29b4-68ff-ae8b-5c0e-e025a7939102@redhat.com>
Date: Mon, 5 Nov 2018 12:50:00 +0100
MIME-Version: 1.0
In-Reply-To: <a836fc7f-ab55-a51e-26ed-4d0dfd721737@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/4] s390x/zpci: use hotplug_dev instead
 of looking up the host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, =Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>

On 05.11.18 12:40, Christian Borntraeger wrote:
>=20
>=20
> On 11/05/2018 12:37 PM, David Hildenbrand wrote:
>> On 05.11.18 12:21, Cornelia Huck wrote:
>>> On Mon,  5 Nov 2018 12:03:11 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> We directly have it in our hands.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  hw/s390x/s390-pci-bus.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>> index 1eaae3aca6..68660eac74 100644
>>>> --- a/hw/s390x/s390-pci-bus.c
>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>> @@ -814,9 +814,9 @@ static bool s390_pci_alloc_idx(S390pciState *s, =
S390PCIBusDevice *pbdev)
>>>>  static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceSt=
ate *dev,
>>>>                                Error **errp)
>>>>  {
>>>> +    S390pciState *s =3D S390_PCI_HOST_BRIDGE(hotplug_dev);
>>>>      PCIDevice *pdev =3D NULL;
>>>>      S390PCIBusDevice *pbdev =3D NULL;
>>>> -    S390pciState *s =3D s390_get_phb();
>>>> =20
>>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>>>>          BusState *bus;
>>>> @@ -924,11 +924,11 @@ static void s390_pcihost_timer_cb(void *opaque=
)
>>>>  static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, Device=
State *dev,
>>>>                                  Error **errp)
>>>>  {
>>>> +    S390pciState *s =3D S390_PCI_HOST_BRIDGE(hotplug_dev);
>>>>      PCIDevice *pci_dev =3D NULL;
>>>>      PCIBus *bus;
>>>>      int32_t devfn;
>>>>      S390PCIBusDevice *pbdev =3D NULL;
>>>> -    S390pciState *s =3D s390_get_phb();
>>>> =20
>>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>>>>          error_setg(errp, "PCI bridge hot unplug currently not suppo=
rted");
>>>
>>> Not sure whether that is an improvement (s390_get_phb() caches the
>>> value, and is called from multiple other places as well.)
>>>
>>
>> Looking up a variable that is directly passed as an argument doesn't
>> look clean to me.
>=20
> I think there was a reason for this caching, namely that qom resolution=
 can
> be quite expensive. For the hotplug case this obviously does not matter=
 but
> for all the other cases it might. So do we really want to have differen=
t=20
> places use different methods?
>=20

Caching resolution is fine (as that is expensive), caching a downcast is
as far as I remember not necessary. Especially, as you said, for hotplug
handlers.

Anyhow, if there are strong feelings to this change, I can drop this
patch. There are certainly more important things to do in zPCI hotplug co=
de.


--=20

Thanks,

David / dhildenb
