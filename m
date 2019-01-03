Received: from eggs.gnu.org ([208.118.235.92]:51789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gez3a-0003Lp-01
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gez3Y-0006Vk-Rm
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:12:50 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  3 Jan 2019 09:11:09 +0000
Message-Id: <20190103091119.9367-2-stefanha@redhat.com>
In-Reply-To: <20190103091119.9367-1-stefanha@redhat.com>
References: <20190103091119.9367-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/11] qtest: Add set_irq_in command to set
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

Adds a new qtest command "set_irq_in" which allows
to set qemu gpio lines to a given level.

Based on https://lists.gnu.org/archive/html/qemu-devel/2012-12/msg02363.h=
tml
which never got merged.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Originally-by: Matthew Ogilvie <mmogilvi_qemu@miniinfo.net>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqtest.h | 13 +++++++++++++
 qtest.c          | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/libqtest.c | 10 ++++++++++
 3 files changed, 66 insertions(+)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 9758c51be6..7ea94139b0 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -230,6 +230,19 @@ void qtest_irq_intercept_in(QTestState *s, const cha=
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
diff --git a/qtest.c b/qtest.c
index 69b9e9962b..451696b5da 100644
--- a/qtest.c
+++ b/qtest.c
@@ -164,6 +164,17 @@ static bool qtest_opened;
  * where NUM is an IRQ number.  For the PC, interrupts can be intercepte=
d
  * simply with "irq_intercept_in ioapic" (note that IRQ0 comes out with
  * NUM=3D0 even though it is remapped to GSI 2).
+ *
+ * Setting interrupt level:
+ *
+ *  > set_irq_in QOM-PATH NAME NUM LEVEL
+ *  < OK
+ *
+ *  where NAME is the name of the irq/gpio list, NUM is an IRQ number an=
d
+ *  LEVEL is an signed integer IRQ level.
+ *
+ * Forcibly set the given interrupt pin to the given level.
+ *
  */
=20
 static int hex2nib(char ch)
@@ -326,7 +337,39 @@ static void qtest_process_command(CharBackend *chr, =
gchar **words)
         irq_intercept_dev =3D dev;
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
+    } else if (strcmp(words[0], "set_irq_in") =3D=3D 0) {
+        DeviceState *dev;
+        qemu_irq irq;
+        char *name;
+        int ret;
+        int num;
+        int level;
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
+        ret =3D qemu_strtoi(words[3], NULL, 0, &num);
+        g_assert(!ret);
+        ret =3D qemu_strtoi(words[4], NULL, 0, &level);
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
index 1d75d3c936..55750dd68d 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -753,6 +753,16 @@ void qtest_irq_intercept_in(QTestState *s, const cha=
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
--=20
2.19.2
