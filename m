Received: from eggs.gnu.org ([2001:4830:134:3::10]:42905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6Xq4-0001ZU-Q7
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6Xq1-0006wx-NQ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:39:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6Xq1-0006wi-Dm
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:39:41 -0400
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
	<20170426144645.12476-2-farman@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1ff618a0-bf5c-b389-be53-3c4ab25c7a6f@redhat.com>
Date: Fri, 5 May 2017 09:39:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170426144645.12476-2-farman@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 1/5] hw/scsi: Override the
 max_sectors value for virtio-scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>



On 26/04/2017 16:46, Eric Farman wrote:
> The virtio spec states that the max_sectors field is
> "a hint to the driver for the maximum transfer size"
> that would be used for a virtio-scsi request.
> 
> It's currently hardcoded to xFFFF unless one is established
> by the max_sectors parameter on the command line, but let's
> roll through the associated devices and set it to anything
> lower if one is set for the underlying block device and
> retrieved by the BLKSECTGET ioctl.

Have you tried looking at the block limits VPD page in the firmware?
QEMU is passing BLKSECTGET down by patching that VPD page.  Your
solution would not work with hotplug.

Thanks,

Paolo

> Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
> ---
>  hw/scsi/virtio-scsi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 46a3e3f..bca9461 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -640,7 +640,11 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
>                                     uint8_t *config)
>  {
>      VirtIOSCSIConfig *scsiconf = (VirtIOSCSIConfig *)config;
> +    VirtIOSCSI *vs = VIRTIO_SCSI(vdev);
>      VirtIOSCSICommon *s = VIRTIO_SCSI_COMMON(vdev);
> +    SCSIDevice *d;
> +    BusChild *kid;
> +    unsigned int max_transfer;
>  
>      virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
>      virtio_stl_p(vdev, &scsiconf->seg_max, 128 - 2);
> @@ -652,6 +656,14 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
>      virtio_stw_p(vdev, &scsiconf->max_channel, VIRTIO_SCSI_MAX_CHANNEL);
>      virtio_stw_p(vdev, &scsiconf->max_target, VIRTIO_SCSI_MAX_TARGET);
>      virtio_stl_p(vdev, &scsiconf->max_lun, VIRTIO_SCSI_MAX_LUN);
> +
> +    QTAILQ_FOREACH(kid, &vs->bus.qbus.children, sibling) {
> +        d = SCSI_DEVICE(kid->child);
> +        max_transfer = blk_get_max_transfer(d->conf.blk) / d->blocksize;
> +        virtio_stl_p(vdev,
> +                     &scsiconf->max_sectors,
> +                     MIN_NON_ZERO(max_transfer, scsiconf->max_sectors));
> +    }
>  }
>  
>  static void virtio_scsi_set_config(VirtIODevice *vdev,
> 
