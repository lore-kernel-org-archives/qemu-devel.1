Received: from eggs.gnu.org ([2001:4830:134:3::10]:60884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dlJIr-0003Hj-0D
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dlJIq-0001Vr-4n
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:25:57 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dlJIp-0001Ul-UO
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:25:56 -0400
Received: by mail-wr0-x243.google.com with SMTP id o76so308350wrb.5
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 11:25:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823221445.15243-6-ehabkost@redhat.com>
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-6-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 25 Aug 2017 11:25:24 -0700
Message-ID: <CAKmqyKM8kKPQ=br6XL4wSEhz_=XuQcEkJJwFZjfNYkS+CLnhvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/5] pci: Validate interfaces on
 base_class_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Aug 23, 2017 at 3:14 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Make sure we don't forget to add the legacy-PCI or PCIe interface
> names on PCI device classes in the future.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  hw/pci/pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index baa3429..7ac5cc6 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2525,6 +2525,17 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
>      pc->realize = pci_default_realize;
>  }
>
> +static void pci_device_class_base_init(ObjectClass *klass, void *data)
> +{
> +    if (!object_class_is_abstract(klass)) {
> +        ObjectClass *legacy =
> +            object_class_dynamic_cast(klass, INTERFACE_LEGACY_PCI_DEVICE);
> +        ObjectClass *pcie =
> +            object_class_dynamic_cast(klass, INTERFACE_PCIE_DEVICE);
> +        assert(legacy || pcie);
> +    }
> +}
> +
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>  {
>      PCIBus *bus = PCI_BUS(dev->bus);
> @@ -2649,6 +2660,7 @@ static const TypeInfo pci_device_type_info = {
>      .abstract = true,
>      .class_size = sizeof(PCIDeviceClass),
>      .class_init = pci_device_class_init,
> +    .class_base_init = pci_device_class_base_init,
>  };
>
>  static void pci_register_types(void)
> --
> 2.9.4
>
>
