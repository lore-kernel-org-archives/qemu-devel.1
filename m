Received: from eggs.gnu.org ([2001:4830:134:3::10]:40960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qj-0001h9-HS
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qe-0004vl-7S
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qd-0004uq-Ul
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Wro128035
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:31 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ambn295q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:30 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:30 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:00 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-37-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 36/81] balloon: Don't balloon roms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

A broken guest can specify physical addresses that correspond
to any memory region, but it shouldn't be able to change ROM.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: qemu-stable@nongnu.org
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit f2fd57db363e465653efa55102104039b5516759)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.7.4
