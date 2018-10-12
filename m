Received: from eggs.gnu.org ([2001:4830:134:3::10]:60995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gAo4D-0003GK-34
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 23:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gAo49-0007Wu-47
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 23:24:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 12 Oct 2018 14:24:27 +1100
Message-Id: <20181012032431.32693-2-david@gibson.dropbear.id.au>
In-Reply-To: <20181012032431.32693-1-david@gibson.dropbear.id.au>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

When the balloon is inflated, we discard memory place in it using madvise()
with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, which
sounds like it makes sense but is actually unnecessary.

The misleadingly named MADV_DONTNEED just discards the memory in question,
it doesn't set any persistent state on it in-kernel; all that's necessary
to bring the memory back is to touch it.  MADV_WILLNEED in contrast
specifically says that the memory will be used soon and faults it in.

Memory that's being given back to the guest by deflating the balloon
*might* be used soon, but it equally could just sit around in the guest's
pools until it actually needs it.  And, over the general timescale that
memory ballooning operates, it seems unlikely that one extra fault for the
guest will be a vast performance issue.

So, simplify the balloon's operation by dropping the madvise() on deflate.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/virtio/virtio-balloon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 1728e4f83a..6ec4bcf4e1 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -35,9 +35,8 @@
 
 static void balloon_page(void *addr, int deflate)
 {
-    if (!qemu_balloon_is_inhibited()) {
-        qemu_madvise(addr, BALLOON_PAGE_SIZE,
-                deflate ? QEMU_MADV_WILLNEED : QEMU_MADV_DONTNEED);
+    if (!qemu_balloon_is_inhibited() && !deflate) {
+        qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
     }
 }
 
-- 
2.17.1
