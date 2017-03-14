Received: from eggs.gnu.org ([2001:4830:134:3::10]:34614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cniln-0007py-OK
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cnilj-0004Of-Ps
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:29:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45751
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cnilj-0004OV-K3
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:29:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2E9NfhQ086573
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 05:29:26 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29603fjynq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 05:29:26 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 14 Mar 2017 09:29:24 -0000
Date: Tue, 14 Mar 2017 10:29:18 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1489460502-6686-3-git-send-email-jasowang@redhat.com>
References: <1489460502-6686-1-git-send-email-jasowang@redhat.com>
	<1489460502-6686-3-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170314102918.3dce0075.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH V3 2/3] virtio: destroy region cache during
 reset
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

On Tue, 14 Mar 2017 11:01:41 +0800
Jason Wang <jasowang@redhat.com> wrote:

> We don't destroy region cache during reset which can make the maps
> of previous driver leaked to a buggy or malicious driver that don't
> set vring address before starting to use the device. Fix this by
> destroy the region cache during reset and validate it before trying to
> see them.
> 
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V2:
> - introduce a helper and assert caches != NULL
> Changes from v1:
> - switch to use rcu in virtio_virtqueue_region_cache()
> - use unlikely() when needed
> ---
>  hw/virtio/virtio.c | 46 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 16 deletions(-)
> 

> @@ -249,11 +255,10 @@ static inline void vring_used_idx_set(VirtQueue *vq, uint16_t val)
>  /* Called within rcu_read_lock().  */
>  static inline void vring_used_flags_set_bit(VirtQueue *vq, int mask)
>  {
> -    VRingMemoryRegionCaches *caches = atomic_rcu_read(&vq->vring.caches);
> +    VRingMemoryRegionCaches *caches = vring_get_region_caches(vq);
>      VirtIODevice *vdev = vq->vdev;
>      hwaddr pa = offsetof(VRingUsed, flags);
>      uint16_t flags = virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
> -

Unrelated whitespace change.

>      virtio_stw_phys_cached(vdev, &caches->used, pa, flags | mask);
>      address_space_cache_invalidate(&caches->used, pa, sizeof(flags));
>  }

Other than that:

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
