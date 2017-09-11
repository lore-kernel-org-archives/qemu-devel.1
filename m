Received: from eggs.gnu.org ([2001:4830:134:3::10]:39380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPk-0000CA-P0
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPe-0001pd-Lj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:28 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:18 -0500
Message-Id: <20170911172022.4738-35-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 34/38] libqtest: Merge qtest_{read,
 write}[bwlq]() with {read, write}[bwlq]()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>, Ben Warren <ben@skyportsystems.com>, "open list:sPAPR" <qemu-ppc@nongnu.org>, "open list:virtio-blk" <qemu-block@nongnu.org>

Maintaining two layers of libqtest APIs, one that takes an explicit
QTestState object, and the other that uses the implicit global_qtest,
is annoying.  In the interest of getting rid of global implicit
state and having less code to maintain, merge:
 qtest_readb()
 qtest_readw()
 qtest_readl()
 qtest_readq()
 qtest_writeb()
 qtest_writew()
 qtest_writel()
 qtest_writeq()
with their short counterparts.  All callers that previously
used the short form now make it explicit that they are relying on
global_qtest, and later patches can then clean things up to remove
the global variable.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h           | 132 ++++++---------------------------------------
 tests/acpi-utils.h         |  10 ++--
 tests/libqtest.c           |  16 +++---
 tests/acpi-utils.c         |   2 +-
 tests/bios-tables-test.c   |   8 +--
 tests/boot-order-test.c    |   6 +--
 tests/boot-sector.c        |   4 +-
 tests/endianness-test.c    |  12 ++---
 tests/libqos/fw_cfg.c      |   4 +-
 tests/libqos/i2c-imx.c     |  64 +++++++++++-----------
 tests/libqos/i2c-omap.c    |  42 +++++++--------
 tests/libqos/pci-spapr.c   |  16 +++---
 tests/libqos/rtas.c        |   4 +-
 tests/libqos/virtio-mmio.c |  58 +++++++++-----------
 tests/libqos/virtio-pci.c  |   8 +--
 tests/libqos/virtio.c      |  73 ++++++++++++-------------
 tests/m25p80-test.c        |  80 +++++++++++++--------------
 tests/m48t59-test.c        |   4 +-
 tests/pnv-xscom-test.c     |   2 +-
 tests/prom-env-test.c      |   2 +-
 tests/q35-test.c           |  12 ++---
 tests/tco-test.c           |   4 +-
 tests/test-arm-mptimer.c   |  14 ++---
 tests/vhost-user-test.c    |   2 +-
 tests/virtio-blk-test.c    |  18 +++----
 tests/virtio-scsi-test.c   |   2 +-
 tests/vmgenid-test.c       |   2 +-
 27 files changed, 245 insertions(+), 356 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 520f745e7b..d0c487cf79 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -262,47 +262,47 @@ uint16_t inw(QTestState *s, uint16_t addr);
 uint32_t inl(QTestState *s, uint16_t addr);

 /**
- * qtest_writeb:
+ * writeb:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to write to.
  * @value: Value being written.
  *
  * Writes an 8-bit value to memory.
  */
-void qtest_writeb(QTestState *s, uint64_t addr, uint8_t value);
+void writeb(QTestState *s, uint64_t addr, uint8_t value);

 /**
- * qtest_writew:
+ * writew:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to write to.
  * @value: Value being written.
  *
  * Writes a 16-bit value to memory.
  */
-void qtest_writew(QTestState *s, uint64_t addr, uint16_t value);
+void writew(QTestState *s, uint64_t addr, uint16_t value);

 /**
- * qtest_writel:
+ * writel:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to write to.
  * @value: Value being written.
  *
  * Writes a 32-bit value to memory.
  */
-void qtest_writel(QTestState *s, uint64_t addr, uint32_t value);
+void writel(QTestState *s, uint64_t addr, uint32_t value);

 /**
- * qtest_writeq:
+ * writeq:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to write to.
  * @value: Value being written.
  *
  * Writes a 64-bit value to memory.
  */
-void qtest_writeq(QTestState *s, uint64_t addr, uint64_t value);
+void writeq(QTestState *s, uint64_t addr, uint64_t value);

 /**
- * qtest_readb:
+ * readb:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to read from.
  *
@@ -310,10 +310,10 @@ void qtest_writeq(QTestState *s, uint64_t addr, uint64_t value);
  *
  * Returns: Value read.
  */
-uint8_t qtest_readb(QTestState *s, uint64_t addr);
+uint8_t readb(QTestState *s, uint64_t addr);

 /**
- * qtest_readw:
+ * readw:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to read from.
  *
@@ -321,10 +321,10 @@ uint8_t qtest_readb(QTestState *s, uint64_t addr);
  *
  * Returns: Value read.
  */
-uint16_t qtest_readw(QTestState *s, uint64_t addr);
+uint16_t readw(QTestState *s, uint64_t addr);

 /**
- * qtest_readl:
+ * readl:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to read from.
  *
@@ -332,10 +332,10 @@ uint16_t qtest_readw(QTestState *s, uint64_t addr);
  *
  * Returns: Value read.
  */
-uint32_t qtest_readl(QTestState *s, uint64_t addr);
+uint32_t readl(QTestState *s, uint64_t addr);

 /**
- * qtest_readq:
+ * readq:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to read from.
  *
@@ -343,7 +343,7 @@ uint32_t qtest_readl(QTestState *s, uint64_t addr);
  *
  * Returns: Value read.
  */
-uint64_t qtest_readq(QTestState *s, uint64_t addr);
+uint64_t readq(QTestState *s, uint64_t addr);

 /**
  * qtest_memread:
@@ -594,106 +594,6 @@ static inline QDict *qmp_eventwait_ref(const char *event)
 char *hmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);

 /**
- * writeb:
- * @addr: Guest address to write to.
- * @value: Value being written.
- *
- * Writes an 8-bit value to guest memory.
- */
-static inline void writeb(uint64_t addr, uint8_t value)
-{
-    qtest_writeb(global_qtest, addr, value);
-}
-
-/**
- * writew:
- * @addr: Guest address to write to.
- * @value: Value being written.
- *
- * Writes a 16-bit value to guest memory.
- */
-static inline void writew(uint64_t addr, uint16_t value)
-{
-    qtest_writew(global_qtest, addr, value);
-}
-
-/**
- * writel:
- * @addr: Guest address to write to.
- * @value: Value being written.
- *
- * Writes a 32-bit value to guest memory.
- */
-static inline void writel(uint64_t addr, uint32_t value)
-{
-    qtest_writel(global_qtest, addr, value);
-}
-
-/**
- * writeq:
- * @addr: Guest address to write to.
- * @value: Value being written.
- *
- * Writes a 64-bit value to guest memory.
- */
-static inline void writeq(uint64_t addr, uint64_t value)
-{
-    qtest_writeq(global_qtest, addr, value);
-}
-
-/**
- * readb:
- * @addr: Guest address to read from.
- *
- * Reads an 8-bit value from guest memory.
- *
- * Returns: Value read.
- */
-static inline uint8_t readb(uint64_t addr)
-{
-    return qtest_readb(global_qtest, addr);
-}
-
-/**
- * readw:
- * @addr: Guest address to read from.
- *
- * Reads a 16-bit value from guest memory.
- *
- * Returns: Value read.
- */
-static inline uint16_t readw(uint64_t addr)
-{
-    return qtest_readw(global_qtest, addr);
-}
-
-/**
- * readl:
- * @addr: Guest address to read from.
- *
- * Reads a 32-bit value from guest memory.
- *
- * Returns: Value read.
- */
-static inline uint32_t readl(uint64_t addr)
-{
-    return qtest_readl(global_qtest, addr);
-}
-
-/**
- * readq:
- * @addr: Guest address to read from.
- *
- * Reads a 64-bit value from guest memory.
- *
- * Returns: Value read.
- */
-static inline uint64_t readq(uint64_t addr)
-{
-    return qtest_readq(global_qtest, addr);
-}
-
-/**
  * memread:
  * @addr: Guest address to read from.
  * @data: Pointer to where memory contents will be stored.
diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 8ec83f71b1..31eb59837d 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -32,21 +32,21 @@ typedef struct {
     do {                                       \
         switch (sizeof(field)) {               \
         case 1:                                \
-            field = qtest_readb(qts, addr);    \
+            field = readb(qts, addr);          \
             break;                             \
         case 2:                                \
-            field = qtest_readw(qts, addr);    \
+            field = readw(qts, addr);          \
             break;                             \
         case 4:                                \
-            field = qtest_readl(qts, addr);    \
+            field = readl(qts, addr);          \
             break;                             \
         case 8:                                \
-            field = qtest_readq(qts, addr);    \
+            field = readq(qts, addr);          \
             break;                             \
         default:                               \
             g_assert(false);                   \
         }                                      \
-        addr += sizeof(field);                  \
+        addr += sizeof(field);                 \
     } while (0);

 #define ACPI_READ_ARRAY_PTR(qts, arr, length, addr)      \
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 1db86b39f1..d9d0402287 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -754,22 +754,22 @@ static void qtest_write(QTestState *s, const char *cmd, uint64_t addr,
     qtest_rsp(s, 0);
 }

-void qtest_writeb(QTestState *s, uint64_t addr, uint8_t value)
+void writeb(QTestState *s, uint64_t addr, uint8_t value)
 {
     qtest_write(s, "writeb", addr, value);
 }

-void qtest_writew(QTestState *s, uint64_t addr, uint16_t value)
+void writew(QTestState *s, uint64_t addr, uint16_t value)
 {
     qtest_write(s, "writew", addr, value);
 }

-void qtest_writel(QTestState *s, uint64_t addr, uint32_t value)
+void writel(QTestState *s, uint64_t addr, uint32_t value)
 {
     qtest_write(s, "writel", addr, value);
 }

-void qtest_writeq(QTestState *s, uint64_t addr, uint64_t value)
+void writeq(QTestState *s, uint64_t addr, uint64_t value)
 {
     qtest_write(s, "writeq", addr, value);
 }
@@ -789,22 +789,22 @@ static uint64_t qtest_read(QTestState *s, const char *cmd, uint64_t addr)
     return value;
 }

-uint8_t qtest_readb(QTestState *s, uint64_t addr)
+uint8_t readb(QTestState *s, uint64_t addr)
 {
     return qtest_read(s, "readb", addr);
 }

-uint16_t qtest_readw(QTestState *s, uint64_t addr)
+uint16_t readw(QTestState *s, uint64_t addr)
 {
     return qtest_read(s, "readw", addr);
 }

-uint32_t qtest_readl(QTestState *s, uint64_t addr)
+uint32_t readl(QTestState *s, uint64_t addr)
 {
     return qtest_read(s, "readl", addr);
 }

-uint64_t qtest_readq(QTestState *s, uint64_t addr)
+uint64_t readq(QTestState *s, uint64_t addr)
 {
     return qtest_read(s, "readq", addr);
 }
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index 6dc8ca1a8c..e915cc8d57 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -42,7 +42,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
         int i;

         for (i = 0; i < sizeof sig - 1; ++i) {
-            sig[i] = qtest_readb(qts, off + i);
+            sig[i] = readb(qts, off + i);
         }

         if (!memcmp(sig, "RSD PTR ", sizeof sig)) {
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index c17cd8e1a3..f0a2e94ff1 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -539,7 +539,7 @@ static void test_smbios_entry_point(test_data *data)
         int i;

         for (i = 0; i < sizeof sig - 1; ++i) {
-            sig[i] = qtest_readb(data->qts, off + i);
+            sig[i] = readb(data->qts, off + i);
         }

         if (!memcmp(sig, "_SM_", sizeof sig)) {
@@ -582,9 +582,9 @@ static void test_smbios_structs(test_data *data)
     for (i = 0; i < ep_table->number_of_structures; i++) {

         /* grab type and formatted area length from struct header */
-        type = qtest_readb(data->qts, addr);
+        type = readb(data->qts, addr);
         g_assert_cmpuint(type, <=, SMBIOS_MAX_TYPE);
-        len = qtest_readb(data->qts, addr + 1);
+        len = readb(data->qts, addr + 1);

         /* single-instance structs must not have been encountered before */
         if (smbios_single_instance(type)) {
@@ -596,7 +596,7 @@ static void test_smbios_structs(test_data *data)
         prv = crt = 1;
         while (prv || crt) {
             prv = crt;
-            crt = qtest_readb(data->qts, addr + len);
+            crt = readb(data->qts, addr + len);
             len++;
         }

diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index 177aac95ad..048c8721c6 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -108,9 +108,9 @@ static void test_pc_boot_order(void)

 static uint8_t read_m48t59(uint64_t addr, uint16_t reg)
 {
-    writeb(addr, reg & 0xff);
-    writeb(addr + 1, reg >> 8);
-    return readb(addr + 3);
+    writeb(global_qtest, addr, reg & 0xff);
+    writeb(global_qtest, addr + 1, reg >> 8);
+    return readb(global_qtest, addr + 3);
 }

 static uint64_t read_boot_order_prep(void)
diff --git a/tests/boot-sector.c b/tests/boot-sector.c
index 8c8ac7f124..7b69e1d706 100644
--- a/tests/boot-sector.c
+++ b/tests/boot-sector.c
@@ -146,8 +146,8 @@ void boot_sector_test(QTestState *qts)
      * instruction.
      */
     for (i = 0; i < TEST_CYCLES; ++i) {
-        signature_low = qtest_readb(qts, SIGNATURE_ADDR);
-        signature_high = qtest_readb(qts, SIGNATURE_ADDR + 1);
+        signature_low = readb(qts, SIGNATURE_ADDR);
+        signature_high = readb(qts, SIGNATURE_ADDR + 1);
         signature = (signature_high << 8) | signature_low;
         if (signature == SIGNATURE) {
             break;
diff --git a/tests/endianness-test.c b/tests/endianness-test.c
index 16b303525e..bb1fb025a6 100644
--- a/tests/endianness-test.c
+++ b/tests/endianness-test.c
@@ -54,7 +54,7 @@ static uint8_t isa_inb(const TestCase *test, uint16_t addr)
     if (test->isa_base == -1) {
         value = inb(global_qtest, addr);
     } else {
-        value = readb(test->isa_base + addr);
+        value = readb(global_qtest, test->isa_base + addr);
     }
     return value;
 }
@@ -65,7 +65,7 @@ static uint16_t isa_inw(const TestCase *test, uint16_t addr)
     if (test->isa_base == -1) {
         value = inw(global_qtest, addr);
     } else {
-        value = readw(test->isa_base + addr);
+        value = readw(global_qtest, test->isa_base + addr);
     }
     return test->bswap ? bswap16(value) : value;
 }
@@ -76,7 +76,7 @@ static uint32_t isa_inl(const TestCase *test, uint16_t addr)
     if (test->isa_base == -1) {
         value = inl(global_qtest, addr);
     } else {
-        value = readl(test->isa_base + addr);
+        value = readl(global_qtest, test->isa_base + addr);
     }
     return test->bswap ? bswap32(value) : value;
 }
@@ -86,7 +86,7 @@ static void isa_outb(const TestCase *test, uint16_t addr, uint8_t value)
     if (test->isa_base == -1) {
         outb(global_qtest, addr, value);
     } else {
-        writeb(test->isa_base + addr, value);
+        writeb(global_qtest, test->isa_base + addr, value);
     }
 }

@@ -96,7 +96,7 @@ static void isa_outw(const TestCase *test, uint16_t addr, uint16_t value)
     if (test->isa_base == -1) {
         outw(global_qtest, addr, value);
     } else {
-        writew(test->isa_base + addr, value);
+        writew(global_qtest, test->isa_base + addr, value);
     }
 }

@@ -106,7 +106,7 @@ static void isa_outl(const TestCase *test, uint16_t addr, uint32_t value)
     if (test->isa_base == -1) {
         outl(global_qtest, addr, value);
     } else {
-        writel(test->isa_base + addr, value);
+        writel(global_qtest, test->isa_base + addr, value);
     }
 }

diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
index 157d5190c6..667e2ee93a 100644
--- a/tests/libqos/fw_cfg.c
+++ b/tests/libqos/fw_cfg.c
@@ -56,7 +56,7 @@ uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key)

 static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 {
-    qtest_writew(fw_cfg->qts, fw_cfg->base, key);
+    writew(fw_cfg->qts, fw_cfg->base, key);
 }

 static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
@@ -65,7 +65,7 @@ static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
     int i;

     for (i = 0; i < len; i++) {
-        ptr[i] = qtest_readb(fw_cfg->qts, fw_cfg->base + 2);
+        ptr[i] = readb(fw_cfg->qts, fw_cfg->base + 2);
     }
 }

diff --git a/tests/libqos/i2c-imx.c b/tests/libqos/i2c-imx.c
index 0945f2ecdc..cb5cce701f 100644
--- a/tests/libqos/i2c-imx.c
+++ b/tests/libqos/i2c-imx.c
@@ -40,8 +40,8 @@ typedef struct IMXI2C {
 static void imx_i2c_set_slave_addr(IMXI2C *s, uint8_t addr,
                                    enum IMXI2CDirection direction)
 {
-    qtest_writeb(s->parent.qts, s->addr + I2DR_ADDR,
-                 (addr << 1) | (direction == IMX_I2C_READ ? 1 : 0));
+    writeb(s->parent.qts, s->addr + I2DR_ADDR,
+           (addr << 1) | (direction == IMX_I2C_READ ? 1 : 0));
 }

 static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
@@ -63,35 +63,35 @@ static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
            I2CR_MTX |
            I2CR_TXAK;

-    qtest_writeb(i2c->qts, s->addr + I2CR_ADDR, data);
-    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+    writeb(i2c->qts, s->addr + I2CR_ADDR, data);
+    status = readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IBB) != 0);

     /* set the slave address */
     imx_i2c_set_slave_addr(s, addr, IMX_I2C_WRITE);
-    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+    status = readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IIF) != 0);
     g_assert((status & I2SR_RXAK) == 0);

     /* ack the interrupt */
-    qtest_writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
-    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+    writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
+    status = readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IIF) == 0);

     while (size < len) {
         /* check we are still busy */
-        status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+        status = readb(i2c->qts, s->addr + I2SR_ADDR);
         g_assert((status & I2SR_IBB) != 0);

         /* write the data */
-        qtest_writeb(i2c->qts, s->addr + I2DR_ADDR, buf[size]);
-        status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+        writeb(i2c->qts, s->addr + I2DR_ADDR, buf[size]);
+        status = readb(i2c->qts, s->addr + I2SR_ADDR);
         g_assert((status & I2SR_IIF) != 0);
         g_assert((status & I2SR_RXAK) == 0);

         /* ack the interrupt */
-        qtest_writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
-        status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+        writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
+        status = readb(i2c->qts, s->addr + I2SR_ADDR);
         g_assert((status & I2SR_IIF) == 0);

         size++;
@@ -99,8 +99,8 @@ static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,

     /* release the bus */
     data &= ~(I2CR_MSTA | I2CR_MTX);
-    qtest_writeb(i2c->qts, s->addr + I2CR_ADDR, data);
-    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+    writeb(i2c->qts, s->addr + I2CR_ADDR, data);
+    status = readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IBB) == 0);
 }

@@ -123,19 +123,19 @@ static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
            I2CR_MTX |
            I2CR_TXAK;

-    qtest_writeb(i2c->qts, s->addr + I2CR_ADDR, data);
-    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+    writeb(i2c->qts, s->addr + I2CR_ADDR, data);
+    status = readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IBB) != 0);

     /* set the slave address */
     imx_i2c_set_slave_addr(s, addr, IMX_I2C_READ);
-    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+    status = readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IIF) != 0);
     g_assert((status & I2SR_RXAK) == 0);

     /* ack the interrupt */
-    qtest_writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
-    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+    writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
+    status = readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IIF) == 0);

     /* set the bus for read */
@@ -144,23 +144,23 @@ static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
     if (len != 1) {
         data &= ~I2CR_TXAK;
     }
-    qtest_writeb(i2c->qts, s->addr + I2CR_ADDR, data);
-    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+    writeb(i2c->qts, s->addr + I2CR_ADDR, data);
+    status = readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IBB) != 0);

     /* dummy read */
-    qtest_readb(i2c->qts, s->addr + I2DR_ADDR);
-    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+    readb(i2c->qts, s->addr + I2DR_ADDR);
+    status = readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IIF) != 0);

     /* ack the interrupt */
-    qtest_writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
-    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+    writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
+    status = readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IIF) == 0);

     while (size < len) {
         /* check we are still busy */
-        status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+        status = readb(i2c->qts, s->addr + I2SR_ADDR);
         g_assert((status & I2SR_IBB) != 0);

         if (size == (len - 1)) {
@@ -170,26 +170,26 @@ static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
             /* ack the data read */
             data |= I2CR_TXAK;
         }
-        qtest_writeb(i2c->qts, s->addr + I2CR_ADDR, data);
+        writeb(i2c->qts, s->addr + I2CR_ADDR, data);

         /* read the data */
-        buf[size] = qtest_readb(i2c->qts, s->addr + I2DR_ADDR);
+        buf[size] = readb(i2c->qts, s->addr + I2DR_ADDR);

         if (size != (len - 1)) {
-            status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+            status = readb(i2c->qts, s->addr + I2SR_ADDR);
             g_assert((status & I2SR_IIF) != 0);

             /* ack the interrupt */
-            qtest_writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
+            writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
         }

-        status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+        status = readb(i2c->qts, s->addr + I2SR_ADDR);
         g_assert((status & I2SR_IIF) == 0);

         size++;
     }

-    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
+    status = readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IBB) == 0);
 }

diff --git a/tests/libqos/i2c-omap.c b/tests/libqos/i2c-omap.c
index 1ef6e7b200..c4fefb64a8 100644
--- a/tests/libqos/i2c-omap.c
+++ b/tests/libqos/i2c-omap.c
@@ -51,8 +51,8 @@ static void omap_i2c_set_slave_addr(OMAPI2C *s, uint8_t addr)
 {
     uint16_t data = addr;

-    qtest_writew(s->parent.qts, s->addr + OMAP_I2C_SA, data);
-    data = qtest_readw(s->parent.qts, s->addr + OMAP_I2C_SA);
+    writew(s->parent.qts, s->addr + OMAP_I2C_SA, data);
+    data = readw(s->parent.qts, s->addr + OMAP_I2C_SA);
     g_assert_cmphex(data, ==, addr);
 }

@@ -65,38 +65,38 @@ static void omap_i2c_send(I2CAdapter *i2c, uint8_t addr,
     omap_i2c_set_slave_addr(s, addr);

     data = len;
-    qtest_writew(i2c->qts, s->addr + OMAP_I2C_CNT, data);
+    writew(i2c->qts, s->addr + OMAP_I2C_CNT, data);

     data = OMAP_I2C_CON_I2C_EN |
            OMAP_I2C_CON_TRX |
            OMAP_I2C_CON_MST |
            OMAP_I2C_CON_STT |
            OMAP_I2C_CON_STP;
-    qtest_writew(i2c->qts, s->addr + OMAP_I2C_CON, data);
-    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CON);
+    writew(i2c->qts, s->addr + OMAP_I2C_CON, data);
+    data = readw(i2c->qts, s->addr + OMAP_I2C_CON);
     g_assert((data & OMAP_I2C_CON_STP) != 0);

-    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
+    data = readw(i2c->qts, s->addr + OMAP_I2C_STAT);
     g_assert((data & OMAP_I2C_STAT_NACK) == 0);

     while (len > 1) {
-        data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
+        data = readw(i2c->qts, s->addr + OMAP_I2C_STAT);
         g_assert((data & OMAP_I2C_STAT_XRDY) != 0);

         data = buf[0] | ((uint16_t)buf[1] << 8);
-        qtest_writew(i2c->qts, s->addr + OMAP_I2C_DATA, data);
+        writew(i2c->qts, s->addr + OMAP_I2C_DATA, data);
         buf = (uint8_t *)buf + 2;
         len -= 2;
     }
     if (len == 1) {
-        data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
+        data = readw(i2c->qts, s->addr + OMAP_I2C_STAT);
         g_assert((data & OMAP_I2C_STAT_XRDY) != 0);

         data = buf[0];
-        qtest_writew(i2c->qts, s->addr + OMAP_I2C_DATA, data);
+        writew(i2c->qts, s->addr + OMAP_I2C_DATA, data);
     }

-    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CON);
+    data = readw(i2c->qts, s->addr + OMAP_I2C_CON);
     g_assert((data & OMAP_I2C_CON_STP) == 0);
 }

@@ -109,30 +109,30 @@ static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
     omap_i2c_set_slave_addr(s, addr);

     data = len;
-    qtest_writew(i2c->qts, s->addr + OMAP_I2C_CNT, data);
+    writew(i2c->qts, s->addr + OMAP_I2C_CNT, data);

     data = OMAP_I2C_CON_I2C_EN |
            OMAP_I2C_CON_MST |
            OMAP_I2C_CON_STT |
            OMAP_I2C_CON_STP;
-    qtest_writew(i2c->qts, s->addr + OMAP_I2C_CON, data);
-    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CON);
+    writew(i2c->qts, s->addr + OMAP_I2C_CON, data);
+    data = readw(i2c->qts, s->addr + OMAP_I2C_CON);
     g_assert((data & OMAP_I2C_CON_STP) == 0);

-    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
+    data = readw(i2c->qts, s->addr + OMAP_I2C_STAT);
     g_assert((data & OMAP_I2C_STAT_NACK) == 0);

-    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CNT);
+    data = readw(i2c->qts, s->addr + OMAP_I2C_CNT);
     g_assert_cmpuint(data, ==, len);

     while (len > 0) {
-        data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
+        data = readw(i2c->qts, s->addr + OMAP_I2C_STAT);
         g_assert((data & OMAP_I2C_STAT_RRDY) != 0);
         g_assert((data & OMAP_I2C_STAT_ROVR) == 0);

-        data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_DATA);
+        data = readw(i2c->qts, s->addr + OMAP_I2C_DATA);

-        stat = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
+        stat = readw(i2c->qts, s->addr + OMAP_I2C_STAT);

         if (unlikely(len == 1)) {
             g_assert((stat & OMAP_I2C_STAT_SBD) != 0);
@@ -148,7 +148,7 @@ static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
         }
     }

-    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CON);
+    data = readw(i2c->qts, s->addr + OMAP_I2C_CON);
     g_assert((data & OMAP_I2C_CON_STP) == 0);
 }

@@ -165,7 +165,7 @@ I2CAdapter *omap_i2c_create(QTestState *qts, uint64_t addr)
     i2c->qts = qts;

     /* verify the mmio address by looking for a known signature */
-    data = qtest_readw(qts, addr + OMAP_I2C_REV);
+    data = readw(qts, addr + OMAP_I2C_REV);
     g_assert_cmphex(data, ==, 0x34);

     return i2c;
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index 4c29889b0b..7bae94e9bd 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -45,49 +45,49 @@ typedef struct QPCIBusSPAPR {
 static uint8_t qpci_spapr_pio_readb(QPCIBus *bus, uint32_t addr)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    return qtest_readb(bus->qts, s->pio_cpu_base + addr);
+    return readb(bus->qts, s->pio_cpu_base + addr);
 }

 static void qpci_spapr_pio_writeb(QPCIBus *bus, uint32_t addr, uint8_t val)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    qtest_writeb(bus->qts, s->pio_cpu_base + addr, val);
+    writeb(bus->qts, s->pio_cpu_base + addr, val);
 }

 static uint16_t qpci_spapr_pio_readw(QPCIBus *bus, uint32_t addr)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    return bswap16(qtest_readw(bus->qts, s->pio_cpu_base + addr));
+    return bswap16(readw(bus->qts, s->pio_cpu_base + addr));
 }

 static void qpci_spapr_pio_writew(QPCIBus *bus, uint32_t addr, uint16_t val)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    qtest_writew(bus->qts, s->pio_cpu_base + addr, bswap16(val));
+    writew(bus->qts, s->pio_cpu_base + addr, bswap16(val));
 }

 static uint32_t qpci_spapr_pio_readl(QPCIBus *bus, uint32_t addr)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    return bswap32(qtest_readl(bus->qts, s->pio_cpu_base + addr));
+    return bswap32(readl(bus->qts, s->pio_cpu_base + addr));
 }

 static void qpci_spapr_pio_writel(QPCIBus *bus, uint32_t addr, uint32_t val)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    qtest_writel(bus->qts, s->pio_cpu_base + addr, bswap32(val));
+    writel(bus->qts, s->pio_cpu_base + addr, bswap32(val));
 }

 static uint64_t qpci_spapr_pio_readq(QPCIBus *bus, uint32_t addr)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    return bswap64(qtest_readq(bus->qts, s->pio_cpu_base + addr));
+    return bswap64(readq(bus->qts, s->pio_cpu_base + addr));
 }

 static void qpci_spapr_pio_writeq(QPCIBus *bus, uint32_t addr, uint64_t val)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    qtest_writeq(bus->qts, s->pio_cpu_base + addr, bswap64(val));
+    writeq(bus->qts, s->pio_cpu_base + addr, bswap64(val));
 }

 static void qpci_spapr_memread(QPCIBus *bus, uint32_t addr,
diff --git a/tests/libqos/rtas.c b/tests/libqos/rtas.c
index d81ff4274d..fd5d34364e 100644
--- a/tests/libqos/rtas.c
+++ b/tests/libqos/rtas.c
@@ -13,7 +13,7 @@ static void qrtas_copy_args(QTestState *qts, uint64_t target_args,
     int i;

     for (i = 0; i < nargs; i++) {
-        qtest_writel(qts, target_args + i * sizeof(uint32_t), args[i]);
+        writel(qts, target_args + i * sizeof(uint32_t), args[i]);
     }
 }

@@ -23,7 +23,7 @@ static void qrtas_copy_ret(QTestState *qts, uint64_t target_ret,
     int i;

     for (i = 0; i < nret; i++) {
-        ret[i] = qtest_readl(qts, target_ret + i * sizeof(uint32_t));
+        ret[i] = readl(qts, target_ret + i * sizeof(uint32_t));
     }
 }

diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 8d256f6ac9..b2a5b63494 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -18,45 +18,40 @@
 static uint8_t qvirtio_mmio_config_readb(QVirtioDevice *d, uint64_t off)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return qtest_readb(d->bus->qts,
-                       dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    return readb(d->bus->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }

 static uint16_t qvirtio_mmio_config_readw(QVirtioDevice *d, uint64_t off)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return qtest_readw(d->bus->qts,
-                       dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    return readw(d->bus->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }

 static uint32_t qvirtio_mmio_config_readl(QVirtioDevice *d, uint64_t off)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return qtest_readl(d->bus->qts,
-                       dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    return readl(d->bus->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }

 static uint64_t qvirtio_mmio_config_readq(QVirtioDevice *d, uint64_t off)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return qtest_readq(d->bus->qts,
-                       dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    return readq(d->bus->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }

 static uint32_t qvirtio_mmio_get_features(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL, 0);
-    return qtest_readl(d->bus->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES);
+    writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL, 0);
+    return readl(d->bus->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES);
 }

 static void qvirtio_mmio_set_features(QVirtioDevice *d, uint32_t features)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
     dev->features = features;
-    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SEL, 0);
-    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES,
-                 features);
+    writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SEL, 0);
+    writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES, features);
 }

 static uint32_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
@@ -68,13 +63,13 @@ static uint32_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
 static uint8_t qvirtio_mmio_get_status(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return qtest_readl(d->bus->qts, dev->addr + QVIRTIO_MMIO_DEVICE_STATUS);
+    return readl(d->bus->qts, dev->addr + QVIRTIO_MMIO_DEVICE_STATUS);
 }

 static void qvirtio_mmio_set_status(QVirtioDevice *d, uint8_t status)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_DEVICE_STATUS, status);
+    writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_DEVICE_STATUS, status);
 }

 static bool qvirtio_mmio_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
@@ -82,10 +77,9 @@ static bool qvirtio_mmio_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
     uint32_t isr;

-    isr = qtest_readl(d->bus->qts,
-                      dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 1;
+    isr = readl(d->bus->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 1;
     if (isr != 0) {
-        qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 1);
+        writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 1);
         return true;
     }

@@ -97,10 +91,9 @@ static bool qvirtio_mmio_get_config_isr_status(QVirtioDevice *d)
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
     uint32_t isr;

-    isr = qtest_readl(d->bus->qts,
-                      dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 2;
+    isr = readl(d->bus->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 2;
     if (isr != 0) {
-        qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 2);
+        writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 2);
         return true;
     }

@@ -110,22 +103,22 @@ static bool qvirtio_mmio_get_config_isr_status(QVirtioDevice *d)
 static void qvirtio_mmio_queue_select(QVirtioDevice *d, uint16_t index)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_SEL, index);
+    writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_SEL, index);

-    g_assert_cmphex(qtest_readl(d->bus->qts,
-                                dev->addr + QVIRTIO_MMIO_QUEUE_PFN), ==, 0);
+    g_assert_cmphex(readl(d->bus->qts,
+                          dev->addr + QVIRTIO_MMIO_QUEUE_PFN), ==, 0);
 }

 static uint16_t qvirtio_mmio_get_queue_size(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return qtest_readl(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NUM_MAX);
+    return readl(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NUM_MAX);
 }

 static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, uint32_t pfn)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
+    writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
 }

 static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
@@ -137,8 +130,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,

     vq = g_malloc0(sizeof(*vq));
     qvirtio_mmio_queue_select(d, index);
-    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_ALIGN,
-                 dev->page_size);
+    writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_ALIGN, dev->page_size);

     vq->dev = d;
     vq->index = index;
@@ -149,7 +141,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
     vq->indirect = (dev->features & (1u << VIRTIO_RING_F_INDIRECT_DESC)) != 0;
     vq->event = (dev->features & (1u << VIRTIO_RING_F_EVENT_IDX)) != 0;

-    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NUM, vq->size);
+    writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NUM, vq->size);

     /* Check different than 0 */
     g_assert_cmpint(vq->size, !=, 0);
@@ -174,7 +166,7 @@ static void qvirtio_mmio_virtqueue_cleanup(QVirtQueue *vq,
 static void qvirtio_mmio_virtqueue_kick(QVirtioDevice *d, QVirtQueue *vq)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NOTIFY, vq->index);
+    writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NOTIFY, vq->index);
 }

 const QVirtioBus qvirtio_mmio = {
@@ -204,15 +196,15 @@ QVirtioMMIODevice *qvirtio_mmio_init_device(QTestState *qts, uint64_t addr,
     uint32_t magic;
     dev = g_malloc0(sizeof(*dev));

-    magic = qtest_readl(qts, addr + QVIRTIO_MMIO_MAGIC_VALUE);
+    magic = readl(qts, addr + QVIRTIO_MMIO_MAGIC_VALUE);
     g_assert(magic == ('v' | 'i' << 8 | 'r' << 16 | 't' << 24));

     dev->addr = addr;
     dev->page_size = page_size;
-    dev->vdev.device_type = qtest_readl(qts, addr + QVIRTIO_MMIO_DEVICE_ID);
+    dev->vdev.device_type = readl(qts, addr + QVIRTIO_MMIO_DEVICE_ID);
     dev->vdev.bus = qvirtio_init_bus(qts, &qvirtio_mmio);

-    qtest_writel(qts, addr + QVIRTIO_MMIO_GUEST_PAGE_SIZE, page_size);
+    writel(qts, addr + QVIRTIO_MMIO_GUEST_PAGE_SIZE, page_size);

     return dev;
 }
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index a7b17b3ba2..ef7d6da153 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -168,9 +168,9 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
         } else {
-            data = qtest_readl(d->bus->qts, vqpci->msix_addr);
+            data = readl(d->bus->qts, vqpci->msix_addr);
             if (data == vqpci->msix_data) {
-                qtest_writel(d->bus->qts, vqpci->msix_addr, 0);
+                writel(d->bus->qts, vqpci->msix_addr, 0);
                 return true;
             } else {
                 return false;
@@ -192,9 +192,9 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
         } else {
-            data = qtest_readl(d->bus->qts, dev->config_msix_addr);
+            data = readl(d->bus->qts, dev->config_msix_addr);
             if (data == dev->config_msix_data) {
-                qtest_writel(d->bus->qts, dev->config_msix_addr, 0);
+                writel(d->bus->qts, dev->config_msix_addr, 0);
                 return true;
             } else {
                 return false;
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 92e47e78f2..e5252052d9 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -118,7 +118,7 @@ uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
     gint64 start_time = g_get_monotonic_time();
     uint8_t val;

-    while ((val = qtest_readb(d->bus->qts, addr)) == 0xff) {
+    while ((val = readb(d->bus->qts, addr)) == 0xff) {
         clock_step(d->bus->qts, 100);
         g_assert(!d->bus->get_queue_isr_status(d, vq));
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
@@ -179,23 +179,23 @@ void qvring_init(const QGuestAllocator *alloc, QVirtQueue *vq, uint64_t addr)

     for (i = 0; i < vq->size - 1; i++) {
         /* vq->desc[i].addr */
-        qtest_writeq(vq->dev->bus->qts, vq->desc + (16 * i), 0);
+        writeq(vq->dev->bus->qts, vq->desc + (16 * i), 0);
         /* vq->desc[i].next */
-        qtest_writew(vq->dev->bus->qts, vq->desc + (16 * i) + 14, i + 1);
+        writew(vq->dev->bus->qts, vq->desc + (16 * i) + 14, i + 1);
     }

     /* vq->avail->flags */
-    qtest_writew(vq->dev->bus->qts, vq->avail, 0);
+    writew(vq->dev->bus->qts, vq->avail, 0);
     /* vq->avail->idx */
-    qtest_writew(vq->dev->bus->qts, vq->avail + 2, 0);
+    writew(vq->dev->bus->qts, vq->avail + 2, 0);
     /* vq->avail->used_event */
-    qtest_writew(vq->dev->bus->qts, vq->avail + 4 + (2 * vq->size), 0);
+    writew(vq->dev->bus->qts, vq->avail + 4 + (2 * vq->size), 0);

     /* vq->used->flags */
-    qtest_writew(vq->dev->bus->qts, vq->used, 0);
+    writew(vq->dev->bus->qts, vq->used, 0);
     /* vq->used->avail_event */
-    qtest_writew(vq->dev->bus->qts,
-                 vq->used + 2 + sizeof(struct vring_used_elem) * vq->size, 0);
+    writew(vq->dev->bus->qts,
+           vq->used + 2 + sizeof(struct vring_used_elem) * vq->size, 0);
 }

 QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
@@ -210,12 +210,11 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,

     for (i = 0; i < elem - 1; ++i) {
         /* indirect->desc[i].addr */
-        qtest_writeq(d->bus->qts, indirect->desc + (16 * i), 0);
+        writeq(d->bus->qts, indirect->desc + (16 * i), 0);
         /* indirect->desc[i].flags */
-        qtest_writew(d->bus->qts, indirect->desc + (16 * i) + 12,
-                     VRING_DESC_F_NEXT);
+        writew(d->bus->qts, indirect->desc + (16 * i) + 12, VRING_DESC_F_NEXT);
         /* indirect->desc[i].next */
-        qtest_writew(d->bus->qts, indirect->desc + (16 * i) + 14, i + 1);
+        writew(d->bus->qts, indirect->desc + (16 * i) + 14, i + 1);
     }

     return indirect;
@@ -228,18 +227,18 @@ void qvring_indirect_desc_add(QTestState *qts, QVRingIndirectDesc *indirect,

     g_assert_cmpint(indirect->index, <, indirect->elem);

-    flags = qtest_readw(qts, indirect->desc + (16 * indirect->index) + 12);
+    flags = readw(qts, indirect->desc + (16 * indirect->index) + 12);

     if (write) {
         flags |= VRING_DESC_F_WRITE;
     }

     /* indirect->desc[indirect->index].addr */
-    qtest_writeq(qts, indirect->desc + (16 * indirect->index), data);
+    writeq(qts, indirect->desc + (16 * indirect->index), data);
     /* indirect->desc[indirect->index].len */
-    qtest_writel(qts, indirect->desc + (16 * indirect->index) + 8, len);
+    writel(qts, indirect->desc + (16 * indirect->index) + 8, len);
     /* indirect->desc[indirect->index].flags */
-    qtest_writew(qts, indirect->desc + (16 * indirect->index) + 12, flags);
+    writew(qts, indirect->desc + (16 * indirect->index) + 12, flags);

     indirect->index++;
 }
@@ -259,12 +258,11 @@ uint32_t qvirtqueue_add(QVirtQueue *vq, uint64_t data, uint32_t len, bool write,
     }

     /* vq->desc[vq->free_head].addr */
-    qtest_writeq(vq->dev->bus->qts, vq->desc + (16 * vq->free_head), data);
+    writeq(vq->dev->bus->qts, vq->desc + (16 * vq->free_head), data);
     /* vq->desc[vq->free_head].len */
-    qtest_writel(vq->dev->bus->qts, vq->desc + (16 * vq->free_head) + 8, len);
+    writel(vq->dev->bus->qts, vq->desc + (16 * vq->free_head) + 8, len);
     /* vq->desc[vq->free_head].flags */
-    qtest_writew(vq->dev->bus->qts, vq->desc + (16 * vq->free_head) + 12,
-                 flags);
+    writew(vq->dev->bus->qts, vq->desc + (16 * vq->free_head) + 12, flags);

     return vq->free_head++; /* Return and increase, in this order */
 }
@@ -278,14 +276,13 @@ uint32_t qvirtqueue_add_indirect(QVirtQueue *vq, QVRingIndirectDesc *indirect)
     vq->num_free--;

     /* vq->desc[vq->free_head].addr */
-    qtest_writeq(vq->dev->bus->qts, vq->desc + (16 * vq->free_head),
-                 indirect->desc);
+    writeq(vq->dev->bus->qts, vq->desc + (16 * vq->free_head), indirect->desc);
     /* vq->desc[vq->free_head].len */
-    qtest_writel(vq->dev->bus->qts, vq->desc + (16 * vq->free_head) + 8,
-                 sizeof(struct vring_desc) * indirect->elem);
+    writel(vq->dev->bus->qts, vq->desc + (16 * vq->free_head) + 8,
+           sizeof(struct vring_desc) * indirect->elem);
     /* vq->desc[vq->free_head].flags */
-    qtest_writew(vq->dev->bus->qts,
-                 vq->desc + (16 * vq->free_head) + 12, VRING_DESC_F_INDIRECT);
+    writew(vq->dev->bus->qts,
+           vq->desc + (16 * vq->free_head) + 12, VRING_DESC_F_INDIRECT);

     return vq->free_head++; /* Return and increase, in this order */
 }
@@ -293,7 +290,7 @@ uint32_t qvirtqueue_add_indirect(QVirtQueue *vq, QVRingIndirectDesc *indirect)
 void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head)
 {
     /* vq->avail->idx */
-    uint16_t idx = qtest_readw(d->bus->qts, vq->avail + 2);
+    uint16_t idx = readw(d->bus->qts, vq->avail + 2);
     /* vq->used->flags */
     uint16_t flags;
     /* vq->used->avail_event */
@@ -302,15 +299,14 @@ void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head)
     assert(vq->dev == d);

     /* vq->avail->ring[idx % vq->size] */
-    qtest_writew(d->bus->qts, vq->avail + 4 + (2 * (idx % vq->size)),
-                 free_head);
+    writew(d->bus->qts, vq->avail + 4 + (2 * (idx % vq->size)), free_head);
     /* vq->avail->idx */
-    qtest_writew(d->bus->qts, vq->avail + 2, idx + 1);
+    writew(d->bus->qts, vq->avail + 2, idx + 1);

     /* Must read after idx is updated */
-    flags = qtest_readw(d->bus->qts, vq->avail);
-    avail_event = qtest_readw(d->bus->qts, vq->used + 4 +
-                              sizeof(struct vring_used_elem) * vq->size);
+    flags = readw(d->bus->qts, vq->avail);
+    avail_event = readw(d->bus->qts, vq->used + 4 +
+                        sizeof(struct vring_used_elem) * vq->size);

     /* < 1 because we add elements to avail queue one by one */
     if ((flags & VRING_USED_F_NO_NOTIFY) == 0 &&
@@ -331,8 +327,7 @@ bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx)
 {
     uint16_t idx;

-    idx = qtest_readw(vq->dev->bus->qts,
-                      vq->used + offsetof(struct vring_used, idx));
+    idx = readw(vq->dev->bus->qts, vq->used + offsetof(struct vring_used, idx));
     if (idx == vq->last_used_idx) {
         return false;
     }
@@ -344,8 +339,8 @@ bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx)
                     offsetof(struct vring_used, ring) +
                     (vq->last_used_idx % vq->size) *
                     sizeof(struct vring_used_elem);
-        *desc_idx = qtest_readl(vq->dev->bus->qts, elem_addr +
-                                offsetof(struct vring_used_elem, id));
+        *desc_idx = readl(vq->dev->bus->qts, elem_addr +
+                          offsetof(struct vring_used_elem, id));
     }

     vq->last_used_idx++;
@@ -357,5 +352,5 @@ void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx)
     g_assert(vq->event);

     /* vq->avail->used_event */
-    qtest_writew(vq->dev->bus->qts, vq->avail + 4 + (2 * vq->size), idx);
+    writew(vq->dev->bus->qts, vq->avail + 4 + (2 * vq->size), idx);
 }
diff --git a/tests/m25p80-test.c b/tests/m25p80-test.c
index c276e738e9..a480776bb5 100644
--- a/tests/m25p80-test.c
+++ b/tests/m25p80-test.c
@@ -75,53 +75,53 @@ static inline uint32_t make_be32(uint32_t data)

 static void spi_conf(uint32_t value)
 {
-    uint32_t conf = readl(ASPEED_FMC_BASE + R_CONF);
+    uint32_t conf = readl(global_qtest, ASPEED_FMC_BASE + R_CONF);

     conf |= value;
-    writel(ASPEED_FMC_BASE + R_CONF, conf);
+    writel(global_qtest, ASPEED_FMC_BASE + R_CONF, conf);
 }

 static void spi_conf_remove(uint32_t value)
 {
-    uint32_t conf = readl(ASPEED_FMC_BASE + R_CONF);
+    uint32_t conf = readl(global_qtest, ASPEED_FMC_BASE + R_CONF);

     conf &= ~value;
-    writel(ASPEED_FMC_BASE + R_CONF, conf);
+    writel(global_qtest, ASPEED_FMC_BASE + R_CONF, conf);
 }

 static void spi_ce_ctrl(uint32_t value)
 {
-    uint32_t conf = readl(ASPEED_FMC_BASE + R_CE_CTRL);
+    uint32_t conf = readl(global_qtest, ASPEED_FMC_BASE + R_CE_CTRL);

     conf |= value;
-    writel(ASPEED_FMC_BASE + R_CE_CTRL, conf);
+    writel(global_qtest, ASPEED_FMC_BASE + R_CE_CTRL, conf);
 }

 static void spi_ctrl_setmode(uint8_t mode, uint8_t cmd)
 {
-    uint32_t ctrl = readl(ASPEED_FMC_BASE + R_CTRL0);
+    uint32_t ctrl = readl(global_qtest, ASPEED_FMC_BASE + R_CTRL0);
     ctrl &= ~(CTRL_USERMODE | 0xff << 16);
     ctrl |= mode | (cmd << 16);
-    writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
+    writel(global_qtest, ASPEED_FMC_BASE + R_CTRL0, ctrl);
 }

 static void spi_ctrl_start_user(void)
 {
-    uint32_t ctrl = readl(ASPEED_FMC_BASE + R_CTRL0);
+    uint32_t ctrl = readl(global_qtest, ASPEED_FMC_BASE + R_CTRL0);

     ctrl |= CTRL_USERMODE | CTRL_CE_STOP_ACTIVE;
-    writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
+    writel(global_qtest, ASPEED_FMC_BASE + R_CTRL0, ctrl);

     ctrl &= ~CTRL_CE_STOP_ACTIVE;
-    writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
+    writel(global_qtest, ASPEED_FMC_BASE + R_CTRL0, ctrl);
 }

 static void spi_ctrl_stop_user(void)
 {
-    uint32_t ctrl = readl(ASPEED_FMC_BASE + R_CTRL0);
+    uint32_t ctrl = readl(global_qtest, ASPEED_FMC_BASE + R_CTRL0);

     ctrl |= CTRL_USERMODE | CTRL_CE_STOP_ACTIVE;
-    writel(ASPEED_FMC_BASE + R_CTRL0, ctrl);
+    writel(global_qtest, ASPEED_FMC_BASE + R_CTRL0, ctrl);
 }

 static void flash_reset(void)
@@ -129,8 +129,8 @@ static void flash_reset(void)
     spi_conf(CONF_ENABLE_W0);

     spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, RESET_ENABLE);
-    writeb(ASPEED_FLASH_BASE, RESET_MEMORY);
+    writeb(global_qtest, ASPEED_FLASH_BASE, RESET_ENABLE);
+    writeb(global_qtest, ASPEED_FLASH_BASE, RESET_MEMORY);
     spi_ctrl_stop_user();

     spi_conf_remove(CONF_ENABLE_W0);
@@ -143,10 +143,10 @@ static void test_read_jedec(void)
     spi_conf(CONF_ENABLE_W0);

     spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, JEDEC_READ);
-    jedec |= readb(ASPEED_FLASH_BASE) << 16;
-    jedec |= readb(ASPEED_FLASH_BASE) << 8;
-    jedec |= readb(ASPEED_FLASH_BASE);
+    writeb(global_qtest, ASPEED_FLASH_BASE, JEDEC_READ);
+    jedec |= readb(global_qtest, ASPEED_FLASH_BASE) << 16;
+    jedec |= readb(global_qtest, ASPEED_FLASH_BASE) << 8;
+    jedec |= readb(global_qtest, ASPEED_FLASH_BASE);
     spi_ctrl_stop_user();

     flash_reset();
@@ -160,13 +160,13 @@ static void read_page(uint32_t addr, uint32_t *page)

     spi_ctrl_start_user();

-    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-    writeb(ASPEED_FLASH_BASE, READ);
-    writel(ASPEED_FLASH_BASE, make_be32(addr));
+    writeb(global_qtest, ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
+    writeb(global_qtest, ASPEED_FLASH_BASE, READ);
+    writel(global_qtest, ASPEED_FLASH_BASE, make_be32(addr));

     /* Continuous read are supported */
     for (i = 0; i < PAGE_SIZE / 4; i++) {
-        page[i] = make_be32(readl(ASPEED_FLASH_BASE));
+        page[i] = make_be32(readl(global_qtest, ASPEED_FLASH_BASE));
     }
     spi_ctrl_stop_user();
 }
@@ -179,7 +179,8 @@ static void read_page_mem(uint32_t addr, uint32_t *page)
     spi_ctrl_setmode(CTRL_READMODE, READ);

     for (i = 0; i < PAGE_SIZE / 4; i++) {
-        page[i] = make_be32(readl(ASPEED_FLASH_BASE + addr + i * 4));
+        page[i] = make_be32(readl(global_qtest,
+                                  ASPEED_FLASH_BASE + addr + i * 4));
     }
 }

@@ -192,10 +193,10 @@ static void test_erase_sector(void)
     spi_conf(CONF_ENABLE_W0);

     spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, WREN);
-    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-    writeb(ASPEED_FLASH_BASE, ERASE_SECTOR);
-    writel(ASPEED_FLASH_BASE, make_be32(some_page_addr));
+    writeb(global_qtest, ASPEED_FLASH_BASE, WREN);
+    writeb(global_qtest, ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
+    writeb(global_qtest, ASPEED_FLASH_BASE, ERASE_SECTOR);
+    writel(global_qtest, ASPEED_FLASH_BASE, make_be32(some_page_addr));
     spi_ctrl_stop_user();

     /* Previous page should be full of zeroes as backend is not
@@ -230,8 +231,8 @@ static void test_erase_all(void)
     }

     spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, WREN);
-    writeb(ASPEED_FLASH_BASE, BULK_ERASE);
+    writeb(global_qtest, ASPEED_FLASH_BASE, WREN);
+    writeb(global_qtest, ASPEED_FLASH_BASE, BULK_ERASE);
     spi_ctrl_stop_user();

     /* Recheck that some random page */
@@ -253,14 +254,15 @@ static void test_write_page(void)
     spi_conf(CONF_ENABLE_W0);

     spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-    writeb(ASPEED_FLASH_BASE, WREN);
-    writeb(ASPEED_FLASH_BASE, PP);
-    writel(ASPEED_FLASH_BASE, make_be32(my_page_addr));
+    writeb(global_qtest, ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
+    writeb(global_qtest, ASPEED_FLASH_BASE, WREN);
+    writeb(global_qtest, ASPEED_FLASH_BASE, PP);
+    writel(global_qtest, ASPEED_FLASH_BASE, make_be32(my_page_addr));

     /* Fill the page with its own addresses */
     for (i = 0; i < PAGE_SIZE / 4; i++) {
-        writel(ASPEED_FLASH_BASE, make_be32(my_page_addr + i * 4));
+        writel(global_qtest, ASPEED_FLASH_BASE,
+               make_be32(my_page_addr + i * 4));
     }
     spi_ctrl_stop_user();

@@ -294,7 +296,7 @@ static void test_read_page_mem(void)
     /* Enable 4BYTE mode for flash. */
     spi_conf(CONF_ENABLE_W0);
     spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
+    writeb(global_qtest, ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
     spi_ctrl_stop_user();
     spi_conf_remove(CONF_ENABLE_W0);

@@ -327,15 +329,15 @@ static void test_write_page_mem(void)
     /* Enable 4BYTE mode for flash. */
     spi_conf(CONF_ENABLE_W0);
     spi_ctrl_start_user();
-    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
-    writeb(ASPEED_FLASH_BASE, WREN);
+    writeb(global_qtest, ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
+    writeb(global_qtest, ASPEED_FLASH_BASE, WREN);
     spi_ctrl_stop_user();

     /* move out USER mode to use direct writes to the AHB bus */
     spi_ctrl_setmode(CTRL_WRITEMODE, PP);

     for (i = 0; i < PAGE_SIZE / 4; i++) {
-        writel(ASPEED_FLASH_BASE + my_page_addr + i * 4,
+        writel(global_qtest, ASPEED_FLASH_BASE + my_page_addr + i * 4,
                make_be32(my_page_addr + i * 4));
     }

diff --git a/tests/m48t59-test.c b/tests/m48t59-test.c
index 7ef3e2d26a..6218995d62 100644
--- a/tests/m48t59-test.c
+++ b/tests/m48t59-test.c
@@ -32,14 +32,14 @@ static bool use_mmio;

 static uint8_t cmos_read_mmio(uint8_t reg)
 {
-    return readb(base + (uint32_t)reg_base + (uint32_t)reg);
+    return readb(global_qtest, base + (uint32_t)reg_base + (uint32_t)reg);
 }

 static void cmos_write_mmio(uint8_t reg, uint8_t val)
 {
     uint8_t data = val;

-    writeb(base + (uint32_t)reg_base + (uint32_t)reg, data);
+    writeb(global_qtest, base + (uint32_t)reg_base + (uint32_t)reg, data);
 }

 static uint8_t cmos_read_ioio(uint8_t reg)
diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 89fa6282d3..52a2cc2f82 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -69,7 +69,7 @@ static uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)

 static uint64_t pnv_xscom_read(const PnvChip *chip, uint32_t pcba)
 {
-    return readq(pnv_xscom_addr(chip, pcba));
+    return readq(global_qtest, pnv_xscom_addr(chip, pcba));
 }

 static void test_xscom_cfam_id(const PnvChip *chip)
diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index 0f8e6950fd..567d5a241d 100644
--- a/tests/prom-env-test.c
+++ b/tests/prom-env-test.c
@@ -32,7 +32,7 @@ static void check_guest_memory(void)

     /* Poll until code has run and modified memory. Wait at most 120 seconds */
     for (i = 0; i < 12000; ++i) {
-        signature = readl(ADDRESS);
+        signature = readl(global_qtest, ADDRESS);
         if (signature == MAGIC) {
             break;
         }
diff --git a/tests/q35-test.c b/tests/q35-test.c
index 4d90b9174e..fc2ecd43c9 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -174,14 +174,14 @@ static void test_tseg_size(const void *data)
      */
     ram_offs = (TSEG_SIZE_TEST_GUEST_RAM_MBYTES - args->expected_tseg_mbytes) *
                1024 * 1024 - 1;
-    g_assert_cmpint(readb(ram_offs), ==, 0);
-    writeb(ram_offs, 1);
-    g_assert_cmpint(readb(ram_offs), ==, 1);
+    g_assert_cmpint(readb(global_qtest, ram_offs), ==, 0);
+    writeb(global_qtest, ram_offs, 1);
+    g_assert_cmpint(readb(global_qtest, ram_offs), ==, 1);

     ram_offs++;
-    g_assert_cmpint(readb(ram_offs), ==, 0xff);
-    writeb(ram_offs, 1);
-    g_assert_cmpint(readb(ram_offs), ==, 0xff);
+    g_assert_cmpint(readb(global_qtest, ram_offs), ==, 0xff);
+    writeb(global_qtest, ram_offs, 1);
+    g_assert_cmpint(readb(global_qtest, ram_offs), ==, 0xff);

     g_free(pcidev);
     qpci_free_pc(pcibus);
diff --git a/tests/tco-test.c b/tests/tco-test.c
index c2abbeeaac..1cf7362d83 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -117,13 +117,13 @@ static void reset_on_second_timeout(bool enable)
 {
     uint32_t val;

-    val = readl(RCBA_BASE_ADDR + ICH9_CC_GCS);
+    val = readl(global_qtest, RCBA_BASE_ADDR + ICH9_CC_GCS);
     if (enable) {
         val &= ~ICH9_CC_GCS_NO_REBOOT;
     } else {
         val |= ICH9_CC_GCS_NO_REBOOT;
     }
-    writel(RCBA_BASE_ADDR + ICH9_CC_GCS, val);
+    writel(global_qtest, RCBA_BASE_ADDR + ICH9_CC_GCS, val);
 }

 static void test_tco_defaults(void)
diff --git a/tests/test-arm-mptimer.c b/tests/test-arm-mptimer.c
index 0e6484a4a8..0b6b514271 100644
--- a/tests/test-arm-mptimer.c
+++ b/tests/test-arm-mptimer.c
@@ -38,7 +38,7 @@ static int scaled = 122;

 static void timer_load(uint32_t load)
 {
-    writel(TIMER_BASE_PHYS + TIMER_LOAD, load);
+    writel(global_qtest, TIMER_BASE_PHYS + TIMER_LOAD, load);
 }

 static void timer_start(int periodic, uint32_t scale)
@@ -49,17 +49,17 @@ static void timer_start(int periodic, uint32_t scale)
         ctl |= TIMER_CONTROL_PERIODIC;
     }

-    writel(TIMER_BASE_PHYS + TIMER_CONTROL, ctl);
+    writel(global_qtest, TIMER_BASE_PHYS + TIMER_CONTROL, ctl);
 }

 static void timer_stop(void)
 {
-    writel(TIMER_BASE_PHYS + TIMER_CONTROL, 0);
+    writel(global_qtest, TIMER_BASE_PHYS + TIMER_CONTROL, 0);
 }

 static void timer_int_clr(void)
 {
-    writel(TIMER_BASE_PHYS + TIMER_INTSTAT, 1);
+    writel(global_qtest, TIMER_BASE_PHYS + TIMER_INTSTAT, 1);
 }

 static void timer_reset(void)
@@ -71,7 +71,7 @@ static void timer_reset(void)

 static uint32_t timer_get_and_clr_int_sts(void)
 {
-    uint32_t int_sts = readl(TIMER_BASE_PHYS + TIMER_INTSTAT);
+    uint32_t int_sts = readl(global_qtest, TIMER_BASE_PHYS + TIMER_INTSTAT);

     if (int_sts) {
         timer_int_clr();
@@ -82,12 +82,12 @@ static uint32_t timer_get_and_clr_int_sts(void)

 static uint32_t timer_counter(void)
 {
-    return readl(TIMER_BASE_PHYS + TIMER_COUNTER);
+    return readl(global_qtest, TIMER_BASE_PHYS + TIMER_COUNTER);
 }

 static void timer_set_counter(uint32_t value)
 {
-    writel(TIMER_BASE_PHYS + TIMER_COUNTER, value);
+    writel(global_qtest, TIMER_BASE_PHYS + TIMER_COUNTER, value);
 }

 static void test_timer_oneshot(gconstpointer arg)
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index c205a9100a..580ad43fad 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -241,7 +241,7 @@ static void read_guest_mem(const void *data)
         for (j = 0; j < 256; j++) {
             uint32_t a, b;

-            a = qtest_readl(s->qts,
+            a = readl(s->qts,
                             s->memory.regions[i].guest_phys_addr + j * 4);
             b = guest_mem[j];

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 9594fbf437..5f8606ea80 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -195,7 +195,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
     qvirtqueue_kick(dev, vq, free_head);

     qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_BLK_TIMEOUT_US);
-    status = readb(req_addr + 528);
+    status = readb(global_qtest, req_addr + 528);
     g_assert_cmpint(status, ==, 0);

     guest_free(alloc, req_addr);
@@ -217,7 +217,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
     qvirtqueue_kick(dev, vq, free_head);

     qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_BLK_TIMEOUT_US);
-    status = readb(req_addr + 528);
+    status = readb(global_qtest, req_addr + 528);
     g_assert_cmpint(status, ==, 0);

     data = g_malloc0(512);
@@ -245,7 +245,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
         qvirtqueue_kick(dev, vq, free_head);

         qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_BLK_TIMEOUT_US);
-        status = readb(req_addr + 528);
+        status = readb(global_qtest, req_addr + 528);
         g_assert_cmpint(status, ==, 0);

         guest_free(alloc, req_addr);
@@ -266,7 +266,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
         qvirtqueue_kick(dev, vq, free_head);

         qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_BLK_TIMEOUT_US);
-        status = readb(req_addr + 528);
+        status = readb(global_qtest, req_addr + 528);
         g_assert_cmpint(status, ==, 0);

         data = g_malloc0(512);
@@ -350,7 +350,7 @@ static void pci_indirect(void)

     qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
                            QVIRTIO_BLK_TIMEOUT_US);
-    status = readb(req_addr + 528);
+    status = readb(global_qtest, req_addr + 528);
     g_assert_cmpint(status, ==, 0);

     g_free(indirect);
@@ -376,7 +376,7 @@ static void pci_indirect(void)

     qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
                            QVIRTIO_BLK_TIMEOUT_US);
-    status = readb(req_addr + 528);
+    status = readb(global_qtest, req_addr + 528);
     g_assert_cmpint(status, ==, 0);

     data = g_malloc0(512);
@@ -488,7 +488,7 @@ static void pci_msix(void)
     qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
                            QVIRTIO_BLK_TIMEOUT_US);

-    status = readb(req_addr + 528);
+    status = readb(global_qtest, req_addr + 528);
     g_assert_cmpint(status, ==, 0);

     guest_free(qs->alloc, req_addr);
@@ -513,7 +513,7 @@ static void pci_msix(void)
     qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
                            QVIRTIO_BLK_TIMEOUT_US);

-    status = readb(req_addr + 528);
+    status = readb(global_qtest, req_addr + 528);
     g_assert_cmpint(status, ==, 0);

     data = g_malloc0(512);
@@ -636,7 +636,7 @@ static void pci_idx(void)
     g_assert(qvirtqueue_get_buf(&vqpci->vq, &desc_idx));
     g_assert_cmpint(desc_idx, ==, free_head);

-    status = readb(req_addr + 528);
+    status = readb(global_qtest, req_addr + 528);
     g_assert_cmpint(status, ==, 0);

     data = g_malloc0(512);
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 4d544ddbc3..30a341df2f 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -125,7 +125,7 @@ static uint8_t virtio_scsi_do_command(QVirtIOSCSI *vs, const uint8_t *cdb,
     qvirtqueue_kick(vs->dev, vq, free_head);
     qvirtio_wait_used_elem(vs->dev, vq, free_head, QVIRTIO_SCSI_TIMEOUT_US);

-    response = readb(resp_addr +
+    response = readb(global_qtest, resp_addr +
                      offsetof(struct virtio_scsi_cmd_resp, response));

     if (resp_out) {
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 108a5d9a6e..aab7760bee 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -105,7 +105,7 @@ static void read_guid_from_memory(QemuUUID *guid)

     /* Read the GUID directly from guest memory */
     for (i = 0; i < 16; i++) {
-        guid->data[i] = readb(vmgenid_addr + i);
+        guid->data[i] = readb(global_qtest, vmgenid_addr + i);
     }
     /* The GUID is in little-endian format in the guest, while QEMU
      * uses big-endian.  Swap after reading.
-- 
2.13.5
