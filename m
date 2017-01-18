Received: from eggs.gnu.org ([2001:4830:134:3::10]:37623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiB-0002gu-6f
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsi9-0007Nd-H7
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsi9-0007NF-9V
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:45 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72935C05B584
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:03:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:08 +0400
Message-Id: <20170118160332.13390-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/25] tests: start generic qemu-qmp tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

These 2 tests exhibited two qmp bugs that were fixed in 2.7
(series from commit e64c75a9752c5d0fd64eb2e684c656a5ea7d03c6 to
commit 1382d4abdf9619985e4078e37e49e487cea9935e)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qmp-test.c       | 79 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 MAINTAINERS            |  1 +
 tests/Makefile.include |  2 ++
 3 files changed, 82 insertions(+)
 create mode 100644 tests/qmp-test.c

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
new file mode 100644
index 0000000000..480ff28339
--- /dev/null
+++ b/tests/qmp-test.c
@@ -0,0 +1,79 @@
+/*
+ * QTest testcase for QMP
+ *
+ * Copyright (c) 2016 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * This program tests QMP commands maintained with the QMP core.
+ * These are defined in qmp.c.  Tests for QMP commands defined in
+ * another subsystem should go into a test program maintained with
+ * that subsystem.
+ *
+ * TODO Actually cover the commands.  The tests we got so far only
+ * demonstrate specific bugs we've fixed.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+static void test_object_add_without_props(void)
+{
+    QDict *ret, *error;
+    const gchar *klass, *desc;
+
+    ret =3D qmp("{'execute': 'object-add',"
+              " 'arguments': { 'qom-type': 'memory-backend-ram', 'id': '=
ram1' } }");
+    g_assert_nonnull(ret);
+
+    error =3D qdict_get_qdict(ret, "error");
+    klass =3D qdict_get_try_str(error, "class");
+    desc =3D qdict_get_try_str(error, "desc");
+
+    g_assert_cmpstr(klass, =3D=3D, "GenericError");
+    g_assert_cmpstr(desc, =3D=3D, "can't create backend with size 0");
+
+    QDECREF(ret);
+}
+
+static void test_qom_set_without_value(void)
+{
+    QDict *ret, *error;
+    const gchar *klass, *desc;
+
+    ret =3D qmp("{'execute': 'qom-set',"
+              " 'arguments': { 'path': '/machine', 'property': 'rtc-time=
' } }");
+    g_assert_nonnull(ret);
+
+    error =3D qdict_get_qdict(ret, "error");
+    klass =3D qdict_get_try_str(error, "class");
+    desc =3D qdict_get_try_str(error, "desc");
+
+    g_assert_cmpstr(klass, =3D=3D, "GenericError");
+    g_assert_cmpstr(desc, =3D=3D, "Parameter 'value' is missing");
+
+    QDECREF(ret);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_start("-machine none");
+
+    qtest_add_func("/qemu-qmp/object-add-without-props",
+                   test_object_add_without_props);
+    qtest_add_func("/qemu-qmp/qom-set-without-value",
+                   test_qom_set_without_value);
+
+    ret =3D g_test_run();
+
+    qtest_end();
+
+    return ret;
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 1444b26dc0..0c94a1ce27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1368,6 +1368,7 @@ F: qmp.c
 F: monitor.c
 F: docs/*qmp-*
 F: scripts/qmp/
+F: tests/qmp-test.c
 T: git git://repo.or.cz/qemu/armbru.git qapi-next
=20
 Register API
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 96f59703a1..152655d086 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -316,6 +316,7 @@ check-qtest-xtensaeb-y =3D $(check-qtest-xtensa-y)
 check-qtest-s390x-y =3D tests/boot-serial-test$(EXESUF)
=20
 check-qtest-generic-y +=3D tests/qom-test$(EXESUF)
+check-qtest-generic-y +=3D tests/qmp-test$(EXESUF)
=20
 qapi-schema +=3D alternate-any.json
 qapi-schema +=3D alternate-array.json
@@ -687,6 +688,7 @@ tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
 tests/qom-test$(EXESUF): tests/qom-test.o
+tests/qmp-test$(EXESUF): tests/qmp-test.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-pc-obj-y)
 tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-=
obj-y)
 tests/nvme-test$(EXESUF): tests/nvme-test.o
--=20
2.11.0.295.gd7dffce1c
