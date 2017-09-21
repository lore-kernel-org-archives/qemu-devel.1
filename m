Received: from eggs.gnu.org ([2001:4830:134:3::10]:41826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1duyXG-0005tk-HK
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1duyXB-000063-Fy
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:16:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1duyXB-0008WU-7j
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:16:41 -0400
References: <1505942471-11260-1-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <f5dbe1a3-bb18-28ff-515b-e8a9ef924835@redhat.com>
Date: Thu, 21 Sep 2017 13:16:39 +0300
MIME-Version: 1.0
In-Reply-To: <1505942471-11260-1-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/pci-bridge/pcie_pci_bridge: properly
 handle MSI unavailability case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com

Hi Aleksandr,

On 21/09/2017 0:21, Aleksandr Bezzubikov wrote:
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>   hw/pci-bridge/pcie_pci_bridge.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> 

Please add Eduardo's Reported-by tag and the
actual failure in the commit message.
You might even explain in the commit message that you
moved msi prop to ON_OFF_AUTO_AUTO.


> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
> index 9aa5cc3..da562fe 100644
> --- a/hw/pci-bridge/pcie_pci_bridge.c
> +++ b/hw/pci-bridge/pcie_pci_bridge.c
> @@ -65,10 +65,18 @@ static void pcie_pci_bridge_realize(PCIDevice *d, Error **errp)
>           goto aer_error;
>       }
>   
> +    Error *local_err = NULL;
>       if (pcie_br->msi != ON_OFF_AUTO_OFF) {
> -        rc = msi_init(d, 0, 1, true, true, errp);
> +        rc = msi_init(d, 0, 1, true, true, &local_err);
>           if (rc < 0) {
> -            goto msi_error;
> +            assert(rc == -ENOTSUP);
> +            if (pcie_br->msi != ON_OFF_AUTO_ON) {
> +                error_free(local_err);

In that case it will fallback to legacy INTx, right?

Thanks,
Marcel

> +            } else {
> +                /* failed to satisfy user's explicit request for MSI */
> +                error_propagate(errp, local_err);
> +                goto msi_error;
> +            }
>           }
>       }
>       pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
> @@ -81,7 +89,7 @@ aer_error:
>   pm_error:
>       pcie_cap_exit(d);
>   cap_error:
> -    shpc_free(d);
> +    shpc_cleanup(d, &pcie_br->shpc_bar);
>   error:
>       pci_bridge_exitfn(d);
>   }
> @@ -98,7 +106,9 @@ static void pcie_pci_bridge_reset(DeviceState *qdev)
>   {
>       PCIDevice *d = PCI_DEVICE(qdev);
>       pci_bridge_reset(qdev);
> -    msi_reset(d);
> +    if (msi_present(d)) {
> +        msi_reset(d);
> +    }
>       shpc_reset(d);
>   }
>   
> @@ -106,12 +116,14 @@ static void pcie_pci_bridge_write_config(PCIDevice *d,
>           uint32_t address, uint32_t val, int len)
>   {
>       pci_bridge_write_config(d, address, val, len);
> -    msi_write_config(d, address, val, len);
> +    if (msi_present(d)) {
> +        msi_write_config(d, address, val, len);
> +    }
>       shpc_cap_write_config(d, address, val, len);
>   }
>   
>   static Property pcie_pci_bridge_dev_properties[] = {
> -        DEFINE_PROP_ON_OFF_AUTO("msi", PCIEPCIBridge, msi, ON_OFF_AUTO_ON),
> +        DEFINE_PROP_ON_OFF_AUTO("msi", PCIEPCIBridge, msi, ON_OFF_AUTO_AUTO),
>           DEFINE_PROP_END_OF_LIST(),
>   };
>   
> 
