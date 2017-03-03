Received: from eggs.gnu.org ([2001:4830:134:3::10]:50975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cjjJJ-0000zc-At
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cjjJE-0002tt-Bl
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:15:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46748
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cjjJE-0002tY-54
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:15:32 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v239DmVD014627
	for <qemu-devel@nongnu.org>; Fri, 3 Mar 2017 04:15:30 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28xs8uvrtv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 04:15:30 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 3 Mar 2017 09:15:23 -0000
Date: Fri, 3 Mar 2017 10:15:17 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1488531088-12483-1-git-send-email-jasowang@redhat.com>
References: <1488531088-12483-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170303101517.20dd05f9.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: unbreak 1.0 device load with
 region cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Fri,  3 Mar 2017 16:51:28 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Current code depends on virtio_queue_update_rings() to setup address
> space cache. But this does not work for 1.0 device since we can't infer
> avail and used. Fixing this by calling virtio_init_region_cache()
> after subsections load which can guarantee avail and used are correct.
> 
> Fixes: 97cd965c0701 ("virtio: use VRingMemoryRegionCaches for avail
>                       and used rings")
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/virtio/virtio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 23483c7..faa45cb 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2059,6 +2059,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> 
>      rcu_read_lock();
>      for (i = 0; i < num; i++) {
> +        virtio_init_region_cache(vdev, i);
>          if (vdev->vq[i].vring.desc) {
>              uint16_t nheads;
>              nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;

"virtio: add missing region cache init in virtio_load()" should take
care of that (but has not been pulled yet, it seems).
