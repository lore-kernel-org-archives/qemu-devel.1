Received: from eggs.gnu.org ([2001:4830:134:3::10]:57259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dxUoI-0005fp-F0
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dxUoF-0003cC-7A
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:08:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dxUoE-0003bo-UV
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:08:43 -0400
References: <20170927195635.16014-1-ehabkost@redhat.com>
	<20170927195635.16014-2-ehabkost@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <89188579-ecb9-341a-2084-f4e27fa21774@redhat.com>
Date: Thu, 28 Sep 2017 12:08:28 +0300
MIME-Version: 1.0
In-Reply-To: <20170927195635.16014-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] pci: conventional-pci-device and
 pci-express-device interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>, Alistair Francis <alistair23@gmail.com>, Laine Stump <laine@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 27/09/2017 22:56, Eduardo Habkost wrote:
> Those two interfaces will be used to indicate which device types
> support Conventional PCI or PCI Express buses.  Management
> software will be able to use the qom-list-types QMP command to
> query that information.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * s/legacy/conventional/
>    * Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>   include/hw/pci/pci.h |  6 ++++++
>   hw/pci/pci.c         | 12 ++++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index aa7ef9cf69..8d02a0a383 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -198,6 +198,12 @@ enum {
>   #define PCI_DEVICE_GET_CLASS(obj) \
>        OBJECT_GET_CLASS(PCIDeviceClass, (obj), TYPE_PCI_DEVICE)
>   
> +/* Implemented by devices that can be plugged on PCI Express buses */
> +#define INTERFACE_PCIE_DEVICE "pci-express-device"
> +
> +/* Implemented by devices that can be plugged on Conventional PCI buses */
> +#define INTERFACE_CONVENTIONAL_PCI_DEVICE "conventional-pci-device"
> +
>   typedef struct PCIINTxRoute {
>       enum {
>           PCI_INTX_ENABLED,
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1e6fb88eba..1b08e18205 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -170,6 +170,16 @@ static const TypeInfo pci_bus_info = {
>       .class_init = pci_bus_class_init,
>   };
>   
> +static const TypeInfo pcie_interface_info = {
> +    .name          = INTERFACE_PCIE_DEVICE,
> +    .parent        = TYPE_INTERFACE,
> +};
> +
> +static const TypeInfo conventional_pci_interface_info = {
> +    .name          = INTERFACE_CONVENTIONAL_PCI_DEVICE,
> +    .parent        = TYPE_INTERFACE,
> +};
> +
>   static const TypeInfo pcie_bus_info = {
>       .name = TYPE_PCIE_BUS,
>       .parent = TYPE_PCI_BUS,
> @@ -2667,6 +2677,8 @@ static void pci_register_types(void)
>   {
>       type_register_static(&pci_bus_info);
>       type_register_static(&pcie_bus_info);
> +    type_register_static(&conventional_pci_interface_info);
> +    type_register_static(&pcie_interface_info);
>       type_register_static(&pci_device_type_info);
>   }
>   
> 


Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
