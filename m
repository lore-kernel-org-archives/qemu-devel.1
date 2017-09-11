Received: from eggs.gnu.org ([2001:4830:134:3::10]:39001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPB-00086C-LT
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSP6-0001Wd-U8
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:53 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:12 -0500
Message-Id: <20170911172022.4738-29-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 28/38] libqtest: Add qtest_[v]startf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Ben Warren <ben@skyportsystems.com>, "open list:IDE" <qemu-block@nongnu.org>

We have several callers that were formatting the argument strings
themselves; consolidate this effort by adding new convenience
functions directly in libqtest, and update all call-sites that
can benefit from it.

Note that the new functions qtest_startf() and qtest_vstartf()
behave more like qtest_init() (the caller must assign global_qtest
after the fact, rather than getting it implicitly set).  This helps
us prepare for future patches that get rid of the global variable,
by explicitly highlighting which tests still depend on it now.

In ide-test, we now have to pass a space to keep -Wformat from
complaining about a zero-length format string (one of gcc's more
pointless warnings, oh well).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h               | 25 ++++++++++++++++
 tests/libqtest.c               | 21 +++++++++++++
 tests/bios-tables-test.c       | 17 ++++-------
 tests/boot-order-test.c        | 11 +++----
 tests/boot-serial-test.c       | 12 +++-----
 tests/e1000-test.c             | 10 +------
 tests/e1000e-test.c            | 12 ++------
 tests/eepro100-test.c          | 11 +------
 tests/endianness-test.c        | 33 ++++++++-------------
 tests/i440fx-test.c            |  6 +---
 tests/ide-test.c               | 10 ++-----
 tests/ipmi-bt-test.c           | 11 +++----
 tests/libqos/libqos.c          |  5 +---
 tests/m25p80-test.c            |  9 ++----
 tests/numa-test.c              | 67 ++++++++++++++++--------------------------
 tests/pc-cpu-test.c            | 20 ++++---------
 tests/pnv-xscom-test.c         | 16 +++-------
 tests/prom-env-test.c          | 13 ++++----
 tests/pxe-test.c               | 14 ++++-----
 tests/qom-test.c               |  5 +---
 tests/tco-test.c               | 10 +++----
 tests/test-filter-mirror.c     | 14 ++++-----
 tests/test-filter-redirector.c | 56 ++++++++++++++++-------------------
 tests/test-hmp.c               |  5 +---
 tests/test-netfilter.c         |  7 ++---
 tests/vhost-user-test.c        | 51 ++++++++++----------------------
 tests/virtio-blk-test.c        |  5 +---
 tests/vmgenid-test.c           | 29 +++++-------------
 28 files changed, 199 insertions(+), 306 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 9ef0fbefea..817e3a5580 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -43,6 +43,31 @@ QTestState *qtest_start_without_qmp_handshake(const char *extra_args);
 QTestState *qtest_start(const char *args);

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
diff --git a/tests/libqtest.c b/tests/libqtest.c
index e8c2e11817..b535d7768f 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -245,6 +245,27 @@ QTestState *qtest_start(const char *extra_args)
     return global_qtest = s;
 }

+QTestState *qtest_vstartf(const char *fmt, va_list ap)
+{
+    char *args = g_strdup_vprintf(fmt, ap);
+    QTestState *s;
+
+    s = qtest_start(args);
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
     if (global_qtest) {
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 4272ea1496..c17cd8e1a3 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -623,17 +623,13 @@ static void test_smbios_structs(test_data *data)

 static void test_acpi_one(const char *params, test_data *data)
 {
-    char *args;
-
     /* Disable kernel irqchip to be able to override apic irq0. */
-    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
-                           "-net none -display none %s "
-                           "-drive id=hd0,if=none,file=%s,format=raw "
-                           "-device ide-hd,drive=hd0 ",
-                           data->machine, "kvm:tcg",
-                           params ? params : "", disk);
-
-    data->qts = qtest_init(args);
+    data->qts = qtest_startf("-machine %s,accel=%s,kernel-irqchip=off "
+                             "-net none -display none %s "
+                             "-drive id=hd0,if=none,file=%s,format=raw "
+                             "-device ide-hd,drive=hd0 ",
+                             data->machine, "kvm:tcg",
+                             params ? params : "", disk);

     boot_sector_test(data->qts);

@@ -658,7 +654,6 @@ static void test_acpi_one(const char *params, test_data *data)

     assert(!global_qtest);
     qtest_quit(data->qts);
-    g_free(args);
 }

 static uint8_t base_required_struct_types[] = {
diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index 5fc2ca8e9e..e70f5dedba 100644
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

diff --git a/tests/e1000-test.c b/tests/e1000-test.c
index 0c5fcdcc44..12bc526ad6 100644
--- a/tests/e1000-test.c
+++ b/tests/e1000-test.c
@@ -14,16 +14,8 @@
 static void test_device(gconstpointer data)
 {
     const char *model = data;
-    QTestState *s;
-    char *args;

-    args = g_strdup_printf("-device %s", model);
-    s = qtest_start(args);
-
-    if (s) {
-        qtest_quit(s);
-    }
-    g_free(args);
+    qtest_quit(qtest_startf("-device %s", model));
 }

 static const char *models[] = {
diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index 98f821fa7b..323aabb454 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -380,17 +380,11 @@ static void e1000e_device_clear(QPCIBus *bus, e1000e_device *d)

 static void data_test_init(e1000e_device *d)
 {
-    char *cmdline;
-
     int ret = socketpair(PF_UNIX, SOCK_STREAM, 0, test_sockets);
     g_assert_cmpint(ret, != , -1);

-    cmdline = g_strdup_printf("-netdev socket,fd=%d,id=hs0 "
-                              "-device e1000e,netdev=hs0", test_sockets[1]);
-    g_assert_nonnull(cmdline);
-
-    qtest_start(cmdline);
-    g_free(cmdline);
+    global_qtest = qtest_startf("-netdev socket,fd=%d,id=hs0 "
+                                "-device e1000e,netdev=hs0", test_sockets[1]);

     test_alloc = pc_alloc_init(global_qtest);
     g_assert_nonnull(test_alloc);
@@ -458,7 +452,7 @@ static void test_e1000e_hotplug(gconstpointer data)
 {
     static const uint8_t slot = 0x06;

-    qtest_start("-device e1000e");
+    global_qtest = qtest_start("-device e1000e");

     qpci_plug_device_test(global_qtest, "e1000e", "e1000e_net", slot, NULL);
     qpci_unplug_device_test(global_qtest, "e1000e_net", slot);
diff --git a/tests/eepro100-test.c b/tests/eepro100-test.c
index bdc8a67d57..fc9ea84d66 100644
--- a/tests/eepro100-test.c
+++ b/tests/eepro100-test.c
@@ -13,18 +13,9 @@
 static void test_device(gconstpointer data)
 {
     const char *model = data;
-    QTestState *s;
-    char *args;
-
-    args = g_strdup_printf("-device %s", model);
-    s = qtest_start(args);

     /* Tests only initialization so far. TODO: Implement functional tests */
-
-    if (s) {
-        qtest_quit(s);
-    }
-    g_free(args);
+    qtest_quit(qtest_startf("-device %s", model));
 }

 static const char *models[] = {
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
diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
index c847e4dbbb..c282ded4ca 100644
--- a/tests/i440fx-test.c
+++ b/tests/i440fx-test.c
@@ -33,11 +33,7 @@ typedef struct FirmwareTestFixture {

 static QPCIBus *test_start_get_bus(const TestData *s)
 {
-    char *cmdline;
-
-    cmdline = g_strdup_printf("-smp %d", s->num_cpus);
-    qtest_start(cmdline);
-    g_free(cmdline);
+    global_qtest = qtest_startf("-smp %d", s->num_cpus);
     return qpci_init_pc(global_qtest, NULL);
 }

diff --git a/tests/ide-test.c b/tests/ide-test.c
index 16b73e0101..e1650c0132 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -115,19 +115,15 @@ static QGuestAllocator *guest_malloc;
 static char tmp_path[] = "/tmp/qtest.XXXXXX";
 static char debug_path[] = "/tmp/qtest-blkdebug.XXXXXX";

-static void ide_test_start(const char *cmdline_fmt, ...)
+static void GCC_FMT_ATTR(1, 2) ide_test_start(const char *cmdline_fmt, ...)
 {
     va_list ap;
-    char *cmdline;

     va_start(ap, cmdline_fmt);
-    cmdline = g_strdup_vprintf(cmdline_fmt, ap);
+    global_qtest = qtest_vstartf(cmdline_fmt, ap);
     va_end(ap);

-    qtest_start(cmdline);
     guest_malloc = pc_alloc_init(global_qtest);
-
-    g_free(cmdline);
 }

 static void ide_test_quit(void)
@@ -675,7 +671,7 @@ static void test_flush_nodev(void)
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;

-    ide_test_start("");
+    ide_test_start(" ");

     dev = get_pci_device(&bmdma_bar, &ide_bar);

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
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 3ff61246a4..559fae36bd 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -15,19 +15,16 @@
  */
 QOSState *qtest_vboot(QOSOps *ops, const char *cmdline_fmt, va_list ap)
 {
-    char *cmdline;

     QOSState *qs = g_new0(QOSState, 1);

-    cmdline = g_strdup_vprintf(cmdline_fmt, ap);
-    qs->qts = qtest_init(cmdline);
+    qs->qts = qtest_vstartf(cmdline_fmt, ap);
     qs->ops = ops;
     if (ops) {
         qs->alloc = ops->init_allocator(qs->qts, ALLOC_NO_FLAGS);
         qs->pcibus = ops->qpci_init(qs->qts, qs->alloc);
     }

-    g_free(cmdline);
     return qs;
 }

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
diff --git a/tests/numa-test.c b/tests/numa-test.c
index fa21d26935..e2f6c68be8 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -12,20 +12,14 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"

-static char *make_cli(const char *generic_cli, const char *test_cli)
-{
-    return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test_cli);
-}
-
 static void test_mon_explicit(const void *data)
 {
     char *s;
-    char *cli;
+    const char *args = data;

-    cli = make_cli(data, "-smp 8 "
-                   "-numa node,nodeid=0,cpus=0-3 "
-                   "-numa node,nodeid=1,cpus=4-7 ");
-    qtest_start(cli);
+    global_qtest = qtest_startf("%s -smp 8 "
+                                "-numa node,nodeid=0,cpus=0-3 "
+                                "-numa node,nodeid=1,cpus=4-7 ", args);

     s = hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
@@ -33,16 +27,14 @@ static void test_mon_explicit(const void *data)
     g_free(s);

     qtest_quit(global_qtest);
-    g_free(cli);
 }

 static void test_mon_default(const void *data)
 {
     char *s;
-    char *cli;
+    const char *args = data;

-    cli = make_cli(data, "-smp 8 -numa node -numa node");
-    qtest_start(cli);
+    global_qtest = qtest_startf("%s -smp 8 -numa node -numa node", args);

     s = hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
@@ -50,18 +42,16 @@ static void test_mon_default(const void *data)
     g_free(s);

     qtest_quit(global_qtest);
-    g_free(cli);
 }

 static void test_mon_partial(const void *data)
 {
     char *s;
-    char *cli;
+    const char *args = data;

-    cli = make_cli(data, "-smp 8 "
-                   "-numa node,nodeid=0,cpus=0-1 "
-                   "-numa node,nodeid=1,cpus=4-5 ");
-    qtest_start(cli);
+    global_qtest = qtest_startf("%s -smp 8 "
+                                "-numa node,nodeid=0,cpus=0-1 "
+                                "-numa node,nodeid=1,cpus=4-5 ", args);

     s = hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
@@ -69,7 +59,6 @@ static void test_mon_partial(const void *data)
     g_free(s);

     qtest_quit(global_qtest);
-    g_free(cli);
 }

 static QList *get_cpus(QDict **resp)
@@ -82,13 +71,13 @@ static QList *get_cpus(QDict **resp)

 static void test_query_cpus(const void *data)
 {
-    char *cli;
+    const char *args = data;
     QDict *resp;
     QList *cpus;
     QObject *e;

-    cli = make_cli(data, "-smp 8 -numa node,cpus=0-3 -numa node,cpus=4-7");
-    qtest_start(cli);
+    global_qtest = qtest_startf("%s -smp 8 -numa node,cpus=0-3 "
+                                "-numa node,cpus=4-7", args);
     cpus = get_cpus(&resp);
     g_assert(cpus);

@@ -114,23 +103,22 @@ static void test_query_cpus(const void *data)

     QDECREF(resp);
     qtest_quit(global_qtest);
-    g_free(cli);
 }

 static void pc_numa_cpu(const void *data)
 {
-    char *cli;
+    const char *args = data;
     QDict *resp;
     QList *cpus;
     QObject *e;

-    cli = make_cli(data, "-cpu pentium -smp 8,sockets=2,cores=2,threads=2 "
+    global_qtest = qtest_startf(
+        "%s -cpu pentium -smp 8,sockets=2,cores=2,threads=2 "
         "-numa node,nodeid=0 -numa node,nodeid=1 "
         "-numa cpu,node-id=1,socket-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=1,thread-id=0 "
-        "-numa cpu,node-id=1,socket-id=1,core-id=1,thread-id=1");
-    qtest_start(cli);
+        "-numa cpu,node-id=1,socket-id=1,core-id=1,thread-id=1", args);
     cpus = get_cpus(&resp);
     g_assert(cpus);

@@ -167,23 +155,22 @@ static void pc_numa_cpu(const void *data)

     QDECREF(resp);
     qtest_quit(global_qtest);
-    g_free(cli);
 }

 static void spapr_numa_cpu(const void *data)
 {
-    char *cli;
+    const char *args = data;
     QDict *resp;
     QList *cpus;
     QObject *e;

-    cli = make_cli(data, "-smp 4,cores=4 "
+    global_qtest = qtest_startf(
+        "%s -smp 4,cores=4 "
         "-numa node,nodeid=0 -numa node,nodeid=1 "
         "-numa cpu,node-id=0,core-id=0 "
         "-numa cpu,node-id=0,core-id=1 "
         "-numa cpu,node-id=0,core-id=2 "
-        "-numa cpu,node-id=1,core-id=3");
-    qtest_start(cli);
+        "-numa cpu,node-id=1,core-id=3", args);
     cpus = get_cpus(&resp);
     g_assert(cpus);

@@ -212,21 +199,20 @@ static void spapr_numa_cpu(const void *data)

     QDECREF(resp);
     qtest_quit(global_qtest);
-    g_free(cli);
 }

 static void aarch64_numa_cpu(const void *data)
 {
-    char *cli;
+    const char *args = data;
     QDict *resp;
     QList *cpus;
     QObject *e;

-    cli = make_cli(data, "-smp 2 "
+    global_qtest = qtest_startf(
+        "%s -smp 2 "
         "-numa node,nodeid=0 -numa node,nodeid=1 "
         "-numa cpu,node-id=1,thread-id=0 "
-        "-numa cpu,node-id=0,thread-id=1");
-    qtest_start(cli);
+        "-numa cpu,node-id=0,thread-id=1", args);
     cpus = get_cpus(&resp);
     g_assert(cpus);

@@ -255,12 +241,11 @@ static void aarch64_numa_cpu(const void *data)

     QDECREF(resp);
     qtest_quit(global_qtest);
-    g_free(cli);
 }

 int main(int argc, char **argv)
 {
-    const char *args = NULL;
+    const char *args = "";
     const char *arch = qtest_get_arch();

     if (strcmp(arch, "aarch64") == 0) {
diff --git a/tests/pc-cpu-test.c b/tests/pc-cpu-test.c
index 3ff7115625..08510a44bf 100644
--- a/tests/pc-cpu-test.c
+++ b/tests/pc-cpu-test.c
@@ -26,15 +26,12 @@ typedef struct PCTestData PCTestData;
 static void test_pc_with_cpu_add(gconstpointer data)
 {
     const PCTestData *s = data;
-    char *args;
     QDict *response;
     unsigned int i;

-    args = g_strdup_printf("-machine %s -cpu %s "
-                           "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
-                           s->machine, s->cpu_model,
-                           s->sockets, s->cores, s->threads, s->maxcpus);
-    qtest_start(args);
+    global_qtest = qtest_startf(
+        "-machine %s -cpu %s -smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
+        s->machine, s->cpu_model, s->sockets, s->cores, s->threads, s->maxcpus);

     for (i = s->sockets * s->cores * s->threads; i < s->maxcpus; i++) {
         response = qmp("{ 'execute': 'cpu-add',"
@@ -45,20 +42,16 @@ static void test_pc_with_cpu_add(gconstpointer data)
     }

     qtest_quit(global_qtest);
-    g_free(args);
 }

 static void test_pc_without_cpu_add(gconstpointer data)
 {
     const PCTestData *s = data;
-    char *args;
     QDict *response;

-    args = g_strdup_printf("-machine %s -cpu %s "
-                           "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
-                           s->machine, s->cpu_model,
-                           s->sockets, s->cores, s->threads, s->maxcpus);
-    qtest_start(args);
+    global_qtest = qtest_startf(
+        "-machine %s -cpu %s -smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
+        s->machine, s->cpu_model, s->sockets, s->cores, s->threads, s->maxcpus);

     response = qmp("{ 'execute': 'cpu-add',"
                    "  'arguments': { 'id': %d } }",
@@ -68,7 +61,6 @@ static void test_pc_without_cpu_add(gconstpointer data)
     QDECREF(response);

     qtest_quit(global_qtest);
-    g_free(args);
 }

 static void test_data_free(gpointer data)
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
index eac207b30e..0f8e6950fd 100644
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
diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index e2d3853534..5f3516e87f 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -23,17 +23,13 @@ static char disk[] = "tests/pxe-test-disk-XXXXXX";

 static void test_pxe_one(const char *params, bool ipv6)
 {
-    char *args;
-
-    args = g_strdup_printf("-machine accel=kvm:tcg -nodefaults -boot order=n "
-                           "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
-                           "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
-                           ipv6 ? "on" : "off", params);
-
-    qtest_start(args);
+    global_qtest = qtest_startf(
+        "-machine accel=kvm:tcg -nodefaults -boot order=n "
+        "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
+        "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
+        ipv6 ? "on" : "off", params);
     boot_sector_test(global_qtest);
     qtest_quit(global_qtest);
-    g_free(args);
 }

 static void test_pxe_e1000(void)
diff --git a/tests/qom-test.c b/tests/qom-test.c
index 661a6edefd..8ed8d7b528 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -90,11 +90,9 @@ static void test_properties(const char *path, bool recurse)
 static void test_machine(gconstpointer data)
 {
     const char *machine = data;
-    char *args;
     QDict *response;

-    args = g_strdup_printf("-machine %s", machine);
-    qtest_start(args);
+    global_qtest = qtest_startf("-machine %s", machine);

     test_properties("/machine", true);

@@ -103,7 +101,6 @@ static void test_machine(gconstpointer data)
     QDECREF(response);

     qtest_quit(global_qtest);
-    g_free(args);
     g_free((void *)machine);
 }

diff --git a/tests/tco-test.c b/tests/tco-test.c
index 3d4b3db308..b84a50927a 100644
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

     d->bus = qpci_init_pc(qs, NULL);
     d->dev = qpci_device_find(d->bus, QPCI_DEVFN(0x1f, 0x00));
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index 85fb38976d..c590698991 100644
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
index d3a0b1cdf4..bcb338e7c1 100644
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
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 752f4b63bd..7ff47eda13 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -119,16 +119,13 @@ static void test_info_commands(void)
 static void test_machine(gconstpointer data)
 {
     const char *machine = data;
-    char *args;

-    args = g_strdup_printf("-S -M %s", machine);
-    qtest_start(args);
+    global_qtest = qtest_startf("-S -M %s", machine);

     test_info_commands();
     test_commands();

     qtest_quit(global_qtest);
-    g_free(args);
     g_free((void *)data);
 }

diff --git a/tests/test-netfilter.c b/tests/test-netfilter.c
index ffb11dbfb7..bf9163e79f 100644
--- a/tests/test-netfilter.c
+++ b/tests/test-netfilter.c
@@ -182,7 +182,6 @@ static void remove_netdev_with_multi_netfilter(void)
 int main(int argc, char **argv)
 {
     int ret;
-    char *args;
     const char *devstr = "e1000";

     if (g_str_equal(qtest_get_arch(), "s390x")) {
@@ -197,13 +196,11 @@ int main(int argc, char **argv)
     qtest_add_func("/netfilter/remove_netdev_multi",
                    remove_netdev_with_multi_netfilter);

-    args = g_strdup_printf("-netdev user,id=qtest-bn0 "
-                           "-device %s,netdev=qtest-bn0", devstr);
-    qtest_start(args);
+    global_qtest = qtest_startf("-netdev user,id=qtest-bn0 "
+                                "-device %s,netdev=qtest-bn0", devstr);
     ret = g_test_run();

     qtest_quit(global_qtest);
-    g_free(args);

     return ret;
 }
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index d5afc5f9f6..c205a9100a 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -479,12 +479,12 @@ static void test_server_listen(TestServer *server)
 }

 #define GET_QEMU_CMD(s)                                         \
-    g_strdup_printf(QEMU_CMD, 512, 512, (root), (s)->chr_name,  \
-                    (s)->socket_path, "", (s)->chr_name)
+    QEMU_CMD, 512, 512, (root), (s)->chr_name,                  \
+        (s)->socket_path, "", (s)->chr_name

 #define GET_QEMU_CMDE(s, mem, chr_opts, extra, ...)                     \
-    g_strdup_printf(QEMU_CMD extra, (mem), (mem), (root), (s)->chr_name, \
-                    (s)->socket_path, (chr_opts), (s)->chr_name, ##__VA_ARGS__)
+    QEMU_CMD extra, (mem), (mem), (root), (s)->chr_name,                \
+        (s)->socket_path, (chr_opts), (s)->chr_name, ##__VA_ARGS__

 static gboolean _test_server_free(TestServer *server)
 {
@@ -634,7 +634,6 @@ static void test_migrate(void)
     TestServer *dest = test_server_new("dest");
     char *uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
     GSource *source;
-    gchar *cmd;
     QDict *rsp;
     guint8 *log;
     guint64 size;
@@ -642,18 +641,14 @@ static void test_migrate(void)
     test_server_listen(s);
     test_server_listen(dest);

-    cmd = GET_QEMU_CMDE(s, 2, "", "");
-    s->qts = qtest_init(cmd);
-    g_free(cmd);
+    s->qts = qtest_startf(GET_QEMU_CMDE(s, 2, "", ""));

     init_virtio_dev(s);
     wait_for_fds(s);
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));

-    cmd = GET_QEMU_CMDE(dest, 2, "", " -incoming %s", uri);
-    dest->qts = qtest_init(cmd);
-    g_free(cmd);
+    dest->qts = qtest_startf(GET_QEMU_CMDE(dest, 2, "", " -incoming %s", uri));

     source = g_source_new(&test_migrate_source_funcs,
                           sizeof(TestMigrateSource));
@@ -751,12 +746,9 @@ connect_thread(gpointer data)
 static void test_reconnect_subprocess(void)
 {
     TestServer *s = test_server_new("reconnect");
-    char *cmd;

     g_thread_new("connect", connect_thread, s);
-    cmd = GET_QEMU_CMDE(s, 2, ",server", "");
-    s->qts = qtest_init(cmd);
-    g_free(cmd);
+    s->qts = qtest_startf(GET_QEMU_CMDE(s, 2, ",server", ""));

     init_virtio_dev(s);
     wait_for_fds(s);
@@ -785,13 +777,10 @@ static void test_reconnect(void)
 static void test_connect_fail_subprocess(void)
 {
     TestServer *s = test_server_new("connect-fail");
-    char *cmd;

     s->test_fail = true;
     g_thread_new("connect", connect_thread, s);
-    cmd = GET_QEMU_CMDE(s, 2, ",server", "");
-    s->qts = qtest_init(cmd);
-    g_free(cmd);
+    s->qts = qtest_startf(GET_QEMU_CMDE(s, 2, ",server", ""));

     init_virtio_dev(s);
     wait_for_fds(s);
@@ -812,13 +801,10 @@ static void test_connect_fail(void)
 static void test_flags_mismatch_subprocess(void)
 {
     TestServer *s = test_server_new("flags-mismatch");
-    char *cmd;

     s->test_flags = TEST_FLAGS_DISCONNECT;
     g_thread_new("connect", connect_thread, s);
-    cmd = GET_QEMU_CMDE(s, 2, ",server", "");
-    s->qts = qtest_init(cmd);
-    g_free(cmd);
+    s->qts = qtest_startf(GET_QEMU_CMDE(s, 2, ",server", ""));

     init_virtio_dev(s);
     wait_for_fds(s);
@@ -877,19 +863,16 @@ static void test_multiqueue(void)
     QPCIBus *bus;
     QVirtQueuePCI *vq[queues * 2];
     QGuestAllocator *alloc;
-    char *cmd;
     int i;

     s->queues = queues;
     test_server_listen(s);

-    cmd = g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
-                          "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
-                          512, 512, root, s->chr_name,
-                          s->socket_path, "", s->chr_name,
-                          queues, queues * 2 + 2);
-    s->qts = qtest_init(cmd);
-    g_free(cmd);
+    s->qts = qtest_startf(
+        QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
+        "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
+        512, 512, root, s->chr_name, s->socket_path, "", s->chr_name,
+        queues, queues * 2 + 2);

     bus = qpci_init_pc(s->qts, NULL);
     dev = virtio_net_pci_init(bus, PCI_SLOT);
@@ -919,7 +902,6 @@ int main(int argc, char **argv)
 {
     TestServer *server = NULL;
     const char *hugefs;
-    char *qemu_cmd = NULL;
     int ret;
     char template[] = "/tmp/vhost-test-XXXXXX";
     GMainLoop *loop;
@@ -951,10 +933,7 @@ int main(int argc, char **argv)
     /* run the main loop thread so the chardev may operate */
     thread = g_thread_new(NULL, thread_function, loop);

-    qemu_cmd = GET_QEMU_CMD(server);
-
-    server->qts = qtest_init(qemu_cmd);
-    g_free(qemu_cmd);
+    server->qts = qtest_startf(GET_QEMU_CMD(server));
     init_virtio_dev(server);

     qtest_add_data_func("/vhost-user/read-guest-mem", server, read_guest_mem);
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index ce316e753e..9594fbf437 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -85,19 +85,16 @@ static QOSState *pci_test_start(void)

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
index 970c6274fd..108a5d9a6e 100644
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
2.13.5
