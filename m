Received: from eggs.gnu.org ([2001:4830:134:3::10]:36363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eleTj-0002Ja-1k
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eleTe-0003EJ-UZ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:34:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eleTe-0003Du-Pe
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:34:46 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Feb 2018 17:34:28 +0000
Message-Id: <20180213173429.19501-5-stefanha@redhat.com>
In-Reply-To: <20180213173429.19501-1-stefanha@redhat.com>
References: <20180213173429.19501-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] ratelimit: don't align wait time with
 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Wolfgang Bumiller <w.bumiller@proxmox.com>

From: Wolfgang Bumiller <w.bumiller@proxmox.com>

It is possible for rate limited writes to keep overshooting a slice's
quota by a tiny amount causing the slice-aligned waiting period to
effectively halve the rate.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20180207071758.6818-1-w.bumiller@proxmox.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
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
2.14.3
