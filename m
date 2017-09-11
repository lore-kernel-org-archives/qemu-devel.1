Received: from eggs.gnu.org ([2001:4830:134:3::10]:39127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPL-0008E9-Cj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPI-0001dT-RM
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:03 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:16 -0500
Message-Id: <20170911172022.4738-33-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 32/38] libqtest: Merge qtest_irq*() with
 irq*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, John Snow <jsnow@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>

Maintaining two layers of libqtest APIs, one that takes an explicit
QTestState object, and the other that uses the implicit global_qtest,
is annoying.  In the interest of getting rid of global implicit
state and having less code to maintain, merge:
 qtest_get_irq()
 qtest_irq_intercept_in()
 qtest_irq_intercept_out()
with their short counterparts.  All callers that previously
used the short form now make it explicit that they are relying on
global_qtest, and later patches can then clean things up to remove
the global variable.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h         | 47 ++++++-----------------------------------------
 tests/libqtest.c         |  6 +++---
 tests/fdc-test.c         | 48 ++++++++++++++++++++++++------------------------
 tests/ide-test.c         | 17 +++++++++--------
 tests/ipmi-bt-test.c     |  6 +++---
 tests/ipmi-kcs-test.c    |  8 ++++----
 tests/libqos/libqos-pc.c |  2 +-
 tests/rtc-test.c         | 10 +++++-----
 tests/tco-test.c         |  2 +-
 tests/wdt_ib700-test.c   |  8 ++++----
 10 files changed, 60 insertions(+), 94 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 26d5f37bc9..8398c0fd07 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -176,33 +176,33 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap);

 /**
- * qtest_get_irq:
+ * get_irq:
  * @s: #QTestState instance to operate on.
  * @num: Interrupt to observe.
  *
  * Returns: The level of the @num interrupt.
  */
-bool qtest_get_irq(QTestState *s, int num);
+bool get_irq(QTestState *s, int num);

 /**
- * qtest_irq_intercept_in:
+ * irq_intercept_in:
  * @s: #QTestState instance to operate on.
  * @string: QOM path of a device.
  *
  * Associate qtest irqs with the GPIO-in pins of the device
  * whose path is specified by @string.
  */
-void qtest_irq_intercept_in(QTestState *s, const char *string);
+void irq_intercept_in(QTestState *s, const char *string);

 /**
- * qtest_irq_intercept_out:
+ * irq_intercept_out:
  * @s: #QTestState instance to operate on.
  * @string: QOM path of a device.
  *
  * Associate qtest irqs with the GPIO-out pins of the device
  * whose path is specified by @string.
  */
-void qtest_irq_intercept_out(QTestState *s, const char *string);
+void irq_intercept_out(QTestState *s, const char *string);

 /**
  * qtest_outb:
@@ -594,41 +594,6 @@ static inline QDict *qmp_eventwait_ref(const char *event)
 char *hmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);

 /**
- * get_irq:
- * @num: Interrupt to observe.
- *
- * Returns: The level of the @num interrupt.
- */
-static inline bool get_irq(int num)
-{
-    return qtest_get_irq(global_qtest, num);
-}
-
-/**
- * irq_intercept_in:
- * @string: QOM path of a device.
- *
- * Associate qtest irqs with the GPIO-in pins of the device
- * whose path is specified by @string.
- */
-static inline void irq_intercept_in(const char *string)
-{
-    qtest_irq_intercept_in(global_qtest, string);
-}
-
-/**
- * qtest_irq_intercept_out:
- * @string: QOM path of a device.
- *
- * Associate qtest irqs with the GPIO-out pins of the device
- * whose path is specified by @string.
- */
-static inline void irq_intercept_out(const char *string)
-{
-    qtest_irq_intercept_out(global_qtest, string);
-}
-
-/**
  * outb:
  * @addr: I/O port to write to.
  * @value: Value being written.
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 9f5f2cb933..962432a27a 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -648,7 +648,7 @@ const char *qtest_get_arch(void)
     return end + strlen("/qemu-system-");
 }

-bool qtest_get_irq(QTestState *s, int num)
+bool get_irq(QTestState *s, int num)
 {
     /* dummy operation in order to make sure irq is up to date */
     qtest_inb(s, 0);
@@ -684,13 +684,13 @@ int64_t clock_set(QTestState *s, int64_t val)
     return qtest_clock_rsp(s);
 }

-void qtest_irq_intercept_out(QTestState *s, const char *qom_path)
+void irq_intercept_out(QTestState *s, const char *qom_path)
 {
     qtest_sendf(s, "irq_intercept_out %s\n", qom_path);
     qtest_rsp(s, 0);
 }

-void qtest_irq_intercept_in(QTestState *s, const char *qom_path)
+void irq_intercept_in(QTestState *s, const char *qom_path)
 {
     qtest_sendf(s, "irq_intercept_in %s\n", qom_path);
     qtest_rsp(s, 0);
diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index e79cd0f3b5..584ad746ed 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -99,7 +99,7 @@ static void ack_irq(uint8_t *pcn)
 {
     uint8_t ret;

-    g_assert(get_irq(FLOPPY_IRQ));
+    g_assert(get_irq(global_qtest, FLOPPY_IRQ));
     floppy_send(CMD_SENSE_INT);
     floppy_recv();

@@ -108,7 +108,7 @@ static void ack_irq(uint8_t *pcn)
         *pcn = ret;
     }

-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
 }

 static uint8_t send_read_command(uint8_t cmd)
@@ -129,7 +129,7 @@ static uint8_t send_read_command(uint8_t cmd)

     floppy_send(cmd);
     floppy_send(head << 2 | drive);
-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
     floppy_send(cyl);
     floppy_send(head);
     floppy_send(sect_addr);
@@ -185,7 +185,7 @@ static uint8_t send_read_no_dma_command(int nb_sect, uint8_t expected_st0)

     floppy_send(CMD_READ);
     floppy_send(head << 2 | drive);
-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
     floppy_send(cyl);
     floppy_send(head);
     floppy_send(sect_addr);
@@ -217,7 +217,7 @@ static uint8_t send_read_no_dma_command(int nb_sect, uint8_t expected_st0)

     msr = inb(FLOPPY_BASE + reg_msr);
     assert_bit_set(msr, BUSY | RQM | DIO);
-    g_assert(get_irq(FLOPPY_IRQ));
+    g_assert(get_irq(global_qtest, FLOPPY_IRQ));

     st0 = floppy_recv();
     if (st0 != expected_st0) {
@@ -229,14 +229,14 @@ static uint8_t send_read_no_dma_command(int nb_sect, uint8_t expected_st0)
     floppy_recv();
     floppy_recv();
     floppy_recv();
-    g_assert(get_irq(FLOPPY_IRQ));
+    g_assert(get_irq(global_qtest, FLOPPY_IRQ));
     floppy_recv();

     /* Check that we're back in command phase */
     msr = inb(FLOPPY_BASE + reg_msr);
     assert_bit_clear(msr, BUSY | DIO);
     assert_bit_set(msr, RQM);
-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));

     return ret;
 }
@@ -248,7 +248,7 @@ static void send_seek(int cyl)

     floppy_send(CMD_SEEK);
     floppy_send(head << 2 | drive);
-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
     floppy_send(cyl);
     ack_irq(NULL);
 }
@@ -363,7 +363,7 @@ static void test_sense_interrupt(void)

     floppy_send(CMD_SEEK);
     floppy_send(head << 2 | drive);
-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
     floppy_send(cyl);

     floppy_send(CMD_SENSE_INT);
@@ -385,7 +385,7 @@ static void test_relative_seek(void)
     /* Send relative seek to increase track by 1 */
     floppy_send(CMD_RELATIVE_SEEK_IN);
     floppy_send(head << 2 | drive);
-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
     floppy_send(cyl);

     ack_irq(&pcn);
@@ -394,7 +394,7 @@ static void test_relative_seek(void)
     /* Send relative seek to decrease track by 1 */
     floppy_send(CMD_RELATIVE_SEEK_OUT);
     floppy_send(head << 2 | drive);
-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
     floppy_send(cyl);

     ack_irq(&pcn);
@@ -413,16 +413,16 @@ static void test_read_id(void)
     send_seek(0);

     floppy_send(CMD_READ_ID);
-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
     floppy_send(head << 2 | drive);

     msr = inb(FLOPPY_BASE + reg_msr);
-    if (!get_irq(FLOPPY_IRQ)) {
+    if (!get_irq(global_qtest, FLOPPY_IRQ)) {
         assert_bit_set(msr, BUSY);
         assert_bit_clear(msr, RQM);
     }

-    while (!get_irq(FLOPPY_IRQ)) {
+    while (!get_irq(global_qtest, FLOPPY_IRQ)) {
         /* qemu involves a timer with READ ID... */
         clock_step(global_qtest, 1000000000LL / 50);
     }
@@ -436,9 +436,9 @@ static void test_read_id(void)
     cyl = floppy_recv();
     head = floppy_recv();
     floppy_recv();
-    g_assert(get_irq(FLOPPY_IRQ));
+    g_assert(get_irq(global_qtest, FLOPPY_IRQ));
     floppy_recv();
-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));

     g_assert_cmpint(cyl, ==, 0);
     g_assert_cmpint(head, ==, 0);
@@ -450,22 +450,22 @@ static void test_read_id(void)

     floppy_send(CMD_SEEK);
     floppy_send(head << 2 | drive);
-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
     floppy_send(cyl);
-    g_assert(get_irq(FLOPPY_IRQ));
+    g_assert(get_irq(global_qtest, FLOPPY_IRQ));
     ack_irq(NULL);

     floppy_send(CMD_READ_ID);
-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
     floppy_send(head << 2 | drive);

     msr = inb(FLOPPY_BASE + reg_msr);
-    if (!get_irq(FLOPPY_IRQ)) {
+    if (!get_irq(global_qtest, FLOPPY_IRQ)) {
         assert_bit_set(msr, BUSY);
         assert_bit_clear(msr, RQM);
     }

-    while (!get_irq(FLOPPY_IRQ)) {
+    while (!get_irq(global_qtest, FLOPPY_IRQ)) {
         /* qemu involves a timer with READ ID... */
         clock_step(global_qtest, 1000000000LL / 50);
     }
@@ -479,9 +479,9 @@ static void test_read_id(void)
     cyl = floppy_recv();
     head = floppy_recv();
     floppy_recv();
-    g_assert(get_irq(FLOPPY_IRQ));
+    g_assert(get_irq(global_qtest, FLOPPY_IRQ));
     floppy_recv();
-    g_assert(!get_irq(FLOPPY_IRQ));
+    g_assert(!get_irq(global_qtest, FLOPPY_IRQ));

     g_assert_cmpint(cyl, ==, 8);
     g_assert_cmpint(head, ==, 1);
@@ -565,7 +565,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);

     global_qtest = qtest_start("-device floppy,id=floppy0");
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/fdc/cmos", test_cmos);
     qtest_add_func("/fdc/no_media_on_start", test_no_media_on_start);
     qtest_add_func("/fdc/read_without_media", test_read_without_media);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index 32c8c40294..c22dde55c1 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -255,14 +255,15 @@ static int send_dma_request(int cmd, uint64_t sector, int nb_sectors,
         status = qpci_io_readb(dev, bmdma_bar, bmreg_status);
     } while ((status & (BM_STS_ACTIVE | BM_STS_INTR)) == BM_STS_ACTIVE);

-    g_assert_cmpint(get_irq(IDE_PRIMARY_IRQ), ==, !!(status & BM_STS_INTR));
+    g_assert_cmpint(get_irq(global_qtest, IDE_PRIMARY_IRQ), ==,
+                    !!(status & BM_STS_INTR));

     /* Check IDE status code */
     assert_bit_set(qpci_io_readb(dev, ide_bar, reg_status), DRDY);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), BSY | DRQ);

     /* Reading the status register clears the IRQ */
-    g_assert(!get_irq(IDE_PRIMARY_IRQ));
+    g_assert(!get_irq(global_qtest, IDE_PRIMARY_IRQ));

     /* Stop DMA transfer if still active */
     if (status & BM_STS_ACTIVE) {
@@ -458,7 +459,7 @@ static void test_bmdma_setup(void)
         "-drive file=%s,if=ide,serial=%s,cache=writeback,format=raw "
         "-global ide-hd.ver=%s",
         tmp_path, "testdisk", "version");
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in(global_qtest, "ioapic");
 }

 static void test_bmdma_teardown(void)
@@ -580,7 +581,7 @@ static void test_flush(void)

     dev = get_pci_device(&bmdma_bar, &ide_bar);

-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in(global_qtest, "ioapic");

     /* Dirty media so that CMD_FLUSH_CACHE will actually go to disk */
     make_dirty(0);
@@ -631,7 +632,7 @@ static void test_retry_flush(const char *machine)

     dev = get_pci_device(&bmdma_bar, &ide_bar);

-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in(global_qtest, "ioapic");

     /* Dirty media so that CMD_FLUSH_CACHE will actually go to disk */
     make_dirty(0);
@@ -784,7 +785,7 @@ static void ide_wait_intr(int irq)

     time(&st);
     while (true) {
-        intr = get_irq(irq);
+        intr = get_irq(global_qtest, irq);
         if (intr) {
             return;
         }
@@ -822,7 +823,7 @@ static void cdrom_pio_impl(int nblocks)
     ide_test_start("-drive if=none,file=%s,media=cdrom,format=raw,id=sr0,index=0 "
                    "-device ide-cd,drive=sr0,bus=ide.0", tmp_path);
     dev = get_pci_device(&bmdma_bar, &ide_bar);
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in(global_qtest, "ioapic");

     /* PACKET command on device 0 */
     qpci_io_writeb(dev, ide_bar, reg_device, 0);
@@ -905,7 +906,7 @@ static void test_cdrom_dma(void)

     ide_test_start("-drive if=none,file=%s,media=cdrom,format=raw,id=sr0,index=0 "
                    "-device ide-cd,drive=sr0,bus=ide.0", tmp_path);
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in(global_qtest, "ioapic");

     guest_buf = guest_alloc(guest_malloc, len);
     prdt[0].addr = cpu_to_le32(guest_buf);
diff --git a/tests/ipmi-bt-test.c b/tests/ipmi-bt-test.c
index 8be18e3f42..f80a9a83c9 100644
--- a/tests/ipmi-bt-test.c
+++ b/tests/ipmi-bt-test.c
@@ -276,10 +276,10 @@ static void bt_cmd(uint8_t *cmd, unsigned int cmd_len,
     bt_wait_b2h_atn();
     if (bt_ints_enabled) {
         g_assert((bt_get_irqreg() & 0x02) == 0x02);
-        g_assert(get_irq(IPMI_IRQ));
+        g_assert(get_irq(global_qtest, IPMI_IRQ));
         bt_write_irqreg(0x03);
     } else {
-        g_assert(!get_irq(IPMI_IRQ));
+        g_assert(!get_irq(global_qtest, IPMI_IRQ));
     }
     IPMI_BT_CTLREG_SET_H_BUSY();
     IPMI_BT_CTLREG_SET_B2H_ATN();
@@ -418,7 +418,7 @@ int main(int argc, char **argv)
         " -chardev socket,id=ipmi0,host=localhost,port=%d,reconnect=10"
         " -device ipmi-bmc-extern,chardev=ipmi0,id=bmc0"
         " -device isa-ipmi-bt,bmc=bmc0", emu_port);
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/ipmi/extern/connect", test_connect);
     qtest_add_func("/ipmi/extern/bt_base", test_bt_base);
     qtest_add_func("/ipmi/extern/bt_enable_irq", test_enable_irq);
diff --git a/tests/ipmi-kcs-test.c b/tests/ipmi-kcs-test.c
index 5acc0d9e35..ddad8dd22f 100644
--- a/tests/ipmi-kcs-test.c
+++ b/tests/ipmi-kcs-test.c
@@ -89,14 +89,14 @@ static void kcs_wait_obf(void)
 static void kcs_clear_obf(void)
 {
     if (kcs_ints_enabled) {
-        g_assert(get_irq(IPMI_IRQ));
+        g_assert(get_irq(global_qtest, IPMI_IRQ));
     } else {
-        g_assert(!get_irq(IPMI_IRQ));
+        g_assert(!get_irq(global_qtest, IPMI_IRQ));
     }
     g_assert(IPMI_KCS_CMDREG_GET_OBF() == 1);
     kcs_get_datareg();
     g_assert(IPMI_KCS_CMDREG_GET_OBF() == 0);
-    g_assert(!get_irq(IPMI_IRQ));
+    g_assert(!get_irq(global_qtest, IPMI_IRQ));
 }

 static void kcs_check_state(uint8_t state)
@@ -277,7 +277,7 @@ int main(int argc, char **argv)

     global_qtest = qtest_start("-device ipmi-bmc-sim,id=bmc0"
                                " -device isa-ipmi-kcs,bmc=bmc0");
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/ipmi/local/kcs_base", test_kcs_base);
     qtest_add_func("/ipmi/local/kcs_abort", test_kcs_abort);
     qtest_add_func("/ipmi/local/kcs_enable_irq", test_enable_irq);
diff --git a/tests/libqos/libqos-pc.c b/tests/libqos/libqos-pc.c
index a9c1aceaa7..df97f0cd03 100644
--- a/tests/libqos/libqos-pc.c
+++ b/tests/libqos/libqos-pc.c
@@ -25,7 +25,7 @@ QOSState *qtest_pc_boot(const char *cmdline_fmt, ...)
     qs = qtest_vboot(&qos_ops, cmdline_fmt, ap);
     va_end(ap);

-    qtest_irq_intercept_in(qs->qts, "ioapic");
+    irq_intercept_in(qs->qts, "ioapic");

     return qs;
 }
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index 9b98e2d494..8ff201993e 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -277,7 +277,7 @@ static void alarm_time(void)
     /* set DEC mode */
     cmos_write(RTC_REG_B, REG_B_24H | REG_B_DM);

-    g_assert(!get_irq(RTC_ISA_IRQ));
+    g_assert(!get_irq(global_qtest, RTC_ISA_IRQ));
     cmos_read(RTC_REG_C);

     now.tm_sec = (now.tm_sec + 2) % 60;
@@ -287,14 +287,14 @@ static void alarm_time(void)
     cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) | REG_B_AIE);

     for (i = 0; i < 2 + wiggle; i++) {
-        if (get_irq(RTC_ISA_IRQ)) {
+        if (get_irq(global_qtest, RTC_ISA_IRQ)) {
             break;
         }

         clock_step(global_qtest, 1000000000);
     }

-    g_assert(get_irq(RTC_ISA_IRQ));
+    g_assert(get_irq(global_qtest, RTC_ISA_IRQ));
     g_assert((cmos_read(RTC_REG_C) & REG_C_AF) != 0);
     g_assert(cmos_read(RTC_REG_C) == 0);
 }
@@ -644,7 +644,7 @@ static void uip_stuck(void)

 static uint64_t wait_periodic_interrupt(uint64_t real_time)
 {
-    while (!get_irq(RTC_ISA_IRQ)) {
+    while (!get_irq(global_qtest, RTC_ISA_IRQ)) {
         real_time = clock_step_next(global_qtest);
     }

@@ -691,7 +691,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);

     s = global_qtest = qtest_start("-rtc clock=vm");
-    qtest_irq_intercept_in(s, "ioapic");
+    irq_intercept_in(s, "ioapic");

     qtest_add_func("/rtc/check-time/bcd", bcd_check_time);
     qtest_add_func("/rtc/check-time/dec", dec_check_time);
diff --git a/tests/tco-test.c b/tests/tco-test.c
index 27e982d8ac..c2abbeeaac 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -60,7 +60,7 @@ static void test_init(TestData *d)
                       d->noreboot ? "" : "-global ICH9-LPC.noreboot=false",
                       !d->args ? "" : d->args);
     global_qtest = qs;
-    qtest_irq_intercept_in(qs, "ioapic");
+    irq_intercept_in(qs, "ioapic");

     d->bus = qpci_init_pc(qs, NULL);
     d->dev = qpci_device_find(d->bus, QPCI_DEVFN(0x1f, 0x00));
diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index 05690e5159..5ce8f4a08a 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -58,7 +58,7 @@ static void ib700_pause(void)
     QDict *d;
     QTestState *s = qtest_start("-watchdog-action pause -device ib700");

-    qtest_irq_intercept_in(s, "ioapic");
+    irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "pause"));
     QDECREF(d);
@@ -71,7 +71,7 @@ static void ib700_reset(void)
     QDict *d;
     QTestState *s = qtest_start("-watchdog-action reset -device ib700");

-    qtest_irq_intercept_in(s, "ioapic");
+    irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
     QDECREF(d);
@@ -85,7 +85,7 @@ static void ib700_shutdown(void)
     QTestState *s;

     s = qtest_start("-watchdog-action reset -no-reboot -device ib700");
-    qtest_irq_intercept_in(s, "ioapic");
+    irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
     QDECREF(d);
@@ -98,7 +98,7 @@ static void ib700_none(void)
     QDict *d;
     QTestState *s = qtest_start("-watchdog-action none -device ib700");

-    qtest_irq_intercept_in(s, "ioapic");
+    irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "none"));
     QDECREF(d);
-- 
2.13.5
