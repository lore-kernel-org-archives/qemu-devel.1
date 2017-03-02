Received: from eggs.gnu.org ([2001:4830:134:3::10]:39309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjLT5-0006IC-C5
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 02:48:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjLT2-0004Av-9r
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 02:48:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cjLT2-0004Ao-3v
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 02:48:04 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 152867E9D5
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 07:48:04 +0000 (UTC)
References: <1488341440-4347-1-git-send-email-jasowang@redhat.com>
	<20170302051016.GA3893@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3c36e5ad-1244-ca1c-ca3c-5cab9e5cdda4@redhat.com>
Date: Thu, 2 Mar 2017 15:47:57 +0800
MIME-Version: 1.0
In-Reply-To: <20170302051016.GA3893@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: unbreak virtio-pci with IOMMU
 after caching ring translations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, wexu@redhat.com, Paolo Bonzini <pbonzini@redhat.com>



On 2017=E5=B9=B403=E6=9C=8802=E6=97=A5 13:10, Michael S. Tsirkin wrote:
> On Wed, Mar 01, 2017 at 12:10:40PM +0800, Jason Wang wrote:
>> Commit c611c76417f5 ("virtio: add MemoryListener to cache ring
>> translations") registers a memory listener to dma_as. This may not
>> work when IOMMU is enabled: dma_as(bus_master_as) were initialized in
>> pcibus_machine_done() after virtio_realize(). This will cause a
>> segfault. Fixing this by using pci_device_iommu_address_space()
>> instead to make sure address space were initialized at this time.
>>
>> With this fix, IOMMU device were required to be initialized before any
>> virtio-pci devices.
>>
>> Fixes: c611c76417f5 ("virtio: add MemoryListener to cache ring transla=
tions")
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> This is very ugly. I guess it's better than broken IOMMU ...
> Paolo?

Maybe we can delay the registering of memory listener on bus master=20
enabling or status setting.

Thanks

>
>> ---
>>   hw/virtio/virtio-pci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index 5ce42af..b76f3f6 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -1153,7 +1153,7 @@ static AddressSpace *virtio_pci_get_dma_as(Devic=
eState *d)
>>       VirtIOPCIProxy *proxy =3D VIRTIO_PCI(d);
>>       PCIDevice *dev =3D &proxy->pci_dev;
>>  =20
>> -    return pci_get_address_space(dev);
>> +    return pci_device_iommu_address_space(dev);
>>   }
>>  =20
>>   static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
>> --=20
>> 2.7.4
