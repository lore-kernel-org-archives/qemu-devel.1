Received: from eggs.gnu.org ([2001:4830:134:3::10]:45477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ceJKm-0007qj-8Z
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ceJKh-0001Q7-81
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:30:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ceJKg-0001Pi-PE
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:30:39 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CB354E4C7
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 10:30:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Feb 2017 14:30:16 +0400
Message-Id: <20170216103016.6669-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] cutils: factor out
 pci_host_device_address_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This will allow the function to be used outside of QOM properties.

Add tests and replace strtoul usage for qemu_strtoul while touching it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/pci/pci.h      | 12 ++++++++++
 hw/core/qdev-properties.c | 61 +++--------------------------------------=
------
 tests/test-cutils.c       | 46 +++++++++++++++++++++++++++++++++++
 util/cutils.c             | 59 +++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 120 insertions(+), 58 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index cbc1fdfb5b..61718080ea 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -815,4 +815,16 @@ extern const VMStateDescription vmstate_pci_device;
=20
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
=20
+/**
+ * pci_host_device_address_parse:
+ * @str: string to parse
+ * @addr: destination structure or NULL
+ *
+ * Parse [<domain>:]<bus>:<slot>.<func>
+ *   if <domain> is not supplied, it's assumed to be 0.
+ *
+ * Returns: -1 on failure, 0 on success.
+ */
+int pci_host_device_address_parse(const char *str, PCIHostDeviceAddress =
*addr);
+
 #endif
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 6ab4265eb4..5dd0774e88 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -722,10 +722,6 @@ static void get_pci_host_devaddr(Object *obj, Visito=
r *v, const char *name,
     visit_type_str(v, name, &p, errp);
 }
=20
-/*
- * Parse [<domain>:]<bus>:<slot>.<func>
- *   if <domain> is not supplied, it's assumed to be 0.
- */
 static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *na=
me,
                                  void *opaque, Error **errp)
 {
@@ -733,11 +729,7 @@ static void set_pci_host_devaddr(Object *obj, Visito=
r *v, const char *name,
     Property *prop =3D opaque;
     PCIHostDeviceAddress *addr =3D qdev_get_prop_ptr(dev, prop);
     Error *local_err =3D NULL;
-    char *str, *p;
-    char *e;
-    unsigned long val;
-    unsigned long dom =3D 0, bus =3D 0;
-    unsigned int slot =3D 0, func =3D 0;
+    char *str;
=20
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -750,58 +742,11 @@ static void set_pci_host_devaddr(Object *obj, Visit=
or *v, const char *name,
         return;
     }
=20
-    p =3D str;
-    val =3D strtoul(p, &e, 16);
-    if (e =3D=3D p || *e !=3D ':') {
-        goto inval;
-    }
-    bus =3D val;
-
-    p =3D e + 1;
-    val =3D strtoul(p, &e, 16);
-    if (e =3D=3D p) {
-        goto inval;
-    }
-    if (*e =3D=3D ':') {
-        dom =3D bus;
-        bus =3D val;
-        p =3D e + 1;
-        val =3D strtoul(p, &e, 16);
-        if (e =3D=3D p) {
-            goto inval;
-        }
-    }
-    slot =3D val;
-
-    if (*e !=3D '.') {
-        goto inval;
+    if (!pci_host_device_address_parse(str, addr)) {
+        error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
     }
-    p =3D e + 1;
-    val =3D strtoul(p, &e, 10);
-    if (e =3D=3D p) {
-        goto inval;
-    }
-    func =3D val;
-
-    if (dom > 0xffff || bus > 0xff || slot > 0x1f || func > 7) {
-        goto inval;
-    }
-
-    if (*e) {
-        goto inval;
-    }
-
-    addr->domain =3D dom;
-    addr->bus =3D bus;
-    addr->slot =3D slot;
-    addr->function =3D func;
=20
     g_free(str);
-    return;
-
-inval:
-    error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
-    g_free(str);
 }
=20
 PropertyInfo qdev_prop_pci_host_devaddr =3D {
diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 20b0f59ba2..81c4f072f3 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
=20
 #include "qemu/cutils.h"
+#include "hw/pci/pci.h"
=20
 static void test_parse_uint_null(void)
 {
@@ -1437,6 +1438,46 @@ static void test_qemu_strtosz_suffix_unit(void)
     g_assert_cmpint(res, =3D=3D, 12345000);
 }
=20
+static void test_pci_parse_valid(void)
+{
+    PCIHostDeviceAddress addr =3D { 0xff, 0xff, 0xff, 0xff };
+    int i, res;
+    const struct {
+        const char *str;
+        PCIHostDeviceAddress addr;
+    } tests[] =3D {
+        { "1:2.3", { 0, 1, 2, 3 } },
+        { "4:1:2.3", { 4, 1, 2, 3 } },
+        { "a:a:a.7", { 10, 10, 10, 7 } },
+    };
+
+    for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
+        res =3D pci_host_device_address_parse(tests[i].str, &addr);
+        g_assert_cmpint(res, =3D=3D, 0);
+
+        g_assert_cmpint(addr.domain, =3D=3D, tests[i].addr.domain);
+        g_assert_cmpint(addr.bus, =3D=3D, tests[i].addr.bus);
+        g_assert_cmpint(addr.slot, =3D=3D, tests[i].addr.slot);
+        g_assert_cmpint(addr.function, =3D=3D, tests[i].addr.function);
+    }
+}
+
+static void test_pci_parse_invalid(void)
+{
+    int i, res;
+    const char *tests[] =3D  {
+        "", "foo", "1:2.3 foo",
+        "a:a:a.a",
+        "1", "1:", "1:2", "1:2:", "1:2:3", ":1:2:3.",
+        "-1:1:2.3", "-1:2.3", "1:-1.3", "1:2.-3",
+        "0x10000:1:1.1", "0x100:1.1", "1:0x20.1", "1:1.8" };
+
+    for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
+        res =3D pci_host_device_address_parse(tests[i], NULL);
+        g_assert_cmpint(res, =3D=3D, -1);
+    }
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -1598,5 +1639,10 @@ int main(int argc, char **argv)
     g_test_add_func("/cutils/strtosz/suffix-unit",
                     test_qemu_strtosz_suffix_unit);
=20
+    g_test_add_func("/cutils/pci-parse/valid",
+                    test_pci_parse_valid);
+    g_test_add_func("/cutils/pci-parse/invalid",
+                    test_pci_parse_invalid);
+
     return g_test_run();
 }
diff --git a/util/cutils.c b/util/cutils.c
index 4fefcf3be3..3666d28ffe 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -29,6 +29,7 @@
 #include "qemu/sockets.h"
 #include "qemu/iov.h"
 #include "net/net.h"
+#include "hw/pci/pci.h"
 #include "qemu/cutils.h"
=20
 void strpadcpy(char *buf, int buf_size, const char *str, char pad)
@@ -594,3 +595,61 @@ const char *qemu_ether_ntoa(const MACAddr *mac)
=20
     return ret;
 }
+
+int pci_host_device_address_parse(const char *str, PCIHostDeviceAddress =
*addr)
+{
+    const char *p =3D str;
+    const char *e;
+    uint64_t val;
+    unsigned long dom =3D 0, bus =3D 0;
+    unsigned int slot =3D 0, func =3D 0;
+
+    if (qemu_strtoul(p, &e, 16, &val) < 0
+        || e =3D=3D p || *e !=3D ':') {
+        return -1;
+    }
+    bus =3D val;
+
+    p =3D e + 1;
+    if (qemu_strtoul(p, &e, 16, &val) < 0
+        || e =3D=3D p) {
+        return -1;
+    }
+    if (*e =3D=3D ':') {
+        dom =3D bus;
+        bus =3D val;
+        p =3D e + 1;
+        if (qemu_strtoul(p, &e, 16, &val) < 0
+            || e =3D=3D p) {
+            return -1;
+        }
+    }
+    slot =3D val;
+
+    if (*e !=3D '.') {
+        return -1;
+    }
+    p =3D e + 1;
+    if (qemu_strtoul(p, &e, 10, &val) < 0
+        || e =3D=3D p) {
+        return -1;
+    }
+    func =3D val;
+
+    if (dom > 0xffff || bus > 0xff || slot > 0x1f || func > 7) {
+        return -1;
+    }
+
+    if (*e) {
+        return -1;
+    }
+
+    if (addr) {
+        addr->domain =3D dom;
+        addr->bus =3D bus;
+        addr->slot =3D slot;
+        addr->function =3D func;
+    }
+
+    return 0;
+}
--=20
2.11.0.295.gd7dffce1c.dirty
