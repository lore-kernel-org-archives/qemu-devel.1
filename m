Received: from eggs.gnu.org ([2001:4830:134:3::10]:41393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1ejJzf-0005J8-SG
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:18:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1ejJze-0005E8-Rh
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:18:11 -0500
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Date: Wed,  7 Feb 2018 08:17:58 +0100
Message-Id: <20180207071758.6818-1-w.bumiller@proxmox.com>
Subject: [Qemu-devel] [PATCH] ratelimit: don't align wait time with slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>

It is possible for rate limited writes to keep overshooting a slice's
quota by a tiny amount causing the slice-aligned waiting period to
effectively halve the rate.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
---
Copied the Ccs from the discussion thread, hope that's fine, as I also
just noticed that for my reply containing this snippet I had hit reply
on the mail that did not contain those Ccs yet, sorry about that.

 include/qemu/ratelimit.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/qemu/ratelimit.h b/include/qemu/ratelimit.h
index 8dece483f5..1b38291823 100644
--- a/include/qemu/ratelimit.h
+++ b/include/qemu/ratelimit.h
@@ -36,7 +36,7 @@ typedef struct {
 static inline int64_t ratelimit_calculate_delay(RateLimit *limit, uint64_t n)
 {
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    uint64_t delay_slices;
+    double delay_slices;
 
     assert(limit->slice_quota && limit->slice_ns);
 
@@ -55,12 +55,11 @@ static inline int64_t ratelimit_calculate_delay(RateLimit *limit, uint64_t n)
         return 0;
     }
 
-    /* Quota exceeded. Calculate the next time slice we may start
-     * sending data again. */
-    delay_slices = (limit->dispatched + limit->slice_quota - 1) /
-        limit->slice_quota;
+    /* Quota exceeded. Wait based on the excess amount and then start a new
+     * slice. */
+    delay_slices = (double)limit->dispatched / limit->slice_quota;
     limit->slice_end_time = limit->slice_start_time +
-        delay_slices * limit->slice_ns;
+        (uint64_t)(delay_slices * limit->slice_ns);
     return limit->slice_end_time - now;
 }
 
-- 
2.11.0
