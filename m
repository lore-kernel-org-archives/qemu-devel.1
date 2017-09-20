Received: from eggs.gnu.org ([2001:4830:134:3::10]:52442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1duhF0-0006fM-Sr
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1duhEv-00031x-NZ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:48:46 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:52754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1duhEv-0002xn-GB
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:48:41 -0400
Received: by mail-wr0-f176.google.com with SMTP id c23so2522243wrg.9
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 08:48:39 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Wed, 20 Sep 2017 17:48:36 +0200
Message-Id: <0bc0c49663fafdf3b03844fe048cac3216d88c5b.1505922364.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] virtio_balloon: include buffers and chached
 memory statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>, Huang Ying <ying.huang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Add a new fields, VIRTIO_BALLOON_S_BUFFERS and VIRTIO_BALLOON_S_CACHED,
to virtio_balloon memory statistics protocol. The values correspond to
'Buffers' and 'Cached' in /proc/meminfo.

To be able to compute the value of 'Cached' memory it is necessary to
export total_swapcache_pages() to modules.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 drivers/virtio/virtio_balloon.c     | 11 +++++++++++
 include/uapi/linux/virtio_balloon.h |  4 +++-
 mm/swap_state.c                     |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f0b3a0b9d42f..c2558ec47a62 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -244,12 +244,19 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	struct sysinfo i;
 	unsigned int idx = 0;
 	long available;
+	long cached;
 
 	all_vm_events(events);
 	si_meminfo(&i);
 
 	available = si_mem_available();
 
+	cached = global_node_page_state(NR_FILE_PAGES) -
+			total_swapcache_pages() - i.bufferram;
+	if (cached < 0)
+		cached = 0;
+
+
 #ifdef CONFIG_VM_EVENT_COUNTERS
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
 				pages_to_bytes(events[PSWPIN]));
@@ -264,6 +271,10 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 				pages_to_bytes(i.totalram));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_AVAIL,
 				pages_to_bytes(available));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_BUFFERS,
+				pages_to_bytes(i.bufferram));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_CACHED,
+				pages_to_bytes(cached));
 
 	return idx;
 }
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 343d7ddefe04..119224c34389 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -52,7 +52,9 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory */
 #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
 #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
-#define VIRTIO_BALLOON_S_NR       7
+#define VIRTIO_BALLOON_S_BUFFERS  7   /* Bufferes memory as in /proc */
+#define VIRTIO_BALLOON_S_CACHED   8   /* Cached memory as in /proc */
+#define VIRTIO_BALLOON_S_NR       9
 
 /*
  * Memory statistics structure.
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 71ce2d1ccbf7..f3a4ff7d6c52 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -95,6 +95,7 @@ unsigned long total_swapcache_pages(void)
 	rcu_read_unlock();
 	return ret;
 }
+EXPORT_SYMBOL_GPL(total_swapcache_pages);
 
 static atomic_t swapin_readahead_hits = ATOMIC_INIT(4);
 
-- 
2.14.1
