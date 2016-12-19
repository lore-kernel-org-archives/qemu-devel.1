Received: from eggs.gnu.org ([2001:4830:134:3::10]:34215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cIxsh-0007LT-Pu
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cIxse-0007jt-LM
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:21:31 -0500
Received: from mail.ispras.ru ([83.149.199.45]:46300)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cIxse-0007jQ-E4
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:21:28 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Mon, 19 Dec 2016 16:21:28 +0300
Message-ID: <20161219132128.3016.67376.stgit@PASHA-ISP>
In-Reply-To: <20161219132102.3016.46687.stgit@PASHA-ISP>
References: <20161219132102.3016.46687.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 4/9] replay: don't use rtc clock on loadvm
 phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, pbonzini@redhat.com

This patch disables the update of the periodic timer of mc146818rtc
in record/replay mode. State of this timer is saved and therefore does
not need to be updated in record/replay mode.
Read of RTC breaks the replay because all rtc reads have to be the same
as in record mode.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 hw/timer/mc146818rtc.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index da209d0..5638777 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -27,6 +27,7 @@
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/replay.h"
 #include "hw/timer/mc146818rtc.h"
 #include "qapi/visitor.h"
 #include "qapi-event.h"
@@ -734,10 +735,15 @@ static int rtc_post_load(void *opaque, int version_id)
         check_update_timer(s);
     }
 
-    uint64_t now = qemu_clock_get_ns(rtc_clock);
-    if (now < s->next_periodic_time ||
-        now > (s->next_periodic_time + get_max_clock_jump())) {
-        periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+    /* Periodic timer is deterministic in record/replay mode.
+       No need to update it after loading the vmstate.
+       Reading RTC here may break the execution. */
+    if (replay_mode == REPLAY_MODE_NONE) {
+        uint64_t now = qemu_clock_get_ns(rtc_clock);
+        if (now < s->next_periodic_time ||
+            now > (s->next_periodic_time + get_max_clock_jump())) {
+            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+        }
     }
 
 #ifdef TARGET_I386
