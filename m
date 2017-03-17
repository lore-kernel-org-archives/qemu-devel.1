Received: from eggs.gnu.org ([2001:4830:134:3::10]:43226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1com1i-000758-0M
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 03:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1com1e-0000ZV-NX
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 03:10:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1com1e-0000ZN-FH
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 03:10:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46AA5486DC
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 07:10:14 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Mar 2017 08:09:54 +0100
Message-Id: <1489734595-14749-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] ich9: add tco reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Without that the nmi watchdog fires after reboot and the
linux kernel is confused where the nmi comes from:

   Uhhuh. NMI received for unknown reason 20 on CPU 0.
   Do you have a strange power saving mode enabled?
   Dazed and confused, but trying to continue

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/acpi/ich9.c        |  1 +
 hw/acpi/tco.c         | 39 ++++++++++++++++++++-------------------
 include/hw/acpi/tco.h |  1 +
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5c279bb..4d03182 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -250,6 +250,7 @@ static void pm_reset(void *opaque)
     acpi_pm1_cnt_reset(&pm->acpi_regs);
     acpi_pm_tmr_reset(&pm->acpi_regs);
     acpi_gpe_reset(&pm->acpi_regs);
+    acpi_pm_tco_reset(&pm->tco_regs);
 
     pm->smi_en = 0;
     if (!pm->smm_enabled) {
diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
index b4adac8..6e5fca8 100644
--- a/hw/acpi/tco.c
+++ b/hw/acpi/tco.c
@@ -214,27 +214,28 @@ static const MemoryRegionOps tco_io_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+void acpi_pm_tco_reset(TCOIORegs *tr)
+{
+    tr->tco.rld      = TCO_RLD_DEFAULT;
+    tr->tco.din      = TCO_DAT_IN_DEFAULT;
+    tr->tco.dout     = TCO_DAT_OUT_DEFAULT;
+    tr->tco.sts1     = TCO1_STS_DEFAULT;
+    tr->tco.sts2     = TCO2_STS_DEFAULT;
+    tr->tco.cnt1     = TCO1_CNT_DEFAULT;
+    tr->tco.cnt2     = TCO2_CNT_DEFAULT;
+    tr->tco.msg1     = TCO_MESSAGE1_DEFAULT;
+    tr->tco.msg2     = TCO_MESSAGE2_DEFAULT;
+    tr->tco.wdcnt    = TCO_WDCNT_DEFAULT;
+    tr->tco.tmr      = TCO_TMR_DEFAULT;
+    tr->sw_irq_gen   = SW_IRQ_GEN_DEFAULT;
+    tr->expire_time  = -1;
+    tr->timeouts_no  = 0;
+}
+
 void acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent)
 {
-    *tr = (TCOIORegs) {
-        .tco = {
-            .rld      = TCO_RLD_DEFAULT,
-            .din      = TCO_DAT_IN_DEFAULT,
-            .dout     = TCO_DAT_OUT_DEFAULT,
-            .sts1     = TCO1_STS_DEFAULT,
-            .sts2     = TCO2_STS_DEFAULT,
-            .cnt1     = TCO1_CNT_DEFAULT,
-            .cnt2     = TCO2_CNT_DEFAULT,
-            .msg1     = TCO_MESSAGE1_DEFAULT,
-            .msg2     = TCO_MESSAGE2_DEFAULT,
-            .wdcnt    = TCO_WDCNT_DEFAULT,
-            .tmr      = TCO_TMR_DEFAULT,
-        },
-        .sw_irq_gen    = SW_IRQ_GEN_DEFAULT,
-        .tco_timer     = timer_new_ns(QEMU_CLOCK_VIRTUAL, tco_timer_expired, tr),
-        .expire_time   = -1,
-        .timeouts_no   = 0,
-    };
+    tr->tco_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tco_timer_expired, tr);
+    acpi_pm_tco_reset(tr);
     memory_region_init_io(&tr->io, memory_region_owner(parent),
                           &tco_io_ops, tr, "sm-tco", ICH9_PMIO_TCO_LEN);
     memory_region_add_subregion(parent, ICH9_PMIO_TCO_RLD, &tr->io);
diff --git a/include/hw/acpi/tco.h b/include/hw/acpi/tco.h
index 52ad767..7d14043 100644
--- a/include/hw/acpi/tco.h
+++ b/include/hw/acpi/tco.h
@@ -74,6 +74,7 @@ typedef struct TCOIORegs {
 } TCOIORegs;
 
 /* tco.c */
+void acpi_pm_tco_reset(TCOIORegs *tr);
 void acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent);
 
 extern const VMStateDescription vmstate_tco_io_sts;
-- 
1.8.3.1
