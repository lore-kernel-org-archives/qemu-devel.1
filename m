Received: from eggs.gnu.org ([2001:4830:134:3::10]:43807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fudC5-0005LA-Kj
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fudC3-0006Cq-G5
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:34:01 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 28 Aug 2018 14:33:46 +0200
Message-Id: <20180828123346.17548-4-cohuck@redhat.com>
In-Reply-To: <20180828123346.17548-1-cohuck@redhat.com>
References: <20180828123346.17548-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] vfio-ccw: switch to warn_report_once_cond()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>

We can replace the local function with the new common interface.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index e96bbdc78b..9246729a75 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -37,24 +37,12 @@ typedef struct VFIOCCWDevice {
     bool warned_orb_pfch;
 } VFIOCCWDevice;
 
-static inline void warn_once(bool *warned, const char *fmt, ...)
-{
-    va_list ap;
-
-    if (!warned || *warned) {
-        return;
-    }
-    *warned = true;
-    va_start(ap, fmt);
-    warn_vreport(fmt, ap);
-    va_end(ap);
-}
-
 static inline void warn_once_pfch(VFIOCCWDevice *vcdev, SubchDev *sch,
                                   const char *msg)
 {
-    warn_once(&vcdev->warned_orb_pfch, "vfio-ccw (devno %x.%x.%04x): %s",
-              sch->cssid, sch->ssid, sch->devno, msg);
+    warn_report_once_cond(&vcdev->warned_orb_pfch,
+                          "vfio-ccw (devno %x.%x.%04x): %s",
+                          sch->cssid, sch->ssid, sch->devno, msg);
 }
 
 static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
-- 
2.14.4
