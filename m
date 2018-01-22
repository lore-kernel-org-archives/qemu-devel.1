Received: from eggs.gnu.org ([2001:4830:134:3::10]:42538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1edaFu-0002ke-UL
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1edaFr-0007ER-BQ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:27:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1edaFr-0007E2-2i
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:27:11 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 22 Jan 2018 12:26:58 +0100
Message-Id: <1516620426-18530-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1516620426-18530-1-git-send-email-thuth@redhat.com>
References: <1516620426-18530-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/9] tests: Rename pc-cpu-test.c to
 cpu-plug-test.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>

The test will be extended to work on other architectures, too, so let's
use a more generic name for the file and the functions in here first.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include                   |  4 ++--
 tests/{pc-cpu-test.c =3D> cpu-plug-test.c} | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)
 rename tests/{pc-cpu-test.c =3D> cpu-plug-test.c} (87%)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8883274..669f7f6 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -278,7 +278,7 @@ gcov-files-i386-y +=3D hw/usb/dev-hid.c
 gcov-files-i386-y +=3D hw/usb/dev-storage.c
 check-qtest-i386-y +=3D tests/usb-hcd-xhci-test$(EXESUF)
 gcov-files-i386-y +=3D hw/usb/hcd-xhci.c
-check-qtest-i386-y +=3D tests/pc-cpu-test$(EXESUF)
+check-qtest-i386-y +=3D tests/cpu-plug-test$(EXESUF)
 check-qtest-i386-y +=3D tests/q35-test$(EXESUF)
 check-qtest-i386-y +=3D tests/vmgenid-test$(EXESUF)
 gcov-files-i386-y +=3D hw/pci-host/q35.c
@@ -795,7 +795,7 @@ tests/usb-hcd-ohci-test$(EXESUF): tests/usb-hcd-ohci-=
test.o $(libqos-usb-obj-y)
 tests/usb-hcd-uhci-test$(EXESUF): tests/usb-hcd-uhci-test.o $(libqos-usb=
-obj-y)
 tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb=
-obj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb=
-obj-y)
-tests/pc-cpu-test$(EXESUF): tests/pc-cpu-test.o
+tests/cpu-plug-test$(EXESUF): tests/cpu-plug-test.o
 tests/migration-test$(EXESUF): tests/migration-test.o
 tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-=
y) \
 	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-=
y) \
diff --git a/tests/pc-cpu-test.c b/tests/cpu-plug-test.c
similarity index 87%
rename from tests/pc-cpu-test.c
rename to tests/cpu-plug-test.c
index 11d3e81..4579119 100644
--- a/tests/pc-cpu-test.c
+++ b/tests/cpu-plug-test.c
@@ -1,5 +1,5 @@
 /*
- * QTest testcase for PC CPUs
+ * QTest testcase for CPU plugging
  *
  * Copyright (c) 2015 SUSE Linux GmbH
  *
@@ -13,7 +13,7 @@
 #include "libqtest.h"
 #include "qapi/qmp/types.h"
=20
-struct PCTestData {
+struct PlugTestData {
     char *machine;
     const char *cpu_model;
     unsigned sockets;
@@ -21,11 +21,11 @@ struct PCTestData {
     unsigned threads;
     unsigned maxcpus;
 };
-typedef struct PCTestData PCTestData;
+typedef struct PlugTestData PlugTestData;
=20
-static void test_pc_with_cpu_add(gconstpointer data)
+static void test_plug_with_cpu_add(gconstpointer data)
 {
-    const PCTestData *s =3D data;
+    const PlugTestData *s =3D data;
     char *args;
     QDict *response;
     unsigned int i;
@@ -48,9 +48,9 @@ static void test_pc_with_cpu_add(gconstpointer data)
     g_free(args);
 }
=20
-static void test_pc_without_cpu_add(gconstpointer data)
+static void test_plug_without_cpu_add(gconstpointer data)
 {
-    const PCTestData *s =3D data;
+    const PlugTestData *s =3D data;
     char *args;
     QDict *response;
=20
@@ -73,7 +73,7 @@ static void test_pc_without_cpu_add(gconstpointer data)
=20
 static void test_data_free(gpointer data)
 {
-    PCTestData *pc =3D data;
+    PlugTestData *pc =3D data;
=20
     g_free(pc->machine);
     g_free(pc);
@@ -82,12 +82,12 @@ static void test_data_free(gpointer data)
 static void add_pc_test_case(const char *mname)
 {
     char *path;
-    PCTestData *data;
+    PlugTestData *data;
=20
     if (!g_str_has_prefix(mname, "pc-")) {
         return;
     }
-    data =3D g_new(PCTestData, 1);
+    data =3D g_new(PlugTestData, 1);
     data->machine =3D g_strdup(mname);
     data->cpu_model =3D "Haswell"; /* 1.3+ theoretically */
     data->sockets =3D 1;
@@ -108,14 +108,14 @@ static void add_pc_test_case(const char *mname)
         path =3D g_strdup_printf("cpu/%s/init/%ux%ux%u&maxcpus=3D%u",
                                mname, data->sockets, data->cores,
                                data->threads, data->maxcpus);
-        qtest_add_data_func_full(path, data, test_pc_without_cpu_add,
+        qtest_add_data_func_full(path, data, test_plug_without_cpu_add,
                                  test_data_free);
         g_free(path);
     } else {
         path =3D g_strdup_printf("cpu/%s/add/%ux%ux%u&maxcpus=3D%u",
                                mname, data->sockets, data->cores,
                                data->threads, data->maxcpus);
-        qtest_add_data_func_full(path, data, test_pc_with_cpu_add,
+        qtest_add_data_func_full(path, data, test_plug_with_cpu_add,
                                  test_data_free);
         g_free(path);
     }
--=20
1.8.3.1
