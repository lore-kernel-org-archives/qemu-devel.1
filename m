Received: from eggs.gnu.org ([2001:4830:134:3::10]:38543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfuuV-00063a-2m
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 17:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfuuQ-000660-H0
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 17:22:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dfuuQ-00065C-7c
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 17:22:26 -0400
Date: Fri, 11 Aug 2017 00:22:20 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170811002203-mutt-send-email-mst@kernel.org>
References: <20170810165255.20865-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170810165255.20865-1-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: Add virtqueue_size parameter
 allowing virtqueue size to be set.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, hch@lst.de, martin.petersen@oracle.com

On Thu, Aug 10, 2017 at 05:52:55PM +0100, Richard W.M. Jones wrote:
> Since Linux switched to blk-mq as the default in Linux commit
> 5c279bd9e406 ("scsi: default to scsi-mq"), virtio-scsi LUNs consume
> about 10x as much guest kernel memory.
> 
> This commit allows you to choose the virtqueue size for each
> virtio-scsi-pci controller like this:
> 
>   -device virtio-scsi-pci,id=scsi,virtqueue_size=16
> 
> The default is still 128 as before.  Using smaller virtqueue_size
> allows many more disks to be added to small memory virtual machines.
> For a 1 vCPU, 500 MB, no swap VM I observed:
> 
>   With scsi-mq enabled (upstream kernel):              175 disks
>     -"- ditto -"-   virtqueue_size=64:                 318 disks
>     -"- ditto -"-   virtqueue_size=16:                 775 disks
>   With scsi-mq disabled (kernel before 5c279bd9e406): 1755 disks
> 
> Note that to have any effect, this requires a kernel patch:
> 
>   https://lkml.org/lkml/2017/8/10/689
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>

Looks reasonable but pls remember to repost after the release.

> ---
>  hw/scsi/virtio-scsi.c           | 8 +++++---
>  include/hw/virtio/virtio-scsi.h | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index eb639442d1..aca1909a59 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -867,10 +867,10 @@ void virtio_scsi_common_realize(DeviceState *dev,
>      s->sense_size = VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
>      s->cdb_size = VIRTIO_SCSI_CDB_DEFAULT_SIZE;
>  
> -    s->ctrl_vq = virtio_add_queue(vdev, VIRTIO_SCSI_VQ_SIZE, ctrl);
> -    s->event_vq = virtio_add_queue(vdev, VIRTIO_SCSI_VQ_SIZE, evt);
> +    s->ctrl_vq = virtio_add_queue(vdev, s->conf.virtqueue_size, ctrl);
> +    s->event_vq = virtio_add_queue(vdev, s->conf.virtqueue_size, evt);
>      for (i = 0; i < s->conf.num_queues; i++) {
> -        s->cmd_vqs[i] = virtio_add_queue(vdev, VIRTIO_SCSI_VQ_SIZE, cmd);
> +        s->cmd_vqs[i] = virtio_add_queue(vdev, s->conf.virtqueue_size, cmd);
>      }
>  }
>  
> @@ -917,6 +917,8 @@ static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
>  
>  static Property virtio_scsi_properties[] = {
>      DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues, 1),
> +    DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
> +                                         parent_obj.conf.virtqueue_size, 128),
>      DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
>                                                    0xFFFF),
>      DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_per_lun,
> diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
> index de6ae5a9f6..4c0bcdb788 100644
> --- a/include/hw/virtio/virtio-scsi.h
> +++ b/include/hw/virtio/virtio-scsi.h
> @@ -32,7 +32,6 @@
>  #define VIRTIO_SCSI(obj) \
>          OBJECT_CHECK(VirtIOSCSI, (obj), TYPE_VIRTIO_SCSI)
>  
> -#define VIRTIO_SCSI_VQ_SIZE     128
>  #define VIRTIO_SCSI_MAX_CHANNEL 0
>  #define VIRTIO_SCSI_MAX_TARGET  255
>  #define VIRTIO_SCSI_MAX_LUN     16383
> @@ -48,6 +47,7 @@ typedef struct virtio_scsi_config VirtIOSCSIConfig;
>  
>  struct VirtIOSCSIConf {
>      uint32_t num_queues;
> +    uint32_t virtqueue_size;
>      uint32_t max_sectors;
>      uint32_t cmd_per_lun;
>  #ifdef CONFIG_VHOST_SCSI
> -- 
> 2.13.1
