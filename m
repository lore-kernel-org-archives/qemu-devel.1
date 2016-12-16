Received: from eggs.gnu.org ([2001:4830:134:3::10]:54213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHqto-0002v5-QB
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHqtj-0004D2-Uv
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:42:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHqtj-0004BY-Q7
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:41:59 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 129F44D688
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 11:41:58 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 16 Dec 2016 11:41:55 +0000
Message-Id: <20161216114155.18446-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [for 2.9] balloon: Don't balloon roms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com
Cc: lcapitulino@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

A broken guest can specify physical addresses that correspond
to any memory region, but it shouldn't be able to change ROM.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events     | 2 ++
 hw/virtio/virtio-balloon.c | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 7b6f55e..6926eed 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -15,6 +15,8 @@ virtio_rng_pushed(void *rng, size_t len) "rng %p: %zd bytes pushed"
 virtio_rng_request(void *rng, size_t size, unsigned quota) "rng %p: %zd bytes requested, %u bytes quota left"
 
 # hw/virtio/virtio-balloon.c
+#
+virtio_balloon_bad_addr(uint64_t gpa) "%"PRIx64
 virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s gpa: %"PRIx64
 virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
 virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 884570a..a705e0e 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -228,8 +228,13 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 
             /* FIXME: remove get_system_memory(), but how? */
             section = memory_region_find(get_system_memory(), pa, 1);
-            if (!int128_nz(section.size) || !memory_region_is_ram(section.mr))
+            if (!int128_nz(section.size) ||
+                !memory_region_is_ram(section.mr) ||
+                memory_region_is_rom(section.mr) ||
+                memory_region_is_romd(section.mr)) {
+                trace_virtio_balloon_bad_addr(pa);
                 continue;
+            }
 
             trace_virtio_balloon_handle_output(memory_region_name(section.mr),
                                                pa);
-- 
2.9.3
