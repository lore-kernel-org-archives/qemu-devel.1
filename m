Received: from eggs.gnu.org ([2001:4830:134:3::10]:34479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMszG-0008Qx-T5
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMszD-0008Gy-Pt
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cMszD-0008G7-HJ
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 03:56:27 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 30 Dec 2016 16:55:56 +0800
Message-Id: <1483088160-6714-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1483088160-6714-1-git-send-email-peterx@redhat.com>
References: <1483088160-6714-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 4/8] x86: ioapic: generalize
 trigger mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@web.de>, Paolo Bonzini <pbonzini@redhat.com>, agordeev@redhat.com, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Andrew Jones <drjones@redhat.com>, peterx@redhat.com

Move it out of x86/ioapic.c since it can be further re-used. Also,
renaming into TRIGGER_*.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/x86/apic.h |  6 ++++++
 x86/ioapic.c   | 34 ++++++++++++++++------------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/lib/x86/apic.h b/lib/x86/apic.h
index 192268c..699102c 100644
--- a/lib/x86/apic.h
+++ b/lib/x86/apic.h
@@ -18,6 +18,12 @@ typedef struct {
     uint8_t dest_id;
 } ioapic_redir_entry_t;
 
+typedef enum trigger_mode {
+	TRIGGER_EDGE = 0,
+	TRIGGER_LEVEL,
+	TRIGGER_MAX,
+} trigger_mode_t;
+
 void mask_pic_interrupts(void);
 
 void eoi(void);
diff --git a/x86/ioapic.c b/x86/ioapic.c
index 314c9bb..e5cc259 100644
--- a/x86/ioapic.c
+++ b/x86/ioapic.c
@@ -5,10 +5,8 @@
 #include "desc.h"
 #include "isr.h"
 
-#define EDGE_TRIGGERED 0
-#define LEVEL_TRIGGERED 1
-
-static void set_ioapic_redir(unsigned line, unsigned vec, unsigned trig_mode)
+static void set_ioapic_redir(unsigned line, unsigned vec,
+			     trigger_mode_t trig_mode)
 {
 	ioapic_redir_entry_t e = {
 		.vector = vec,
@@ -89,7 +87,7 @@ static void ioapic_isr_76(isr_regs_t *regs)
 static void test_ioapic_edge_intr(void)
 {
 	handle_irq(0x76, ioapic_isr_76);
-	set_ioapic_redir(0x0e, 0x76, EDGE_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x76, TRIGGER_EDGE);
 	toggle_irq_line(0x0e);
 	asm volatile ("nop");
 	report("edge triggered intr", g_isr_76 == 1);
@@ -107,7 +105,7 @@ static void ioapic_isr_77(isr_regs_t *regs)
 static void test_ioapic_level_intr(void)
 {
 	handle_irq(0x77, ioapic_isr_77);
-	set_ioapic_redir(0x0e, 0x77, LEVEL_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x77, TRIGGER_LEVEL);
 	set_irq_line(0x0e, 1);
 	asm volatile ("nop");
 	report("level triggered intr", g_isr_77 == 1);
@@ -136,8 +134,8 @@ static void test_ioapic_simultaneous(void)
 {
 	handle_irq(0x78, ioapic_isr_78);
 	handle_irq(0x66, ioapic_isr_66);
-	set_ioapic_redir(0x0e, 0x78, EDGE_TRIGGERED);
-	set_ioapic_redir(0x0f, 0x66, EDGE_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x78, TRIGGER_EDGE);
+	set_ioapic_redir(0x0f, 0x66, TRIGGER_EDGE);
 	irq_disable();
 	toggle_irq_line(0x0f);
 	toggle_irq_line(0x0e);
@@ -161,7 +159,7 @@ static void test_ioapic_edge_tmr(bool expected_tmr_before)
 	int tmr_before;
 
 	handle_irq(0x79, ioapic_isr_79);
-	set_ioapic_redir(0x0e, 0x79, EDGE_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x79, TRIGGER_EDGE);
 	tmr_before = apic_read_bit(APIC_TMR, 0x79);
 	toggle_irq_line(0x0e);
 	asm volatile ("nop");
@@ -175,7 +173,7 @@ static void test_ioapic_level_tmr(bool expected_tmr_before)
 	int tmr_before;
 
 	handle_irq(0x79, ioapic_isr_79);
-	set_ioapic_redir(0x0e, 0x79, LEVEL_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x79, TRIGGER_LEVEL);
 	tmr_before = apic_read_bit(APIC_TMR, 0x79);
 	set_irq_line(0x0e, 1);
 	asm volatile ("nop");
@@ -206,7 +204,7 @@ static void test_ioapic_edge_tmr_smp(bool expected_tmr_before)
 
 	g_tmr_79 = -1;
 	handle_irq(0x79, ioapic_isr_79);
-	set_ioapic_redir(0x0e, 0x79, EDGE_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x79, TRIGGER_EDGE);
 	tmr_before = apic_read_bit(APIC_TMR, 0x79);
 	on_cpu_async(1, toggle_irq_line_0x0e, 0);
 	i = 0;
@@ -231,7 +229,7 @@ static void test_ioapic_level_tmr_smp(bool expected_tmr_before)
 
 	g_tmr_79 = -1;
 	handle_irq(0x79, ioapic_isr_79);
-	set_ioapic_redir(0x0e, 0x79, LEVEL_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x79, TRIGGER_LEVEL);
 	tmr_before = apic_read_bit(APIC_TMR, 0x79);
 	on_cpu_async(1, set_irq_line_0x0e, 0);
 	i = 0;
@@ -258,7 +256,7 @@ static void ioapic_isr_98(isr_regs_t *regs)
 static void test_ioapic_level_coalesce(void)
 {
 	handle_irq(0x98, ioapic_isr_98);
-	set_ioapic_redir(0x0e, 0x98, LEVEL_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x98, TRIGGER_LEVEL);
 	set_irq_line(0x0e, 1);
 	asm volatile ("nop");
 	report("coalesce simultaneous level interrupts", g_isr_98 == 1);
@@ -276,7 +274,7 @@ static void ioapic_isr_99(isr_regs_t *regs)
 static void test_ioapic_level_sequential(void)
 {
 	handle_irq(0x99, ioapic_isr_99);
-	set_ioapic_redir(0x0e, 0x99, LEVEL_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x99, TRIGGER_LEVEL);
 	set_irq_line(0x0e, 1);
 	set_irq_line(0x0e, 1);
 	asm volatile ("nop");
@@ -298,7 +296,7 @@ static void test_ioapic_level_retrigger(void)
 	int i;
 
 	handle_irq(0x9a, ioapic_isr_9a);
-	set_ioapic_redir(0x0e, 0x9a, LEVEL_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x9a, TRIGGER_LEVEL);
 
 	asm volatile ("cli");
 	set_irq_line(0x0e, 1);
@@ -327,7 +325,7 @@ static void ioapic_isr_81(isr_regs_t *regs)
 static void test_ioapic_edge_mask(void)
 {
 	handle_irq(0x81, ioapic_isr_81);
-	set_ioapic_redir(0x0e, 0x81, EDGE_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x81, TRIGGER_EDGE);
 
 	set_mask(0x0e, true);
 	set_irq_line(0x0e, 1);
@@ -355,7 +353,7 @@ static void ioapic_isr_82(isr_regs_t *regs)
 static void test_ioapic_level_mask(void)
 {
 	handle_irq(0x82, ioapic_isr_82);
-	set_ioapic_redir(0x0e, 0x82, LEVEL_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x82, TRIGGER_LEVEL);
 
 	set_mask(0x0e, true);
 	set_irq_line(0x0e, 1);
@@ -381,7 +379,7 @@ static void ioapic_isr_83(isr_regs_t *regs)
 static void test_ioapic_level_retrigger_mask(void)
 {
 	handle_irq(0x83, ioapic_isr_83);
-	set_ioapic_redir(0x0e, 0x83, LEVEL_TRIGGERED);
+	set_ioapic_redir(0x0e, 0x83, TRIGGER_LEVEL);
 
 	set_irq_line(0x0e, 1);
 	asm volatile ("nop");
-- 
2.7.4
