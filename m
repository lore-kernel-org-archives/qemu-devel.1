Received: from eggs.gnu.org ([2001:4830:134:3::10]:35631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cOzmG-0001g7-M3
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:35:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cOzmD-0001Oe-Dh
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:35:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54448
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alastair@au1.ibm.com>)
	id 1cOzmD-0001O2-7C
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:35:45 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v054Xjxg018880
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 23:35:44 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27sdu5b50m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 23:35:43 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alastair@au1.ibm.com>;
	Thu, 5 Jan 2017 14:35:40 +1000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
Date: Thu,  5 Jan 2017 15:34:26 +1100
In-Reply-To: <20170105043430.3176-1-alastair@au1.ibm.com>
References: <20170105043430.3176-1-alastair@au1.ibm.com>
Message-Id: <20170105043430.3176-4-alastair@au1.ibm.com>
Subject: [Qemu-devel] [PATCH v5 3/7] qtest: Support setting named GPIOs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

From: Alastair D'Silva <alastair@d-silva.org>

Some devices change their behaviour based on the state of their input GPIO
lines.

This patch allows testing of the variable behaviour by providing facilities
for the test to set the state of these GPIO lines.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 qtest.c          | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/libqtest.c |  7 +++++++
 tests/libqtest.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/qtest.c b/qtest.c
index ad7e215..a947892 100644
--- a/qtest.c
+++ b/qtest.c
@@ -165,6 +165,11 @@ static bool qtest_opened;
  * where NUM is an IRQ number.  For the PC, interrupts can be intercepted
  * simply with "irq_intercept_in ioapic" (note that IRQ0 comes out with
  * NUM=0 even though it is remapped to GSI 2).
+ *
+ *  > irq_set NAME NUM LEVEL
+ *  < OK
+ *
+ *  Set the named input IRQ to the level (0/1)
  */
 
 static int hex2nib(char ch)
@@ -344,6 +349,43 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
 
+    } else if (strcmp(words[0], "irq_set") == 0) {
+        DeviceState *dev;
+        NamedGPIOList *ngl;
+        int level;
+        qemu_irq irq = NULL;
+        int irq_num;
+
+        g_assert(words[1]); /* device */
+        g_assert(words[2]); /* gpio list */
+        g_assert(words[3]); /* gpio line in list */
+        g_assert(words[4]); /* level */
+        dev = DEVICE(object_resolve_path(words[1], NULL));
+        if (!dev) {
+            qtest_send_prefix(chr);
+            qtest_send(chr, "FAIL Unknown device\n");
+            return;
+        }
+
+        irq_num = atoi(words[3]);
+        level = atoi(words[4]);
+
+        QLIST_FOREACH(ngl, &dev->gpios, node) {
+            if (strcmp(words[2], ngl->name) == 0 && ngl->num_in > irq_num) {
+                irq = ngl->in[irq_num];
+            }
+        }
+
+        if (irq == NULL) {
+            qtest_send_prefix(chr);
+            qtest_send(chr, "FAIL Unknown IRQ\n");
+            return;
+        }
+
+        qemu_set_irq(irq, level);
+
+        qtest_send_prefix(chr);
+        qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "outb") == 0 ||
                strcmp(words[0], "outw") == 0 ||
                strcmp(words[0], "outl") == 0) {
diff --git a/tests/libqtest.c b/tests/libqtest.c
index a433c3b..a7cdd3b 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -988,3 +988,10 @@ bool qtest_big_endian(QTestState *s)
 {
     return s->big_endian;
 }
+
+void qtest_irq_set(QTestState *s, const char *id, const char *gpiolist, int n,
+        bool level)
+{
+    qtest_sendf(s, "irq_set %s %s %d %d\n", id, gpiolist, n, level);
+    qtest_rsp(s, 0);
+}
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 99b14b1..3063bc9 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -190,6 +190,20 @@ void qtest_irq_attach(QTestState *s, const char *name, int irq,
         void *opaque);
 
 /**
+ * qtest_irq_set:
+ * Set an interrupt level
+ * @s: #QTestState instance to operate on.
+ * @id: the device to inject interrupts for
+ * @gpiolist: the GPIO list containing the IRQ
+ * @n: the GPIO within the list
+ * @level: the IRQ level
+ *
+ * Set an interrupt to a nominated level
+ */
+void qtest_irq_set(QTestState *s, const char *id, const char *gpiolist, int n,
+        bool level);
+
+/**
  * qtest_outb:
  * @s: #QTestState instance to operate on.
  * @addr: I/O port to write to.
@@ -656,6 +670,21 @@ static inline void irq_attach(const char *name, int irq,
 }
 
 /**
+ * qtest_irq_set
+ * Set an interrupt level
+ * @id: the device to inject interrupts for
+ * @gpiolist: the GPIO list containing the line to seh
+ * @n: the line to set within the list
+ * @level: the IRQ level
+ */
+static inline void irq_set(const char *id, const char *gpiolist, int n,
+        bool level)
+{
+    qtest_irq_set(global_qtest, id, gpiolist, n, level);
+}
+
+
+/**
  * outb:
  * @addr: I/O port to write to.
  * @value: Value being written.
-- 
2.9.3
