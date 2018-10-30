Received: from eggs.gnu.org ([2001:4830:134:3::10]:38319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHWD9-0003OP-Qa
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHWD5-0005NO-Ap
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:45:43 -0400
Received: from steffen-goertz.de ([88.198.119.201]:60118)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gHWD3-00050d-DT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:45:37 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Tue, 30 Oct 2018 11:45:02 -0400
Message-Id: <20181030154510.29868-2-contrib@steffen-goertz.de>
In-Reply-To: <20181030154510.29868-1-contrib@steffen-goertz.de>
References: <20181030154510.29868-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/8] qtest: Add set_irq_in command to set
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Adds a new qtest command "set_irq_in" which allows
to set qemu gpio lines to a given level.

Based on https://lists.gnu.org/archive/html/qemu-devel/2012-12/msg02363.h=
tml
which never got merged.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Originally-by: Matthew Ogilvie <mmogilvi_qemu@miniinfo.net>
---
 qtest.c          | 40 ++++++++++++++++++++++++++++++++++++++++
 tests/libqtest.c | 10 ++++++++++
 tests/libqtest.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/qtest.c b/qtest.c
index 69b9e9962b..214f42a6c5 100644
--- a/qtest.c
+++ b/qtest.c
@@ -164,6 +164,14 @@ static bool qtest_opened;
  * where NUM is an IRQ number.  For the PC, interrupts can be intercepte=
d
  * simply with "irq_intercept_in ioapic" (note that IRQ0 comes out with
  * NUM=3D0 even though it is remapped to GSI 2).
+ *
+ * Setting interrupt level:
+ *
+ *  > set_irq_in QOM-PATH IRQ LEVEL
+ *  < OK
+ *
+ * Forcibly set the given interrupt pin to the given level.
+ *
  */
=20
 static int hex2nib(char ch)
@@ -326,7 +334,39 @@ static void qtest_process_command(CharBackend *chr, =
gchar **words)
         irq_intercept_dev =3D dev;
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
+    } else if (strcmp(words[0], "set_irq_in") =3D=3D 0) {
+        DeviceState *dev;
+        qemu_irq irq;
+        char *name;
+        int ret;
+        long num;
+        long level;
=20
+        g_assert(words[1] && words[2] && words[3] && words[4]);
+
+        dev =3D DEVICE(object_resolve_path(words[1], NULL));
+        if (!dev) {
+            qtest_send_prefix(chr);
+            qtest_send(chr, "FAIL Unknown device\n");
+            return;
+        }
+
+        if (strcmp(words[2], "unnamed-gpio-in") =3D=3D 0) {
+            name =3D NULL;
+        } else {
+            name =3D words[2];
+        }
+
+        ret =3D qemu_strtol(words[3], NULL, 10, &num);
+        g_assert(!ret);
+        ret =3D qemu_strtol(words[4], NULL, 10, &level);
+        g_assert(!ret);
+
+        irq =3D qdev_get_gpio_in_named(dev, name, num);
+
+        qemu_set_irq(irq, level);
+        qtest_send_prefix(chr);
+        qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "outb") =3D=3D 0 ||
                strcmp(words[0], "outw") =3D=3D 0 ||
                strcmp(words[0], "outl") =3D=3D 0) {
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 44ce118cfc..1cbde0d91a 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -732,6 +732,16 @@ void qtest_irq_intercept_in(QTestState *s, const cha=
r *qom_path)
     qtest_rsp(s, 0);
 }
=20
+void qtest_set_irq_in(QTestState *s, const char *qom_path, const char *n=
ame,
+                      int num, int level)
+{
+    if (!name) {
+        name =3D "unnamed-gpio-in";
+    }
+    qtest_sendf(s, "set_irq_in %s %s %d %d\n", qom_path, name, num, leve=
l);
+    qtest_rsp(s, 0);
+}
+
 static void qtest_out(QTestState *s, const char *cmd, uint16_t addr, uin=
t32_t value)
 {
     qtest_sendf(s, "%s 0x%x 0x%x\n", cmd, addr, value);
diff --git a/tests/libqtest.h b/tests/libqtest.h
index ed88ff99d5..65bffa9ace 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -232,6 +232,19 @@ void qtest_irq_intercept_in(QTestState *s, const cha=
r *string);
  */
 void qtest_irq_intercept_out(QTestState *s, const char *string);
=20
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
+void qtest_set_irq_in(QTestState *s, const char *string, const char *nam=
e,
+                      int irq, int level);
+
 /**
  * qtest_outb:
  * @s: #QTestState instance to operate on.
@@ -678,6 +691,21 @@ static inline void irq_intercept_out(const char *str=
ing)
     qtest_irq_intercept_out(global_qtest, string);
 }
=20
+/**
+ * qtest_set_irq_in:
+ * @string: QOM path of a device
+ * @name: IRQ name
+ * @irq: IRQ number
+ * @level: IRQ level
+ *
+ * Force given device/IRQ GPIO-in pin to the given level.
+ */
+static inline void set_irq_in(const char *string, const char *name,
+                              int irq, int level)
+{
+    qtest_set_irq_in(global_qtest, string, name, irq, level);
+}
+
 /**
  * outb:
  * @addr: I/O port to write to.
--=20
2.19.1
