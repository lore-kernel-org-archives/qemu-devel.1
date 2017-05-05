Received: from eggs.gnu.org ([2001:4830:134:3::10]:45019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d6Y0K-0004pI-P8
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d6Y0H-0002mQ-LI
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:50:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d6Y0H-0002mC-Cj
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:50:17 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v457mXMj012743
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 03:50:16 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8jb3q65w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 03:50:15 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 5 May 2017 01:50:14 -0600
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
	<20170426144645.12476-2-farman@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 5 May 2017 09:50:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170426144645.12476-2-farman@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Message-Id: <8af6d47e-06fc-d840-47a8-6690fd250cc6@de.ibm.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 04/26/2017 04:46 PM, Eric Farman wrote:
> The virtio spec states that the max_sectors field is
> "a hint to the driver for the maximum transfer size"
> that would be used for a virtio-scsi request.
> 
> It's currently hardcoded to xFFFF unless one is established
> by the max_sectors parameter on the command line, but let's
> roll through the associated devices and set it to anything
> lower if one is set for the underlying block device and
> retrieved by the BLKSECTGET ioctl.
> 
> Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>

So since nobody else commented, I looked into this (not knowing anything 
about scsi before)

Your patch basically limits the HBA limit to the lowest size of all child devices.
This will certainly work, as guests will use the minimum of per-device size
and hba size.
Now: I think this might have some impact on cases where a HBA will have different
scsi disks or even non disk type scsi devices (what does blk_get_max_transfer 
return for a scsi cdrom or old scsi-1 devices?)

So in essence I think what could be a better solution is to enhance the 
ccw bios to actually read the per-device config in addition to the hba config.

Linux seems to use the Block Limits VPD any maybe the ccw bios should do the
same. So basically keep patch 4 and add an additional call to read the block VPD
and use the minimum of HBA and device value?

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
