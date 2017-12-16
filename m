Received: from eggs.gnu.org ([2001:4830:134:3::10]:53086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8My-0004hQ-Do
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:02:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8Mx-00021V-6F
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:02:56 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:58795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eQ8Mx-0001we-0O
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:02:55 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 16 Dec 2017 10:02:16 +0100
Message-Id: <20171216090228.28505-4-hpoussin@reactos.org>
In-Reply-To: <20171216090228.28505-1-hpoussin@reactos.org>
References: <20171216090228.28505-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/15] mc146818rtc: move structure to header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

We are now able to embed a timer in another object.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/timer/mc146818rtc.c         | 30 ------------------------------
 include/hw/timer/mc146818rtc.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 7764be25ec..73d1ce21de 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -62,36 +62,6 @@
 #define RTC_CLOCK_RATE            32768
 #define UIP_HOLD_LENGTH           (8 * NANOSECONDS_PER_SECOND / 32768)
 
-#define MC146818_RTC(obj) OBJECT_CHECK(RTCState, (obj), TYPE_MC146818_RTC)
-
-typedef struct RTCState {
-    ISADevice parent_obj;
-
-    MemoryRegion io;
-    uint8_t cmos_data[128];
-    uint8_t cmos_index;
-    int32_t base_year;
-    uint64_t base_rtc;
-    uint64_t last_update;
-    int64_t offset;
-    qemu_irq irq;
-    int it_shift;
-    /* periodic timer */
-    QEMUTimer *periodic_timer;
-    int64_t next_periodic_time;
-    /* update-ended timer */
-    QEMUTimer *update_timer;
-    uint64_t next_alarm_time;
-    uint16_t irq_reinject_on_ack_count;
-    uint32_t irq_coalesced;
-    uint32_t period;
-    QEMUTimer *coalesced_timer;
-    Notifier clock_reset_notifier;
-    LostTickPolicy lost_tick_policy;
-    Notifier suspend_notifier;
-    QLIST_ENTRY(RTCState) link;
-} RTCState;
-
 static void rtc_set_time(RTCState *s);
 static void rtc_update_time(RTCState *s);
 static void rtc_set_cmos(RTCState *s, const struct tm *tm);
diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rtc.h
index 7c8e64b203..d7b2aa6b13 100644
--- a/include/hw/timer/mc146818rtc.h
+++ b/include/hw/timer/mc146818rtc.h
@@ -5,6 +5,35 @@
 #include "hw/timer/mc146818rtc_regs.h"
 
 #define TYPE_MC146818_RTC "mc146818rtc"
+#define MC146818_RTC(obj) OBJECT_CHECK(RTCState, (obj), TYPE_MC146818_RTC)
+
+typedef struct RTCState {
+    ISADevice parent_obj;
+
+    MemoryRegion io;
+    uint8_t cmos_data[128];
+    uint8_t cmos_index;
+    int32_t base_year;
+    uint64_t base_rtc;
+    uint64_t last_update;
+    int64_t offset;
+    qemu_irq irq;
+    int it_shift;
+    /* periodic timer */
+    QEMUTimer *periodic_timer;
+    int64_t next_periodic_time;
+    /* update-ended timer */
+    QEMUTimer *update_timer;
+    uint64_t next_alarm_time;
+    uint16_t irq_reinject_on_ack_count;
+    uint32_t irq_coalesced;
+    uint32_t period;
+    QEMUTimer *coalesced_timer;
+    Notifier clock_reset_notifier;
+    LostTickPolicy lost_tick_policy;
+    Notifier suspend_notifier;
+    QLIST_ENTRY(RTCState) link;
+} RTCState;
 
 ISADevice *rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq);
 void rtc_set_memory(ISADevice *dev, int addr, int val);
-- 
2.11.0
