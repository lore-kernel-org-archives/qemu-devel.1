Received: from eggs.gnu.org ([209.51.188.92]:46510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoi-00056k-HT
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoe-0002Gm-UV
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:56 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXod-0002DU-2H
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:51 -0500
Received: by mail-wr1-x42b.google.com with SMTP id z5so1034408wrt.11
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.48 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:04 +0000
Message-Id: <20190107163117.16269-25-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/37] qtest: Add set_irq_in command to set
 IRQ/GPIO level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Steffen Görtz <contrib@steffen-goertz.de>

Adds a new qtest command "set_irq_in" which allows
to set qemu gpio lines to a given level.

Based on https://lists.gnu.org/archive/html/qemu-devel/2012-12/msg02363.html
which never got merged.

Signed-off-by: Steffen Görtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190103091119.9367-2-stefanha@redhat.com
Originally-by: Matthew Ogilvie <mmogilvi_qemu@miniinfo.net>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/libqtest.h | 13 +++++++++++++
 qtest.c          | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/libqtest.c | 10 ++++++++++
 3 files changed, 66 insertions(+)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 9758c51be61..7ea94139b0c 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -230,6 +230,19 @@ void qtest_irq_intercept_in(QTestState *s, const char *string);
  */
 void qtest_irq_intercept_out(QTestState *s, const char *string);
 
+/**
+ * qtest_set_irq_in:
+ * @s: QTestState instance to operate on.
+ * @string: QOM path of a device
+ * @name: IRQ name
+ * @irq: IRQ number
+ * @level: IRQ level
+ *
+ * Force given device/irq GPIO-in pin to the given level.
+ */
+void qtest_set_irq_in(QTestState *s, const char *string, const char *name,
+                      int irq, int level);
+
 /**
  * qtest_outb:
  * @s: #QTestState instance to operate on.
diff --git a/qtest.c b/qtest.c
index 69b9e9962b5..451696b5dae 100644
--- a/qtest.c
+++ b/qtest.c
@@ -164,6 +164,17 @@ static bool qtest_opened;
  * where NUM is an IRQ number.  For the PC, interrupts can be intercepted
  * simply with "irq_intercept_in ioapic" (note that IRQ0 comes out with
  * NUM=0 even though it is remapped to GSI 2).
+ *
+ * Setting interrupt level:
+ *
+ *  > set_irq_in QOM-PATH NAME NUM LEVEL
+ *  < OK
+ *
+ *  where NAME is the name of the irq/gpio list, NUM is an IRQ number and
+ *  LEVEL is an signed integer IRQ level.
+ *
+ * Forcibly set the given interrupt pin to the given level.
+ *
  */
 
 static int hex2nib(char ch)
@@ -326,7 +337,39 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         irq_intercept_dev = dev;
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
+    } else if (strcmp(words[0], "set_irq_in") == 0) {
+        DeviceState *dev;
+        qemu_irq irq;
+        char *name;
+        int ret;
+        int num;
+        int level;
 
+        g_assert(words[1] && words[2] && words[3] && words[4]);
+
+        dev = DEVICE(object_resolve_path(words[1], NULL));
+        if (!dev) {
+            qtest_send_prefix(chr);
+            qtest_send(chr, "FAIL Unknown device\n");
+            return;
+        }
+
+        if (strcmp(words[2], "unnamed-gpio-in") == 0) {
+            name = NULL;
+        } else {
+            name = words[2];
+        }
+
+        ret = qemu_strtoi(words[3], NULL, 0, &num);
+        g_assert(!ret);
+        ret = qemu_strtoi(words[4], NULL, 0, &level);
+        g_assert(!ret);
+
+        irq = qdev_get_gpio_in_named(dev, name, num);
+
+        qemu_set_irq(irq, level);
+        qtest_send_prefix(chr);
+        qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "outb") == 0 ||
                strcmp(words[0], "outw") == 0 ||
                strcmp(words[0], "outl") == 0) {
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 1d75d3c9363..55750dd68de 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -753,6 +753,16 @@ void qtest_irq_intercept_in(QTestState *s, const char *qom_path)
     qtest_rsp(s, 0);
 }
 
+void qtest_set_irq_in(QTestState *s, const char *qom_path, const char *name,
+                      int num, int level)
+{
+    if (!name) {
+        name = "unnamed-gpio-in";
+    }
+    qtest_sendf(s, "set_irq_in %s %s %d %d\n", qom_path, name, num, level);
+    qtest_rsp(s, 0);
+}
+
 static void qtest_out(QTestState *s, const char *cmd, uint16_t addr, uint32_t value)
 {
     qtest_sendf(s, "%s 0x%x 0x%x\n", cmd, addr, value);
-- 
2.19.2
