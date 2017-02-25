Received: from eggs.gnu.org ([2001:4830:134:3::10]:35050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1chYpA-0002GN-QR
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 04:39:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1chYp6-0002YG-G8
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 04:39:32 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1chYp6-0002WY-7C
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 04:39:28 -0500
Received: by mail-pf0-x243.google.com with SMTP id p185so1929478pfb.0
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 01:39:25 -0800 (PST)
References: <148776029578.5865.5785337570950575739.stgit@bahia>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <99a3a245-d508-01b8-6b10-0bb32ea54209@ozlabs.ru>
Date: Sat, 25 Feb 2017 20:39:18 +1100
MIME-Version: 1.0
In-Reply-To: <148776029578.5865.5785337570950575739.stgit@bahia>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr/pci: populate PCI DT in reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 22/02/17 21:56, Greg Kurz wrote:
> From: Greg Kurz <gkurz@linux.vnet.ibm.com>
> 
> Since commit 1d2d974244c6 "spapr_pci: enumerate and add PCI device tree", QEMU
> populates the PCI device tree in the opposite order compared to SLOF.
> 
> Before 1d2d974244c6:
> 
> Populating /pci@800000020000000
>                      00 0000 (D) : 1af4 1000    virtio [ net ]
>                      00 0800 (D) : 1af4 1001    virtio [ block ]
>                      00 1000 (D) : 1af4 1009    virtio [ network ]
> Populating /pci@800000020000000/unknown-legacy-device@2
> 
> 7e5294b8 :  /pci@800000020000000
> 7e52b998 :  |-- ethernet@0
> 7e52c0c8 :  |-- scsi@1
> 7e52c7e8 :  +-- unknown-legacy-device@2 ok
> 
> Since 1d2d974244c6:
> 
> Populating /pci@800000020000000
>                      00 1000 (D) : 1af4 1009    virtio [ network ]
> Populating /pci@800000020000000/unknown-legacy-device@2
>                      00 0800 (D) : 1af4 1001    virtio [ block ]
>                      00 0000 (D) : 1af4 1000    virtio [ net ]
> 
> 7e5e8118 :  /pci@800000020000000
> 7e5ea6a0 :  |-- unknown-legacy-device@2
> 7e5eadb8 :  |-- scsi@1
> 7e5eb4d8 :  +-- ethernet@0 ok
> 
> This behaviour change is not actually a bug since no assumptions should be
> made on DT ordering. But it has no real justification either, other than
> being the consequence of the way fdt_add_subnode() inserts new elements
> to the front of the FDT rather than adding them to the tail.
> 
> This patch reverts to the historical SLOF ordering by walking PCI devices
> in reverse order. This reconciles pseries with x86 machine types behavior.
> It is expected to make things easier when porting existing applications to
> power.
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> (slight update to the changelog)
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/pci/pci.c         |   28 ++++++++++++++++++++++++++++
>  hw/ppc/spapr_pci.c   |   12 ++++++------
>  include/hw/pci/pci.h |    4 ++++
>  3 files changed, 38 insertions(+), 6 deletions(-)
> 
> David,
> 
> This patch was posted and already discussed during 2.5 development:
> 
> http://patchwork.ozlabs.org/patch/549925/
> 
> The "consensus" at the time was that guests should not rely on device
> ordering (i.e. use persistent naming instead).
> 
> I got recently contacted by OpenStack people who had several complaints
> about the reverse ordering of PCI devices in pseries: different behavior
> between ppc64 and x86, lots of time spent in debugging when porting
> applications from x86 to ppc64 before realizing that it is caused by the
> reverse ordering, necessity to carry hacky workarounds...


x86 does not have a device tree, and PCI id (bus:slot:fn) is the same
regardless the scanning order, i.e. "lspci" will show the same picture with
either order.

How could OpenStack tell the difference and require workaround for what
precisely?

I am definitely missing the point here...


> 
> One strong argument against handling this properly with persistent naming
> is that it requires systemd/udev. This option is considered as painful
> with CirrOS, which aims at remaining as minimal as possible and is widely
> used in the OpenStack ecosystem.
> 
> Would you re-consider your position and apply this patch ?
> 
> Cheers.
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index a563555e7da7..273f1e46025a 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1530,6 +1530,34 @@ static const pci_class_desc pci_class_descriptions[] =
>      { 0, NULL}
>  };
>  
> +static void pci_for_each_device_under_bus_reverse(PCIBus *bus,
> +                                                  void (*fn)(PCIBus *b,
> +                                                             PCIDevice *d,
> +                                                             void *opaque),
> +                                                  void *opaque)
> +{
> +    PCIDevice *d;
> +    int devfn;
> +
> +    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
> +        d = bus->devices[ARRAY_SIZE(bus->devices) - 1 - devfn];
> +        if (d) {
> +            fn(bus, d, opaque);
> +        }
> +    }
> +}
> +
> +void pci_for_each_device_reverse(PCIBus *bus, int bus_num,
> +                         void (*fn)(PCIBus *b, PCIDevice *d, void *opaque),
> +                         void *opaque)
> +{
> +    bus = pci_find_bus_nr(bus, bus_num);
> +
> +    if (bus) {
> +        pci_for_each_device_under_bus_reverse(bus, fn, opaque);
> +    }
> +}
> +
>  static void pci_for_each_device_under_bus(PCIBus *bus,
>                                            void (*fn)(PCIBus *b, PCIDevice *d,
>                                                       void *opaque),
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index fd6fc1d95344..2a20c2a140fc 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1782,9 +1782,9 @@ static void spapr_populate_pci_devices_dt(PCIBus *bus, PCIDevice *pdev,
>      s_fdt.fdt = p->fdt;
>      s_fdt.node_off = offset;
>      s_fdt.sphb = p->sphb;
> -    pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
> -                        spapr_populate_pci_devices_dt,
> -                        &s_fdt);
> +    pci_for_each_device_reverse(sec_bus, pci_bus_num(sec_bus),
> +                                spapr_populate_pci_devices_dt,
> +                                &s_fdt);
>  }
>  
>  static void spapr_phb_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
> @@ -1953,9 +1953,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>      s_fdt.fdt = fdt;
>      s_fdt.node_off = bus_off;
>      s_fdt.sphb = phb;
> -    pci_for_each_device(bus, pci_bus_num(bus),
> -                        spapr_populate_pci_devices_dt,
> -                        &s_fdt);
> +    pci_for_each_device_reverse(bus, pci_bus_num(bus),
> +                                spapr_populate_pci_devices_dt,
> +                                &s_fdt);
>  
>      ret = spapr_drc_populate_dt(fdt, bus_off, OBJECT(phb),
>                                  SPAPR_DR_CONNECTOR_TYPE_PCI);
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 6983f13745a5..9349acbfb278 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -429,6 +429,10 @@ int pci_bus_numa_node(PCIBus *bus);
>  void pci_for_each_device(PCIBus *bus, int bus_num,
>                           void (*fn)(PCIBus *bus, PCIDevice *d, void *opaque),
>                           void *opaque);
> +void pci_for_each_device_reverse(PCIBus *bus, int bus_num,
> +                                 void (*fn)(PCIBus *bus, PCIDevice *d,
> +                                            void *opaque),
> +                                 void *opaque);
>  void pci_for_each_bus_depth_first(PCIBus *bus,
>                                    void *(*begin)(PCIBus *bus, void *parent_state),
>                                    void (*end)(PCIBus *bus, void *state),
> 
> 


-- 
Alexey
