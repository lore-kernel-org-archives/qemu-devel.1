Received: from eggs.gnu.org ([2001:4830:134:3::10]:38432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOK-0007Gk-2r
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOI-0001BY-75
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1drSOH-0001BB-VU
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1827C11A28D
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 17:20:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:19:59 -0500
Message-Id: <20170911172022.4738-16-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 15/38] libqos: Use explicit QTestState for
 i2c operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com

Drop one more client of global_qtest by teaching all i2c test
functionality to pass in an explicit QTestState, adjusting all
callers.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqos/i2c.h      |  7 ++++--
 tests/ds1338-test.c     |  6 ++---
 tests/libqos/i2c-imx.c  | 67 +++++++++++++++++++++++++------------------------
 tests/libqos/i2c-omap.c | 45 +++++++++++++++++----------------
 tests/tmp105-test.c     |  6 ++---
 5 files changed, 66 insertions(+), 65 deletions(-)

diff --git a/tests/libqos/i2c.h b/tests/libqos/i2c.h
index 6e648f922a..eb40b808bd 100644
--- a/tests/libqos/i2c.h
+++ b/tests/libqos/i2c.h
@@ -9,6 +9,7 @@
 #ifndef LIBQOS_I2C_H
 #define LIBQOS_I2C_H

+#include "libqtest.h"

 typedef struct I2CAdapter I2CAdapter;
 struct I2CAdapter {
@@ -16,6 +17,8 @@ struct I2CAdapter {
                  const uint8_t *buf, uint16_t len);
     void (*recv)(I2CAdapter *adapter, uint8_t addr,
                  uint8_t *buf, uint16_t len);
+
+    QTestState *qts;
 };

 void i2c_send(I2CAdapter *i2c, uint8_t addr,
@@ -24,9 +27,9 @@ void i2c_recv(I2CAdapter *i2c, uint8_t addr,
               uint8_t *buf, uint16_t len);

 /* libi2c-omap.c */
-I2CAdapter *omap_i2c_create(uint64_t addr);
+I2CAdapter *omap_i2c_create(QTestState *qts, uint64_t addr);

 /* libi2c-imx.c */
-I2CAdapter *imx_i2c_create(uint64_t addr);
+I2CAdapter *imx_i2c_create(QTestState *qts, uint64_t addr);

 #endif
diff --git a/tests/ds1338-test.c b/tests/ds1338-test.c
index 26968bc82a..742dad9113 100644
--- a/tests/ds1338-test.c
+++ b/tests/ds1338-test.c
@@ -61,16 +61,14 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);

     s = qtest_start("-display none -machine imx25-pdk");
-    i2c = imx_i2c_create(IMX25_I2C_0_BASE);
+    i2c = imx_i2c_create(s, IMX25_I2C_0_BASE);
     addr = DS1338_ADDR;

     qtest_add_func("/ds1338/tx-rx", send_and_receive);

     ret = g_test_run();

-    if (s) {
-        qtest_quit(s);
-    }
+    qtest_quit(s);
     g_free(i2c);

     return ret;
diff --git a/tests/libqos/i2c-imx.c b/tests/libqos/i2c-imx.c
index 1c4b4314ba..0945f2ecdc 100644
--- a/tests/libqos/i2c-imx.c
+++ b/tests/libqos/i2c-imx.c
@@ -40,8 +40,8 @@ typedef struct IMXI2C {
 static void imx_i2c_set_slave_addr(IMXI2C *s, uint8_t addr,
                                    enum IMXI2CDirection direction)
 {
-    writeb(s->addr + I2DR_ADDR, (addr << 1) |
-           (direction == IMX_I2C_READ ? 1 : 0));
+    qtest_writeb(s->parent.qts, s->addr + I2DR_ADDR,
+                 (addr << 1) | (direction == IMX_I2C_READ ? 1 : 0));
 }

 static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
@@ -63,35 +63,35 @@ static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
            I2CR_MTX |
            I2CR_TXAK;

-    writeb(s->addr + I2CR_ADDR, data);
-    status = readb(s->addr + I2SR_ADDR);
+    qtest_writeb(i2c->qts, s->addr + I2CR_ADDR, data);
+    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IBB) != 0);

     /* set the slave address */
     imx_i2c_set_slave_addr(s, addr, IMX_I2C_WRITE);
-    status = readb(s->addr + I2SR_ADDR);
+    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IIF) != 0);
     g_assert((status & I2SR_RXAK) == 0);

     /* ack the interrupt */
-    writeb(s->addr + I2SR_ADDR, 0);
-    status = readb(s->addr + I2SR_ADDR);
+    qtest_writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
+    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IIF) == 0);

     while (size < len) {
         /* check we are still busy */
-        status = readb(s->addr + I2SR_ADDR);
+        status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
         g_assert((status & I2SR_IBB) != 0);

         /* write the data */
-        writeb(s->addr + I2DR_ADDR, buf[size]);
-        status = readb(s->addr + I2SR_ADDR);
+        qtest_writeb(i2c->qts, s->addr + I2DR_ADDR, buf[size]);
+        status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
         g_assert((status & I2SR_IIF) != 0);
         g_assert((status & I2SR_RXAK) == 0);

         /* ack the interrupt */
-        writeb(s->addr + I2SR_ADDR, 0);
-        status = readb(s->addr + I2SR_ADDR);
+        qtest_writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
+        status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
         g_assert((status & I2SR_IIF) == 0);

         size++;
@@ -99,8 +99,8 @@ static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,

     /* release the bus */
     data &= ~(I2CR_MSTA | I2CR_MTX);
-    writeb(s->addr + I2CR_ADDR, data);
-    status = readb(s->addr + I2SR_ADDR);
+    qtest_writeb(i2c->qts, s->addr + I2CR_ADDR, data);
+    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IBB) == 0);
 }

@@ -123,19 +123,19 @@ static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
            I2CR_MTX |
            I2CR_TXAK;

-    writeb(s->addr + I2CR_ADDR, data);
-    status = readb(s->addr + I2SR_ADDR);
+    qtest_writeb(i2c->qts, s->addr + I2CR_ADDR, data);
+    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IBB) != 0);

     /* set the slave address */
     imx_i2c_set_slave_addr(s, addr, IMX_I2C_READ);
-    status = readb(s->addr + I2SR_ADDR);
+    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IIF) != 0);
     g_assert((status & I2SR_RXAK) == 0);

     /* ack the interrupt */
-    writeb(s->addr + I2SR_ADDR, 0);
-    status = readb(s->addr + I2SR_ADDR);
+    qtest_writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
+    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IIF) == 0);

     /* set the bus for read */
@@ -144,23 +144,23 @@ static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
     if (len != 1) {
         data &= ~I2CR_TXAK;
     }
-    writeb(s->addr + I2CR_ADDR, data);
-    status = readb(s->addr + I2SR_ADDR);
+    qtest_writeb(i2c->qts, s->addr + I2CR_ADDR, data);
+    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IBB) != 0);

     /* dummy read */
-    readb(s->addr + I2DR_ADDR);
-    status = readb(s->addr + I2SR_ADDR);
+    qtest_readb(i2c->qts, s->addr + I2DR_ADDR);
+    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IIF) != 0);

     /* ack the interrupt */
-    writeb(s->addr + I2SR_ADDR, 0);
-    status = readb(s->addr + I2SR_ADDR);
+    qtest_writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
+    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IIF) == 0);

     while (size < len) {
         /* check we are still busy */
-        status = readb(s->addr + I2SR_ADDR);
+        status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
         g_assert((status & I2SR_IBB) != 0);

         if (size == (len - 1)) {
@@ -170,30 +170,30 @@ static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
             /* ack the data read */
             data |= I2CR_TXAK;
         }
-        writeb(s->addr + I2CR_ADDR, data);
+        qtest_writeb(i2c->qts, s->addr + I2CR_ADDR, data);

         /* read the data */
-        buf[size] = readb(s->addr + I2DR_ADDR);
+        buf[size] = qtest_readb(i2c->qts, s->addr + I2DR_ADDR);

         if (size != (len - 1)) {
-            status = readb(s->addr + I2SR_ADDR);
+            status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
             g_assert((status & I2SR_IIF) != 0);

             /* ack the interrupt */
-            writeb(s->addr + I2SR_ADDR, 0);
+            qtest_writeb(i2c->qts, s->addr + I2SR_ADDR, 0);
         }

-        status = readb(s->addr + I2SR_ADDR);
+        status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
         g_assert((status & I2SR_IIF) == 0);

         size++;
     }

-    status = readb(s->addr + I2SR_ADDR);
+    status = qtest_readb(i2c->qts, s->addr + I2SR_ADDR);
     g_assert((status & I2SR_IBB) == 0);
 }

-I2CAdapter *imx_i2c_create(uint64_t addr)
+I2CAdapter *imx_i2c_create(QTestState *qts, uint64_t addr)
 {
     IMXI2C *s = g_malloc0(sizeof(*s));
     I2CAdapter *i2c = (I2CAdapter *)s;
@@ -202,6 +202,7 @@ I2CAdapter *imx_i2c_create(uint64_t addr)

     i2c->send = imx_i2c_send;
     i2c->recv = imx_i2c_recv;
+    i2c->qts = qts;

     return i2c;
 }
diff --git a/tests/libqos/i2c-omap.c b/tests/libqos/i2c-omap.c
index f603fdf43c..1ef6e7b200 100644
--- a/tests/libqos/i2c-omap.c
+++ b/tests/libqos/i2c-omap.c
@@ -51,8 +51,8 @@ static void omap_i2c_set_slave_addr(OMAPI2C *s, uint8_t addr)
 {
     uint16_t data = addr;

-    writew(s->addr + OMAP_I2C_SA, data);
-    data = readw(s->addr + OMAP_I2C_SA);
+    qtest_writew(s->parent.qts, s->addr + OMAP_I2C_SA, data);
+    data = qtest_readw(s->parent.qts, s->addr + OMAP_I2C_SA);
     g_assert_cmphex(data, ==, addr);
 }

@@ -65,38 +65,38 @@ static void omap_i2c_send(I2CAdapter *i2c, uint8_t addr,
     omap_i2c_set_slave_addr(s, addr);

     data = len;
-    writew(s->addr + OMAP_I2C_CNT, data);
+    qtest_writew(i2c->qts, s->addr + OMAP_I2C_CNT, data);

     data = OMAP_I2C_CON_I2C_EN |
            OMAP_I2C_CON_TRX |
            OMAP_I2C_CON_MST |
            OMAP_I2C_CON_STT |
            OMAP_I2C_CON_STP;
-    writew(s->addr + OMAP_I2C_CON, data);
-    data = readw(s->addr + OMAP_I2C_CON);
+    qtest_writew(i2c->qts, s->addr + OMAP_I2C_CON, data);
+    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CON);
     g_assert((data & OMAP_I2C_CON_STP) != 0);

-    data = readw(s->addr + OMAP_I2C_STAT);
+    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
     g_assert((data & OMAP_I2C_STAT_NACK) == 0);

     while (len > 1) {
-        data = readw(s->addr + OMAP_I2C_STAT);
+        data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
         g_assert((data & OMAP_I2C_STAT_XRDY) != 0);

         data = buf[0] | ((uint16_t)buf[1] << 8);
-        writew(s->addr + OMAP_I2C_DATA, data);
+        qtest_writew(i2c->qts, s->addr + OMAP_I2C_DATA, data);
         buf = (uint8_t *)buf + 2;
         len -= 2;
     }
     if (len == 1) {
-        data = readw(s->addr + OMAP_I2C_STAT);
+        data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
         g_assert((data & OMAP_I2C_STAT_XRDY) != 0);

         data = buf[0];
-        writew(s->addr + OMAP_I2C_DATA, data);
+        qtest_writew(i2c->qts, s->addr + OMAP_I2C_DATA, data);
     }

-    data = readw(s->addr + OMAP_I2C_CON);
+    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CON);
     g_assert((data & OMAP_I2C_CON_STP) == 0);
 }

@@ -109,30 +109,30 @@ static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
     omap_i2c_set_slave_addr(s, addr);

     data = len;
-    writew(s->addr + OMAP_I2C_CNT, data);
+    qtest_writew(i2c->qts, s->addr + OMAP_I2C_CNT, data);

     data = OMAP_I2C_CON_I2C_EN |
            OMAP_I2C_CON_MST |
            OMAP_I2C_CON_STT |
            OMAP_I2C_CON_STP;
-    writew(s->addr + OMAP_I2C_CON, data);
-    data = readw(s->addr + OMAP_I2C_CON);
+    qtest_writew(i2c->qts, s->addr + OMAP_I2C_CON, data);
+    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CON);
     g_assert((data & OMAP_I2C_CON_STP) == 0);

-    data = readw(s->addr + OMAP_I2C_STAT);
+    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
     g_assert((data & OMAP_I2C_STAT_NACK) == 0);

-    data = readw(s->addr + OMAP_I2C_CNT);
+    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CNT);
     g_assert_cmpuint(data, ==, len);

     while (len > 0) {
-        data = readw(s->addr + OMAP_I2C_STAT);
+        data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);
         g_assert((data & OMAP_I2C_STAT_RRDY) != 0);
         g_assert((data & OMAP_I2C_STAT_ROVR) == 0);

-        data = readw(s->addr + OMAP_I2C_DATA);
+        data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_DATA);

-        stat = readw(s->addr + OMAP_I2C_STAT);
+        stat = qtest_readw(i2c->qts, s->addr + OMAP_I2C_STAT);

         if (unlikely(len == 1)) {
             g_assert((stat & OMAP_I2C_STAT_SBD) != 0);
@@ -148,11 +148,11 @@ static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
         }
     }

-    data = readw(s->addr + OMAP_I2C_CON);
+    data = qtest_readw(i2c->qts, s->addr + OMAP_I2C_CON);
     g_assert((data & OMAP_I2C_CON_STP) == 0);
 }

-I2CAdapter *omap_i2c_create(uint64_t addr)
+I2CAdapter *omap_i2c_create(QTestState *qts, uint64_t addr)
 {
     OMAPI2C *s = g_malloc0(sizeof(*s));
     I2CAdapter *i2c = (I2CAdapter *)s;
@@ -162,9 +162,10 @@ I2CAdapter *omap_i2c_create(uint64_t addr)

     i2c->send = omap_i2c_send;
     i2c->recv = omap_i2c_recv;
+    i2c->qts = qts;

     /* verify the mmio address by looking for a known signature */
-    data = readw(addr + OMAP_I2C_REV);
+    data = qtest_readw(qts, addr + OMAP_I2C_REV);
     g_assert_cmphex(data, ==, 0x34);

     return i2c;
diff --git a/tests/tmp105-test.c b/tests/tmp105-test.c
index a7940a4639..382f88ba23 100644
--- a/tests/tmp105-test.c
+++ b/tests/tmp105-test.c
@@ -154,15 +154,13 @@ int main(int argc, char **argv)
     s = qtest_start("-machine n800 "
                     "-device tmp105,bus=i2c-bus.0,id=" TMP105_TEST_ID
                     ",address=0x49");
-    i2c = omap_i2c_create(OMAP2_I2C_1_BASE);
+    i2c = omap_i2c_create(s, OMAP2_I2C_1_BASE);

     qtest_add_func("/tmp105/tx-rx", send_and_receive);

     ret = g_test_run();

-    if (s) {
-        qtest_quit(s);
-    }
+    qtest_quit(s);
     g_free(i2c);

     return ret;
-- 
2.13.5
