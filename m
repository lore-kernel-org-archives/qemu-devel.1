Received: from eggs.gnu.org ([2001:4830:134:3::10]:39037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPD-000880-DT
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSP9-0001YQ-UJ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:13 -0500
Message-Id: <20170911172022.4738-30-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 29/38] libqtest: Merge qtest_init() into
 qtest_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, Keith Busch <keith.busch@intel.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>

Remove the trivial wrapper qtest_init(), and change qtest_start()
to no longer implicitly set global_qtest, to make it obvious in the
rest of the testsuite where we are still relying on global_qtest.
Everything now uses qtest_start() (and friends) and qtest_quit(),
and explicitly tracks the QTestState between the two (although in
many cases, this tracking is still done through global_qtest).
Doing this makes it easier to see what remaining cleanups will be
needed if we don't want an implicit dependency on global state.

A few more places that were needlessly strdup'ing a temporary
variable are cleaned up in the process.

As mentioned in an earlier commit, the choice to get rid of
qtest_init() also reduces confusion with the device initializer
of the non-testsuite qtest.c device.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h               | 33 ++++-----------------------------
 tests/libqtest.c               |  4 ++--
 tests/ac97-test.c              |  2 +-
 tests/device-introspect-test.c | 12 ++++++------
 tests/display-vga-test.c       | 18 ++++++------------
 tests/drive_del-test.c         | 11 ++++++-----
 tests/es1370-test.c            |  2 +-
 tests/fdc-test.c               |  2 +-
 tests/fw_cfg-test.c            |  2 +-
 tests/hd-geo-test.c            |  8 ++++----
 tests/i440fx-test.c            |  2 +-
 tests/i82801b11-test.c         |  3 ++-
 tests/intel-hda-test.c         |  9 ++++-----
 tests/ioh3420-test.c           |  5 +++--
 tests/ipmi-kcs-test.c          |  7 ++-----
 tests/ipoctal232-test.c        |  3 ++-
 tests/ivshmem-test.c           |  2 +-
 tests/m48t59-test.c            |  2 +-
 tests/ne2000-test.c            |  2 +-
 tests/nvme-test.c              |  5 +++--
 tests/pcnet-test.c             |  2 +-
 tests/postcopy-test.c          |  4 ++--
 tests/pvpanic-test.c           |  2 +-
 tests/q35-test.c               |  4 ++--
 tests/qmp-test.c               |  4 ++--
 tests/rtc-test.c               |  2 +-
 tests/rtl8139-test.c           |  2 +-
 tests/spapr-phb-test.c         |  5 +++--
 tests/test-arm-mptimer.c       |  2 +-
 tests/test-x86-cpuid-compat.c  |  7 ++++---
 tests/tmp105-test.c            |  1 +
 tests/tpci200-test.c           |  2 +-
 tests/usb-hcd-ehci-test.c      | 23 ++++++++++++-----------
 tests/usb-hcd-ohci-test.c      |  2 +-
 tests/usb-hcd-xhci-test.c      |  5 +++--
 tests/virtio-balloon-test.c    |  2 +-
 tests/virtio-console-test.c    | 10 ++++------
 tests/virtio-net-test.c        |  2 +-
 tests/virtio-rng-test.c        |  2 +-
 tests/virtio-serial-test.c     |  2 +-
 tests/vmxnet3-test.c           |  2 +-
 tests/wdt_ib700-test.c         |  8 ++++----
 42 files changed, 101 insertions(+), 128 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 817e3a5580..2a21bf4605 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -27,7 +27,7 @@ extern QTestState *global_qtest;
  * qtest_start_without_qmp_handshake:
  * @extra_args: other arguments to pass to QEMU.
  *
- * Returns: #QTestState instance.  Does not affect #global_qtest.
+ * Returns: #QTestState instance, handshaking not yet completed.
  */
 QTestState *qtest_start_without_qmp_handshake(const char *extra_args);

@@ -35,10 +35,7 @@ QTestState *qtest_start_without_qmp_handshake(const char *extra_args);
  * qtest_start:
  * @args: other arguments to pass to QEMU
  *
- * Start QEMU and assign the resulting #QTestState to #global_qtest.
- * The global variable is used by "shortcut" functions documented below.
- *
- * Returns: #QTestState instance.
+ * Returns: #QTestState instance, handshaking completed.
  */
 QTestState *qtest_start(const char *args);

@@ -47,10 +44,7 @@ QTestState *qtest_start(const char *args);
  * @fmt...: Format for creating other arguments to pass to QEMU, formatted
  * like sprintf().
  *
- * Start QEMU and return the resulting #QTestState (but unlike qtest_start(),
- * #global_qtest is left at NULL).
- *
- * Returns: #QTestState instance.
+ * Returns: #QTestState instance, handshaking completed.
  */
 QTestState *qtest_startf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);

@@ -60,30 +54,11 @@ QTestState *qtest_startf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
  * like vsprintf().
  * @ap: Format arguments.
  *
- * Start QEMU and return the resulting #QTestState (but unlike qtest_start(),
- * #global_qtest is left at NULL).
- *
- * Returns: #QTestState instance.
+ * Returns: #QTestState instance, handshaking completed.
  */
 QTestState *qtest_vstartf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);

 /**
- * qtest_init:
- * @extra_args: other arguments to pass to QEMU.
- *
- * Returns: #QTestState instance.  Does not affect #global_qtest.
- */
-static inline QTestState *qtest_init(const char *extra_args)
-{
-    QTestState *s;
-
-    assert(!global_qtest);
-    s = qtest_start(extra_args);
-    global_qtest = NULL;
-    return s;
-}
-
-/**
  * qtest_quit:
  * @s: #QTestState instance to operate on.
  *
diff --git a/tests/libqtest.c b/tests/libqtest.c
index b535d7768f..44c89813ff 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -242,7 +242,7 @@ QTestState *qtest_start(const char *extra_args)
     qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");

     assert(!global_qtest);
-    return global_qtest = s;
+    return s;
 }

 QTestState *qtest_vstartf(const char *fmt, va_list ap)
@@ -988,7 +988,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
     QString *qstr;
     const char *mname;

-    qtest_start("-machine none");
+    global_qtest = qtest_start("-machine none");
     response = qmp("{ 'execute': 'query-machines' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
diff --git a/tests/ac97-test.c b/tests/ac97-test.c
index ca9b3dce88..2f5fb10632 100644
--- a/tests/ac97-test.c
+++ b/tests/ac97-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/ac97/nop", nop);

-    qtest_start("-device AC97");
+    global_qtest = qtest_start("-device AC97");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index b3227bd950..ed4f5f2eed 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -126,7 +126,7 @@ static void test_device_intro_list(void)
     QList *types;
     char *help;

-    qtest_start(common_args);
+    global_qtest = qtest_start(common_args);

     types = device_type_list(true);
     QDECREF(types);
@@ -167,7 +167,7 @@ static void test_qom_list_fields(void)
     QList *non_abstract;
     QListEntry *e;

-    qtest_start(common_args);
+    global_qtest = qtest_start(common_args);

     all_types = qom_list_types(NULL, true);
     non_abstract = qom_list_types(NULL, false);
@@ -194,14 +194,14 @@ static void test_qom_list_fields(void)

 static void test_device_intro_none(void)
 {
-    qtest_start(common_args);
+    global_qtest = qtest_start(common_args);
     test_one_device("nonexistent");
     qtest_quit(global_qtest);
 }

 static void test_device_intro_abstract(void)
 {
-    qtest_start(common_args);
+    global_qtest = qtest_start(common_args);
     test_one_device("device");
     qtest_quit(global_qtest);
 }
@@ -212,7 +212,7 @@ static void test_device_intro_concrete(void)
     QListEntry *entry;
     const char *type;

-    qtest_start(common_args);
+    global_qtest = qtest_start(common_args);
     types = device_type_list(false);

     QLIST_FOREACH_ENTRY(types, entry) {
@@ -232,7 +232,7 @@ static void test_abstract_interfaces(void)
     QListEntry *e;
     QDict *index;

-    qtest_start(common_args);
+    global_qtest = qtest_start(common_args);

     all_types = qom_list_types("interface", true);
     index = qom_type_index(all_types);
diff --git a/tests/display-vga-test.c b/tests/display-vga-test.c
index 8667330e3c..d638f15ec3 100644
--- a/tests/display-vga-test.c
+++ b/tests/display-vga-test.c
@@ -12,39 +12,33 @@

 static void pci_cirrus(void)
 {
-    qtest_start("-vga none -device cirrus-vga");
-    qtest_quit(global_qtest);
+    qtest_quit(qtest_start("-vga none -device cirrus-vga"));
 }

 static void pci_stdvga(void)
 {
-    qtest_start("-vga none -device VGA");
-    qtest_quit(global_qtest);
+    qtest_quit(qtest_start("-vga none -device VGA"));
 }

 static void pci_secondary(void)
 {
-    qtest_start("-vga none -device secondary-vga");
-    qtest_quit(global_qtest);
+    qtest_quit(qtest_start("-vga none -device secondary-vga"));
 }

 static void pci_multihead(void)
 {
-    qtest_start("-vga none -device VGA -device secondary-vga");
-    qtest_quit(global_qtest);
+    qtest_quit(qtest_start("-vga none -device VGA -device secondary-vga"));
 }

 static void pci_virtio_gpu(void)
 {
-    qtest_start("-vga none -device virtio-gpu-pci");
-    qtest_quit(global_qtest);
+    qtest_quit(qtest_start("-vga none -device virtio-gpu-pci"));
 }

 #ifdef CONFIG_VIRTIO_VGA
 static void pci_virtio_vga(void)
 {
-    qtest_start("-vga none -device virtio-vga");
-    qtest_quit(global_qtest);
+    qtest_quit(qtest_start("-vga none -device virtio-vga"));
 }
 #endif

diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 16d256fe64..f68c4bc176 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -45,7 +45,7 @@ static void device_del(void)
 static void test_drive_without_dev(void)
 {
     /* Start with an empty drive */
-    qtest_start("-drive if=none,id=drive0");
+    global_qtest = qtest_start("-drive if=none,id=drive0");

     /* Delete the drive */
     drive_del();
@@ -63,7 +63,7 @@ static void test_after_failed_device_add(void)
     QDict *response;
     QDict *error;

-    qtest_start("-drive if=none,id=drive0");
+    global_qtest = qtest_start("-drive if=none,id=drive0");

     /* Make device_add fail.  If this leaks the virtio-blk-pci device then a
      * reference to drive0 will also be held (via qdev properties).
@@ -92,9 +92,10 @@ static void test_after_failed_device_add(void)
 static void test_drive_del_device_del(void)
 {
     /* Start with a drive used by a device that unplugs instantaneously */
-    qtest_start("-drive if=none,id=drive0,file=null-co://,format=raw"
-                " -device virtio-scsi-pci"
-                " -device scsi-hd,drive=drive0,id=dev0");
+    global_qtest = qtest_start(
+        "-drive if=none,id=drive0,file=null-co://,format=raw"
+        " -device virtio-scsi-pci"
+        " -device scsi-hd,drive=drive0,id=dev0");

     /*
      * Delete the drive, and then the device
diff --git a/tests/es1370-test.c b/tests/es1370-test.c
index 5578ff94fa..ff6fdbfe57 100644
--- a/tests/es1370-test.c
+++ b/tests/es1370-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/es1370/nop", nop);

-    qtest_start("-device ES1370");
+    global_qtest = qtest_start("-device ES1370");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index e63e93179a..ec83625db2 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -564,7 +564,7 @@ int main(int argc, char **argv)
     /* Run the tests */
     g_test_init(&argc, &argv, NULL);

-    qtest_start("-device floppy,id=floppy0");
+    global_qtest = qtest_start("-device floppy,id=floppy0");
     qtest_irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/fdc/cmos", test_cmos);
     qtest_add_func("/fdc/no_media_on_start", test_no_media_on_start);
diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 3a8dc7a2cd..37214fdf10 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -106,7 +106,7 @@ int main(int argc, char **argv)

     g_test_init(&argc, &argv, NULL);

-    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
+    s = qtest_start("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");

     fw_cfg = pc_fw_cfg_init(s);

diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 67d571ef13..406eea3c56 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -241,7 +241,7 @@ static void test_ide_none(void)

     setup_common(argv, ARGV_SIZE);
     args = g_strjoinv(" ", argv);
-    qtest_start(args);
+    global_qtest = qtest_start(args);
     g_strfreev(argv);
     g_free(args);
     test_cmos();
@@ -263,7 +263,7 @@ static void test_ide_mbr(bool use_device, MBRcontents mbr)
         argc = setup_ide(argc, argv, ARGV_SIZE, i, dev, i, mbr, "");
     }
     args = g_strjoinv(" ", argv);
-    qtest_start(args);
+    global_qtest = qtest_start(args);
     g_strfreev(argv);
     g_free(args);
     test_cmos();
@@ -339,7 +339,7 @@ static void test_ide_drive_user(const char *dev, bool trans)
                      dev ? "" : opts);
     g_free(opts);
     args = g_strjoinv(" ", argv);
-    qtest_start(args);
+    global_qtest = qtest_start(args);
     g_strfreev(argv);
     g_free(args);
     test_cmos();
@@ -396,7 +396,7 @@ static void test_ide_drive_cd_0(void)
                          ide_idx, NULL, i, mbr_blank, "");
     }
     args = g_strjoinv(" ", argv);
-    qtest_start(args);
+    global_qtest = qtest_start(args);
     g_strfreev(argv);
     g_free(args);
     test_cmos();
diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
index c282ded4ca..1d78089f8e 100644
--- a/tests/i440fx-test.c
+++ b/tests/i440fx-test.c
@@ -340,7 +340,7 @@ static void test_i440fx_firmware(FirmwareTestFixture *fixture,
                                          : "-drive if=pflash,format=raw,file=",
                               fw_pathname);
     g_test_message("qemu cmdline: %s", cmdline);
-    qtest_start(cmdline);
+    global_qtest = qtest_start(cmdline);
     g_free(cmdline);

     /* QEMU has loaded the firmware (because qtest_start() only returns after
diff --git a/tests/i82801b11-test.c b/tests/i82801b11-test.c
index 0c94876626..b76714ae16 100644
--- a/tests/i82801b11-test.c
+++ b/tests/i82801b11-test.c
@@ -22,7 +22,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/i82801b11/nop", nop);

-    qtest_start("-machine q35 -device i82801b11-bridge,bus=pcie.0,addr=1e.0");
+    global_qtest = qtest_start("-machine q35 "
+                               "-device i82801b11-bridge,bus=pcie.0,addr=1e.0");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/intel-hda-test.c b/tests/intel-hda-test.c
index ce24fbac1f..c97a7635ed 100644
--- a/tests/intel-hda-test.c
+++ b/tests/intel-hda-test.c
@@ -18,15 +18,14 @@
 /* Tests only initialization so far. TODO: Replace with functional tests */
 static void ich6_test(void)
 {
-    qtest_start("-device intel-hda,id=" HDA_ID CODEC_DEVICES);
-    qtest_quit(global_qtest);
+    qtest_quit(qtest_start("-device intel-hda,id=" HDA_ID CODEC_DEVICES));
 }

 static void ich9_test(void)
 {
-    qtest_start("-machine q35 -device ich9-intel-hda,bus=pcie.0,addr=1b.0,id="
-                HDA_ID CODEC_DEVICES);
-    qtest_quit(global_qtest);
+    qtest_quit(qtest_start(
+        "-machine q35 -device ich9-intel-hda,bus=pcie.0,addr=1b.0,id="
+        HDA_ID CODEC_DEVICES));
 }

 int main(int argc, char **argv)
diff --git a/tests/ioh3420-test.c b/tests/ioh3420-test.c
index f2ca373e87..aff569b99e 100644
--- a/tests/ioh3420-test.c
+++ b/tests/ioh3420-test.c
@@ -22,8 +22,9 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/ioh3420/nop", nop);

-    qtest_start("-machine q35 -device ioh3420,bus=pcie.0,addr=1c.0,port=1,"
-                "chassis=1,multifunction=on");
+    global_qtest = qtest_start(
+        "-machine q35 -device ioh3420,bus=pcie.0,addr=1c.0,port=1,"
+        "chassis=1,multifunction=on");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/ipmi-kcs-test.c b/tests/ipmi-kcs-test.c
index 178ffc1797..5acc0d9e35 100644
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
-                              " -device isa-ipmi-kcs,bmc=bmc0");
-    qtest_start(cmdline);
-    g_free(cmdline);
+    global_qtest = qtest_start("-device ipmi-bmc-sim,id=bmc0"
+                               " -device isa-ipmi-kcs,bmc=bmc0");
     qtest_irq_intercept_in(global_qtest, "ioapic");
     qtest_add_func("/ipmi/local/kcs_base", test_kcs_base);
     qtest_add_func("/ipmi/local/kcs_abort", test_kcs_abort);
diff --git a/tests/ipoctal232-test.c b/tests/ipoctal232-test.c
index d17a93449f..90b683284a 100644
--- a/tests/ipoctal232-test.c
+++ b/tests/ipoctal232-test.c
@@ -22,7 +22,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/ipoctal232/tpci200/nop", nop);

-    qtest_start("-device tpci200,id=ipack0 -device ipoctal232,bus=ipack0.0");
+    global_qtest = qtest_start("-device tpci200,id=ipack0 "
+                               "-device ipoctal232,bus=ipack0.0");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 58eaf0cafb..aa5619c62c 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -407,7 +407,7 @@ static void test_ivshmem_hotplug(void)
     gchar *opts;
     QTestState *qts;

-    qts = qtest_init("");
+    qts = qtest_start("");

     opts = g_strdup_printf("'shm': '%s', 'size': '1M'", tmpshm);

diff --git a/tests/m48t59-test.c b/tests/m48t59-test.c
index 0f921ef38a..aadd770f4f 100644
--- a/tests/m48t59-test.c
+++ b/tests/m48t59-test.c
@@ -246,7 +246,7 @@ int main(int argc, char **argv)

     g_test_init(&argc, &argv, NULL);

-    s = qtest_start("-rtc clock=vm");
+    s = global_qtest = qtest_start("-rtc clock=vm");

     qtest_add_func("/rtc/bcd/check-time", bcd_check_time);
     qtest_add_func("/rtc/fuzz-registers", fuzz_registers);
diff --git a/tests/ne2000-test.c b/tests/ne2000-test.c
index cae83c5c4c..8e6f7b07c6 100644
--- a/tests/ne2000-test.c
+++ b/tests/ne2000-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/ne2000/pci/nop", pci_nop);

-    qtest_start("-device ne2k_pci");
+    global_qtest = qtest_start("-device ne2k_pci");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/nvme-test.c b/tests/nvme-test.c
index 3d6c0f39cf..b054ad6fcd 100644
--- a/tests/nvme-test.c
+++ b/tests/nvme-test.c
@@ -22,8 +22,9 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/nvme/nop", nop);

-    qtest_start("-drive id=drv0,if=none,file=null-co://,format=raw "
-                "-device nvme,drive=drv0,serial=foo");
+    global_qtest = qtest_start(
+        "-drive id=drv0,if=none,file=null-co://,format=raw "
+        "-device nvme,drive=drv0,serial=foo");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/pcnet-test.c b/tests/pcnet-test.c
index 98246d3504..a58a5fd7bf 100644
--- a/tests/pcnet-test.c
+++ b/tests/pcnet-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/pcnet/pci/nop", pci_nop);

-    qtest_start("-device pcnet");
+    global_qtest = qtest_start("-device pcnet");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 0e5fe20a83..efee20a099 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -403,10 +403,10 @@ static void test_migrate(void)

     g_free(bootpath);

-    from = qtest_init(cmd_src);
+    from = qtest_start(cmd_src);
     g_free(cmd_src);

-    to = qtest_init(cmd_dst);
+    to = qtest_start(cmd_dst);
     g_free(cmd_dst);

     assert(!global_qtest);
diff --git a/tests/pvpanic-test.c b/tests/pvpanic-test.c
index 5d99b3d9e2..c09b3ddac6 100644
--- a/tests/pvpanic-test.c
+++ b/tests/pvpanic-test.c
@@ -37,7 +37,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/pvpanic/panic", test_panic);

-    qtest_start("-device pvpanic");
+    global_qtest = qtest_start("-device pvpanic");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/q35-test.c b/tests/q35-test.c
index a8e24e5b71..4d90b9174e 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -84,7 +84,7 @@ static void test_smram_lock(void)
     QPCIDevice *pcidev;
     QDict *response;

-    qtest_start("-M q35");
+    global_qtest = qtest_start("-M q35");

     pcibus = qpci_init_pc(global_qtest, NULL);
     g_assert(pcibus != NULL);
@@ -141,7 +141,7 @@ static void test_tseg_size(const void *data)
         cmdline = g_strdup_printf("-M q35 -m %uM",
                                   TSEG_SIZE_TEST_GUEST_RAM_MBYTES);
     }
-    qtest_start(cmdline);
+    global_qtest = qtest_start(cmdline);
     g_free(cmdline);

     /* locate the DRAM controller */
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 8985e7f9ec..6ea66211d4 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -172,7 +172,7 @@ static void test_query(const void *data)
     QDict *resp, *error;
     const char *error_class;

-    qtest_start(common_args);
+    global_qtest = qtest_start(common_args);

     resp = qmp("{ 'execute': %s }", cmd);
     error = qdict_get_qdict(resp, "error");
@@ -224,7 +224,7 @@ static void qmp_schema_init(QmpSchema *schema)
     Visitor *qiv;
     SchemaInfoList *tail;

-    qtest_start(common_args);
+    global_qtest = qtest_start(common_args);
     resp = qmp("{ 'execute': 'query-qmp-schema' }");

     qiv = qobject_input_visitor_new(qdict_get(resp, "return"));
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index d7a96cbd79..dd5430dd2d 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -690,7 +690,7 @@ int main(int argc, char **argv)

     g_test_init(&argc, &argv, NULL);

-    s = qtest_start("-rtc clock=vm");
+    s = global_qtest = qtest_start("-rtc clock=vm");
     qtest_irq_intercept_in(s, "ioapic");

     qtest_add_func("/rtc/check-time/bcd", bcd_check_time);
diff --git a/tests/rtl8139-test.c b/tests/rtl8139-test.c
index 317eb586b5..1741f0ec47 100644
--- a/tests/rtl8139-test.c
+++ b/tests/rtl8139-test.c
@@ -197,7 +197,7 @@ int main(int argc, char **argv)
 {
     int ret;

-    qtest_start("-device rtl8139");
+    global_qtest = qtest_start("-device rtl8139");

     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/rtl8139/nop", nop);
diff --git a/tests/spapr-phb-test.c b/tests/spapr-phb-test.c
index e76987ace9..5ab22f3ba6 100644
--- a/tests/spapr-phb-test.c
+++ b/tests/spapr-phb-test.c
@@ -21,15 +21,16 @@ static void test_phb_device(void)
 int main(int argc, char **argv)
 {
     int ret;
+    QTestState *qts;

     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/spapr-phb/device", test_phb_device);

-    qtest_start("-device " TYPE_SPAPR_PCI_HOST_BRIDGE ",index=30");
+    qts = qtest_start("-device " TYPE_SPAPR_PCI_HOST_BRIDGE ",index=30");

     ret = g_test_run();

-    qtest_quit(global_qtest);
+    qtest_quit(qts);

     return ret;
 }
diff --git a/tests/test-arm-mptimer.c b/tests/test-arm-mptimer.c
index 823db9ebc9..9631c55fe3 100644
--- a/tests/test-arm-mptimer.c
+++ b/tests/test-arm-mptimer.c
@@ -1097,7 +1097,7 @@ tests_with_prescaler_arg:
         goto tests_with_prescaler_arg;
     }

-    qtest_start("-machine vexpress-a9");
+    global_qtest = qtest_start("-machine vexpress-a9");
     ret = g_test_run();
     qtest_quit(global_qtest);

diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 4e88f9e4e2..84410c63b9 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -59,7 +59,7 @@ static void test_cpuid_prop(const void *data)
     QNum *value;
     int64_t val;

-    qtest_start(args->cmdline);
+    global_qtest = qtest_start(args->cmdline);
     path = get_cpu0_qom_path();
     value = qobject_to_qnum(qom_get(path, args->property));
     g_assert(qnum_get_try_int(value, &val));
@@ -131,7 +131,7 @@ static void test_feature_flag(const void *data)
     QList *present, *filtered;
     uint32_t value;

-    qtest_start(args->cmdline);
+    global_qtest = qtest_start(args->cmdline);
     path = get_cpu0_qom_path();
     present = qobject_to_qlist(qom_get(path, "feature-words"));
     filtered = qobject_to_qlist(qom_get(path, "filtered-features"));
@@ -181,7 +181,8 @@ static void test_plus_minus_subprocess(void)
      * Note: rules 1 and 2 are planned to be removed soon, and
      * should generate a warning.
      */
-    qtest_start("-cpu pentium,-fpu,+fpu,-mce,mce=on,+cx8,cx8=off,+sse4_1,sse4_2=on");
+    global_qtest = qtest_start("-cpu pentium,-fpu,+fpu,-mce,mce=on,+cx8,"
+                               "cx8=off,+sse4_1,sse4_2=on");
     path = get_cpu0_qom_path();

     g_assert_false(qom_get_bool(path, "fpu"));
diff --git a/tests/tmp105-test.c b/tests/tmp105-test.c
index 382f88ba23..3f2cb3a864 100644
--- a/tests/tmp105-test.c
+++ b/tests/tmp105-test.c
@@ -154,6 +154,7 @@ int main(int argc, char **argv)
     s = qtest_start("-machine n800 "
                     "-device tmp105,bus=i2c-bus.0,id=" TMP105_TEST_ID
                     ",address=0x49");
+    global_qtest = s;
     i2c = omap_i2c_create(s, OMAP2_I2C_1_BASE);

     qtest_add_func("/tmp105/tx-rx", send_and_receive);
diff --git a/tests/tpci200-test.c b/tests/tpci200-test.c
index 3b756d10f0..223d44da35 100644
--- a/tests/tpci200-test.c
+++ b/tests/tpci200-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/tpci200/nop", nop);

-    qtest_start("-device tpci200");
+    global_qtest = qtest_start("-device tpci200");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
index 16d74512cc..c3568a1782 100644
--- a/tests/usb-hcd-ehci-test.c
+++ b/tests/usb-hcd-ehci-test.c
@@ -156,17 +156,18 @@ int main(int argc, char **argv)
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
+    global_qtest = qtest_start(
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
diff --git a/tests/usb-hcd-ohci-test.c b/tests/usb-hcd-ohci-test.c
index aa38e44d03..62fd35f69a 100644
--- a/tests/usb-hcd-ohci-test.c
+++ b/tests/usb-hcd-ohci-test.c
@@ -31,7 +31,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ohci/pci/init", test_ohci_init);
     qtest_add_func("/ohci/pci/hotplug", test_ohci_hotplug);

-    qtest_start("-device pci-ohci,id=ohci");
+    global_qtest = qtest_start("-device pci-ohci,id=ohci");
     ret = g_test_run();
     qtest_quit(global_qtest);

diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index e45509741c..bd3c65ae85 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -80,8 +80,9 @@ int main(int argc, char **argv)
     qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
     qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);

-    qtest_start("-device nec-usb-xhci,id=xhci"
-                " -drive id=drive0,if=none,file=null-co://,format=raw");
+    global_qtest = qtest_start(
+        "-device nec-usb-xhci,id=xhci"
+        " -drive id=drive0,if=none,file=null-co://,format=raw");
     ret = g_test_run();
     qtest_quit(global_qtest);

diff --git a/tests/virtio-balloon-test.c b/tests/virtio-balloon-test.c
index 34ad718601..cca7b0e8fb 100644
--- a/tests/virtio-balloon-test.c
+++ b/tests/virtio-balloon-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/virtio/balloon/pci/nop", pci_nop);

-    qtest_start("-device virtio-balloon-pci");
+    global_qtest = qtest_start("-device virtio-balloon-pci");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/virtio-console-test.c b/tests/virtio-console-test.c
index 5c036ce02a..07a5f26880 100644
--- a/tests/virtio-console-test.c
+++ b/tests/virtio-console-test.c
@@ -13,16 +13,14 @@
 /* Tests only initialization so far. TODO: Replace with functional tests */
 static void console_pci_nop(void)
 {
-    qtest_start("-device virtio-serial-pci,id=vser0 "
-                "-device virtconsole,bus=vser0.0");
-    qtest_quit(global_qtest);
+    qtest_quit(qtest_start("-device virtio-serial-pci,id=vser0 "
+                           "-device virtconsole,bus=vser0.0"));
 }

 static void serialport_pci_nop(void)
 {
-    qtest_start("-device virtio-serial-pci,id=vser0 "
-                "-device virtserialport,bus=vser0.0");
-    qtest_quit(global_qtest);
+    qtest_quit(qtest_start("-device virtio-serial-pci,id=vser0 "
+                           "-device virtserialport,bus=vser0.0"));
 }

 int main(int argc, char **argv)
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index e1085c7e77..9250c417a9 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -246,7 +246,7 @@ static void hotplug(void)
 {
     const char *arch = qtest_get_arch();

-    qtest_start("-device virtio-net-pci");
+    global_qtest = qtest_start("-device virtio-net-pci");

     qpci_plug_device_test(global_qtest, "virtio-net-pci", "net1",
                           PCI_SLOT_HP, NULL);
diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index a3a8bde491..e632281fa4 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -38,7 +38,7 @@ int main(int argc, char **argv)
     qtest_add_func("/virtio/rng/pci/nop", pci_nop);
     qtest_add_func("/virtio/rng/pci/hotplug", hotplug);

-    qtest_start("-device virtio-rng-pci");
+    global_qtest = qtest_start("-device virtio-rng-pci");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
index d0bbc2a8c9..1cc43465e6 100644
--- a/tests/virtio-serial-test.c
+++ b/tests/virtio-serial-test.c
@@ -49,7 +49,7 @@ int main(int argc, char **argv)
     qtest_add_func("/virtio/serial/pci/nop", pci_nop);
     qtest_add_func("/virtio/serial/pci/hotplug", hotplug);

-    qtest_start("-device virtio-serial-pci");
+    global_qtest = qtest_start("-device virtio-serial-pci");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/vmxnet3-test.c b/tests/vmxnet3-test.c
index 631630b4d0..0b4b807616 100644
--- a/tests/vmxnet3-test.c
+++ b/tests/vmxnet3-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/vmxnet3/nop", nop);

-    qtest_start("-device vmxnet3");
+    global_qtest = qtest_start("-device vmxnet3");
     ret = g_test_run();

     qtest_quit(global_qtest);
diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index 4bb8374011..a169265e16 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -56,7 +56,7 @@ static QDict *ib700_program_and_wait(QTestState *s)
 static void ib700_pause(void)
 {
     QDict *d;
-    QTestState *s = qtest_init("-watchdog-action pause -device ib700");
+    QTestState *s = qtest_start("-watchdog-action pause -device ib700");

     qtest_irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
@@ -69,7 +69,7 @@ static void ib700_pause(void)
 static void ib700_reset(void)
 {
     QDict *d;
-    QTestState *s = qtest_init("-watchdog-action reset -device ib700");
+    QTestState *s = qtest_start("-watchdog-action reset -device ib700");

     qtest_irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
@@ -84,7 +84,7 @@ static void ib700_shutdown(void)
     QDict *d;
     QTestState *s;

-    s = qtest_init("-watchdog-action reset -no-reboot -device ib700");
+    s = qtest_start("-watchdog-action reset -no-reboot -device ib700");
     qtest_irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
@@ -96,7 +96,7 @@ static void ib700_shutdown(void)
 static void ib700_none(void)
 {
     QDict *d;
-    QTestState *s = qtest_init("-watchdog-action none -device ib700");
+    QTestState *s = qtest_start("-watchdog-action none -device ib700");

     qtest_irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
-- 
2.13.5
