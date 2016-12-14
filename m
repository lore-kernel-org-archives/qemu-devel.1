Received: from eggs.gnu.org ([2001:4830:134:3::10]:37596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHDDT-0004Mf-Ti
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHDDP-00044j-Re
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:19:43 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHDDP-00044a-Mk
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:19:39 -0500
Received: by mail-io0-f195.google.com with SMTP id y124so5625050iof.1
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 09:19:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161214163035.3297-1-maxime.coquelin@redhat.com>
References: <20161214163035.3297-1-maxime.coquelin@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 14 Dec 2016 17:18:38 +0000
Message-ID: <CAJSP0QWNePPAYHscFAPULpuNw0UkSLtp9A2P96u5GZbh2Naqvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3] virtio-pci: Fix cross-version migration
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Dec 14, 2016 at 4:30 PM, Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
> This patch fixes a cross-version migration regression introduced
> by commit d1b4259f ("virtio-bus: Plug devices after features are
> negotiated").
>
> The problem is encountered when host's vhost backend does not support
> VIRTIO_F_VERSION_1, and migration is initiated from a v2.7 or prior
> machine with virtio-pci modern capabilities enabled to a v2.8 machine.
>
> In this case, modern capabilities get exposed to the guest by the source,
> whereas the target will detect version 1 is not supported so will only
> expose legacy capabilities.
>
> The problem is fixed by introducing a new "x-ignore-backend-features"
> property, which is set in v2.7 and prior compatibility modes. Doing this,
> v2.7 machine keeps its broken behaviour (enabling modern while version
> is not supported), and newer machines will behave correctly.
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
> V3 fixes commit message with the new property name.
> V2 changes the naming as proposed by Michael T.and Cornelia, and
> fixes commit message.
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

Waiting for Michael Tsirkin's R-b before applying.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
