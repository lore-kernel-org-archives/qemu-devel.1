Received: from eggs.gnu.org ([2001:4830:134:3::10]:43592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dlL4Y-0003ya-03
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 16:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dlL4U-0006M8-0t
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 16:19:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dlL4T-0006KB-Nz
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 16:19:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CF697EA9D
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 20:19:11 +0000 (UTC)
Date: Fri, 25 Aug 2017 14:19:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170825141900.08e2a089@w520.home>
In-Reply-To: <20170823221445.15243-2-ehabkost@redhat.com>
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 23 Aug 2017 19:14:41 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Those two interfaces will be used to indicate which device types
> support legacy PCI or PCI-express buses.  Management software
> will be able to use the qom-list-types QMP command to query that
> information.

Nit, while "legacy PCI" and "conventional PCI" have about the same
number of google hits, I believe the latter is the more correct term.
The quality of hits is certainly a lot better with "conventional".
Calling something "legacy" also spurs an immediate negative reaction
for some folks, "conventional" is more neutral.  Thanks,

Alex

> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
