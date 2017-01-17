Received: from eggs.gnu.org ([2001:4830:134:3::10]:48718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTUzp-00034z-7k
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTUzk-0002T4-C1
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:44:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cTUzk-0002Sr-5U
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:44:20 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 015AA21733
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 14:44:20 +0000 (UTC)
Date: Tue, 17 Jan 2017 16:44:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170117164326-mutt-send-email-mst@kernel.org>
References: <1484625660-3312-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484625660-3312-1-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: force VIRTIO_F_IOMMU_PLATFORM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Jan 17, 2017 at 12:01:00PM +0800, Jason Wang wrote:
> We allow vhost to clear VIRITO_F_IOMMU_PLATFORM which is wrong since
> VIRTIO_F_IOMMU_PLATFORM is mandatory for security. Fixing this by
> enforce it after vdc->get_features().
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/virtio/virtio-bus.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index d31cc00..a886011 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -47,6 +47,7 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>      VirtioBusState *bus = VIRTIO_BUS(qbus);
>      VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
>      VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
> +    bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
>  
>      DPRINTF("%s: plug device.\n", qbus->name);
>  
> @@ -63,8 +64,8 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>          klass->device_plugged(qbus->parent, errp);
>      }
>  
> -    if (klass->get_dma_as != NULL &&
> -        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
> +    if (klass->get_dma_as != NULL && has_iommu) {
> +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
>          vdev->dma_as = klass->get_dma_as(qbus->parent);
>      } else {
>          vdev->dma_as = &address_space_memory;

I suspect that's not enough, we must also fail or disable vhost
(depending on the options), otherwise things won't work.

> -- 
> 2.7.4
