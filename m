Received: from eggs.gnu.org ([2001:4830:134:3::10]:51074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJb6-0007GG-31
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJb3-0004eJ-Dm
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:32:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 23 Aug 2017 10:32:16 +1000
Message-Id: <20170823003217.6769-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170823003217.6769-1-david@gibson.dropbear.id.au>
References: <20170823003217.6769-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 6/7] hw/ppc/spapr_rtc: Mark the RTC device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, mdroth@linux.vnet.ibm.com, cohuck@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

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
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_rtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index 00a4e4c717..9ec3078691 100644
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
2.13.5
