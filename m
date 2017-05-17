Received: from eggs.gnu.org ([2001:4830:134:3::10]:46158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=2oIJ=4X=redhat.com=mst@kernel.org>)
	id 1dB6cJ-0006PY-2H
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=2oIJ=4X=redhat.com=mst@kernel.org>)
	id 1dB6cE-0002gG-5S
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=2oIJ=4X=redhat.com=mst@kernel.org>)
	id 1dB6cD-0002fq-Vp
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:36:18 -0400
Date: Thu, 18 May 2017 00:36:12 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170518003605-mutt-send-email-mst@kernel.org>
References: <20170511102529.21618-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511102529.21618-1-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2] Revert "hw/pci: disable pci-bridge's
 shpc by default"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, lersek@redhat.com, dgilbert@redhat.com

On Thu, May 11, 2017 at 01:25:29PM +0300, Marcel Apfelbaum wrote:
> This reverts commit dc0ae767700c156894e36fab89a745a2dc4173de.
> 
> Disabling the shpc controller has an undesired side effect.
> The PCI bridge remains with no attached devices at boot time,
> and the guest operating systems do not allocate any resources
> for it, leaving the bridge unusable. Note that the behaviour
> is dictated by the pci bridge specification.
> 
> Revert the commit and leave the shpc controller even if is not
> actually used by any architecture. Slot 0 remains unusable at boot time.
> 
> Keep shpc off for QEMU 2.9 machines.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>

Applied, thanks!

> ---
> 
> V1 -> V2:
>  - Keep shpc off for QEMU 2.9 machines
>  - Rebased on Michael's tree to get QEMU 2.10 machine types
> 
> Thanks,
> Marcel
> 
>  hw/pci-bridge/pci_bridge_dev.c | 2 +-
>  include/hw/compat.h            | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
> index 647ad80..5dbd933 100644
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -163,7 +163,7 @@ static Property pci_bridge_dev_properties[] = {
>      DEFINE_PROP_ON_OFF_AUTO(PCI_BRIDGE_DEV_PROP_MSI, PCIBridgeDev, msi,
>                              ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
> -                    PCI_BRIDGE_DEV_F_SHPC_REQ, false),
> +                    PCI_BRIDGE_DEV_F_SHPC_REQ, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 846b90e..55b1765 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -2,7 +2,11 @@
>  #define HW_COMPAT_H
>  
>  #define HW_COMPAT_2_9 \
> -    /* empty */
> +    {\
> +        .driver   = "pci-bridge",\
> +        .property = "shpc",\
> +        .value    = "off",\
> +    },
>  
>  #define HW_COMPAT_2_8 \
>      {\
> -- 
> 2.9.3
