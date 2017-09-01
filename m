Received: from eggs.gnu.org ([2001:4830:134:3::10]:56784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqJO-00081a-BN
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqJH-0002NF-QE
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:58 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:39 -0500
Message-Id: <20170901180340.30009-29-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 28/29] libqtest: Remove qtest_start() and
 qtest_end() shortcuts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, Keith Busch <keith.busch@intel.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, Ben Warren <ben@skyportsystems.com>, "open list:Floppy" <qemu-block@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>

Remove the trivial wrappers qtest_start() and qtest_end(), to make
it obvious in the rest of the testsuite where we are still relying on
global_qtest.  Doing this makes it easier to see what remaining
cleanups will be needed if we don't want an implicit dependency
on global state.  Many tests can also take advantage of qtest_init()
doing formatting of args, avoiding a temporary local variable.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h               | 26 ------------------
 tests/libqtest.c               |  4 +--
 tests/ac97-test.c              |  4 +--
 tests/boot-order-test.c        | 11 +++-----
 tests/boot-serial-test.c       | 12 +++------
 tests/device-introspect-test.c | 24 ++++++++---------
 tests/display-vga-test.c       | 18 +++++--------
 tests/drive_del-test.c         | 17 ++++++------
 tests/ds1338-test.c            |  2 +-
 tests/e1000-test.c             | 10 ++-----
 tests/e1000e-test.c            | 14 +++-------
 tests/eepro100-test.c          | 11 ++------
 tests/endianness-test.c        | 33 +++++++++--------------
 tests/es1370-test.c            |  4 +--
 tests/fdc-test.c               |  4 +--
 tests/hd-geo-test.c            | 16 +++++------
 tests/i440fx-test.c            | 16 +++++------
 tests/i82801b11-test.c         |  5 ++--
 tests/ide-test.c               |  4 +--
 tests/intel-hda-test.c         | 11 ++++----
 tests/ioh3420-test.c           |  7 ++---
 tests/ipmi-bt-test.c           | 11 +++-----
 tests/ipmi-kcs-test.c          |  5 +---
 tests/ipoctal232-test.c        |  5 ++--
 tests/ivshmem-test.c           |  4 +--
 tests/libqos/libqos.c          |  2 +-
 tests/m25p80-test.c            |  9 +++----
 tests/m48t59-test.c            |  2 +-
 tests/ne2000-test.c            |  4 +--
 tests/numa-test.c              | 28 ++++++++++----------
 tests/nvme-test.c              |  7 ++---
 tests/pc-cpu-test.c            | 26 +++++++-----------
 tests/pcnet-test.c             |  4 +--
 tests/pnv-xscom-test.c         | 14 ++--------
 tests/prom-env-test.c          | 13 ++++-----
 tests/pvpanic-test.c           |  4 +--
 tests/pxe-test.c               | 14 ++++------
 tests/q35-test.c               |  8 +++---
 tests/qom-test.c               |  7 ++---
 tests/rtc-test.c               |  2 +-
 tests/rtl8139-test.c           |  4 +--
 tests/spapr-phb-test.c         |  5 ++--
 tests/tco-test.c               | 12 ++++-----
 tests/test-arm-mptimer.c       |  4 +--
 tests/test-filter-mirror.c     | 16 +++++------
 tests/test-filter-redirector.c | 60 ++++++++++++++++++++----------------------
 tests/test-hmp.c               |  7 ++---
 tests/test-netfilter.c         |  9 +++----
 tests/test-x86-cpuid-compat.c  | 13 ++++-----
 tests/tmp105-test.c            |  2 +-
 tests/tpci200-test.c           |  4 +--
 tests/usb-hcd-ehci-test.c      | 25 +++++++++---------
 tests/usb-hcd-ohci-test.c      |  4 +--
 tests/usb-hcd-xhci-test.c      |  4 +--
 tests/virtio-balloon-test.c    |  4 +--
 tests/virtio-blk-test.c        | 13 ++++-----
 tests/virtio-console-test.c    |  8 +++---
 tests/virtio-net-test.c        |  4 +--
 tests/virtio-rng-test.c        |  4 +--
 tests/virtio-serial-test.c     |  4 +--
 tests/vmgenid-test.c           | 29 ++++++--------------
 tests/vmxnet3-test.c           |  4 +--
 62 files changed, 267 insertions(+), 394 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index d338de3e22..0459526187 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -509,32 +509,6 @@ void qtest_add_data_func_full(const char *str, void *data,
 void qtest_add_abrt_handler(GHookFunc fn, const void *data);

 /**
- * qtest_start:
- * @args: other arguments to pass to QEMU
- *
- * Start QEMU and assign the resulting #QTestState to a global variable.
- * The global variable is used by "shortcut" functions documented below.
- *
- * Returns: #QTestState instance.
- */
-static inline QTestState *qtest_start(const char *args)
-{
-    global_qtest = qtest_init("%s", args);
-    return global_qtest;
-}
-
-/**
- * qtest_end:
- *
- * Shut down the QEMU process started by qtest_start().
- */
-static inline void qtest_end(void)
-{
-    qtest_quit(global_qtest);
-    global_qtest = NULL;
-}
-
-/**
  * qmp:
  * @fmt...: QMP message to send to qemu
  *
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 18facbf130..fa4e47c137 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -970,7 +970,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
     QString *qstr;
     const char *mname;

-    qtest_start("-machine none");
+    global_qtest = qtest_init("-machine none");
     response = qmp("{ 'execute': 'query-machines' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
@@ -987,6 +987,6 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
         cb(mname);
     }

-    qtest_end();
+    qtest_quit(global_qtest);
     QDECREF(response);
 }
diff --git a/tests/ac97-test.c b/tests/ac97-test.c
index e0d177bd9c..6a1edaa85a 100644
--- a/tests/ac97-test.c
+++ b/tests/ac97-test.c
@@ -22,10 +22,10 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/ac97/nop", nop);

-    qtest_start("-device AC97");
+    global_qtest = qtest_init("-device AC97");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index 5fc2ca8e9e..e6efea6852 100644
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
+    global_qtest = qtest_init("-nodefaults%s%s %s",
+                              machine ? " -M " : "",
+                              machine ?: "",
+                              test_args);
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
index b95c5e74ea..d7c0c320d7 100644
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
+    global_qtest = qtest_init("-M %s,accel=tcg:kvm "
+                              "-chardev file,id=serial0,path=%s "
+                              "-no-shutdown -serial chardev:serial0 %s",
+                              test->machine, tmpname, test->extra);
     unlink(tmpname);

     check_guest_output(test, fd);
     qtest_quit(global_qtest);

-    g_free(args);
     close(fd);
 }

diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index f7162c023f..1c23b71038 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -126,7 +126,7 @@ static void test_device_intro_list(void)
     QList *types;
     char *help;

-    qtest_start(common_args);
+    global_qtest = qtest_init("%s", common_args);

     types = device_type_list(true);
     QDECREF(types);
@@ -134,7 +134,7 @@ static void test_device_intro_list(void)
     help = hmp("device_add help");
     g_free(help);

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 /*
@@ -167,7 +167,7 @@ static void test_qom_list_fields(void)
     QList *non_abstract;
     QListEntry *e;

-    qtest_start(common_args);
+    global_qtest = qtest_init("%s", common_args);

     all_types = qom_list_types(NULL, true);
     non_abstract = qom_list_types(NULL, false);
@@ -189,21 +189,21 @@ static void test_qom_list_fields(void)

     QDECREF(all_types);
     QDECREF(non_abstract);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_device_intro_none(void)
 {
-    qtest_start(common_args);
+    global_qtest = qtest_init("%s", common_args);
     test_one_device("nonexistent");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_device_intro_abstract(void)
 {
-    qtest_start(common_args);
+    global_qtest = qtest_init("%s", common_args);
     test_one_device("device");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_device_intro_concrete(void)
@@ -212,7 +212,7 @@ static void test_device_intro_concrete(void)
     QListEntry *entry;
     const char *type;

-    qtest_start(common_args);
+    global_qtest = qtest_init("%s", common_args);
     types = device_type_list(false);

     QLIST_FOREACH_ENTRY(types, entry) {
@@ -223,7 +223,7 @@ static void test_device_intro_concrete(void)
     }

     QDECREF(types);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_abstract_interfaces(void)
@@ -232,7 +232,7 @@ static void test_abstract_interfaces(void)
     QListEntry *e;
     QDict *index;

-    qtest_start(common_args);
+    global_qtest = qtest_init("%s", common_args);

     all_types = qom_list_types("interface", true);
     index = qom_type_index(all_types);
@@ -257,7 +257,7 @@ static void test_abstract_interfaces(void)

     QDECREF(all_types);
     QDECREF(index);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/display-vga-test.c b/tests/display-vga-test.c
index 2d7d24eee0..51c6feaaf1 100644
--- a/tests/display-vga-test.c
+++ b/tests/display-vga-test.c
@@ -12,39 +12,33 @@

 static void pci_cirrus(void)
 {
-    qtest_start("-vga none -device cirrus-vga");
-    qtest_end();
+    qtest_quit(qtest_init("-vga none -device cirrus-vga"));
 }

 static void pci_stdvga(void)
 {
-    qtest_start("-vga none -device VGA");
-    qtest_end();
+    qtest_quit(qtest_init("-vga none -device VGA"));
 }

 static void pci_secondary(void)
 {
-    qtest_start("-vga none -device secondary-vga");
-    qtest_end();
+    qtest_quit(qtest_init("-vga none -device secondary-vga"));
 }

 static void pci_multihead(void)
 {
-    qtest_start("-vga none -device VGA -device secondary-vga");
-    qtest_end();
+    qtest_quit(qtest_init("-vga none -device VGA -device secondary-vga"));
 }

 static void pci_virtio_gpu(void)
 {
-    qtest_start("-vga none -device virtio-gpu-pci");
-    qtest_end();
+    qtest_quit(qtest_init("-vga none -device virtio-gpu-pci"));
 }

 #ifdef CONFIG_VIRTIO_VGA
 static void pci_virtio_vga(void)
 {
-    qtest_start("-vga none -device virtio-vga");
-    qtest_end();
+    qtest_quit(qtest_init("-vga none -device virtio-vga"));
 }
 #endif

diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 2175139abb..602ab062b4 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -45,7 +45,7 @@ static void device_del(void)
 static void test_drive_without_dev(void)
 {
     /* Start with an empty drive */
-    qtest_start("-drive if=none,id=drive0");
+    global_qtest = qtest_init("-drive if=none,id=drive0");

     /* Delete the drive */
     drive_del();
@@ -55,7 +55,7 @@ static void test_drive_without_dev(void)
      */
     drive_add();

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_after_failed_device_add(void)
@@ -63,7 +63,7 @@ static void test_after_failed_device_add(void)
     QDict *response;
     QDict *error;

-    qtest_start("-drive if=none,id=drive0");
+    global_qtest = qtest_init("-drive if=none,id=drive0");

     /* Make device_add fail.  If this leaks the virtio-blk-pci device then a
      * reference to drive0 will also be held (via qdev properties).
@@ -86,15 +86,16 @@ static void test_after_failed_device_add(void)
      */
     drive_add();

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_drive_del_device_del(void)
 {
     /* Start with a drive used by a device that unplugs instantaneously */
-    qtest_start("-drive if=none,id=drive0,file=null-co://,format=raw"
-                " -device virtio-scsi-pci"
-                " -device scsi-hd,drive=drive0,id=dev0");
+    global_qtest = qtest_init(
+        "-drive if=none,id=drive0,file=null-co://,format=raw"
+        " -device virtio-scsi-pci"
+        " -device scsi-hd,drive=drive0,id=dev0");

     /*
      * Delete the drive, and then the device
@@ -103,7 +104,7 @@ static void test_drive_del_device_del(void)
     drive_del();
     device_del();

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/ds1338-test.c b/tests/ds1338-test.c
index 26968bc82a..da5b852351 100644
--- a/tests/ds1338-test.c
+++ b/tests/ds1338-test.c
@@ -60,7 +60,7 @@ int main(int argc, char **argv)

     g_test_init(&argc, &argv, NULL);

-    s = qtest_start("-display none -machine imx25-pdk");
+    s = global_qtest = qtest_init("-display none -machine imx25-pdk");
     i2c = imx_i2c_create(IMX25_I2C_0_BASE);
     addr = DS1338_ADDR;

diff --git a/tests/e1000-test.c b/tests/e1000-test.c
index 0c5fcdcc44..59bd8b781f 100644
--- a/tests/e1000-test.c
+++ b/tests/e1000-test.c
@@ -15,15 +15,9 @@ static void test_device(gconstpointer data)
 {
     const char *model = data;
     QTestState *s;
-    char *args;

-    args = g_strdup_printf("-device %s", model);
-    s = qtest_start(args);
-
-    if (s) {
-        qtest_quit(s);
-    }
-    g_free(args);
+    s = qtest_init("-device %s", model);
+    qtest_quit(s);
 }

 static const char *models[] = {
diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index 32aa738b72..6ef240dc8f 100644
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
+    global_qtest = qtest_init("-netdev socket,fd=%d,id=hs0 "
                               "-device e1000e,netdev=hs0", test_sockets[1]);
-    g_assert_nonnull(cmdline);
-
-    qtest_start(cmdline);
-    g_free(cmdline);

     test_alloc = pc_alloc_init(global_qtest);
     g_assert_nonnull(test_alloc);
@@ -408,7 +402,7 @@ static void data_test_clear(e1000e_device *d)
     pc_alloc_uninit(test_alloc);
     g_free(d->pci_dev);
     qpci_free_pc(test_bus);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_e1000e_init(gconstpointer data)
@@ -458,12 +452,12 @@ static void test_e1000e_hotplug(gconstpointer data)
 {
     static const uint8_t slot = 0x06;

-    qtest_start("-device e1000e");
+    global_qtest = qtest_init("-device e1000e");

     qpci_plug_device_test("e1000e", "e1000e_net", slot, NULL);
     qpci_unplug_acpi_device_test("e1000e_net", slot);

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/eepro100-test.c b/tests/eepro100-test.c
index bdc8a67d57..6f49ac2656 100644
--- a/tests/eepro100-test.c
+++ b/tests/eepro100-test.c
@@ -14,17 +14,10 @@ static void test_device(gconstpointer data)
 {
     const char *model = data;
     QTestState *s;
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
+    s = qtest_init("-device %s", model);
+    qtest_quit(s);
 }

 static const char *models[] = {
diff --git a/tests/endianness-test.c b/tests/endianness-test.c
index ed0bf52019..68d5dbcd14 100644
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
+    global_qtest = qtest_init("-M %s%s%s -device pc-testdev",
+                              test->machine,
+                              test->superio ? " -device " : "",
+                              test->superio ?: "");
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
+    global_qtest = qtest_init("-M %s%s%s -device pc-testdev",
+                              test->machine,
+                              test->superio ? " -device " : "",
+                              test->superio ?: "");
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
+    global_qtest = qtest_init("-M %s%s%s -device pc-testdev",
+                              test->machine,
+                              test->superio ? " -device " : "",
+                              test->superio ?: "");
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
diff --git a/tests/es1370-test.c b/tests/es1370-test.c
index 199fe193ce..edeea13ae7 100644
--- a/tests/es1370-test.c
+++ b/tests/es1370-test.c
@@ -22,10 +22,10 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/es1370/nop", nop);

-    qtest_start("-device ES1370");
+    global_qtest = qtest_init("-device ES1370");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index 325712e0f2..893097f5a3 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -564,7 +564,7 @@ int main(int argc, char **argv)
     /* Run the tests */
     g_test_init(&argc, &argv, NULL);

-    qtest_start("-device floppy,id=floppy0");
+    global_qtest = qtest_init("-device floppy,id=floppy0");
     qtest_irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/fdc/cmos", test_cmos);
     qtest_add_func("/fdc/no_media_on_start", test_no_media_on_start);
@@ -583,7 +583,7 @@ int main(int argc, char **argv)
     ret = g_test_run();

     /* Cleanup */
-    qtest_end();
+    qtest_quit(global_qtest);
     unlink(test_image);

     return ret;
diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 24870b38f4..e0b19cdf17 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -241,11 +241,11 @@ static void test_ide_none(void)

     setup_common(argv, ARGV_SIZE);
     args = g_strjoinv(" ", argv);
-    qtest_start(args);
+    global_qtest = qtest_init("%s", args);
     g_strfreev(argv);
     g_free(args);
     test_cmos();
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_ide_mbr(bool use_device, MBRcontents mbr)
@@ -263,11 +263,11 @@ static void test_ide_mbr(bool use_device, MBRcontents mbr)
         argc = setup_ide(argc, argv, ARGV_SIZE, i, dev, i, mbr, "");
     }
     args = g_strjoinv(" ", argv);
-    qtest_start(args);
+    global_qtest = qtest_init("%s", args);
     g_strfreev(argv);
     g_free(args);
     test_cmos();
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 /*
@@ -339,11 +339,11 @@ static void test_ide_drive_user(const char *dev, bool trans)
                      dev ? "" : opts);
     g_free(opts);
     args = g_strjoinv(" ", argv);
-    qtest_start(args);
+    global_qtest = qtest_init("%s", args);
     g_strfreev(argv);
     g_free(args);
     test_cmos();
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 /*
@@ -396,11 +396,11 @@ static void test_ide_drive_cd_0(void)
                          ide_idx, NULL, i, mbr_blank, "");
     }
     args = g_strjoinv(" ", argv);
-    qtest_start(args);
+    global_qtest = qtest_init("%s", args);
     g_strfreev(argv);
     g_free(args);
     test_cmos();
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
index 4390e5591e..bfedd5d953 100644
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
+    global_qtest = qtest_init("-smp %d", s->num_cpus);
     return qpci_init_pc(global_qtest, NULL);
 }

@@ -136,7 +132,7 @@ static void test_i440fx_defaults(gconstpointer opaque)

     g_free(dev);
     qpci_free_pc(bus);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 #define PAM_RE 1
@@ -275,7 +271,7 @@ static void test_i440fx_pam(gconstpointer opaque)

     g_free(dev);
     qpci_free_pc(bus);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 #define BLOB_SIZE ((size_t)65536)
@@ -344,10 +340,10 @@ static void test_i440fx_firmware(FirmwareTestFixture *fixture,
                                          : "-drive if=pflash,format=raw,file=",
                               fw_pathname);
     g_test_message("qemu cmdline: %s", cmdline);
-    qtest_start(cmdline);
+    global_qtest = qtest_init("%s", cmdline);
     g_free(cmdline);

-    /* QEMU has loaded the firmware (because qtest_start() only returns after
+    /* QEMU has loaded the firmware (because qtest_init() only returns after
      * the QMP handshake completes). We must unlink the firmware blob right
      * here, because any assertion firing below would leak it in the
      * filesystem. This is also the reason why we recreate the blob every time
@@ -373,7 +369,7 @@ static void test_i440fx_firmware(FirmwareTestFixture *fixture,
     }

     g_free(buf);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void add_firmware_test(const char *testpath,
diff --git a/tests/i82801b11-test.c b/tests/i82801b11-test.c
index a6e31594c9..58436172b7 100644
--- a/tests/i82801b11-test.c
+++ b/tests/i82801b11-test.c
@@ -22,10 +22,11 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/i82801b11/nop", nop);

-    qtest_start("-machine q35 -device i82801b11-bridge,bus=pcie.0,addr=1e.0");
+    global_qtest = qtest_init("-machine q35 "
+                              "-device i82801b11-bridge,bus=pcie.0,addr=1e.0");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/ide-test.c b/tests/ide-test.c
index 084f6a5f96..b22a4fc1c5 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -124,7 +124,7 @@ static void ide_test_start(const char *cmdline_fmt, ...)
     cmdline = g_strdup_vprintf(cmdline_fmt, ap);
     va_end(ap);

-    qtest_start(cmdline);
+    global_qtest = qtest_init("%s", cmdline);
     guest_malloc = pc_alloc_init(global_qtest);

     g_free(cmdline);
@@ -134,7 +134,7 @@ static void ide_test_quit(void)
 {
     pc_alloc_uninit(guest_malloc);
     guest_malloc = NULL;
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static QPCIDevice *get_pci_device(QPCIBar *bmdma_bar, QPCIBar *ide_bar)
diff --git a/tests/intel-hda-test.c b/tests/intel-hda-test.c
index b782b2e944..c10a59d932 100644
--- a/tests/intel-hda-test.c
+++ b/tests/intel-hda-test.c
@@ -18,15 +18,16 @@
 /* Tests only initialization so far. TODO: Replace with functional tests */
 static void ich6_test(void)
 {
-    qtest_start("-device intel-hda,id=" HDA_ID CODEC_DEVICES);
-    qtest_end();
+    global_qtest = qtest_init("-device intel-hda,id=" HDA_ID CODEC_DEVICES);
+    qtest_quit(global_qtest);
 }

 static void ich9_test(void)
 {
-    qtest_start("-machine q35 -device ich9-intel-hda,bus=pcie.0,addr=1b.0,id="
-                HDA_ID CODEC_DEVICES);
-    qtest_end();
+    global_qtest = qtest_init(
+        "-machine q35 -device ich9-intel-hda,bus=pcie.0,addr=1b.0,id="
+        HDA_ID CODEC_DEVICES);
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/ioh3420-test.c b/tests/ioh3420-test.c
index b54c4b9f11..cd5d062370 100644
--- a/tests/ioh3420-test.c
+++ b/tests/ioh3420-test.c
@@ -22,11 +22,12 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/ioh3420/nop", nop);

-    qtest_start("-machine q35 -device ioh3420,bus=pcie.0,addr=1c.0,port=1,"
-                "chassis=1,multifunction=on");
+    global_qtest = qtest_init(
+        "-machine q35 -device ioh3420,bus=pcie.0,addr=1c.0,port=1,"
+        "chassis=1,multifunction=on");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/ipmi-bt-test.c b/tests/ipmi-bt-test.c
index 7e21a9bbcb..476d527cfd 100644
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
+    global_qtest = qtest_init(
+        " -chardev socket,id=ipmi0,host=localhost,port=%d,reconnect=10"
+        " -device ipmi-bmc-extern,chardev=ipmi0,id=bmc0"
+        " -device isa-ipmi-bt,bmc=bmc0", emu_port);
     qtest_irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/ipmi/extern/connect", test_connect);
     qtest_add_func("/ipmi/extern/bt_base", test_bt_base);
diff --git a/tests/ipmi-kcs-test.c b/tests/ipmi-kcs-test.c
index 178ffc1797..2bd3771e9f 100644
--- a/tests/ipmi-kcs-test.c
+++ b/tests/ipmi-kcs-test.c
@@ -264,7 +264,6 @@ static void test_enable_irq(void)
 int main(int argc, char **argv)
 {
     const char *arch = qtest_get_arch();
-    char *cmdline;
     int ret;

     /* Check architecture */
@@ -276,10 +275,8 @@ int main(int argc, char **argv)
     /* Run the tests */
     g_test_init(&argc, &argv, NULL);

-    cmdline = g_strdup_printf("-device ipmi-bmc-sim,id=bmc0"
+    global_qtest = qtest_init("-device ipmi-bmc-sim,id=bmc0"
                               " -device isa-ipmi-kcs,bmc=bmc0");
-    qtest_start(cmdline);
-    g_free(cmdline);
     qtest_irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/ipmi/local/kcs_base", test_kcs_base);
     qtest_add_func("/ipmi/local/kcs_abort", test_kcs_abort);
diff --git a/tests/ipoctal232-test.c b/tests/ipoctal232-test.c
index 684914164d..5e1cae3917 100644
--- a/tests/ipoctal232-test.c
+++ b/tests/ipoctal232-test.c
@@ -22,10 +22,11 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/ipoctal232/tpci200/nop", nop);

-    qtest_start("-device tpci200,id=ipack0 -device ipoctal232,bus=ipack0.0");
+    global_qtest = qtest_init("-device tpci200,id=ipack0 "
+                              "-device ipoctal232,bus=ipack0.0");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index b9e0f573f6..f254f09487 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -407,7 +407,7 @@ static void test_ivshmem_hotplug(void)
     const char *arch = qtest_get_arch();
     gchar *opts;

-    qtest_start("");
+    global_qtest = qtest_init(" ");

     opts = g_strdup_printf("'shm': '%s', 'size': '1M'", tmpshm);

@@ -416,7 +416,7 @@ static void test_ivshmem_hotplug(void)
         qpci_unplug_acpi_device_test("iv1", PCI_SLOT_HP);
     }

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(opts);
 }

diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 24e8156fe2..bd9106a132 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -20,7 +20,7 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdline_fmt, va_list ap)
     struct QOSState *qs = g_malloc(sizeof(QOSState));

     cmdline = g_strdup_vprintf(cmdline_fmt, ap);
-    qs->qts = qtest_start(cmdline);
+    qs->qts = global_qtest = qtest_init("%s", cmdline);
     qs->ops = ops;
     if (ops) {
         if (ops->init_allocator) {
diff --git a/tests/m25p80-test.c b/tests/m25p80-test.c
index 244aa33dd9..18135cfb86 100644
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
+    global_qtest = qtest_init("-m 256 -machine palmetto-bmc "
+                              "-drive file=%s,format=raw,if=mtd",
+                              tmp_path);

     qtest_add_func("/m25p80/read_jedec", test_read_jedec);
     qtest_add_func("/m25p80/erase_sector", test_erase_sector);
@@ -380,6 +378,5 @@ int main(int argc, char **argv)

     qtest_quit(global_qtest);
     unlink(tmp_path);
-    g_free(args);
     return ret;
 }
diff --git a/tests/m48t59-test.c b/tests/m48t59-test.c
index 0f921ef38a..52c61fe33e 100644
--- a/tests/m48t59-test.c
+++ b/tests/m48t59-test.c
@@ -246,7 +246,7 @@ int main(int argc, char **argv)

     g_test_init(&argc, &argv, NULL);

-    s = qtest_start("-rtc clock=vm");
+    s = global_qtest = qtest_init("-rtc clock=vm");

     qtest_add_func("/rtc/bcd/check-time", bcd_check_time);
     qtest_add_func("/rtc/fuzz-registers", fuzz_registers);
diff --git a/tests/ne2000-test.c b/tests/ne2000-test.c
index b7cf3dd2f5..d205bc91a6 100644
--- a/tests/ne2000-test.c
+++ b/tests/ne2000-test.c
@@ -22,10 +22,10 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/ne2000/pci/nop", pci_nop);

-    qtest_start("-device ne2k_pci");
+    global_qtest = qtest_init("-device ne2k_pci");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/numa-test.c b/tests/numa-test.c
index e1b6152244..17bbc0f5f8 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -25,14 +25,14 @@ static void test_mon_explicit(const void *data)
     cli = make_cli(data, "-smp 8 "
                    "-numa node,nodeid=0,cpus=0-3 "
                    "-numa node,nodeid=1,cpus=4-7 ");
-    qtest_start(cli);
+    global_qtest = qtest_init("%s", cli);

     s = hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
     g_assert(strstr(s, "node 1 cpus: 4 5 6 7"));
     g_free(s);

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

@@ -42,14 +42,14 @@ static void test_mon_default(const void *data)
     char *cli;

     cli = make_cli(data, "-smp 8 -numa node -numa node");
-    qtest_start(cli);
+    global_qtest = qtest_init("%s", cli);

     s = hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
     g_assert(strstr(s, "node 1 cpus: 1 3 5 7"));
     g_free(s);

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

@@ -61,14 +61,14 @@ static void test_mon_partial(const void *data)
     cli = make_cli(data, "-smp 8 "
                    "-numa node,nodeid=0,cpus=0-1 "
                    "-numa node,nodeid=1,cpus=4-5 ");
-    qtest_start(cli);
+    global_qtest = qtest_init("%s", cli);

     s = hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
     g_assert(strstr(s, "node 1 cpus: 4 5"));
     g_free(s);

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

@@ -88,7 +88,7 @@ static void test_query_cpus(const void *data)
     QObject *e;

     cli = make_cli(data, "-smp 8 -numa node,cpus=0-3 -numa node,cpus=4-7");
-    qtest_start(cli);
+    global_qtest = qtest_init("%s", cli);
     cpus = get_cpus(&resp);
     g_assert(cpus);

@@ -113,7 +113,7 @@ static void test_query_cpus(const void *data)
     }

     QDECREF(resp);
-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

@@ -130,7 +130,7 @@ static void pc_numa_cpu(const void *data)
         "-numa cpu,node-id=0,socket-id=1,core-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=1,thread-id=0 "
         "-numa cpu,node-id=1,socket-id=1,core-id=1,thread-id=1");
-    qtest_start(cli);
+    global_qtest = qtest_init("%s", cli);
     cpus = get_cpus(&resp);
     g_assert(cpus);

@@ -166,7 +166,7 @@ static void pc_numa_cpu(const void *data)
     }

     QDECREF(resp);
-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

@@ -183,7 +183,7 @@ static void spapr_numa_cpu(const void *data)
         "-numa cpu,node-id=0,core-id=1 "
         "-numa cpu,node-id=0,core-id=2 "
         "-numa cpu,node-id=1,core-id=3");
-    qtest_start(cli);
+    global_qtest = qtest_init("%s", cli);
     cpus = get_cpus(&resp);
     g_assert(cpus);

@@ -211,7 +211,7 @@ static void spapr_numa_cpu(const void *data)
     }

     QDECREF(resp);
-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

@@ -226,7 +226,7 @@ static void aarch64_numa_cpu(const void *data)
         "-numa node,nodeid=0 -numa node,nodeid=1 "
         "-numa cpu,node-id=1,thread-id=0 "
         "-numa cpu,node-id=0,thread-id=1");
-    qtest_start(cli);
+    global_qtest = qtest_init("%s", cli);
     cpus = get_cpus(&resp);
     g_assert(cpus);

@@ -254,7 +254,7 @@ static void aarch64_numa_cpu(const void *data)
     }

     QDECREF(resp);
-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

diff --git a/tests/nvme-test.c b/tests/nvme-test.c
index 7674a446e4..382d26671f 100644
--- a/tests/nvme-test.c
+++ b/tests/nvme-test.c
@@ -22,11 +22,12 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/nvme/nop", nop);

-    qtest_start("-drive id=drv0,if=none,file=null-co://,format=raw "
-                "-device nvme,drive=drv0,serial=foo");
+    global_qtest = qtest_init(
+        "-drive id=drv0,if=none,file=null-co://,format=raw "
+        "-device nvme,drive=drv0,serial=foo");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/pc-cpu-test.c b/tests/pc-cpu-test.c
index c4211a4e85..9c36051c07 100644
--- a/tests/pc-cpu-test.c
+++ b/tests/pc-cpu-test.c
@@ -26,15 +26,13 @@ typedef struct PCTestData PCTestData;
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
+    global_qtest = qtest_init("-machine %s -cpu %s "
+                              "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
+                              s->machine, s->cpu_model,
+                              s->sockets, s->cores, s->threads, s->maxcpus);

     for (i = s->sockets * s->cores * s->threads; i < s->maxcpus; i++) {
         response = qmp("{ 'execute': 'cpu-add',"
@@ -44,21 +42,18 @@ static void test_pc_with_cpu_add(gconstpointer data)
         QDECREF(response);
     }

-    qtest_end();
-    g_free(args);
+    qtest_quit(global_qtest);
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
+    global_qtest = qtest_init("-machine %s -cpu %s "
+                              "-smp sockets=%u,cores=%u,threads=%u,maxcpus=%u",
+                              s->machine, s->cpu_model,
+                              s->sockets, s->cores, s->threads, s->maxcpus);

     response = qmp("{ 'execute': 'cpu-add',"
                    "  'arguments': { 'id': %d } }",
@@ -67,8 +62,7 @@ static void test_pc_without_cpu_add(gconstpointer data)
     g_assert(qdict_haskey(response, "error"));
     QDECREF(response);

-    qtest_end();
-    g_free(args);
+    qtest_quit(global_qtest);
 }

 static void test_data_free(gpointer data)
diff --git a/tests/pcnet-test.c b/tests/pcnet-test.c
index efb1ef44e9..23e36da805 100644
--- a/tests/pcnet-test.c
+++ b/tests/pcnet-test.c
@@ -22,10 +22,10 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/pcnet/pci/nop", pci_nop);

-    qtest_start("-device pcnet");
+    global_qtest = qtest_init("-device pcnet");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 5adc3fd3a9..852322b3f2 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -81,16 +81,11 @@ static void test_xscom_cfam_id(const PnvChip *chip)

 static void test_cfam_id(const void *data)
 {
-    char *args;
     const PnvChip *chip = data;

-    args = g_strdup_printf("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
-
-    qtest_start(args);
+    global_qtest = qtest_init("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
     test_xscom_cfam_id(chip);
     qtest_quit(global_qtest);
-
-    g_free(args);
 }

 #define PNV_XSCOM_EX_CORE_BASE(chip, i)                 \
@@ -109,16 +104,11 @@ static void test_xscom_core(const PnvChip *chip)

 static void test_core(const void *data)
 {
-    char *args;
     const PnvChip *chip = data;

-    args = g_strdup_printf("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
-
-    qtest_start(args);
+    global_qtest = qtest_init("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
     test_xscom_core(chip);
     qtest_quit(global_qtest);
-
-    g_free(args);
 }

 static void add_test(const char *name, void (*test)(const void *data))
diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index eac207b30e..fffef0b252 100644
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
+    global_qtest = qtest_init("-M %s,accel=tcg %s "
+                              "-prom-env 'use-nvramrc?=true' "
+                              "-prom-env 'nvramrc=%x %x l!' ",
+                              (const char *)machine, extra_args,
+                              MAGIC, ADDRESS);
     check_guest_memory();
     qtest_quit(global_qtest);
-
-    g_free(args);
 }

 static void add_tests(const char *machines[])
diff --git a/tests/pvpanic-test.c b/tests/pvpanic-test.c
index 71ebb5c02c..48b71be26f 100644
--- a/tests/pvpanic-test.c
+++ b/tests/pvpanic-test.c
@@ -37,10 +37,10 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/pvpanic/panic", test_panic);

-    qtest_start("-device pvpanic");
+    global_qtest = qtest_init("-device pvpanic");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index e2d3853534..eaad88601a 100644
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
+    global_qtest = qtest_init("-machine accel=kvm:tcg -nodefaults "
+                              "-boot order=n "
+                              "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
+                              "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
+                              ipv6 ? "on" : "off", params);
     boot_sector_test(global_qtest);
     qtest_quit(global_qtest);
-    g_free(args);
 }

 static void test_pxe_e1000(void)
diff --git a/tests/q35-test.c b/tests/q35-test.c
index e149c4c51d..91a189ce62 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -84,7 +84,7 @@ static void test_smram_lock(void)
     QPCIDevice *pcidev;
     QDict *response;

-    qtest_start("-M q35");
+    global_qtest = qtest_init("-M q35");

     pcibus = qpci_init_pc(global_qtest, NULL);
     g_assert(pcibus != NULL);
@@ -119,7 +119,7 @@ static void test_smram_lock(void)
     g_free(pcidev);
     qpci_free_pc(pcibus);

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_tseg_size(const void *data)
@@ -141,7 +141,7 @@ static void test_tseg_size(const void *data)
         cmdline = g_strdup_printf("-M q35 -m %uM",
                                   TSEG_SIZE_TEST_GUEST_RAM_MBYTES);
     }
-    qtest_start(cmdline);
+    global_qtest = qtest_init("%s", cmdline);
     g_free(cmdline);

     /* locate the DRAM controller */
@@ -185,7 +185,7 @@ static void test_tseg_size(const void *data)

     g_free(pcidev);
     qpci_free_pc(pcibus);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/qom-test.c b/tests/qom-test.c
index ab0595dc75..5edd735387 100644
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
+    global_qtest = qtest_init("-machine %s", machine);

     test_properties("/machine", true);

@@ -102,8 +100,7 @@ static void test_machine(gconstpointer data)
     g_assert(qdict_haskey(response, "return"));
     QDECREF(response);

-    qtest_end();
-    g_free(args);
+    qtest_quit(global_qtest);
     g_free((void *)machine);
 }

diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index d7a96cbd79..b6058d28f5 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -690,7 +690,7 @@ int main(int argc, char **argv)

     g_test_init(&argc, &argv, NULL);

-    s = qtest_start("-rtc clock=vm");
+    s = global_qtest = qtest_init("-rtc clock=vm");
     qtest_irq_intercept_in(s, "ioapic");

     qtest_add_func("/rtc/check-time/bcd", bcd_check_time);
diff --git a/tests/rtl8139-test.c b/tests/rtl8139-test.c
index 68bfc42178..dc9935439f 100644
--- a/tests/rtl8139-test.c
+++ b/tests/rtl8139-test.c
@@ -197,7 +197,7 @@ int main(int argc, char **argv)
 {
     int ret;

-    qtest_start("-device rtl8139");
+    global_qtest = qtest_init("-device rtl8139");

     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/rtl8139/nop", nop);
@@ -205,7 +205,7 @@ int main(int argc, char **argv)

     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/spapr-phb-test.c b/tests/spapr-phb-test.c
index d3522ea093..0d26cbda6c 100644
--- a/tests/spapr-phb-test.c
+++ b/tests/spapr-phb-test.c
@@ -25,11 +25,12 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/spapr-phb/device", test_phb_device);

-    qtest_start("-device " TYPE_SPAPR_PCI_HOST_BRIDGE ",index=30");
+    global_qtest = qtest_init("-device " TYPE_SPAPR_PCI_HOST_BRIDGE
+                              ",index=30");

     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/tco-test.c b/tests/tco-test.c
index 0387971953..b2a4baeeef 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -49,20 +49,18 @@ static void test_end(TestData *d)
 {
     g_free(d->dev);
     qpci_free_pc(d->bus);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_init(TestData *d)
 {
     QTestState *qs;
-    char *s;

-    s = g_strdup_printf("-machine q35 %s %s",
-                        d->noreboot ? "" : "-global ICH9-LPC.noreboot=false",
-                        !d->args ? "" : d->args);
-    qs = qtest_start(s);
+    qs = qtest_init("-machine q35 %s %s",
+                    d->noreboot ? "" : "-global ICH9-LPC.noreboot=false",
+                    !d->args ? "" : d->args);
+    global_qtest = qs;
     qtest_irq_intercept_in(qs, "ioapic");
-    g_free(s);

     d->bus = qpci_init_pc(qs, NULL);
     d->dev = qpci_device_find(d->bus, QPCI_DEVFN(0x1f, 0x00));
diff --git a/tests/test-arm-mptimer.c b/tests/test-arm-mptimer.c
index cb8f2df914..a4bef2322a 100644
--- a/tests/test-arm-mptimer.c
+++ b/tests/test-arm-mptimer.c
@@ -1097,9 +1097,9 @@ tests_with_prescaler_arg:
         goto tests_with_prescaler_arg;
     }

-    qtest_start("-machine vexpress-a9");
+    global_qtest = qtest_init("-machine vexpress-a9");
     ret = g_test_run();
-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index d569d27657..9d8608a609 100644
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
+    global_qtest = qtest_init(
+        "-netdev socket,id=qtest-bn0,fd=%d "
+        "-device %s,netdev=qtest-bn0,id=qtest-e0 "
+        "-chardev socket,id=mirror0,path=%s,server,nowait "
+        "-object filter-mirror,id=qtest-f0,netdev=qtest-bn0,queue=tx,outdev=mirror0 "
+        , send_sock[1], devstr, sock_path);

     recv_sock = unix_connect(sock_path, NULL);
     g_assert_cmpint(recv_sock, !=, -1);
@@ -86,7 +84,7 @@ int main(int argc, char **argv)

     qtest_add_func("/netfilter/mirror", test_mirror);
     ret = g_test_run();
-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index 3afd41110d..b34f8ec2ad 100644
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
+    global_qtest = qtest_init(
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
@@ -135,13 +133,12 @@ static void test_redirector_tx(void)
     close(recv_sock);
     unlink(sock_path0);
     unlink(sock_path1);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

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
+    global_qtest = qtest_init(
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
@@ -204,7 +200,7 @@ static void test_redirector_rx(void)
     g_free(recv_buf);
     unlink(sock_path0);
     unlink(sock_path1);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 729c0339f7..dd03693707 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -119,16 +119,13 @@ static void test_info_commands(void)
 static void test_machine(gconstpointer data)
 {
     const char *machine = data;
-    char *args;

-    args = g_strdup_printf("-S -M %s", machine);
-    qtest_start(args);
+    global_qtest = qtest_init("-S -M %s", machine);

     test_info_commands();
     test_commands();

-    qtest_end();
-    g_free(args);
+    qtest_quit(global_qtest);
     g_free((void *)data);
 }

diff --git a/tests/test-netfilter.c b/tests/test-netfilter.c
index 2506473365..76caaedfc1 100644
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
+    global_qtest = qtest_init("-netdev user,id=qtest-bn0 "
+                              "-device %s,netdev=qtest-bn0", devstr);
     ret = g_test_run();

-    qtest_end();
-    g_free(args);
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 58a2dd9fe8..5b026ac38a 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -59,12 +59,12 @@ static void test_cpuid_prop(const void *data)
     QNum *value;
     int64_t val;

-    qtest_start(args->cmdline);
+    global_qtest = qtest_init("%s", args->cmdline);
     path = get_cpu0_qom_path();
     value = qobject_to_qnum(qom_get(path, args->property));
     g_assert(qnum_get_try_int(value, &val));
     g_assert_cmpint(val, ==, args->expected_value);
-    qtest_end();
+    qtest_quit(global_qtest);

     QDECREF(value);
     g_free(path);
@@ -131,13 +131,13 @@ static void test_feature_flag(const void *data)
     QList *present, *filtered;
     uint32_t value;

-    qtest_start(args->cmdline);
+    global_qtest = qtest_init("%s", args->cmdline);
     path = get_cpu0_qom_path();
     present = qobject_to_qlist(qom_get(path, "feature-words"));
     filtered = qobject_to_qlist(qom_get(path, "filtered-features"));
     value = get_feature_word(present, args->in_eax, args->in_ecx, args->reg);
     value |= get_feature_word(filtered, args->in_eax, args->in_ecx, args->reg);
-    qtest_end();
+    qtest_quit(global_qtest);

     g_assert(!!(value & (1U << args->bitnr)) == args->expected_value);

@@ -181,7 +181,8 @@ static void test_plus_minus_subprocess(void)
      * Note: rules 1 and 2 are planned to be removed soon, and
      * should generate a warning.
      */
-    qtest_start("-cpu pentium,-fpu,+fpu,-mce,mce=on,+cx8,cx8=off,+sse4_1,sse4_2=on");
+    global_qtest = qtest_init("-cpu pentium,-fpu,+fpu,-mce,mce=on,+cx8,"
+                              "cx8=off,+sse4_1,sse4_2=on");
     path = get_cpu0_qom_path();

     g_assert_false(qom_get_bool(path, "fpu"));
@@ -195,7 +196,7 @@ static void test_plus_minus_subprocess(void)
     g_assert_true(qom_get_bool(path, "sse4-2"));
     g_assert_true(qom_get_bool(path, "sse4.2"));

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(path);
 }

diff --git a/tests/tmp105-test.c b/tests/tmp105-test.c
index a7940a4639..3ef2efff6e 100644
--- a/tests/tmp105-test.c
+++ b/tests/tmp105-test.c
@@ -151,7 +151,7 @@ int main(int argc, char **argv)

     g_test_init(&argc, &argv, NULL);

-    s = qtest_start("-machine n800 "
+    s = global_qtest = qtest_init("-machine n800 "
                     "-device tmp105,bus=i2c-bus.0,id=" TMP105_TEST_ID
                     ",address=0x49");
     i2c = omap_i2c_create(OMAP2_I2C_1_BASE);
diff --git a/tests/tpci200-test.c b/tests/tpci200-test.c
index 0321ec27ec..2ed378196d 100644
--- a/tests/tpci200-test.c
+++ b/tests/tpci200-test.c
@@ -22,10 +22,10 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/tpci200/nop", nop);

-    qtest_start("-device tpci200");
+    global_qtest = qtest_init("-device tpci200");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
index 55d4743a2a..55349a39a2 100644
--- a/tests/usb-hcd-ehci-test.c
+++ b/tests/usb-hcd-ehci-test.c
@@ -156,23 +156,24 @@ int main(int argc, char **argv)
     qtest_add_func("/ehci/pci/ehci-port-2", pci_ehci_port_2);
     qtest_add_func("/ehci/pci/ehci-port-3-hotplug", pci_ehci_port_hotplug);

-    qtest_start("-machine q35 -device ich9-usb-ehci1,bus=pcie.0,addr=1d.7,"
-                "multifunction=on,id=ich9-ehci-1 "
-                "-device ich9-usb-uhci1,bus=pcie.0,addr=1d.0,"
-                "multifunction=on,masterbus=ich9-ehci-1.0,firstport=0 "
-                "-device ich9-usb-uhci2,bus=pcie.0,addr=1d.1,"
-                "multifunction=on,masterbus=ich9-ehci-1.0,firstport=2 "
-                "-device ich9-usb-uhci3,bus=pcie.0,addr=1d.2,"
-                "multifunction=on,masterbus=ich9-ehci-1.0,firstport=4 "
-                "-drive if=none,id=usbcdrom,media=cdrom "
-                "-device usb-tablet,bus=ich9-ehci-1.0,port=1,usb_version=1 "
-                "-device usb-storage,bus=ich9-ehci-1.0,port=2,drive=usbcdrom ");
+    global_qtest = qtest_init(
+        "-machine q35 -device ich9-usb-ehci1,bus=pcie.0,addr=1d.7,"
+        "multifunction=on,id=ich9-ehci-1 "
+        "-device ich9-usb-uhci1,bus=pcie.0,addr=1d.0,"
+        "multifunction=on,masterbus=ich9-ehci-1.0,firstport=0 "
+        "-device ich9-usb-uhci2,bus=pcie.0,addr=1d.1,"
+        "multifunction=on,masterbus=ich9-ehci-1.0,firstport=2 "
+        "-device ich9-usb-uhci3,bus=pcie.0,addr=1d.2,"
+        "multifunction=on,masterbus=ich9-ehci-1.0,firstport=4 "
+        "-drive if=none,id=usbcdrom,media=cdrom "
+        "-device usb-tablet,bus=ich9-ehci-1.0,port=1,usb_version=1 "
+        "-device usb-storage,bus=ich9-ehci-1.0,port=2,drive=usbcdrom ");

     test_init();
     ret = g_test_run();
     test_deinit();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/usb-hcd-ohci-test.c b/tests/usb-hcd-ohci-test.c
index 4758813d78..2763c9ec24 100644
--- a/tests/usb-hcd-ohci-test.c
+++ b/tests/usb-hcd-ohci-test.c
@@ -31,9 +31,9 @@ int main(int argc, char **argv)
     qtest_add_func("/ohci/pci/init", test_ohci_init);
     qtest_add_func("/ohci/pci/hotplug", test_ohci_hotplug);

-    qtest_start("-device pci-ohci,id=ohci");
+    global_qtest = qtest_init("-device pci-ohci,id=ohci");
     ret = g_test_run();
-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index c05a339894..cc3fcd82fa 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -80,10 +80,10 @@ int main(int argc, char **argv)
     qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
     qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);

-    qtest_start("-device nec-usb-xhci,id=xhci"
+    global_qtest = qtest_init("-device nec-usb-xhci,id=xhci"
                 " -drive id=drive0,if=none,file=null-co://,format=raw");
     ret = g_test_run();
-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/virtio-balloon-test.c b/tests/virtio-balloon-test.c
index 0d0046bf25..7304392c17 100644
--- a/tests/virtio-balloon-test.c
+++ b/tests/virtio-balloon-test.c
@@ -22,10 +22,10 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/virtio/balloon/pci/nop", pci_nop);

-    qtest_start("-device virtio-balloon-pci");
+    global_qtest = qtest_init("-device virtio-balloon-pci");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 26d0a7e9af..063b0f4013 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -84,24 +84,21 @@ static QOSState *pci_test_start(void)

 static void arm_test_start(void)
 {
-    char *cmdline;
     char *tmp_path;

     tmp_path = drive_create();

-    cmdline = g_strdup_printf("-machine virt "
-                                "-drive if=none,id=drive0,file=%s,format=raw "
-                                "-device virtio-blk-device,drive=drive0",
-                                tmp_path);
-    qtest_start(cmdline);
+    global_qtest = qtest_init("-machine virt "
+                              "-drive if=none,id=drive0,file=%s,format=raw "
+                              "-device virtio-blk-device,drive=drive0",
+                              tmp_path);
     unlink(tmp_path);
     g_free(tmp_path);
-    g_free(cmdline);
 }

 static void test_end(void)
 {
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static QVirtioPCIDevice *virtio_blk_pci_init(QPCIBus *bus, int slot)
diff --git a/tests/virtio-console-test.c b/tests/virtio-console-test.c
index 1c3de072f4..73fb30b051 100644
--- a/tests/virtio-console-test.c
+++ b/tests/virtio-console-test.c
@@ -13,16 +13,16 @@
 /* Tests only initialization so far. TODO: Replace with functional tests */
 static void console_pci_nop(void)
 {
-    qtest_start("-device virtio-serial-pci,id=vser0 "
+    global_qtest = qtest_init("-device virtio-serial-pci,id=vser0 "
                 "-device virtconsole,bus=vser0.0");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void serialport_pci_nop(void)
 {
-    qtest_start("-device virtio-serial-pci,id=vser0 "
+    global_qtest = qtest_init("-device virtio-serial-pci,id=vser0 "
                 "-device virtserialport,bus=vser0.0");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 635b942c36..9b32866fb1 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -30,7 +30,7 @@

 static void test_end(void)
 {
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 #ifndef _WIN32
@@ -243,7 +243,7 @@ static void hotplug(void)
 {
     const char *arch = qtest_get_arch();

-    qtest_start("-device virtio-net-pci");
+    global_qtest = qtest_init("-device virtio-net-pci");

     qpci_plug_device_test("virtio-net-pci", "net1", PCI_SLOT_HP, NULL);

diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index dcecf77463..e1b1e89b59 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -37,10 +37,10 @@ int main(int argc, char **argv)
     qtest_add_func("/virtio/rng/pci/nop", pci_nop);
     qtest_add_func("/virtio/rng/pci/hotplug", hotplug);

-    qtest_start("-device virtio-rng-pci");
+    global_qtest = qtest_init("-device virtio-rng-pci");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
index b14d943ada..ce708cc11e 100644
--- a/tests/virtio-serial-test.c
+++ b/tests/virtio-serial-test.c
@@ -49,10 +49,10 @@ int main(int argc, char **argv)
     qtest_add_func("/virtio/serial/pci/nop", pci_nop);
     qtest_add_func("/virtio/serial/pci/hotplug", hotplug);

-    qtest_start("-device virtio-serial-pci");
+    global_qtest = qtest_init("-device virtio-serial-pci");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 73473162d0..b149690a1a 100644
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
+    global_qtest = qtest_init(GUID_CMD(VGID_GUID));

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
+    global_qtest = qtest_init(GUID_CMD("auto"));

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
+    global_qtest = qtest_init(GUID_CMD(VGID_GUID));

     /* Read the GUID via the monitor */
     read_guid_from_monitor(&measured);
     g_assert(memcmp(measured.data, expected.data, sizeof(measured.data)) == 0);

     qtest_quit(global_qtest);
-    g_free(cmd);
 }

 int main(int argc, char **argv)
diff --git a/tests/vmxnet3-test.c b/tests/vmxnet3-test.c
index 159c0ad728..c9a876bcd9 100644
--- a/tests/vmxnet3-test.c
+++ b/tests/vmxnet3-test.c
@@ -22,10 +22,10 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/vmxnet3/nop", nop);

-    qtest_start("-device vmxnet3");
+    global_qtest = qtest_init("-device vmxnet3");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
-- 
2.13.5
