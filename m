Received: from eggs.gnu.org ([2001:4830:134:3::10]:59834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dlJFi-0001R2-GX
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dlJFh-0004tm-CB
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:22:42 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dlJFh-0004ll-5Z
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 14:22:41 -0400
Received: by mail-wr0-x242.google.com with SMTP id p14so307075wrg.4
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 11:22:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823221445.15243-2-ehabkost@redhat.com>
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-2-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 25 Aug 2017 11:22:08 -0700
Message-ID: <CAKmqyKMDQKQARPjs+uEE5DBoetQin0t2w0XXAzHpTiZ=55k=6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/5] pci: INTERFACE_LEGACY_PCI_DEVICE and
 INTERFACE_PCIE_DEVICE interfaces
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
> Those two interfaces will be used to indicate which device types
> support legacy PCI or PCI-express buses.  Management software
> will be able to use the qom-list-types QMP command to query that
> information.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  include/hw/pci/pci.h |  6 ++++++
>  hw/pci/pci.c         | 12 ++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index e598b09..f5e8ab9 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -195,6 +195,12 @@ enum {
>  #define PCI_DEVICE_GET_CLASS(obj) \
>       OBJECT_GET_CLASS(PCIDeviceClass, (obj), TYPE_PCI_DEVICE)
>
> +/* Interface implemented by devices that can be plugged on PCIe buses */
> +#define INTERFACE_PCIE_DEVICE "pci-express-device"
> +
> +/* Interface implemented by devices that can be plugged on legacy PCI buses */
> +#define INTERFACE_LEGACY_PCI_DEVICE "legacy-pci-device"
> +
>  typedef struct PCIINTxRoute {
>      enum {
>          PCI_INTX_ENABLED,
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 258fbe5..baa3429 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -168,6 +168,16 @@ static const TypeInfo pci_bus_info = {
>      .class_init = pci_bus_class_init,
>  };
>
> +static const TypeInfo pcie_interface_info = {
> +    .name          = INTERFACE_PCIE_DEVICE,
> +    .parent        = TYPE_INTERFACE,
> +};
> +
> +static const TypeInfo legacy_pci_interface_info = {
> +    .name          = INTERFACE_LEGACY_PCI_DEVICE,
> +    .parent        = TYPE_INTERFACE,
> +};
> +
>  static const TypeInfo pcie_bus_info = {
>      .name = TYPE_PCIE_BUS,
>      .parent = TYPE_PCI_BUS,
> @@ -2645,6 +2655,8 @@ static void pci_register_types(void)
>  {
>      type_register_static(&pci_bus_info);
>      type_register_static(&pcie_bus_info);
> +    type_register_static(&legacy_pci_interface_info);
> +    type_register_static(&pcie_interface_info);
>      type_register_static(&pci_device_type_info);
>  }
>
> --
> 2.9.4
>
>
