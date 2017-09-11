Received: from eggs.gnu.org ([2001:4830:134:3::10]:39151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPO-0008H5-Ap
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPL-0001eM-0e
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:06 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:17 -0500
Message-Id: <20170911172022.4738-34-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 33/38] libqtest: Merge qtest_{in,
 out}[bwl]() with {in, out}[bwl]()
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
 qtest_outb()
 qtest_outw()
 qtest_outl()
 qtest_inb()
 qtest_inw()
 qtest_inl()
with their short counterparts.  All callers that previously
used the short form now make it explicit that they are relying on
global_qtest, and later patches can then clean things up to remove
the global variable.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h        | 99 ++++++-------------------------------------------
 tests/multiboot/libc.h  |  2 +-
 tests/libqtest.c        | 14 +++----
 tests/boot-order-test.c |  4 +-
 tests/endianness-test.c | 12 +++---
 tests/fdc-test.c        | 77 ++++++++++++++++++++------------------
 tests/hd-geo-test.c     |  4 +-
 tests/ipmi-bt-test.c    | 12 +++---
 tests/ipmi-kcs-test.c   |  8 ++--
 tests/libqos/fw_cfg.c   |  4 +-
 tests/libqos/pci-pc.c   | 44 +++++++++++-----------
 tests/libqos/pci.c      |  2 +-
 tests/m48t59-test.c     |  8 ++--
 tests/multiboot/libc.c  |  2 +-
 tests/pvpanic-test.c    |  4 +-
 tests/rtc-test.c        |  8 ++--
 tests/wdt_ib700-test.c  |  8 ++--
 17 files changed, 120 insertions(+), 192 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 8398c0fd07..520f745e7b 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -205,61 +205,61 @@ void irq_intercept_in(QTestState *s, const char *string);
 void irq_intercept_out(QTestState *s, const char *string);

 /**
- * qtest_outb:
+ * outb:
  * @s: #QTestState instance to operate on.
  * @addr: I/O port to write to.
  * @value: Value being written.
  *
  * Write an 8-bit value to an I/O port.
  */
-void qtest_outb(QTestState *s, uint16_t addr, uint8_t value);
+void outb(QTestState *s, uint16_t addr, uint8_t value);

 /**
- * qtest_outw:
+ * outw:
  * @s: #QTestState instance to operate on.
  * @addr: I/O port to write to.
  * @value: Value being written.
  *
  * Write a 16-bit value to an I/O port.
  */
-void qtest_outw(QTestState *s, uint16_t addr, uint16_t value);
+void outw(QTestState *s, uint16_t addr, uint16_t value);

 /**
- * qtest_outl:
+ * outl:
  * @s: #QTestState instance to operate on.
  * @addr: I/O port to write to.
  * @value: Value being written.
  *
  * Write a 32-bit value to an I/O port.
  */
-void qtest_outl(QTestState *s, uint16_t addr, uint32_t value);
+void outl(QTestState *s, uint16_t addr, uint32_t value);

 /**
- * qtest_inb:
+ * inb:
  * @s: #QTestState instance to operate on.
  * @addr: I/O port to read from.
  *
  * Returns an 8-bit value from an I/O port.
  */
-uint8_t qtest_inb(QTestState *s, uint16_t addr);
+uint8_t inb(QTestState *s, uint16_t addr);

 /**
- * qtest_inw:
+ * inw:
  * @s: #QTestState instance to operate on.
  * @addr: I/O port to read from.
  *
  * Returns a 16-bit value from an I/O port.
  */
-uint16_t qtest_inw(QTestState *s, uint16_t addr);
+uint16_t inw(QTestState *s, uint16_t addr);

 /**
- * qtest_inl:
+ * inl:
  * @s: #QTestState instance to operate on.
  * @addr: I/O port to read from.
  *
  * Returns a 32-bit value from an I/O port.
  */
-uint32_t qtest_inl(QTestState *s, uint16_t addr);
+uint32_t inl(QTestState *s, uint16_t addr);

 /**
  * qtest_writeb:
@@ -594,81 +594,6 @@ static inline QDict *qmp_eventwait_ref(const char *event)
 char *hmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);

 /**
- * outb:
- * @addr: I/O port to write to.
- * @value: Value being written.
- *
- * Write an 8-bit value to an I/O port.
- */
-static inline void outb(uint16_t addr, uint8_t value)
-{
-    qtest_outb(global_qtest, addr, value);
-}
-
-/**
- * outw:
- * @addr: I/O port to write to.
- * @value: Value being written.
- *
- * Write a 16-bit value to an I/O port.
- */
-static inline void outw(uint16_t addr, uint16_t value)
-{
-    qtest_outw(global_qtest, addr, value);
-}
-
-/**
- * outl:
- * @addr: I/O port to write to.
- * @value: Value being written.
- *
- * Write a 32-bit value to an I/O port.
- */
-static inline void outl(uint16_t addr, uint32_t value)
-{
-    qtest_outl(global_qtest, addr, value);
-}
-
-/**
- * inb:
- * @addr: I/O port to read from.
- *
- * Reads an 8-bit value from an I/O port.
- *
- * Returns: Value read.
- */
-static inline uint8_t inb(uint16_t addr)
-{
-    return qtest_inb(global_qtest, addr);
-}
-
-/**
- * inw:
- * @addr: I/O port to read from.
- *
- * Reads a 16-bit value from an I/O port.
- *
- * Returns: Value read.
- */
-static inline uint16_t inw(uint16_t addr)
-{
-    return qtest_inw(global_qtest, addr);
-}
-
-/**
- * inl:
- * @addr: I/O port to read from.
- *
- * Reads a 32-bit value from an I/O port.
- *
- * Returns: Value read.
- */
-static inline uint32_t inl(uint16_t addr)
-{
-    return qtest_inl(global_qtest, addr);
-}
-
-/**
  * writeb:
  * @addr: Guest address to write to.
  * @value: Value being written.
diff --git a/tests/multiboot/libc.h b/tests/multiboot/libc.h
index 04c9922c27..05eb7eafd6 100644
--- a/tests/multiboot/libc.h
+++ b/tests/multiboot/libc.h
@@ -48,7 +48,7 @@ typedef __builtin_va_list       va_list;

 /* Port I/O functions */

-static inline void outb(uint16_t port, uint8_t data)
+static inline void outb(global_qtest, uint16_t port, uint8_t data)
 {
     asm volatile ("outb %0, %1" : : "a" (data), "Nd" (port));
 }
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 962432a27a..1db86b39f1 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -651,7 +651,7 @@ const char *qtest_get_arch(void)
 bool get_irq(QTestState *s, int num)
 {
     /* dummy operation in order to make sure irq is up to date */
-    qtest_inb(s, 0);
+    inb(s, 0);

     return s->irq_level[num];
 }
@@ -702,17 +702,17 @@ static void qtest_out(QTestState *s, const char *cmd, uint16_t addr, uint32_t va
     qtest_rsp(s, 0);
 }

-void qtest_outb(QTestState *s, uint16_t addr, uint8_t value)
+void outb(QTestState *s, uint16_t addr, uint8_t value)
 {
     qtest_out(s, "outb", addr, value);
 }

-void qtest_outw(QTestState *s, uint16_t addr, uint16_t value)
+void outw(QTestState *s, uint16_t addr, uint16_t value)
 {
     qtest_out(s, "outw", addr, value);
 }

-void qtest_outl(QTestState *s, uint16_t addr, uint32_t value)
+void outl(QTestState *s, uint16_t addr, uint32_t value)
 {
     qtest_out(s, "outl", addr, value);
 }
@@ -732,17 +732,17 @@ static uint32_t qtest_in(QTestState *s, const char *cmd, uint16_t addr)
     return value;
 }

-uint8_t qtest_inb(QTestState *s, uint16_t addr)
+uint8_t inb(QTestState *s, uint16_t addr)
 {
     return qtest_in(s, "inb", addr);
 }

-uint16_t qtest_inw(QTestState *s, uint16_t addr)
+uint16_t inw(QTestState *s, uint16_t addr)
 {
     return qtest_in(s, "inw", addr);
 }

-uint32_t qtest_inl(QTestState *s, uint16_t addr)
+uint32_t inl(QTestState *s, uint16_t addr)
 {
     return qtest_in(s, "inl", addr);
 }
diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index e70f5dedba..177aac95ad 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -63,8 +63,8 @@ static void test_boot_orders(const char *machine,

 static uint8_t read_mc146818(uint16_t port, uint8_t reg)
 {
-    outb(port, reg);
-    return inb(port + 1);
+    outb(global_qtest, port, reg);
+    return inb(global_qtest, port + 1);
 }

 static uint64_t read_boot_order_pc(void)
diff --git a/tests/endianness-test.c b/tests/endianness-test.c
index 546e0969e4..16b303525e 100644
--- a/tests/endianness-test.c
+++ b/tests/endianness-test.c
@@ -52,7 +52,7 @@ static uint8_t isa_inb(const TestCase *test, uint16_t addr)
 {
     uint8_t value;
     if (test->isa_base == -1) {
-        value = inb(addr);
+        value = inb(global_qtest, addr);
     } else {
         value = readb(test->isa_base + addr);
     }
@@ -63,7 +63,7 @@ static uint16_t isa_inw(const TestCase *test, uint16_t addr)
 {
     uint16_t value;
     if (test->isa_base == -1) {
-        value = inw(addr);
+        value = inw(global_qtest, addr);
     } else {
         value = readw(test->isa_base + addr);
     }
@@ -74,7 +74,7 @@ static uint32_t isa_inl(const TestCase *test, uint16_t addr)
 {
     uint32_t value;
     if (test->isa_base == -1) {
-        value = inl(addr);
+        value = inl(global_qtest, addr);
     } else {
         value = readl(test->isa_base + addr);
     }
@@ -84,7 +84,7 @@ static uint32_t isa_inl(const TestCase *test, uint16_t addr)
 static void isa_outb(const TestCase *test, uint16_t addr, uint8_t value)
 {
     if (test->isa_base == -1) {
-        outb(addr, value);
+        outb(global_qtest, addr, value);
     } else {
         writeb(test->isa_base + addr, value);
     }
@@ -94,7 +94,7 @@ static void isa_outw(const TestCase *test, uint16_t addr, uint16_t value)
 {
     value = test->bswap ? bswap16(value) : value;
     if (test->isa_base == -1) {
-        outw(addr, value);
+        outw(global_qtest, addr, value);
     } else {
         writew(test->isa_base + addr, value);
     }
@@ -104,7 +104,7 @@ static void isa_outl(const TestCase *test, uint16_t addr, uint32_t value)
 {
     value = test->bswap ? bswap32(value) : value;
     if (test->isa_base == -1) {
-        outl(addr, value);
+        outl(global_qtest, addr, value);
     } else {
         writel(test->isa_base + addr, value);
     }
diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index 584ad746ed..7803ff2789 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -77,21 +77,21 @@ static void floppy_send(uint8_t byte)
 {
     uint8_t msr;

-    msr = inb(FLOPPY_BASE + reg_msr);
+    msr = inb(global_qtest, FLOPPY_BASE + reg_msr);
     assert_bit_set(msr, RQM);
     assert_bit_clear(msr, DIO);

-    outb(FLOPPY_BASE + reg_fifo, byte);
+    outb(global_qtest, FLOPPY_BASE + reg_fifo, byte);
 }

 static uint8_t floppy_recv(void)
 {
     uint8_t msr;

-    msr = inb(FLOPPY_BASE + reg_msr);
+    msr = inb(global_qtest, FLOPPY_BASE + reg_msr);
     assert_bit_set(msr, RQM | DIO);

-    return inb(FLOPPY_BASE + reg_fifo);
+    return inb(global_qtest, FLOPPY_BASE + reg_fifo);
 }

 /* pcn: Present Cylinder Number */
@@ -141,7 +141,7 @@ static uint8_t send_read_command(uint8_t cmd)
     uint8_t i = 0;
     uint8_t n = 2;
     for (; i < n; i++) {
-        msr = inb(FLOPPY_BASE + reg_msr);
+        msr = inb(global_qtest, FLOPPY_BASE + reg_msr);
         if (msr == 0xd0) {
             break;
         }
@@ -197,7 +197,7 @@ static uint8_t send_read_no_dma_command(int nb_sect, uint8_t expected_st0)
     uint16_t i = 0;
     uint8_t n = 2;
     for (; i < n; i++) {
-        msr = inb(FLOPPY_BASE + reg_msr);
+        msr = inb(global_qtest, FLOPPY_BASE + reg_msr);
         if (msr == (BUSY | NONDMA | DIO | RQM)) {
             break;
         }
@@ -210,12 +210,12 @@ static uint8_t send_read_no_dma_command(int nb_sect, uint8_t expected_st0)

     /* Non-DMA mode */
     for (i = 0; i < 512 * 2 * nb_sect; i++) {
-        msr = inb(FLOPPY_BASE + reg_msr);
+        msr = inb(global_qtest, FLOPPY_BASE + reg_msr);
         assert_bit_set(msr, BUSY | RQM | DIO);
-        inb(FLOPPY_BASE + reg_fifo);
+        inb(global_qtest, FLOPPY_BASE + reg_fifo);
     }

-    msr = inb(FLOPPY_BASE + reg_msr);
+    msr = inb(global_qtest, FLOPPY_BASE + reg_msr);
     assert_bit_set(msr, BUSY | RQM | DIO);
     g_assert(get_irq(global_qtest, FLOPPY_IRQ));

@@ -233,7 +233,7 @@ static uint8_t send_read_no_dma_command(int nb_sect, uint8_t expected_st0)
     floppy_recv();

     /* Check that we're back in command phase */
-    msr = inb(FLOPPY_BASE + reg_msr);
+    msr = inb(global_qtest, FLOPPY_BASE + reg_msr);
     assert_bit_clear(msr, BUSY | DIO);
     assert_bit_set(msr, RQM);
     g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
@@ -255,8 +255,8 @@ static void send_seek(int cyl)

 static uint8_t cmos_read(uint8_t reg)
 {
-    outb(base + 0, reg);
-    return inb(base + 1);
+    outb(global_qtest, base + 0, reg);
+    return inb(global_qtest, base + 1);
 }

 static void test_cmos(void)
@@ -273,14 +273,14 @@ static void test_no_media_on_start(void)

     /* Media changed bit must be set all time after start if there is
      * no media in drive. */
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
     send_seek(1);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
 }

@@ -302,22 +302,22 @@ static void test_media_insert(void)
                          " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
                          test_image);

-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);

     send_seek(0);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);

     /* Step to next track should clear DSKCHG bit. */
     send_seek(1);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_clear(dir, DSKCHG);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_clear(dir, DSKCHG);
 }

@@ -332,21 +332,21 @@ static void test_media_change(void)
     qmp_discard_response("{'execute':'eject', 'arguments':{"
                          " 'id':'floppy0' }}");

-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);

     send_seek(0);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);

     send_seek(1);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
-    dir = inb(FLOPPY_BASE + reg_dir);
+    dir = inb(global_qtest, FLOPPY_BASE + reg_dir);
     assert_bit_set(dir, DSKCHG);
 }

@@ -416,7 +416,7 @@ static void test_read_id(void)
     g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
     floppy_send(head << 2 | drive);

-    msr = inb(FLOPPY_BASE + reg_msr);
+    msr = inb(global_qtest, FLOPPY_BASE + reg_msr);
     if (!get_irq(global_qtest, FLOPPY_IRQ)) {
         assert_bit_set(msr, BUSY);
         assert_bit_clear(msr, RQM);
@@ -427,7 +427,7 @@ static void test_read_id(void)
         clock_step(global_qtest, 1000000000LL / 50);
     }

-    msr = inb(FLOPPY_BASE + reg_msr);
+    msr = inb(global_qtest, FLOPPY_BASE + reg_msr);
     assert_bit_set(msr, BUSY | RQM | DIO);

     st0 = floppy_recv();
@@ -459,7 +459,7 @@ static void test_read_id(void)
     g_assert(!get_irq(global_qtest, FLOPPY_IRQ));
     floppy_send(head << 2 | drive);

-    msr = inb(FLOPPY_BASE + reg_msr);
+    msr = inb(global_qtest, FLOPPY_BASE + reg_msr);
     if (!get_irq(global_qtest, FLOPPY_IRQ)) {
         assert_bit_set(msr, BUSY);
         assert_bit_clear(msr, RQM);
@@ -470,7 +470,7 @@ static void test_read_id(void)
         clock_step(global_qtest, 1000000000LL / 50);
     }

-    msr = inb(FLOPPY_BASE + reg_msr);
+    msr = inb(global_qtest, FLOPPY_BASE + reg_msr);
     assert_bit_set(msr, BUSY | RQM | DIO);

     st0 = floppy_recv();
@@ -492,7 +492,8 @@ static void test_read_no_dma_1(void)
 {
     uint8_t ret;

-    outb(FLOPPY_BASE + reg_dor, inb(FLOPPY_BASE + reg_dor) & ~0x08);
+    outb(global_qtest, FLOPPY_BASE + reg_dor,
+         inb(global_qtest, FLOPPY_BASE + reg_dor) & ~0x08);
     send_seek(0);
     ret = send_read_no_dma_command(1, 0x04);
     g_assert(ret == 0);
@@ -502,7 +503,8 @@ static void test_read_no_dma_18(void)
 {
     uint8_t ret;

-    outb(FLOPPY_BASE + reg_dor, inb(FLOPPY_BASE + reg_dor) & ~0x08);
+    outb(global_qtest, FLOPPY_BASE + reg_dor,
+         inb(global_qtest, FLOPPY_BASE + reg_dor) & ~0x08);
     send_seek(0);
     ret = send_read_no_dma_command(18, 0x04);
     g_assert(ret == 0);
@@ -512,7 +514,8 @@ static void test_read_no_dma_19(void)
 {
     uint8_t ret;

-    outb(FLOPPY_BASE + reg_dor, inb(FLOPPY_BASE + reg_dor) & ~0x08);
+    outb(global_qtest, FLOPPY_BASE + reg_dor,
+         inb(global_qtest, FLOPPY_BASE + reg_dor) & ~0x08);
     send_seek(0);
     ret = send_read_no_dma_command(19, 0x20);
     g_assert(ret == 0);
@@ -537,8 +540,8 @@ static void fuzz_registers(void)
         reg = (uint8_t)g_test_rand_int_range(0, 8);
         val = (uint8_t)g_test_rand_int_range(0, 256);

-        outb(FLOPPY_BASE + reg, val);
-        inb(FLOPPY_BASE + reg);
+        outb(global_qtest, FLOPPY_BASE + reg, val);
+        inb(global_qtest, FLOPPY_BASE + reg);
     }
 }

diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 406eea3c56..98e6621e6c 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -82,8 +82,8 @@ static void test_cmos_byte(int reg, int expected)
     enum { cmos_base = 0x70 };
     int actual;

-    outb(cmos_base + 0, reg);
-    actual = inb(cmos_base + 1);
+    outb(global_qtest, cmos_base + 0, reg);
+    actual = inb(global_qtest, cmos_base + 1);
     g_assert(actual == expected);
 }

diff --git a/tests/ipmi-bt-test.c b/tests/ipmi-bt-test.c
index f80a9a83c9..e25819fd4f 100644
--- a/tests/ipmi-bt-test.c
+++ b/tests/ipmi-bt-test.c
@@ -66,32 +66,32 @@ static int bt_ints_enabled;

 static uint8_t bt_get_ctrlreg(void)
 {
-    return inb(IPMI_BT_BASE);
+    return inb(global_qtest, IPMI_BT_BASE);
 }

 static void bt_write_ctrlreg(uint8_t val)
 {
-    outb(IPMI_BT_BASE, val);
+    outb(global_qtest, IPMI_BT_BASE, val);
 }

 static uint8_t bt_get_buf(void)
 {
-    return inb(IPMI_BT_BASE + 1);
+    return inb(global_qtest, IPMI_BT_BASE + 1);
 }

 static void bt_write_buf(uint8_t val)
 {
-    outb(IPMI_BT_BASE + 1, val);
+    outb(global_qtest, IPMI_BT_BASE + 1, val);
 }

 static uint8_t bt_get_irqreg(void)
 {
-    return inb(IPMI_BT_BASE + 2);
+    return inb(global_qtest, IPMI_BT_BASE + 2);
 }

 static void bt_write_irqreg(uint8_t val)
 {
-    outb(IPMI_BT_BASE + 2, val);
+    outb(global_qtest, IPMI_BT_BASE + 2, val);
 }

 static void bt_wait_b_busy(void)
diff --git a/tests/ipmi-kcs-test.c b/tests/ipmi-kcs-test.c
index ddad8dd22f..d27b9de185 100644
--- a/tests/ipmi-kcs-test.c
+++ b/tests/ipmi-kcs-test.c
@@ -52,22 +52,22 @@ static int kcs_ints_enabled;

 static uint8_t kcs_get_cmdreg(void)
 {
-    return inb(IPMI_KCS_BASE + 1);
+    return inb(global_qtest, IPMI_KCS_BASE + 1);
 }

 static void kcs_write_cmdreg(uint8_t val)
 {
-    outb(IPMI_KCS_BASE + 1, val);
+    outb(global_qtest, IPMI_KCS_BASE + 1, val);
 }

 static uint8_t kcs_get_datareg(void)
 {
-    return inb(IPMI_KCS_BASE);
+    return inb(global_qtest, IPMI_KCS_BASE);
 }

 static void kcs_write_datareg(uint8_t val)
 {
-    outb(IPMI_KCS_BASE, val);
+    outb(global_qtest, IPMI_KCS_BASE, val);
 }

 static void kcs_wait_ibf(void)
diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
index d0889d1e22..157d5190c6 100644
--- a/tests/libqos/fw_cfg.c
+++ b/tests/libqos/fw_cfg.c
@@ -83,7 +83,7 @@ QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base)

 static void io_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 {
-    qtest_outw(fw_cfg->qts, fw_cfg->base, key);
+    outw(fw_cfg->qts, fw_cfg->base, key);
 }

 static void io_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
@@ -92,7 +92,7 @@ static void io_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
     int i;

     for (i = 0; i < len; i++) {
-        ptr[i] = qtest_inb(fw_cfg->qts, fw_cfg->base + 1);
+        ptr[i] = inb(fw_cfg->qts, fw_cfg->base + 1);
     }
 }

diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index e5af083f0c..4d8329bef0 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -26,44 +26,44 @@ typedef struct QPCIBusPC

 static uint8_t qpci_pc_pio_readb(QPCIBus *bus, uint32_t addr)
 {
-    return qtest_inb(bus->qts, addr);
+    return inb(bus->qts, addr);
 }

 static void qpci_pc_pio_writeb(QPCIBus *bus, uint32_t addr, uint8_t val)
 {
-    qtest_outb(bus->qts, addr, val);
+    outb(bus->qts, addr, val);
 }

 static uint16_t qpci_pc_pio_readw(QPCIBus *bus, uint32_t addr)
 {
-    return qtest_inw(bus->qts, addr);
+    return inw(bus->qts, addr);
 }

 static void qpci_pc_pio_writew(QPCIBus *bus, uint32_t addr, uint16_t val)
 {
-    qtest_outw(bus->qts, addr, val);
+    outw(bus->qts, addr, val);
 }

 static uint32_t qpci_pc_pio_readl(QPCIBus *bus, uint32_t addr)
 {
-    return qtest_inl(bus->qts, addr);
+    return inl(bus->qts, addr);
 }

 static void qpci_pc_pio_writel(QPCIBus *bus, uint32_t addr, uint32_t val)
 {
-    qtest_outl(bus->qts, addr, val);
+    outl(bus->qts, addr, val);
 }

 static uint64_t qpci_pc_pio_readq(QPCIBus *bus, uint32_t addr)
 {
-    return (uint64_t)qtest_inl(bus->qts, addr) +
-        ((uint64_t)qtest_inl(bus->qts, addr + 4) << 32);
+    return (uint64_t)inl(bus->qts, addr) +
+        ((uint64_t)inl(bus->qts, addr + 4) << 32);
 }

 static void qpci_pc_pio_writeq(QPCIBus *bus, uint32_t addr, uint64_t val)
 {
-    qtest_outl(bus->qts, addr, val & 0xffffffff);
-    qtest_outl(bus->qts, addr + 4, val >> 32);
+    outl(bus->qts, addr, val & 0xffffffff);
+    outl(bus->qts, addr + 4, val >> 32);
 }

 static void qpci_pc_memread(QPCIBus *bus, uint32_t addr, void *buf, size_t len)
@@ -79,38 +79,38 @@ static void qpci_pc_memwrite(QPCIBus *bus, uint32_t addr,

 static uint8_t qpci_pc_config_readb(QPCIBus *bus, int devfn, uint8_t offset)
 {
-    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
-    return qtest_inb(bus->qts, 0xcfc);
+    outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    return inb(bus->qts, 0xcfc);
 }

 static uint16_t qpci_pc_config_readw(QPCIBus *bus, int devfn, uint8_t offset)
 {
-    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
-    return qtest_inw(bus->qts, 0xcfc);
+    outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    return inw(bus->qts, 0xcfc);
 }

 static uint32_t qpci_pc_config_readl(QPCIBus *bus, int devfn, uint8_t offset)
 {
-    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
-    return qtest_inl(bus->qts, 0xcfc);
+    outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    return inl(bus->qts, 0xcfc);
 }

 static void qpci_pc_config_writeb(QPCIBus *bus, int devfn, uint8_t offset, uint8_t value)
 {
-    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
-    qtest_outb(bus->qts, 0xcfc, value);
+    outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    outb(bus->qts, 0xcfc, value);
 }

 static void qpci_pc_config_writew(QPCIBus *bus, int devfn, uint8_t offset, uint16_t value)
 {
-    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
-    qtest_outw(bus->qts, 0xcfc, value);
+    outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    outw(bus->qts, 0xcfc, value);
 }

 static void qpci_pc_config_writel(QPCIBus *bus, int devfn, uint8_t offset, uint32_t value)
 {
-    qtest_outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
-    qtest_outl(bus->qts, 0xcfc, value);
+    outl(bus->qts, 0xcf8, (1U << 31) | (devfn << 8) | offset);
+    outl(bus->qts, 0xcfc, value);
 }

 QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index d3ee21fdfd..aac42dc3d9 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -426,7 +426,7 @@ void qpci_unplug_device_test(QTestState *qts, const char *id, uint8_t slot)
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    qtest_outb(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
+    outb(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);

     qtest_qmp_eventwait(qts, "DEVICE_DELETED");
 }
diff --git a/tests/m48t59-test.c b/tests/m48t59-test.c
index aadd770f4f..7ef3e2d26a 100644
--- a/tests/m48t59-test.c
+++ b/tests/m48t59-test.c
@@ -44,14 +44,14 @@ static void cmos_write_mmio(uint8_t reg, uint8_t val)

 static uint8_t cmos_read_ioio(uint8_t reg)
 {
-    outw(base + 0, reg_base + (uint16_t)reg);
-    return inb(base + 3);
+    outw(global_qtest, base + 0, reg_base + (uint16_t)reg);
+    return inb(global_qtest, base + 3);
 }

 static void cmos_write_ioio(uint8_t reg, uint8_t val)
 {
-    outw(base + 0, reg_base + (uint16_t)reg);
-    outb(base + 3, val);
+    outw(global_qtest, base + 0, reg_base + (uint16_t)reg);
+    outb(global_qtest, base + 3, val);
 }

 static uint8_t cmos_read(uint8_t reg)
diff --git a/tests/multiboot/libc.c b/tests/multiboot/libc.c
index 6df9bda96d..bf02987c5e 100644
--- a/tests/multiboot/libc.c
+++ b/tests/multiboot/libc.c
@@ -36,7 +36,7 @@ void* memcpy(void *dest, const void *src, int n)

 static void print_char(char c)
 {
-    outb(0xe9, c);
+    outb(global_qtest, 0xe9, c);
 }

 static void print_str(char *s)
diff --git a/tests/pvpanic-test.c b/tests/pvpanic-test.c
index c09b3ddac6..6dce9e368a 100644
--- a/tests/pvpanic-test.c
+++ b/tests/pvpanic-test.c
@@ -15,10 +15,10 @@ static void test_panic(void)
     uint8_t val;
     QDict *response, *data;

-    val = inb(0x505);
+    val = inb(global_qtest, 0x505);
     g_assert_cmpuint(val, ==, 1);

-    outb(0x505, 0x1);
+    outb(global_qtest, 0x505, 0x1);

     response = qmp_receive();
     g_assert(qdict_haskey(response, "event"));
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index 8ff201993e..aea7eaec9f 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -28,14 +28,14 @@ static int bcd2dec(int value)

 static uint8_t cmos_read(uint8_t reg)
 {
-    outb(base + 0, reg);
-    return inb(base + 1);
+    outb(global_qtest, base + 0, reg);
+    return inb(global_qtest, base + 1);
 }

 static void cmos_write(uint8_t reg, uint8_t val)
 {
-    outb(base + 0, reg);
-    outb(base + 1, val);
+    outb(global_qtest, base + 0, reg);
+    outb(global_qtest, base + 1, val);
 }

 static int tm_cmp(struct tm *lhs, struct tm *rhs)
diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index 5ce8f4a08a..b2ff95bfd7 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -26,22 +26,22 @@ static QDict *ib700_program_and_wait(QTestState *s)
     qmp_check_no_event(s);

     /* 2 second limit */
-    qtest_outb(s, 0x443, 14);
+    outb(s, 0x443, 14);

     /* Ping */
     clock_step(s, NANOSECONDS_PER_SECOND);
     qmp_check_no_event(s);
-    qtest_outb(s, 0x443, 14);
+    outb(s, 0x443, 14);

     /* Disable */
     clock_step(s, NANOSECONDS_PER_SECOND);
     qmp_check_no_event(s);
-    qtest_outb(s, 0x441, 1);
+    outb(s, 0x441, 1);
     clock_step(s, 3 * NANOSECONDS_PER_SECOND);
     qmp_check_no_event(s);

     /* Enable and let it fire */
-    qtest_outb(s, 0x443, 13);
+    outb(s, 0x443, 13);
     clock_step(s, 3 * NANOSECONDS_PER_SECOND);
     qmp_check_no_event(s);
     clock_step(s, 2 * NANOSECONDS_PER_SECOND);
-- 
2.13.5
