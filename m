Received: from eggs.gnu.org ([209.51.188.92]:42138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmJZn-0005QB-UJ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:32:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmJRG-0004tV-PM
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:23:36 -0500
References: <20190123082425.10643-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d799bc1c-3d68-ae51-e43c-8ef4ea2b02cc@redhat.com>
Date: Wed, 23 Jan 2019 15:23:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190123082425.10643-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] spapr/pci: Fix primary bus number for
 PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org

On 23.01.19 09:24, David Hildenbrand wrote:
> While looking at the s390x implementation, looks like spapr has a
> similar BUG when building the topology.
> 
> The primary bus number corresponds always to the bus number of the
> bus the bridge is attached to.
> 
> Right now, if we have two bridges attached to the same bus (e.g. root
> bus) this is however not the case. The first bridge will have primary
> bus 0, the second bridge primary bus 1, which is wrong. Fix the assignment.
> 
> While at it, drop setting the PCI_SUBORDINATE_BUS temporarily to 0xff.
> Setting it temporarily to that value (as discussed e.g. in [1]), is
> only relevant for a running system that probes the buses. The value is
> effectively unused for us just doing a DFS.
> 
> [1] http://www.science.unitn.it/~fiorella/guidelinux/tlk/node76.html
> 
> Note: Is hotplug of bridges supported? I can't find where the topology
> is fixed up when hotplugging a PCI bridge. (e.g. bus numbers assigned
> and PCI_SUBORDINATE_BUS of path to the root updated). But maybe we are
> excluding bridges or this is not necessary for some reason.

This note can be dropped. I learned that this is under guest control.
(which has to reserve bus numbers and rebuild the topology)

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/ppc/spapr_pci.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index b74f2632ec..5cdc98513d 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2030,8 +2030,6 @@ static void spapr_phb_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
>                                             void *opaque)
>  {
>      unsigned int *bus_no = opaque;
> -    unsigned int primary = *bus_no;
> -    unsigned int subordinate = 0xff;
>      PCIBus *sec_bus = NULL;
>  
>      if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=
> @@ -2040,7 +2038,7 @@ static void spapr_phb_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
>      }
>  
>      (*bus_no)++;
> -    pci_default_write_config(pdev, PCI_PRIMARY_BUS, primary, 1);
> +    pci_default_write_config(pdev, PCI_PRIMARY_BUS, pci_dev_bus_num(pdev), 1);
>      pci_default_write_config(pdev, PCI_SECONDARY_BUS, *bus_no, 1);
>      pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, *bus_no, 1);
>  
> @@ -2049,7 +2047,6 @@ static void spapr_phb_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
>          return;
>      }
>  
> -    pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, subordinate, 1);
>      pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
>                          spapr_phb_pci_enumerate_bridge, bus_no);
>      pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, *bus_no, 1);
> 


-- 

Thanks,

David / dhildenb
