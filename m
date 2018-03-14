Received: from eggs.gnu.org ([2001:4830:134:3::10]:47401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1evz9o-00050w-A2
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1evz9l-00088f-8W
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:41:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1evz9k-000881-W2
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:40:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2E5enbC000717
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 01:40:55 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gpuqq3s02-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 01:40:55 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Wed, 14 Mar 2018 01:40:53 -0400
References: <20180314051440.9538-1-zyimin@linux.vnet.ibm.com>
	<62501049-ae2b-f6cc-2f79-04e1b6072a2c@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 13:40:46 +0800
MIME-Version: 1.0
In-Reply-To: <62501049-ae2b-f6cc-2f79-04e1b6072a2c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b4a87d0a-6b98-ad0a-47d9-cc46bf916c89@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390x/pci: forbid multifunction pci device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pasic@linux.vnet.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, marcel@redhat.com, Qemu-s390x list <qemu-s390x@nongnu.org>



=E5=9C=A8 2018/3/14 =E4=B8=8B=E5=8D=881:35, Thomas Huth =E5=86=99=E9=81=93=
:
> On 14.03.2018 06:14, Yi Min Zhao wrote:
>> Currently we don't support pci multifunction. If a pci with
>> multifucntion is plugged, the guest will spin forever. This patch fixe=
s
>> this.
>>
>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 77a50cab36..10da87458e 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -816,6 +816,11 @@ static void s390_pcihost_hot_plug(HotplugHandler =
*hotplug_dev,
>>           PCIBridge *pb =3D PCI_BRIDGE(dev);
>>           PCIDevice *pdev =3D PCI_DEVICE(dev);
> Off-topic: That "PCIDevice *pdev" shadows the pdev variable that is
> declared at the beginning of this function. So I think we should rather
> change the above line into "pdev =3D PCI_DEVICE(dev)" instead, without
> re-declaring a variable here. (i.e. we should do this in a separate
> patch later...).
Thanks for your reminder. Actually I have noticed this. But I thought=20
this is not very urgent.
I will do this later.
>
>> +        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
>> +            error_setg(errp, "multifunction not supported in s390");
>> +            return;
>> +        }
>> +
>>           pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
>>           pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
>>  =20
>> @@ -835,6 +840,11 @@ static void s390_pcihost_hot_plug(HotplugHandler =
*hotplug_dev,
>>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>>           pdev =3D PCI_DEVICE(dev);
>>  =20
>> +        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
>> +            error_setg(errp, "multifunction not supported in s390");
>> +            return;
>> +        }
>> +
>>           if (!dev->id) {
>>               /* In the case the PCI device does not define an id */
>>               /* we generate one based on the PCI address         */
>>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
>
