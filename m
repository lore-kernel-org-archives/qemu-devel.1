Received: from eggs.gnu.org ([209.51.188.92]:42420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpOk-0005WF-6g
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpOi-0002wo-5h
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:54:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpOh-0002nI-Sg
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:54:40 -0500
Date: Thu, 17 Jan 2019 01:46:04 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20190116174604.GA28579@wei-ubt>
References: <1542895581-10721-1-git-send-email-wexu@redhat.com>
	<1542895581-10721-10-git-send-email-wexu@redhat.com>
	<d0059b46-34c0-86d9-0840-ebe20bbdd561@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0059b46-34c0-86d9-0840-ebe20bbdd561@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 09/16] virtio: fill/flush/pop for packed
 ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, jfreimann@redhat.com, tiwei.bie@intel.com, mst@redhat.com

On Fri, Nov 30, 2018 at 01:45:19PM +0100, Maxime Coquelin wrote:
> Hi Wei,
> 
> On 11/22/18 3:06 PM, wexu@redhat.com wrote:
> >+void virtqueue_flush(VirtQueue *vq, unsigned int count)
> >+{
> >+    if (unlikely(vq->vdev->broken)) {
> >+        vq->inuse -= count;
> >+        return;
> >+    }
> >+
> >+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> >+        virtqueue_packed_flush(vq, count);
> >+    } else {
> >+        virtqueue_split_flush(vq, count);
> >+    }
> >+}
> >+
> >  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
> >                      unsigned int len)
> >  {
> >@@ -1074,7 +1180,7 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
> >      return elem;
> >  }
> >-void *virtqueue_pop(VirtQueue *vq, size_t sz)
> >+static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
> >  {
> >      unsigned int i, head, max;
> >      VRingMemoryRegionCaches *caches;
> >@@ -1089,9 +1195,6 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
> >      VRingDesc desc;
> >      int rc;
> >-    if (unlikely(vdev->broken)) {
> >-        return NULL;
> >-    }
> >      rcu_read_lock();
> >      if (virtio_queue_empty_rcu(vq)) {
> >          goto done;
> >@@ -1209,6 +1312,159 @@ err_undo_map:
> >      goto done;
> >  }
> >+static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
> >+{
> >+    unsigned int i, head, max;
> >+    VRingMemoryRegionCaches *caches;
> >+    MemoryRegionCache indirect_desc_cache = MEMORY_REGION_CACHE_INVALID;
> >+    MemoryRegionCache *cache;
> >+    int64_t len;
> >+    VirtIODevice *vdev = vq->vdev;
> >+    VirtQueueElement *elem = NULL;
> >+    unsigned out_num, in_num, elem_entries;
> >+    hwaddr addr[VIRTQUEUE_MAX_SIZE];
> >+    struct iovec iov[VIRTQUEUE_MAX_SIZE];
> >+    VRingPackedDesc desc;
> >+    uint16_t id;
> >+
> >+    rcu_read_lock();
> >+    if (virtio_queue_packed_empty_rcu(vq)) {
> >+        goto done;
> >+    }
> >+
> >+    /* When we start there are none of either input nor output. */
> >+    out_num = in_num = elem_entries = 0;
> >+
> >+    max = vq->vring.num;
> >+
> >+    if (vq->inuse >= vq->vring.num) {
> >+        virtio_error(vdev, "Virtqueue size exceeded");
> >+        goto done;
> >+    }
> >+
> >+    head = vq->last_avail_idx;
> >+    i = head;
> >+
> >+    caches = vring_get_region_caches(vq);
> >+    cache = &caches->desc;
> >+
> >+    /* Empty check has been done at the beginning, so it is an available
> >+     * entry already, make sure all fields has been exposed by guest */
> >+    smp_rmb();
> >+    vring_packed_desc_read(vdev, &desc, cache, i);
> >+
> >+    id = desc.id;
> >+    if (desc.flags & VRING_DESC_F_INDIRECT) {
> >+
> >+        if (desc.len % sizeof(VRingPackedDesc)) {
> >+            virtio_error(vdev, "Invalid size for indirect buffer table");
> >+            goto done;
> >+        }
> >+
> >+        /* loop over the indirect descriptor table */
> >+        len = address_space_cache_init(&indirect_desc_cache, vdev->dma_as,
> >+                                       desc.addr, desc.len, false);
> >+        cache = &indirect_desc_cache;
> >+        if (len < desc.len) {
> >+            virtio_error(vdev, "Cannot map indirect buffer");
> >+            goto done;
> >+        }
> >+
> >+        max = desc.len / sizeof(VRingPackedDesc);
> >+        i = 0;
> >+        vring_packed_desc_read(vdev, &desc, cache, i);
> >+        /* Make sure we see all the fields*/
> >+        smp_rmb();
> >+    }
> >+
> >+    /* Collect all the descriptors */
> >+    while (1) {
> >+        bool map_ok;
> >+
> >+        if (desc.flags & VRING_DESC_F_WRITE) {
> >+            map_ok = virtqueue_map_desc(vdev, &in_num, addr + out_num,
> >+                                        iov + out_num,
> >+                                        VIRTQUEUE_MAX_SIZE - out_num, true,
> >+                                        desc.addr, desc.len);
> >+        } else {
> >+            if (in_num) {
> >+                virtio_error(vdev, "Incorrect order for descriptors");
> >+                goto err_undo_map;
> >+            }
> >+            map_ok = virtqueue_map_desc(vdev, &out_num, addr, iov,
> >+                                        VIRTQUEUE_MAX_SIZE, false,
> >+                                        desc.addr, desc.len);
> >+        }
> >+        if (!map_ok) {
> >+            goto err_undo_map;
> >+        }
> >+
> >+        /* If we've got too many, that implies a descriptor loop. */
> >+        if (++elem_entries > max) {
> >+            virtio_error(vdev, "Looped descriptor");
> >+            goto err_undo_map;
> >+        }
> >+
> >+        if (++i >= vq->vring.num) {
> >+            i -= vq->vring.num;
> >+        }
> >+
> >+        if (desc.flags & VRING_DESC_F_NEXT) {
> >+            vring_packed_desc_read(vq->vdev, &desc, cache, i);
> >+        } else {
> >+            break;
> >+        }
> >+    }
> >+
> >+    /* Now copy what we have collected and mapped */
> >+    elem = virtqueue_alloc_element(sz, out_num, in_num);
> >+    elem->index = id;
> >+    for (i = 0; i < out_num; i++) {
> >+        elem->out_addr[i] = addr[i];
> >+        elem->out_sg[i] = iov[i];
> >+    }
> >+    for (i = 0; i < in_num; i++) {
> >+        elem->in_addr[i] = addr[head + out_num + i];
> >+        elem->in_sg[i] = iov[out_num + i];
> >+    }
> >+
> >+    vq->last_avail_idx += (cache == &indirect_desc_cache) ?
> >+                          1 : out_num + in_num;
> 
> I think you cannot rely on out_num and in_num to deduce the number of
> descriptors.
> 
> Indeed, in virtqueue_map_desc(), in_num and out_num can be incremented
> by more than one for a single descriptor, when the desc buffer is not
> contiguous in the QEMU address space.
> 

Indeed, should replace it with 'elem_entries', thanks.

Wei
