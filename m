Received: from eggs.gnu.org ([2001:4830:134:3::10]:45809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQnQR-00080f-GT
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQnQO-0006JW-D1
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:48:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQnQO-0006JJ-6z
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:48:40 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B44CC04B30F
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:48:39 +0000 (UTC)
Date: Tue, 10 Jan 2017 05:48:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110054818-mutt-send-email-mst@kernel.org>
References: <1478099802-14188-1-git-send-email-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478099802-14188-1-git-send-email-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/pci: disable pci-bridge's shpc by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, laine@redhat.com

On Wed, Nov 02, 2016 at 05:16:42PM +0200, Marcel Apfelbaum wrote:
> The shpc component is optional while  ACPI hotplug is used
> for hot-plugging PCI devices into a PCI-PCI bridge.
> Disabling the shpc by default will make slot 0 usable at boot time
> and not only for hot-plug, without loosing any functionality.
> Older machines will have shpc enabled for compatibility reasons.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>

Can you pls post a rebase since compat changed?

> ---
>  hw/pci-bridge/pci_bridge_dev.c | 2 +-
>  include/hw/compat.h            | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
> index 5dbd933..647ad80 100644
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -163,7 +163,7 @@ static Property pci_bridge_dev_properties[] = {
>      DEFINE_PROP_ON_OFF_AUTO(PCI_BRIDGE_DEV_PROP_MSI, PCIBridgeDev, msi,
>                              ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
> -                    PCI_BRIDGE_DEV_F_SHPC_REQ, true),
> +                    PCI_BRIDGE_DEV_F_SHPC_REQ, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 0f06e11..388b7ec 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -18,6 +18,10 @@
>          .driver   = "intel-iommu",\
>          .property = "x-buggy-eim",\
>          .value    = "true",\
> +    },{\
> +        .driver   = "pci-bridge",\
> +        .property = "shpc",\
> +        .value    = "on",\
>      },
>  
>  #define HW_COMPAT_2_6 \
> -- 
> 2.5.5
