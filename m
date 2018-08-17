Received: from eggs.gnu.org ([2001:4830:134:3::10]:42380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqhQV-0003gB-RM
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqhQH-0008SL-7q
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:16:33 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fqhQD-0008PN-B5
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:16:21 -0400
Received: by mail-wm0-x243.google.com with SMTP id y2-v6so8096231wma.1
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 09:16:20 -0700 (PDT)
References: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
	<1534411696-6454-4-git-send-email-jing2.liu@linux.intel.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <a70db4b4-0c30-4a0c-4ef8-98d87b5cc80a@gmail.com>
Date: Fri, 17 Aug 2018 19:16:17 +0300
MIME-Version: 1.0
In-Reply-To: <1534411696-6454-4-git-send-email-jing2.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 3/3] hw/pci: add PCI resource reserve
 capability to legacy PCI bridge
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
> Add hint to firmware (e.g. SeaBIOS) to reserve addtional
> BUS/IO/MEM/PREF resource for legacy pci-pci bridge.
>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> ---
>   hw/pci-bridge/pci_bridge_dev.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
> index b2d861d..874e618 100644Hi
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -46,6 +46,8 @@ struct PCIBridgeDev {
>       uint32_t flags;
>   
>       OnOffAuto msi;
> +
> +    PCIResReserve res_reserve;
>   };
>   typedef struct PCIBridgeDev PCIBridgeDev;
>   
> @@ -95,6 +97,12 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
>           error_free(local_err);
>       }
>   
> +    err = pci_bridge_qemu_reserve_cap_init(dev, 0,
> +                                         bridge_dev->res_reserve, errp);
> +    if (err) {
> +        goto cap_error;
> +    }
> +
>       if (shpc_present(dev)) {
>           /* TODO: spec recommends using 64 bit prefetcheable BAR.
>            * Check whether that works well. */
> @@ -103,6 +111,10 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
>       }
>       return;
>   
> +cap_error:
> +    if (msi_present(dev)) {
> +        msi_uninit(dev);

You were right. Since msi_uninit checks msi_present
inside, you don;t need this check, sorry for misleading you.

> +    }
>   msi_error:
>       slotid_cap_cleanup(dev);
>   slotid_error:
> @@ -116,6 +128,8 @@ shpc_error:
>   static void pci_bridge_dev_exitfn(PCIDevice *dev)
>   {
>       PCIBridgeDev *bridge_dev = PCI_BRIDGE_DEV(dev);
> +
> +    pci_bridge_qemu_reserve_cap_uninit(dev);

Here you should have  only the "delete_cap" function.

>       if (msi_present(dev)) {
>           msi_uninit(dev);
>       }
> @@ -162,6 +176,17 @@ static Property pci_bridge_dev_properties[] = {
>                               ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
>                       PCI_BRIDGE_DEV_F_SHPC_REQ, true),
> +    DEFINE_PROP_UINT32("bus-reserve", PCIBridgeDev,
> +                       res_reserve.bus_reserve, -1),
> +    DEFINE_PROP_SIZE("io-reserve", PCIBridgeDev,
> +                     res_reserve.io_reserve, -1),
> +    DEFINE_PROP_SIZE("mem-reserve", PCIBridgeDev,
> +                     res_reserve.mem_reserve, -1),
> +    DEFINE_PROP_SIZE("pref32-reserve", PCIBridgeDev,
> +                     res_reserve.pref32_reserve, -1),
> +    DEFINE_PROP_SIZE("pref64-reserve", PCIBridgeDev,
> +                     res_reserve.pref64_reserve, -1),
> +
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   

Thanks,
Marcel
