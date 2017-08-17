Received: from eggs.gnu.org ([2001:4830:134:3::10]:60936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diD9K-00054H-7o
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diD9H-0005tc-1E
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:15:18 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Aug 2017 07:15:10 +0200
Message-Id: <1502946910-14580-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr_rtc: Mark the RTC device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org

QEMU currently aborts unexpectedly when a user tries to do something
like this:

$ qemu-system-ppc64 -nographic -S -nodefaults -monitor stdio
QEMU 2.9.92 monitor - type 'help' for more information
(qemu) device_add spapr-rtc,id=spapr-rtc
(qemu) device_del spapr-rtc
**
ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
Aborted (core dumped)

The RTC device is not meant to be hot-pluggable - it's an internal
device only and it even should not be possible to create it a
second time with the "-device" parameter, so let's mark this
with "user_creatable = false".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr_rtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index 00a4e4c..9ec3078 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -164,6 +164,8 @@ static void spapr_rtc_class_init(ObjectClass *oc, void *data)
 
     dc->realize = spapr_rtc_realize;
     dc->vmsd = &vmstate_spapr_rtc;
+    /* Reason: This is an internal device only for handling the hypercalls */
+    dc->user_creatable = false;
 
     spapr_rtas_register(RTAS_GET_TIME_OF_DAY, "get-time-of-day",
                         rtas_get_time_of_day);
-- 
1.8.3.1
