Received: from eggs.gnu.org ([2001:4830:134:3::10]:60081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e2dwI-0008Vn-KH
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e2dwE-0005Mg-KE
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:54:18 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e2dwE-0005M1-Cn
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:54:14 -0400
Received: by mail-wm0-x244.google.com with SMTP id l10so4042458wmg.1
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 06:54:14 -0700 (PDT)
Received: from 640k.lan (94-36-246-2.adsl-ull.clienti.tiscali.it.
	[94.36.246.2]) by smtp.gmail.com with ESMTPSA id
	s196sm333449wmb.26.2017.10.12.06.54.10 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Oct 2017 06:54:10 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Oct 2017 15:54:08 +0200
Message-Id: <1507816448-86665-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] tco: add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add trace events to the PCH watchdog timer, it can be useful to see how
the guest is using it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/tco.c        | 11 +++++++++--
 hw/acpi/trace-events |  4 ++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
index 05b9d7b..0032db4 100644
--- a/hw/acpi/tco.c
+++ b/hw/acpi/tco.c
@@ -12,6 +12,7 @@
 #include "hw/i386/ich9.h"
 
 #include "hw/acpi/tco.h"
+#include "trace.h"
 
 //#define DEBUG
 
@@ -41,8 +42,11 @@ enum {
 
 static inline void tco_timer_reload(TCOIORegs *tr)
 {
-    tr->expire_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-        ((int64_t)(tr->tco.tmr & TCO_TMR_MASK) * TCO_TICK_NSEC);
+    int ticks = tr->tco.tmr & TCO_TMR_MASK;
+    int64_t nsec = (int64_t)ticks * TCO_TICK_NSEC;
+
+    trace_tco_timer_reload(ticks, nsec / 1000000);
+    tr->expire_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + nsec;
     timer_mod(tr->tco_timer, tr->expire_time);
 }
 
@@ -59,6 +63,9 @@ static void tco_timer_expired(void *opaque)
     ICH9LPCState *lpc = container_of(pm, ICH9LPCState, pm);
     uint32_t gcs = pci_get_long(lpc->chip_config + ICH9_CC_GCS);
 
+    trace_tco_timer_expired(tr->timeouts_no,
+			    lpc->pin_strap.spkr_hi,
+			    !!(gcs & ICH9_CC_GCS_NO_REBOOT));
     tr->tco.rld = 0;
     tr->tco.sts1 |= TCO_TIMEOUT;
     if (++tr->timeouts_no == 2) {
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index e3b41e9..df0024f 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -30,3 +30,7 @@ cpuhp_acpi_ejecting_invalid_cpu(uint32_t idx) "0x%"PRIx32
 cpuhp_acpi_ejecting_cpu(uint32_t idx) "0x%"PRIx32
 cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT: 0x%"PRIx32
 cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
+
+# hw/acpi/tco.c
+tco_timer_reload(int ticks, int msec) "ticks=%d (%d ms)"
+tco_timer_expired(int timeouts_no, bool strap, bool no_reboot) "timeouts_no=%d no_reboot=%d/%d"
-- 
1.8.3.1
