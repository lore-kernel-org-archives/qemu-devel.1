Received: from eggs.gnu.org ([2001:4830:134:3::10]:59629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cijiO-0005zP-Fz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cijiL-0001wI-Rz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:29:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40845
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cijiL-0001vq-MC
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:29:21 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1SFOW2m060155
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 10:29:19 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28wam8vhtj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 10:29:18 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 28 Feb 2017 10:29:18 -0500
References: <20170228152411.81609-1-cornelia.huck@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 28 Feb 2017 16:29:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170228152411.81609-1-cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Message-Id: <a4a43c1b-f5c0-125f-c46f-34889277f6ca@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: guard vring access when setting
 notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com

On 02/28/2017 04:24 PM, Cornelia Huck wrote:
> Switching to vring caches exposed an existing bug in
> virtio_queue_set_notification(): We can't access vring structures
> if they have not been set up yet. This may happen, for example,
> for virtio-blk devices with multiple queues: The code will try to
> switch notifiers for every queue, but the guest may have only set up
> a subset of them.
> 
> Fix this by (1) guarding access to the vring memory by checking
> for vring.desc and (2) triggering an update to the vring flags
> for consistency with the configured notification state once the
> queue is actually configured.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Together with Paolos patch this fixes my issue.

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/virtio/virtio.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index e487e36..d2ecd64 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -284,10 +284,11 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
>      virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
>  }
> 
> -void virtio_queue_set_notification(VirtQueue *vq, int enable)
> +static void vring_set_notification(VirtQueue *vq, int enable)
>  {
> -    vq->notification = enable;
> -
> +    if (!vq->vring.desc) {
> +        return;
> +    }
>      rcu_read_lock();
>      if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
>          vring_set_avail_event(vq, vring_avail_idx(vq));
> @@ -303,6 +304,13 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
>      rcu_read_unlock();
>  }
> 
> +void virtio_queue_set_notification(VirtQueue *vq, int enable)
> +{
> +    vq->notification = enable;
> +
> +    vring_set_notification(vq, enable);
> +}
> +
>  int virtio_queue_ready(VirtQueue *vq)
>  {
>      return vq->vring.avail != 0;
> @@ -1348,6 +1356,7 @@ void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
>  {
>      vdev->vq[n].vring.desc = addr;
>      virtio_queue_update_rings(vdev, n);
> +    vring_set_notification(&vdev->vq[n], vdev->vq[n].notification);
>  }
> 
>  hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n)
> @@ -1362,6 +1371,7 @@ void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
>      vdev->vq[n].vring.avail = avail;
>      vdev->vq[n].vring.used = used;
>      virtio_init_region_cache(vdev, n);
> +    vring_set_notification(&vdev->vq[n], vdev->vq[n].notification);
>  }
> 
>  void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
> 
