Received: from eggs.gnu.org ([2001:4830:134:3::10]:60585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVyrT-0002cH-6t
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVyrS-0008Q0-8T
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:02:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVyrS-0008Pj-3O
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:02:02 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 11:01:45 +0000
Message-Id: <20170124110151.937-3-berrange@redhat.com>
In-Reply-To: <20170124110151.937-1-berrange@redhat.com>
References: <20170124110151.937-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/8] trace: move hw/block/dataplane events
 to correct subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The trace-events for a given source file should generally
always live in the same directory as the source file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs                   | 1 +
 hw/block/dataplane/trace-events | 6 ++++++
 hw/block/trace-events           | 5 -----
 3 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 hw/block/dataplane/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 01cef86..babbc4e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -125,6 +125,7 @@ trace-events-y += io/trace-events
 trace-events-y += migration/trace-events
 trace-events-y += block/trace-events
 trace-events-y += hw/block/trace-events
+trace-events-y += hw/block/dataplane/trace-events
 trace-events-y += hw/char/trace-events
 trace-events-y += hw/intc/trace-events
 trace-events-y += hw/net/trace-events
diff --git a/hw/block/dataplane/trace-events b/hw/block/dataplane/trace-events
new file mode 100644
index 0000000..13f5dbb
--- /dev/null
+++ b/hw/block/dataplane/trace-events
@@ -0,0 +1,6 @@
+# See docs/tracing.txt for syntax documentation.
+
+# hw/block/dataplane/virtio-blk.c
+virtio_blk_data_plane_start(void *s) "dataplane %p"
+virtio_blk_data_plane_stop(void *s) "dataplane %p"
+virtio_blk_data_plane_process_request(void *s, unsigned int out_num, unsigned int in_num, unsigned int head) "dataplane %p out_num %u in_num %u head %u"
diff --git a/hw/block/trace-events b/hw/block/trace-events
index d0dd94f..65e83dc 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -7,11 +7,6 @@ virtio_blk_handle_write(void *req, uint64_t sector, size_t nsectors) "req %p sec
 virtio_blk_handle_read(void *req, uint64_t sector, size_t nsectors) "req %p sector %"PRIu64" nsectors %zu"
 virtio_blk_submit_multireq(void *mrb, int start, int num_reqs, uint64_t offset, size_t size, bool is_write) "mrb %p start %d num_reqs %d offset %"PRIu64" size %zu is_write %d"
 
-# hw/block/dataplane/virtio-blk.c
-virtio_blk_data_plane_start(void *s) "dataplane %p"
-virtio_blk_data_plane_stop(void *s) "dataplane %p"
-virtio_blk_data_plane_process_request(void *s, unsigned int out_num, unsigned int in_num, unsigned int head) "dataplane %p out_num %u in_num %u head %u"
-
 # hw/block/hd-geometry.c
 hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk %p LCHS %d %d %d"
 hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t secs, int trans) "blk %p CHS %u %u %u trans %d"
-- 
2.9.3
