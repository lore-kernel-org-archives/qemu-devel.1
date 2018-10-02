Received: from eggs.gnu.org ([2001:4830:134:3::10]:50669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g7N9I-0000Zp-Bl
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g7N9F-00056q-4A
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:03:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1g7N9E-00056W-SM
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:03:45 -0400
Date: Tue, 2 Oct 2018 17:03:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181002160337.GA2389@work-vm>
References: <20181002135538.12113-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002135538.12113-1-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/1] qmp,
 hmp: make subsystem/system-vendor identities optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Denis V. Lunev (den@openvz.org) wrote:
> According to PCI specification subsystem id and subsystem vendor id are
> optinal and could be abscent in Type1 header and can be found on
> different offsets within Type0 and Type2 headers.
> 
> Thus we should make this data optional in struct PciDeviceId and skip
> reporting them via HMP if the information is not available.
> 
> Additional (wrong information) about PCI bridges (Type1 devices) has been
> added in 5383a705 and fortunately not released. This patch fixes that
> problem. The problem was spotted by Markus.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>

Looks good to me, thanks

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp.c          |  6 ++++--
>  hw/pci/pci.c   | 13 ++++++++++---
>  qapi/misc.json |  4 ++--
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 3a9f797677..55633d29a3 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -824,8 +824,10 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
>  
>      monitor_printf(mon, ": PCI device %04" PRIx64 ":%04" PRIx64 "\n",
>                     dev->id->vendor, dev->id->device);
> -    monitor_printf(mon, "      PCI subsystem %04" PRIx64 ":%04" PRIx64 "\n",
> -                   dev->id->subsystem_vendor, dev->id->subsystem);
> +    if (dev->id->has_subsystem_vendor && dev->id->has_subsystem) {
> +        monitor_printf(mon, "      PCI subsystem %04" PRIx64 ":%04" PRIx64 "\n",
> +                       dev->id->subsystem_vendor, dev->id->subsystem);
> +    }
>  
>      if (dev->has_irq) {
>          monitor_printf(mon, "      IRQ %" PRId64 ".\n", dev->irq);
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 51d0dec466..b937f0dc0a 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1737,9 +1737,6 @@ static PciDeviceInfo *qmp_query_pci_device(PCIDevice *dev, PCIBus *bus,
>      info->id = g_new0(PciDeviceId, 1);
>      info->id->vendor = pci_get_word(dev->config + PCI_VENDOR_ID);
>      info->id->device = pci_get_word(dev->config + PCI_DEVICE_ID);
> -    info->id->subsystem = pci_get_word(dev->config + PCI_SUBSYSTEM_ID);
> -    info->id->subsystem_vendor =
> -        pci_get_word(dev->config + PCI_SUBSYSTEM_VENDOR_ID);
>      info->regions = qmp_query_pci_regions(dev);
>      info->qdev_id = g_strdup(dev->qdev.id ? dev->qdev.id : "");
>  
> @@ -1752,6 +1749,16 @@ static PciDeviceInfo *qmp_query_pci_device(PCIDevice *dev, PCIBus *bus,
>      if (type == PCI_HEADER_TYPE_BRIDGE) {
>          info->has_pci_bridge = true;
>          info->pci_bridge = qmp_query_pci_bridge(dev, bus, bus_num);
> +    } else if (type == PCI_HEADER_TYPE_NORMAL) {
> +        info->id->has_subsystem = info->id->has_subsystem_vendor = true;
> +        info->id->subsystem = pci_get_word(dev->config + PCI_SUBSYSTEM_ID);
> +        info->id->subsystem_vendor =
> +            pci_get_word(dev->config + PCI_SUBSYSTEM_VENDOR_ID);
> +    } else if (type == PCI_HEADER_TYPE_CARDBUS) {
> +        info->id->has_subsystem = info->id->has_subsystem_vendor = true;
> +        info->id->subsystem = pci_get_word(dev->config + PCI_CB_SUBSYSTEM_ID);
> +        info->id->subsystem_vendor =
> +            pci_get_word(dev->config + PCI_CB_SUBSYSTEM_VENDOR_ID);
>      }
>  
>      return info;
> diff --git a/qapi/misc.json b/qapi/misc.json
> index ada9af5add..95a6ed022d 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -839,8 +839,8 @@
>  # Since: 2.4
>  ##
>  { 'struct': 'PciDeviceId',
> -  'data': {'device': 'int', 'vendor': 'int', 'subsystem': 'int',
> -            'subsystem-vendor': 'int'} }
> +  'data': {'device': 'int', 'vendor': 'int', '*subsystem': 'int',
> +            '*subsystem-vendor': 'int'} }
>  
>  ##
>  # @PciDeviceInfo:
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
