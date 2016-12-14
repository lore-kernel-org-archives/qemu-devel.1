Received: from eggs.gnu.org ([2001:4830:134:3::10]:48120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cHCMh-0002YG-OQ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cHCMc-0000My-QA
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:25:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cHCMc-0000MC-HO
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:25:06 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBEGOkKl109559
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 11:25:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27b8rc3jb4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 11:25:04 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 14 Dec 2016 16:25:02 -0000
Date: Wed, 14 Dec 2016 17:24:48 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20161214161958.2958-1-maxime.coquelin@redhat.com>
References: <20161214161958.2958-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161214172448.7619816e.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] virtio-pci: Fix cross-version migration
 with older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mdroth@linux.vnet.ibm.com, stefanha@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, marcel@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, 14 Dec 2016 17:19:58 +0100
Maxime Coquelin <maxime.coquelin@redhat.com> wrote:

> This patch fixes a cross-version migration regression introduced
> by commit d1b4259f ("virtio-bus: Plug devices after features are
> negotiated").
> 
> The problem is encountered when host's vhost backend does not support
> VIRTIO_F_VERSION_1, and migration is initiated from a v2.7 or prior
> QEMU version with virtio-pci modern capabilities enabled to a v2.8
> QEMU version.
> 
> In this case, modern capabilities get exposed to the guest by the source,
> whereas the target will detect version 1 is not supported so will only
> expose legacy capabilities.
> 
> The problem is fixed by introducing a new "x-modern-broken" property,

wrong property name...

> which is set in v2.7 and prior compatibility modes. Doing this, v2.7
> machine keeps its broken behaviour (enabling modern while version is
> not supported), and newer machines will behave correctly.
> 
> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
> 
> Thanks for the reviews and tests.
> This version changes the naming as proposed by Michael T.
> and Cornelia, and fixies commit message.
> 
>  hw/virtio/virtio-pci.c | 5 ++++-
>  hw/virtio/virtio-pci.h | 1 +
>  include/hw/compat.h    | 4 ++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 521ba0b..21c2b9d 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1580,7 +1580,8 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
>       * Virtio capabilities present without
>       * VIRTIO_F_VERSION_1 confuses guests
>       */
> -    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
> +    if (!proxy->ignore_backend_features &&
> +            !virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
>          virtio_pci_disable_modern(proxy);
> 
>          if (!legacy) {
> @@ -1852,6 +1853,8 @@ static Property virtio_pci_properties[] = {
>                      VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT, false),
>      DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
> +    DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
> +                     ignore_backend_features, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> 
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index b2a996f..5e07886 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -153,6 +153,7 @@ struct VirtIOPCIProxy {
>      int config_cap;
>      uint32_t flags;
>      bool disable_modern;
> +    bool ignore_backend_features;
>      OnOffAuto disable_legacy;
>      uint32_t class_code;
>      uint32_t nvectors;
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 0f06e11..8dfc7a3 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -18,6 +18,10 @@
>          .driver   = "intel-iommu",\
>          .property = "x-buggy-eim",\
>          .value    = "true",\
> +    },{\
> +        .driver   = "virtio-pci",\
> +        .property = "x-ignore-backend-features",\
> +        .value    = "on",\
>      },
> 
>  #define HW_COMPAT_2_6 \

Not 100% sure that this was the property name we agreed on, but it's
fine with me.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
