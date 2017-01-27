Received: from eggs.gnu.org ([2001:4830:134:3::10]:39483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cX941-0003yc-LB
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cX93x-0000lR-MF
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:07:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cX93x-0000kj-FX
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:07:45 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 335FBC7041
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 16:07:45 +0000 (UTC)
References: <1483559838-8797-1-git-send-email-marcel@redhat.com>
	<1483559838-8797-3-git-send-email-marcel@redhat.com>
	<20170110050646-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <8ea6379b-62c6-c407-1152-aed64e08a587@redhat.com>
Date: Fri, 27 Jan 2017 18:07:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170110050646-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/virtio: fix error enabling flags in
 Device Control register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, yvugenfi@redhat.com

On 01/10/2017 05:07 AM, Michael S. Tsirkin wrote:
> On Wed, Jan 04, 2017 at 09:57:16PM +0200, Marcel Apfelbaum wrote:
>> When the virtio devices are PCI Express, make error-enabling flags
>> writable to respect the PCIe spec.
>>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>
> If guest writes there, it won't be able to migrate.
> So I think this needs a compat flag.

Hi Michael,
Thanks for the review.

Do you have any suggestion on the compat property name?
Should I use the same property for all patches in this path set,
something like "x-pcie-compliance" or one per issue?

Thanks,
Marcel

>
>> ---
>>  hw/virtio/virtio-pci.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index 21c2b9d..da2124f 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -1802,6 +1802,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>>           * PCI Power Management Interface Specification.
>>           */
>>          pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
>> +        /* Init error enabling flags */
>> +        pcie_cap_deverr_init(pci_dev);
>>      } else {
>>          /*
>>           * make future invocations of pci_is_express() return false
>> @@ -1828,6 +1830,7 @@ static void virtio_pci_reset(DeviceState *qdev)
>>  {
>>      VirtIOPCIProxy *proxy = VIRTIO_PCI(qdev);
>>      VirtioBusState *bus = VIRTIO_BUS(&proxy->bus);
>> +    PCIDevice *dev = PCI_DEVICE(qdev);
>>      int i;
>>
>>      virtio_pci_stop_ioeventfd(proxy);
>> @@ -1837,6 +1840,10 @@ static void virtio_pci_reset(DeviceState *qdev)
>>      for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>>          proxy->vqs[i].enabled = 0;
>>      }
>> +
>> +    if (pci_is_express(dev)) {
>> +        pcie_cap_deverr_reset(dev);
>> +    }
>>  }
>>
>>  static Property virtio_pci_properties[] = {
>> --
>> 2.5.5
