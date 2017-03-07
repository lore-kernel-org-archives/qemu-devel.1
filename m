Received: from eggs.gnu.org ([2001:4830:134:3::10]:40454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clB68-0001GV-M4
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clB64-0002y9-Mz
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:08:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1clB64-0002y3-EI
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:07:56 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2C9F80463
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 09:07:56 +0000 (UTC)
References: <1488784960-15622-1-git-send-email-jasowang@redhat.com>
	<41346932-fb04-02a8-fcc0-591a87964c08@redhat.com>
	<20170307083011.GE4311@pxdev.xzpeter.org>
	<cf9be4a0-07cb-bea1-eb9d-f14361f7bfa1@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3a0355f8-a437-cffd-7135-a1a8d4aa6ab9@redhat.com>
Date: Tue, 7 Mar 2017 17:07:50 +0800
MIME-Version: 1.0
In-Reply-To: <cf9be4a0-07cb-bea1-eb9d-f14361f7bfa1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: do not require IOMMU to be created
 in advance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, marcel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, qemu devel <qemu-devel@nongnu.org>

miss the list, cced.


On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 16:55, Jason Wang wrote:
>
>
> On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 16:30, Peter Xu wrote:
>> On Tue, Mar 07, 2017 at 04:02:09PM +0800, Jason Wang wrote:
>>>
>>> On 2017=E5=B9=B403=E6=9C=8806=E6=97=A5 15:22, Jason Wang wrote:
>>>> After commit 96a8821d2141 ("virtio: unbreak virtio-pci with IOMMU
>>>> after caching ring translations"), IOMMU was required to be created =
in
>>>> advance. This is because we can only get the correct dma_as after pc=
i
>>>> IOMMU (e.g intel_iommu) was initialized. This is suboptimal and
>>>> inconvenient for user. This patch releases this by:
>>>>
>>>> - introduce a bus_master_ready method for PCIDeviceClass and trigger
>>>>    this during pci_init_bus_master
>>>> - implement virtio-pci method and 1) reset the dma_as 2) re-register
>>>>    the memory listener to the new dma_as
>>>>
>>>> Cc: Paolo Bonzini<pbonzini@redhat.com>
>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>> This patch breaks hotplug by calling reset_dma_as() when virtio is no=
t
>>> initialized. Will post V2 to call bus_master_ready() only at
>>> pcibus_machine_done().
>> A tiny issue with above fix would be: bus_master_ready() will not be
>> called when do device hot-plug. If we want that interface to be a
>> general one for the whole PCI framework, then imho we'd better call it
>> as well for hot-plug devices. So instead, do you like below fix?
>>
>> --------8<--------
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index a563555..f71ad54 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -995,9 +995,6 @@ static PCIDevice=20
>> *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>>       pci_dev->devfn =3D devfn;
>>       pci_dev->requester_id_cache =3D pci_req_id_cache_get(pci_dev);
>>   -    if (qdev_hotplug) {
>> -        pci_init_bus_master(pci_dev);
>> -    }
>>       pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>>       pci_dev->irq_state =3D 0;
>>       pci_config_alloc(pci_dev);
>> @@ -1967,6 +1964,10 @@ static void pci_qdev_realize(DeviceState=20
>> *qdev, Error **errp)
>>           }
>>       }
>>   +    if (qdev_hotplug) {
>> +        pci_init_bus_master(pci_dev);
>> +    }
>> +
>>       /* rom loading */
>>       is_default_rom =3D false;
>>       if (pci_dev->romfile =3D=3D NULL && pc->romfile !=3D NULL) {
>> -------->8--------
>>
>> Thanks,
>>
>> -- peterx
>
> I like this, will post V3.
>
> Thanks
