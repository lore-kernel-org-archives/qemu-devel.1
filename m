Received: from eggs.gnu.org ([2001:4830:134:3::10]:59811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vur-0003vz-29
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vuo-0004Az-8E
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:41 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:15 +0200
Message-Id: <20171020115418.2050-44-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 43/46] libqtest: Add qtest_[v]startf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Eric Blake <eblake@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Eric Blake <eblake@redhat.com>

We have several callers that were formatting the argument strings
themselves; consolidate this effort by adding new convenience
functions directly in libqtest, and update some call-sites that
can benefit from it.

Note that the new functions qtest_startf() and qtest_vstartf()
behave more like qtest_init() (the caller must assign global_qtest
after the fact, rather than getting it implicitly set).  This helps
us prepare for future patches that get rid of the global variable,
by explicitly highlighting which tests still depend on it now.

Signed-off-by: Eric Blake <eblake@redhat.com>
[thuth: Dropped the hunks that do not apply cleanly to qemu master
 yet and added the missing g_free(args) in qtest_vstartf()]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1508336428-20511-2-git-send-email-thuth@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 tests/boot-order-test.c        | 11 +++------
 tests/boot-serial-test.c       | 12 +++------
 tests/endianness-test.c        | 33 +++++++++----------------
 tests/ipmi-bt-test.c           | 11 +++------
 tests/libqtest.c               | 22 +++++++++++++++++
 tests/libqtest.h               | 25 +++++++++++++++++++
 tests/m25p80-test.c            |  9 +++----
 tests/pnv-xscom-test.c         | 16 +++---------
 tests/prom-env-test.c          | 13 ++++------
 tests/tco-test.c               | 10 +++-----
 tests/test-filter-mirror.c     | 14 +++++------
 tests/test-filter-redirector.c | 56 ++++++++++++++++++++----------------------
 tests/virtio-blk-test.c        |  5 +---
 tests/vmgenid-test.c           | 29 ++++++----------------
 14 files changed, 128 insertions(+), 138 deletions(-)

diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index fc1e7941f7..60c5545e45 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -28,14 +28,12 @@ static void test_a_boot_order(const char *machine,
                               uint64_t expected_boot,
                               uint64_t expected_reboot)
 {
-    char *args;
     uint64_t actual;
 
-    args = g_strdup_printf("-nodefaults%s%s %s",
-                           machine ? " -M " : "",
-                           machine ?: "",
-                           test_args);
-    qtest_start(args);
+    global_qtest = qtest_startf("-nodefaults%s%s %s",
+                                machine ? " -M " : "",
+                                machine ?: "",
+                                test_args);
     actual = read_boot_order();
     g_assert_cmphex(actual, ==, expected_boot);
     qmp_discard_response("{ 'execute': 'system_reset' }");
@@ -47,7 +45,6 @@ static void test_a_boot_order(const char *machine,
     actual = read_boot_order();
     g_assert_cmphex(actual, ==, expected_reboot);
     qtest_quit(global_qtest);
-    g_free(args);
 }
 
 static void test_boot_orders(const char *machine,
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index b95c5e74ea..c935d69824 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -71,7 +71,6 @@ done:
 static void test_machine(const void *data)
 {
     const testdef_t *test = data;
-    char *args;
     char tmpname[] = "/tmp/qtest-boot-serial-XXXXXX";
     int fd;
 
@@ -82,18 +81,15 @@ static void test_machine(const void *data)
      * Make sure that this test uses tcg if available: It is used as a
      * fast-enough smoketest for that.
      */
-    args = g_strdup_printf("-M %s,accel=tcg:kvm "
-                           "-chardev file,id=serial0,path=%s "
-                           "-no-shutdown -serial chardev:serial0 %s",
-                           test->machine, tmpname, test->extra);
-
-    qtest_start(args);
+    global_qtest = qtest_startf("-M %s,accel=tcg:kvm "
+                                "-chardev file,id=serial0,path=%s "
+                                "-no-shutdown -serial chardev:serial0 %s",
+                                test->machine, tmpname, test->extra);
     unlink(tmpname);
 
     check_guest_output(test, fd);
     qtest_quit(global_qtest);
 
-    g_free(args);
     close(fd);
 }
 
diff --git a/tests/endianness-test.c b/tests/endianness-test.c
index ed0bf52019..546e0969e4 100644
--- a/tests/endianness-test.c
+++ b/tests/endianness-test.c
@@ -114,13 +114,11 @@ static void isa_outl(const TestCase *test, uint16_t addr, uint32_t value)
 static void test_endianness(gconstpointer data)
 {
     const TestCase *test = data;
-    char *args;
 
-    args = g_strdup_printf("-M %s%s%s -device pc-testdev",
-                           test->machine,
-                           test->superio ? " -device " : "",
-                           test->superio ?: "");
-    qtest_start(args);
+    global_qtest = qtest_startf("-M %s%s%s -device pc-testdev",
+                                test->machine,
+                                test->superio ? " -device " : "",
+                                test->superio ?: "");
     isa_outl(test, 0xe0, 0x87654321);
     g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654321);
     g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
@@ -183,19 +181,16 @@ static void test_endianness(gconstpointer data)
     g_assert_cmphex(isa_inb(test, 0xe1), ==, 0x43);
     g_assert_cmphex(isa_inb(test, 0xe0), ==, 0x21);
     qtest_quit(global_qtest);
-    g_free(args);
 }
 
 static void test_endianness_split(gconstpointer data)
 {
     const TestCase *test = data;
-    char *args;
 
-    args = g_strdup_printf("-M %s%s%s -device pc-testdev",
-                           test->machine,
-                           test->superio ? " -device " : "",
-                           test->superio ?: "");
-    qtest_start(args);
+    global_qtest = qtest_startf("-M %s%s%s -device pc-testdev",
+                                test->machine,
+                                test->superio ? " -device " : "",
+                                test->superio ?: "");
     isa_outl(test, 0xe8, 0x87654321);
     g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654321);
     g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
@@ -230,19 +225,16 @@ static void test_endianness_split(gconstpointer data)
     g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
     g_assert_cmphex(isa_inw(test, 0xe0), ==, 0x4321);
     qtest_quit(global_qtest);
-    g_free(args);
 }
 
 static void test_endianness_combine(gconstpointer data)
 {
     const TestCase *test = data;
-    char *args;
 
-    args = g_strdup_printf("-M %s%s%s -device pc-testdev",
-                           test->machine,
-                           test->superio ? " -device " : "",
-                           test->superio ?: "");
-    qtest_start(args);
+    global_qtest = qtest_startf("-M %s%s%s -device pc-testdev",
+                                test->machine,
+                                test->superio ? " -device " : "",
+                                test->superio ?: "");
     isa_outl(test, 0xe0, 0x87654321);
     g_assert_cmphex(isa_inl(test, 0xe8), ==, 0x87654321);
     g_assert_cmphex(isa_inw(test, 0xea), ==, 0x8765);
@@ -277,7 +269,6 @@ static void test_endianness_combine(gconstpointer data)
     g_assert_cmphex(isa_inw(test, 0xea), ==, 0x8765);
     g_assert_cmphex(isa_inw(test, 0xe8), ==, 0x4321);
     qtest_quit(global_qtest);
-    g_free(args);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/ipmi-bt-test.c b/tests/ipmi-bt-test.c
index 7e21a9bbcb..8be18e3f42 100644
--- a/tests/ipmi-bt-test.c
+++ b/tests/ipmi-bt-test.c
@@ -401,7 +401,6 @@ static void open_socket(void)
 int main(int argc, char **argv)
 {
     const char *arch = qtest_get_arch();
-    char *cmdline;
     int ret;
 
     /* Check architecture */
@@ -415,12 +414,10 @@ int main(int argc, char **argv)
     /* Run the tests */
     g_test_init(&argc, &argv, NULL);
 
-    cmdline = g_strdup_printf(
-          " -chardev socket,id=ipmi0,host=localhost,port=%d,reconnect=10"
-          " -device ipmi-bmc-extern,chardev=ipmi0,id=bmc0"
-          " -device isa-ipmi-bt,bmc=bmc0", emu_port);
-    qtest_start(cmdline);
-    g_free(cmdline);
+    global_qtest = qtest_startf(
+        " -chardev socket,id=ipmi0,host=localhost,port=%d,reconnect=10"
+        " -device ipmi-bmc-extern,chardev=ipmi0,id=bmc0"
+        " -device isa-ipmi-bt,bmc=bmc0", emu_port);
     qtest_irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/ipmi/extern/connect", test_connect);
     qtest_add_func("/ipmi/extern/bt_base", test_bt_base);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index adf71188b6..0ec8af2923 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -244,6 +244,28 @@ QTestState *qtest_init(const char *extra_args)
     return s;
 }
 
+QTestState *qtest_vstartf(const char *fmt, va_list ap)
+{
+    char *args = g_strdup_vprintf(fmt, ap);
+    QTestState *s;
+
+    s = qtest_start(args);
+    g_free(args);
+    global_qtest = NULL;
+    return s;
+}
+
+QTestState *qtest_startf(const char *fmt, ...)
+{
+    va_list ap;
+    QTestState *s;
+
+    va_start(ap, fmt);
+    s = qtest_vstartf(fmt, ap);
+    va_end(ap);
+    return s;
+}
+
 void qtest_quit(QTestState *s)
 {
     g_hook_destroy_link(&abrt_hooks, g_hook_find_data(&abrt_hooks, TRUE, s));
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 86b3a3bb0d..fe7847cbd5 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -24,6 +24,31 @@ typedef struct QTestState QTestState;
 extern QTestState *global_qtest;
 
 /**
+ * qtest_startf:
+ * @fmt...: Format for creating other arguments to pass to QEMU, formatted
+ * like sprintf().
+ *
+ * Start QEMU and return the resulting #QTestState (but unlike qtest_start(),
+ * #global_qtest is left at NULL).
+ *
+ * Returns: #QTestState instance.
+ */
+QTestState *qtest_startf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
+
+/**
+ * qtest_vstartf:
+ * @fmt: Format for creating other arguments to pass to QEMU, formatted
+ * like vsprintf().
+ * @ap: Format arguments.
+ *
+ * Start QEMU and return the resulting #QTestState (but unlike qtest_start(),
+ * #global_qtest is left at NULL).
+ *
+ * Returns: #QTestState instance.
+ */
+QTestState *qtest_vstartf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
+
+/**
  * qtest_init:
  * @extra_args: other arguments to pass to QEMU.
  *
diff --git a/tests/m25p80-test.c b/tests/m25p80-test.c
index 244aa33dd9..c276e738e9 100644
--- a/tests/m25p80-test.c
+++ b/tests/m25p80-test.c
@@ -354,7 +354,6 @@ int main(int argc, char **argv)
 {
     int ret;
     int fd;
-    char *args;
 
     g_test_init(&argc, &argv, NULL);
 
@@ -364,10 +363,9 @@ int main(int argc, char **argv)
     g_assert(ret == 0);
     close(fd);
 
-    args = g_strdup_printf("-m 256 -machine palmetto-bmc "
-                           "-drive file=%s,format=raw,if=mtd",
-                           tmp_path);
-    qtest_start(args);
+    global_qtest = qtest_startf("-m 256 -machine palmetto-bmc "
+                                "-drive file=%s,format=raw,if=mtd",
+                                tmp_path);
 
     qtest_add_func("/m25p80/read_jedec", test_read_jedec);
     qtest_add_func("/m25p80/erase_sector", test_erase_sector);
@@ -380,6 +378,5 @@ int main(int argc, char **argv)
 
     qtest_quit(global_qtest);
     unlink(tmp_path);
-    g_free(args);
     return ret;
 }
diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 5adc3fd3a9..89fa6282d3 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -81,16 +81,12 @@ static void test_xscom_cfam_id(const PnvChip *chip)
 
 static void test_cfam_id(const void *data)
 {
-    char *args;
     const PnvChip *chip = data;
 
-    args = g_strdup_printf("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
-
-    qtest_start(args);
+    global_qtest = qtest_startf("-M powernv,accel=tcg -cpu %s",
+                                chip->cpu_model);
     test_xscom_cfam_id(chip);
     qtest_quit(global_qtest);
-
-    g_free(args);
 }
 
 #define PNV_XSCOM_EX_CORE_BASE(chip, i)                 \
@@ -109,16 +105,12 @@ static void test_xscom_core(const PnvChip *chip)
 
 static void test_core(const void *data)
 {
-    char *args;
     const PnvChip *chip = data;
 
-    args = g_strdup_printf("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
-
-    qtest_start(args);
+    global_qtest = qtest_startf("-M powernv,accel=tcg -cpu %s",
+                                chip->cpu_model);
     test_xscom_core(chip);
     qtest_quit(global_qtest);
-
-    g_free(args);
 }
 
 static void add_test(const char *name, void (*test)(const void *data))
diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index bc8b616912..8c867e631a 100644
--- a/tests/prom-env-test.c
+++ b/tests/prom-env-test.c
@@ -44,21 +44,18 @@ static void check_guest_memory(void)
 
 static void test_machine(const void *machine)
 {
-    char *args;
     const char *extra_args;
 
     /* The pseries firmware boots much faster without the default devices */
     extra_args = strcmp(machine, "pseries") == 0 ? "-nodefaults" : "";
 
-    args = g_strdup_printf("-M %s,accel=tcg %s -prom-env 'use-nvramrc?=true' "
-                           "-prom-env 'nvramrc=%x %x l!' ",
-                           (const char *)machine, extra_args, MAGIC, ADDRESS);
-
-    qtest_start(args);
+    global_qtest = qtest_startf("-M %s,accel=tcg %s "
+                                "-prom-env 'use-nvramrc?=true' "
+                                "-prom-env 'nvramrc=%x %x l!' ",
+                                (const char *)machine, extra_args,
+                                MAGIC, ADDRESS);
     check_guest_memory();
     qtest_quit(global_qtest);
-
-    g_free(args);
 }
 
 static void add_tests(const char *machines[])
diff --git a/tests/tco-test.c b/tests/tco-test.c
index c4c264eb3d..2616d33c29 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -55,14 +55,12 @@ static void test_end(TestData *d)
 static void test_init(TestData *d)
 {
     QTestState *qs;
-    char *s;
 
-    s = g_strdup_printf("-machine q35 %s %s",
-                        d->noreboot ? "" : "-global ICH9-LPC.noreboot=false",
-                        !d->args ? "" : d->args);
-    qs = qtest_start(s);
+    qs = qtest_startf("-machine q35 %s %s",
+                      d->noreboot ? "" : "-global ICH9-LPC.noreboot=false",
+                      !d->args ? "" : d->args);
+    global_qtest = qs;
     qtest_irq_intercept_in(qs, "ioapic");
-    g_free(s);
 
     d->bus = qpci_init_pc(NULL);
     d->dev = qpci_device_find(d->bus, QPCI_DEVFN(0x1f, 0x00));
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index d569d27657..6c6f710dc6 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -18,7 +18,6 @@
 static void test_mirror(void)
 {
     int send_sock[2], recv_sock;
-    char *cmdline;
     uint32_t ret = 0, len = 0;
     char send_buf[] = "Hello! filter-mirror~";
     char sock_path[] = "filter-mirror.XXXXXX";
@@ -37,13 +36,12 @@ static void test_mirror(void)
     ret = mkstemp(sock_path);
     g_assert_cmpint(ret, !=, -1);
 
-    cmdline = g_strdup_printf("-netdev socket,id=qtest-bn0,fd=%d "
-                 "-device %s,netdev=qtest-bn0,id=qtest-e0 "
-                 "-chardev socket,id=mirror0,path=%s,server,nowait "
-                 "-object filter-mirror,id=qtest-f0,netdev=qtest-bn0,queue=tx,outdev=mirror0 "
-                 , send_sock[1], devstr, sock_path);
-    qtest_start(cmdline);
-    g_free(cmdline);
+    global_qtest = qtest_startf(
+        "-netdev socket,id=qtest-bn0,fd=%d "
+        "-device %s,netdev=qtest-bn0,id=qtest-e0 "
+        "-chardev socket,id=mirror0,path=%s,server,nowait "
+        "-object filter-mirror,id=qtest-f0,netdev=qtest-bn0,queue=tx,outdev=mirror0 "
+        , send_sock[1], devstr, sock_path);
 
     recv_sock = unix_connect(sock_path, NULL);
     g_assert_cmpint(recv_sock, !=, -1);
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index 3afd41110d..f2566144cf 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -70,7 +70,6 @@ static const char *get_devstr(void)
 static void test_redirector_tx(void)
 {
     int backend_sock[2], recv_sock;
-    char *cmdline;
     uint32_t ret = 0, len = 0;
     char send_buf[] = "Hello!!";
     char sock_path0[] = "filter-redirector0.XXXXXX";
@@ -87,20 +86,19 @@ static void test_redirector_tx(void)
     ret = mkstemp(sock_path1);
     g_assert_cmpint(ret, !=, -1);
 
-    cmdline = g_strdup_printf("-netdev socket,id=qtest-bn0,fd=%d "
-                "-device %s,netdev=qtest-bn0,id=qtest-e0 "
-                "-chardev socket,id=redirector0,path=%s,server,nowait "
-                "-chardev socket,id=redirector1,path=%s,server,nowait "
-                "-chardev socket,id=redirector2,path=%s,nowait "
-                "-object filter-redirector,id=qtest-f0,netdev=qtest-bn0,"
-                "queue=tx,outdev=redirector0 "
-                "-object filter-redirector,id=qtest-f1,netdev=qtest-bn0,"
-                "queue=tx,indev=redirector2 "
-                "-object filter-redirector,id=qtest-f2,netdev=qtest-bn0,"
-                "queue=tx,outdev=redirector1 ", backend_sock[1], get_devstr(),
-                sock_path0, sock_path1, sock_path0);
-    qtest_start(cmdline);
-    g_free(cmdline);
+    global_qtest = qtest_startf(
+        "-netdev socket,id=qtest-bn0,fd=%d "
+        "-device %s,netdev=qtest-bn0,id=qtest-e0 "
+        "-chardev socket,id=redirector0,path=%s,server,nowait "
+        "-chardev socket,id=redirector1,path=%s,server,nowait "
+        "-chardev socket,id=redirector2,path=%s,nowait "
+        "-object filter-redirector,id=qtest-f0,netdev=qtest-bn0,"
+        "queue=tx,outdev=redirector0 "
+        "-object filter-redirector,id=qtest-f1,netdev=qtest-bn0,"
+        "queue=tx,indev=redirector2 "
+        "-object filter-redirector,id=qtest-f2,netdev=qtest-bn0,"
+        "queue=tx,outdev=redirector1 ", backend_sock[1], get_devstr(),
+        sock_path0, sock_path1, sock_path0);
 
     recv_sock = unix_connect(sock_path1, NULL);
     g_assert_cmpint(recv_sock, !=, -1);
@@ -141,7 +139,6 @@ static void test_redirector_tx(void)
 static void test_redirector_rx(void)
 {
     int backend_sock[2], send_sock;
-    char *cmdline;
     uint32_t ret = 0, len = 0;
     char send_buf[] = "Hello!!";
     char sock_path0[] = "filter-redirector0.XXXXXX";
@@ -158,20 +155,19 @@ static void test_redirector_rx(void)
     ret = mkstemp(sock_path1);
     g_assert_cmpint(ret, !=, -1);
 
-    cmdline = g_strdup_printf("-netdev socket,id=qtest-bn0,fd=%d "
-                "-device %s,netdev=qtest-bn0,id=qtest-e0 "
-                "-chardev socket,id=redirector0,path=%s,server,nowait "
-                "-chardev socket,id=redirector1,path=%s,server,nowait "
-                "-chardev socket,id=redirector2,path=%s,nowait "
-                "-object filter-redirector,id=qtest-f0,netdev=qtest-bn0,"
-                "queue=rx,indev=redirector0 "
-                "-object filter-redirector,id=qtest-f1,netdev=qtest-bn0,"
-                "queue=rx,outdev=redirector2 "
-                "-object filter-redirector,id=qtest-f2,netdev=qtest-bn0,"
-                "queue=rx,indev=redirector1 ", backend_sock[1], get_devstr(),
-                sock_path0, sock_path1, sock_path0);
-    qtest_start(cmdline);
-    g_free(cmdline);
+    global_qtest = qtest_startf(
+        "-netdev socket,id=qtest-bn0,fd=%d "
+        "-device %s,netdev=qtest-bn0,id=qtest-e0 "
+        "-chardev socket,id=redirector0,path=%s,server,nowait "
+        "-chardev socket,id=redirector1,path=%s,server,nowait "
+        "-chardev socket,id=redirector2,path=%s,nowait "
+        "-object filter-redirector,id=qtest-f0,netdev=qtest-bn0,"
+        "queue=rx,indev=redirector0 "
+        "-object filter-redirector,id=qtest-f1,netdev=qtest-bn0,"
+        "queue=rx,outdev=redirector2 "
+        "-object filter-redirector,id=qtest-f2,netdev=qtest-bn0,"
+        "queue=rx,indev=redirector1 ", backend_sock[1], get_devstr(),
+        sock_path0, sock_path1, sock_path0);
 
     struct iovec iov[] = {
         {
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 0576cb16ba..e6fb9bac87 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -84,19 +84,16 @@ static QOSState *pci_test_start(void)
 
 static void arm_test_start(void)
 {
-    char *cmdline;
     char *tmp_path;
 
     tmp_path = drive_create();
 
-    cmdline = g_strdup_printf("-machine virt "
+    global_qtest = qtest_startf("-machine virt "
                                 "-drive if=none,id=drive0,file=%s,format=raw "
                                 "-device virtio-blk-device,drive=drive0",
                                 tmp_path);
-    qtest_start(cmdline);
     unlink(tmp_path);
     g_free(tmp_path);
-    g_free(cmdline);
 }
 
 static void test_end(void)
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 918c82c82a..b6e7b3b086 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -130,41 +130,32 @@ static void read_guid_from_monitor(QemuUUID *guid)
 
 static char disk[] = "tests/vmgenid-test-disk-XXXXXX";
 
-static char *guid_cmd_strdup(const char *guid)
-{
-    return g_strdup_printf("-machine accel=kvm:tcg "
-                           "-device vmgenid,id=testvgid,guid=%s "
-                           "-drive id=hd0,if=none,file=%s,format=raw "
-                           "-device ide-hd,drive=hd0 ",
-                           guid, disk);
-}
-
+#define GUID_CMD(guid)                          \
+    "-machine accel=kvm:tcg "                   \
+    "-device vmgenid,id=testvgid,guid=%s "      \
+    "-drive id=hd0,if=none,file=%s,format=raw " \
+    "-device ide-hd,drive=hd0 ", guid, disk
 
 static void vmgenid_set_guid_test(void)
 {
     QemuUUID expected, measured;
-    gchar *cmd;
 
     g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);
 
-    cmd = guid_cmd_strdup(VGID_GUID);
-    qtest_start(cmd);
+    global_qtest = qtest_startf(GUID_CMD(VGID_GUID));
 
     /* Read the GUID from accessing guest memory */
     read_guid_from_memory(&measured);
     g_assert(memcmp(measured.data, expected.data, sizeof(measured.data)) == 0);
 
     qtest_quit(global_qtest);
-    g_free(cmd);
 }
 
 static void vmgenid_set_guid_auto_test(void)
 {
-    char *cmd;
     QemuUUID measured;
 
-    cmd = guid_cmd_strdup("auto");
-    qtest_start(cmd);
+    global_qtest = qtest_startf(GUID_CMD("auto"));
 
     read_guid_from_memory(&measured);
 
@@ -172,25 +163,21 @@ static void vmgenid_set_guid_auto_test(void)
     g_assert(!qemu_uuid_is_null(&measured));
 
     qtest_quit(global_qtest);
-    g_free(cmd);
 }
 
 static void vmgenid_query_monitor_test(void)
 {
     QemuUUID expected, measured;
-    gchar *cmd;
 
     g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);
 
-    cmd = guid_cmd_strdup(VGID_GUID);
-    qtest_start(cmd);
+    global_qtest = qtest_startf(GUID_CMD(VGID_GUID));
 
     /* Read the GUID via the monitor */
     read_guid_from_monitor(&measured);
     g_assert(memcmp(measured.data, expected.data, sizeof(measured.data)) == 0);
 
     qtest_quit(global_qtest);
-    g_free(cmd);
 }
 
 int main(int argc, char **argv)
-- 
2.13.6
