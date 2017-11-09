Received: from eggs.gnu.org ([2001:4830:134:3::10]:37233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCtTW-0002bD-Jk
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 15:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCtTV-000412-Pe
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 15:30:58 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Nov 2017 21:30:25 +0100
Message-Id: <20171109203025.27493-6-mreitz@redhat.com>
In-Reply-To: <20171109203025.27493-1-mreitz@redhat.com>
References: <20171109203025.27493-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/5] iotests: Make 136 less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

136 executes some AIO requests without a final aio_flush; then it
advances the virtual clock and thus expects the last access time of the
device to be less than the current time when queried (i.e. idle_time_ns
to be greater than 0).  However, without the aio_flush, some requests
may be settled after the clock_step invocation.  In that case,
idle_time_ns would be 0 and the test fails.

Fix this by adding an aio_flush if any AIO request other than some other
aio_flush has been executed.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/136 | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index 4b994897af..88b97ea7c6 100644
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -238,6 +238,18 @@ sector = "%d"
         for i in range(failed_wr_ops):
             ops.append("aio_write %d 512" % bad_offset)
 
+        # We need an extra aio_flush to settle all outstanding AIO
+        # operations before we can advance the virtual clock, so that
+        # the last access happens before clock_step and idle_time_ns
+        # will be greater than 0
+        extra_flush = 0
+        if rd_ops + wr_ops + invalid_rd_ops + invalid_wr_ops + \
+                failed_rd_ops + failed_wr_ops > 0:
+            extra_flush = 1
+
+        if extra_flush > 0:
+            ops.append("aio_flush")
+
         if failed_wr_ops > 0:
             highest_offset = max(highest_offset, bad_offset + 512)
 
@@ -251,7 +263,7 @@ sector = "%d"
         self.total_wr_bytes += wr_ops * wr_size
         self.total_wr_ops += wr_ops
         self.total_wr_merged += wr_merged
-        self.total_flush_ops += flush_ops
+        self.total_flush_ops += flush_ops + extra_flush
         self.invalid_rd_ops += invalid_rd_ops
         self.invalid_wr_ops += invalid_wr_ops
         self.failed_rd_ops += failed_rd_ops
-- 
2.13.6
