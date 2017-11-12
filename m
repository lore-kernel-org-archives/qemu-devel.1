Received: from eggs.gnu.org ([2001:4830:134:3::10]:35266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eDr1H-0000FP-PD
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 07:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eDr1E-0007ra-IS
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 07:05:47 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1eDr1E-0007qO-BO
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 07:05:44 -0500
Received: by mail-wm0-f66.google.com with SMTP id b189so3219095wmd.5
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 04:05:43 -0800 (PST)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Sun, 12 Nov 2017 13:05:38 +0100
Message-Id: <2e8c12f5242bcf755a33ee3a0e9ef94339d1808c.1510487579.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] virtio_balloon: include disk/file caches
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
Cc: Huang Ying <ying.huang@intel.com>, Gal Hammer <ghammer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Amnon Ilan <ailan@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>, Rik van Riel <riel@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Add a new field VIRTIO_BALLOON_S_CACHES to virtio_balloon memory
statistics protocol. The value represents all disk/file caches.

In this case it corresponds to the sum of values
Buffers+Cached+SwapCached from /proc/meminfo.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 drivers/virtio/virtio_balloon.c     | 4 ++++
 include/uapi/linux/virtio_balloon.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f0b3a0b9d42f..d2bd13bbaf9f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -244,11 +244,13 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	struct sysinfo i;
 	unsigned int idx = 0;
 	long available;
+	unsigned long caches;
 
 	all_vm_events(events);
 	si_meminfo(&i);
 
 	available = si_mem_available();
+	caches = global_node_page_state(NR_FILE_PAGES);
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
@@ -264,6 +266,8 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 				pages_to_bytes(i.totalram));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_AVAIL,
 				pages_to_bytes(available));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_CACHES,
+				pages_to_bytes(caches));
 
 	return idx;
 }
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 343d7ddefe04..4e8b8304b793 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -52,7 +52,8 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory */
 #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
 #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
-#define VIRTIO_BALLOON_S_NR       7
+#define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
+#define VIRTIO_BALLOON_S_NR       8
 
 /*
  * Memory statistics structure.
-- 
2.15.0
