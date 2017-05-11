Received: from eggs.gnu.org ([2001:4830:134:3::10]:49667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8lKi-0004qv-Kh
	for qemu-devel@nongnu.org; Thu, 11 May 2017 06:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8lKf-00071s-HI
	for qemu-devel@nongnu.org; Thu, 11 May 2017 06:28:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d8lKf-000701-Bd
	for qemu-devel@nongnu.org; Thu, 11 May 2017 06:28:29 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55EAC624DC
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 10:28:28 +0000 (UTC)
References: <20170511102529.21618-1-marcel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb115468-bf9d-30d7-ee1b-fefc107c55a9@redhat.com>
Date: Thu, 11 May 2017 12:28:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170511102529.21618-1-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, lersek@redhat.com, dgilbert@redhat.com



On 11/05/2017 12:25, Marcel Apfelbaum wrote:
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
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
