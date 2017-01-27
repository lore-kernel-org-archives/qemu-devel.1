Received: from eggs.gnu.org ([2001:4830:134:3::10]:33283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qj-0004qK-Ps
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qj-0003o1-0g
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:57 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qi-0003mz-Qo
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:56 -0500
Received: by mail-wm0-x244.google.com with SMTP id c85so58230980wmi.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:45:56 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:11 +0100
Message-Id: <1485524749-118532-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/41] replay: don't use rtc clock on loadvm
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch disables the update of the periodic timer of mc146818rtc
in record/replay mode. State of this timer is saved and therefore does
not need to be updated in record/replay mode.
Read of RTC breaks the replay because all rtc reads have to be the same
as in record mode.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <20170124071730.4572.41874.stgit@PASHA-ISP>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/mc146818rtc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 637f872..4165450 100644
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
@@ -734,10 +735,16 @@ static int rtc_post_load(void *opaque, int version_id)
         check_update_timer(s);
     }
 
-    uint64_t now = qemu_clock_get_ns(rtc_clock);
-    if (now < s->next_periodic_time ||
-        now > (s->next_periodic_time + get_max_clock_jump())) {
-        periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+    /* The periodic timer is deterministic in record/replay mode,
+     * so there is no need to update it after loading the vmstate.
+     * Reading RTC here would misalign record and replay.
+     */
+    if (replay_mode == REPLAY_MODE_NONE) {
+        uint64_t now = qemu_clock_get_ns(rtc_clock);
+        if (now < s->next_periodic_time ||
+            now > (s->next_periodic_time + get_max_clock_jump())) {
+            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock));
+        }
     }
 
 #ifdef TARGET_I386
-- 
1.8.3.1
