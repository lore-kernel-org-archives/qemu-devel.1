Received: from eggs.gnu.org ([2001:4830:134:3::10]:40641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqhNO-0008C3-MC
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqhL1-00057q-5K
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:11:02 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fqhL0-00057H-U6
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:10:59 -0400
Received: by mail-wm0-x243.google.com with SMTP id c14-v6so8073587wmb.4
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 09:10:58 -0700 (PDT)
References: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
	<1534411696-6454-3-git-send-email-jing2.liu@linux.intel.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <bf7fbbe7-0bc0-12a7-c0c2-cf3249df75a9@gmail.com>
Date: Fri, 17 Aug 2018 19:10:55 +0300
MIME-Version: 1.0
In-Reply-To: <1534411696-6454-3-git-send-email-jing2.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/3] hw/pci: add teardown function for
 PCI resource reserve capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jing Liu <jing2.liu@linux.intel.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, mst@redhat.com, lersek@redhat.com, pbonzini@redhat.com

Hi Jing,

On 08/16/2018 12:28 PM, Jing Liu wrote:
> Clean up the PCI config space of resource reserve capability.
>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> ---
>   hw/pci/pci_bridge.c         | 9 +++++++++
>   include/hw/pci/pci_bridge.h | 1 +
>   2 files changed, 10 insertions(+)
>
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index 15b055e..dbcee90 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -465,6 +465,15 @@ int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
>       return 0;
>   }
>   
> +void pci_bridge_qemu_reserve_cap_uninit(PCIDevice *dev)
> +{
> +    uint8_t pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> +
> +    pci_del_capability(dev, PCI_CAP_ID_VNDR, sizeof(PCIBridgeQemuCap));

I think that you only need to call pci_del_capability,

> +    memset(dev->config + pos + PCI_CAP_FLAGS, 0,
> +           sizeof(PCIBridgeQemuCap) - PCI_CAP_FLAGS);
> +}

... no need for the above line. The reason is pci_del_capability
will "unlink" the capability, and even if the data remains in
the configuration space array, it will not be used.

Do you agree? If yes, just call pci_del_capability and you don't need
this patch.


Thanks,
Marcel

> +
>   static const TypeInfo pci_bridge_type_info = {
>       .name = TYPE_PCI_BRIDGE,
>       .parent = TYPE_PCI_DEVICE,
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index 6186a32..b1e25ad 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -147,4 +147,5 @@ typedef struct PCIResReserve {
>   int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
>                                  PCIResReserve res_reserve, Error **errp);
>   
> +void pci_bridge_qemu_reserve_cap_uninit(PCIDevice *dev);
>   #endif /* QEMU_PCI_BRIDGE_H */
