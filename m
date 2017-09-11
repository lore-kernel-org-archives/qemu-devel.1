Received: from eggs.gnu.org ([2001:4830:134:3::10]:38915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSP3-0007xh-7A
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSP0-0001SI-7q
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:45 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:10 -0500
Message-Id: <20170911172022.4738-27-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 26/38] libqtest: Merge qtest_end() into
 qtest_quit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, Keith Busch <keith.busch@intel.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>

Rather than have two similar shutdown functions, where one requires
the use of global_qtest in the header, it is better to have a single
shutdown function that still takes care of cleaning up global_qtest
if it is set.  All callers are updated.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h               | 11 -----------
 tests/libqtest.c               |  6 +++++-
 tests/ac97-test.c              |  2 +-
 tests/device-introspect-test.c | 12 ++++++------
 tests/display-vga-test.c       | 12 ++++++------
 tests/drive_del-test.c         |  6 +++---
 tests/e1000e-test.c            |  4 ++--
 tests/es1370-test.c            |  2 +-
 tests/fdc-test.c               |  2 +-
 tests/hd-geo-test.c            |  8 ++++----
 tests/i440fx-test.c            |  6 +++---
 tests/i82801b11-test.c         |  2 +-
 tests/ide-test.c               |  2 +-
 tests/intel-hda-test.c         |  4 ++--
 tests/ioh3420-test.c           |  2 +-
 tests/ipoctal232-test.c        |  2 +-
 tests/ne2000-test.c            |  2 +-
 tests/numa-test.c              | 14 +++++++-------
 tests/nvme-test.c              |  2 +-
 tests/pc-cpu-test.c            |  4 ++--
 tests/pcnet-test.c             |  2 +-
 tests/pvpanic-test.c           |  2 +-
 tests/q35-test.c               |  4 ++--
 tests/qmp-test.c               |  4 ++--
 tests/qom-test.c               |  2 +-
 tests/rtl8139-test.c           |  2 +-
 tests/spapr-phb-test.c         |  2 +-
 tests/tco-test.c               |  2 +-
 tests/test-arm-mptimer.c       |  2 +-
 tests/test-filter-mirror.c     |  2 +-
 tests/test-filter-redirector.c |  4 ++--
 tests/test-hmp.c               |  2 +-
 tests/test-netfilter.c         |  2 +-
 tests/test-x86-cpuid-compat.c  |  6 +++---
 tests/tpci200-test.c           |  2 +-
 tests/usb-hcd-ehci-test.c      |  2 +-
 tests/usb-hcd-ohci-test.c      |  2 +-
 tests/usb-hcd-xhci-test.c      |  2 +-
 tests/virtio-balloon-test.c    |  2 +-
 tests/virtio-blk-test.c        |  2 +-
 tests/virtio-console-test.c    |  4 ++--
 tests/virtio-net-test.c        |  2 +-
 tests/virtio-rng-test.c        |  2 +-
 tests/virtio-serial-test.c     |  2 +-
 tests/vmxnet3-test.c           |  2 +-
 45 files changed, 80 insertions(+), 87 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 3ae570927a..d976a542b8 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -523,17 +523,6 @@ static inline QTestState *qtest_start(const char *args)
 }

 /**
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
index 1710d63276..94c157ce02 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -246,6 +246,10 @@ QTestState *qtest_init(const char *extra_args)

 void qtest_quit(QTestState *s)
 {
+    if (global_qtest) {
+        assert(s == global_qtest);
+        global_qtest = NULL;
+    }
     g_hook_destroy_link(&abrt_hooks, g_hook_find_data(&abrt_hooks, TRUE, s));

     /* Uninstall SIGABRT handler on last instance */
@@ -979,6 +983,6 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
         cb(mname);
     }

-    qtest_end();
+    qtest_quit(global_qtest);
     QDECREF(response);
 }
diff --git a/tests/ac97-test.c b/tests/ac97-test.c
index e0d177bd9c..ca9b3dce88 100644
--- a/tests/ac97-test.c
+++ b/tests/ac97-test.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
     qtest_start("-device AC97");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index f7162c023f..b3227bd950 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -134,7 +134,7 @@ static void test_device_intro_list(void)
     help = hmp("device_add help");
     g_free(help);

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 /*
@@ -189,21 +189,21 @@ static void test_qom_list_fields(void)

     QDECREF(all_types);
     QDECREF(non_abstract);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_device_intro_none(void)
 {
     qtest_start(common_args);
     test_one_device("nonexistent");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_device_intro_abstract(void)
 {
     qtest_start(common_args);
     test_one_device("device");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_device_intro_concrete(void)
@@ -223,7 +223,7 @@ static void test_device_intro_concrete(void)
     }

     QDECREF(types);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_abstract_interfaces(void)
@@ -257,7 +257,7 @@ static void test_abstract_interfaces(void)

     QDECREF(all_types);
     QDECREF(index);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/display-vga-test.c b/tests/display-vga-test.c
index 2d7d24eee0..8667330e3c 100644
--- a/tests/display-vga-test.c
+++ b/tests/display-vga-test.c
@@ -13,38 +13,38 @@
 static void pci_cirrus(void)
 {
     qtest_start("-vga none -device cirrus-vga");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void pci_stdvga(void)
 {
     qtest_start("-vga none -device VGA");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void pci_secondary(void)
 {
     qtest_start("-vga none -device secondary-vga");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void pci_multihead(void)
 {
     qtest_start("-vga none -device VGA -device secondary-vga");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void pci_virtio_gpu(void)
 {
     qtest_start("-vga none -device virtio-gpu-pci");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 #ifdef CONFIG_VIRTIO_VGA
 static void pci_virtio_vga(void)
 {
     qtest_start("-vga none -device virtio-vga");
-    qtest_end();
+    qtest_quit(global_qtest);
 }
 #endif

diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 2175139abb..16d256fe64 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -55,7 +55,7 @@ static void test_drive_without_dev(void)
      */
     drive_add();

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_after_failed_device_add(void)
@@ -86,7 +86,7 @@ static void test_after_failed_device_add(void)
      */
     drive_add();

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_drive_del_device_del(void)
@@ -103,7 +103,7 @@ static void test_drive_del_device_del(void)
     drive_del();
     device_del();

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index 8645485c19..98f821fa7b 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -408,7 +408,7 @@ static void data_test_clear(e1000e_device *d)
     pc_alloc_uninit(test_alloc);
     g_free(d->pci_dev);
     qpci_free_pc(test_bus);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_e1000e_init(gconstpointer data)
@@ -463,7 +463,7 @@ static void test_e1000e_hotplug(gconstpointer data)
     qpci_plug_device_test(global_qtest, "e1000e", "e1000e_net", slot, NULL);
     qpci_unplug_device_test(global_qtest, "e1000e_net", slot);

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/es1370-test.c b/tests/es1370-test.c
index 199fe193ce..5578ff94fa 100644
--- a/tests/es1370-test.c
+++ b/tests/es1370-test.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
     qtest_start("-device ES1370");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index 325712e0f2..e63e93179a 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -583,7 +583,7 @@ int main(int argc, char **argv)
     ret = g_test_run();

     /* Cleanup */
-    qtest_end();
+    qtest_quit(global_qtest);
     unlink(test_image);

     return ret;
diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 24870b38f4..67d571ef13 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -245,7 +245,7 @@ static void test_ide_none(void)
     g_strfreev(argv);
     g_free(args);
     test_cmos();
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_ide_mbr(bool use_device, MBRcontents mbr)
@@ -267,7 +267,7 @@ static void test_ide_mbr(bool use_device, MBRcontents mbr)
     g_strfreev(argv);
     g_free(args);
     test_cmos();
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 /*
@@ -343,7 +343,7 @@ static void test_ide_drive_user(const char *dev, bool trans)
     g_strfreev(argv);
     g_free(args);
     test_cmos();
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 /*
@@ -400,7 +400,7 @@ static void test_ide_drive_cd_0(void)
     g_strfreev(argv);
     g_free(args);
     test_cmos();
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
index 4390e5591e..c847e4dbbb 100644
--- a/tests/i440fx-test.c
+++ b/tests/i440fx-test.c
@@ -136,7 +136,7 @@ static void test_i440fx_defaults(gconstpointer opaque)

     g_free(dev);
     qpci_free_pc(bus);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 #define PAM_RE 1
@@ -275,7 +275,7 @@ static void test_i440fx_pam(gconstpointer opaque)

     g_free(dev);
     qpci_free_pc(bus);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 #define BLOB_SIZE ((size_t)65536)
@@ -373,7 +373,7 @@ static void test_i440fx_firmware(FirmwareTestFixture *fixture,
     }

     g_free(buf);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void add_firmware_test(const char *testpath,
diff --git a/tests/i82801b11-test.c b/tests/i82801b11-test.c
index a6e31594c9..0c94876626 100644
--- a/tests/i82801b11-test.c
+++ b/tests/i82801b11-test.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
     qtest_start("-machine q35 -device i82801b11-bridge,bus=pcie.0,addr=1e.0");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/ide-test.c b/tests/ide-test.c
index 084f6a5f96..16b73e0101 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -134,7 +134,7 @@ static void ide_test_quit(void)
 {
     pc_alloc_uninit(guest_malloc);
     guest_malloc = NULL;
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static QPCIDevice *get_pci_device(QPCIBar *bmdma_bar, QPCIBar *ide_bar)
diff --git a/tests/intel-hda-test.c b/tests/intel-hda-test.c
index b782b2e944..ce24fbac1f 100644
--- a/tests/intel-hda-test.c
+++ b/tests/intel-hda-test.c
@@ -19,14 +19,14 @@
 static void ich6_test(void)
 {
     qtest_start("-device intel-hda,id=" HDA_ID CODEC_DEVICES);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void ich9_test(void)
 {
     qtest_start("-machine q35 -device ich9-intel-hda,bus=pcie.0,addr=1b.0,id="
                 HDA_ID CODEC_DEVICES);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/ioh3420-test.c b/tests/ioh3420-test.c
index b54c4b9f11..f2ca373e87 100644
--- a/tests/ioh3420-test.c
+++ b/tests/ioh3420-test.c
@@ -26,7 +26,7 @@ int main(int argc, char **argv)
                 "chassis=1,multifunction=on");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/ipoctal232-test.c b/tests/ipoctal232-test.c
index 684914164d..d17a93449f 100644
--- a/tests/ipoctal232-test.c
+++ b/tests/ipoctal232-test.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
     qtest_start("-device tpci200,id=ipack0 -device ipoctal232,bus=ipack0.0");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/ne2000-test.c b/tests/ne2000-test.c
index b7cf3dd2f5..cae83c5c4c 100644
--- a/tests/ne2000-test.c
+++ b/tests/ne2000-test.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
     qtest_start("-device ne2k_pci");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/numa-test.c b/tests/numa-test.c
index e1b6152244..fa21d26935 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -32,7 +32,7 @@ static void test_mon_explicit(const void *data)
     g_assert(strstr(s, "node 1 cpus: 4 5 6 7"));
     g_free(s);

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

@@ -49,7 +49,7 @@ static void test_mon_default(const void *data)
     g_assert(strstr(s, "node 1 cpus: 1 3 5 7"));
     g_free(s);

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

@@ -68,7 +68,7 @@ static void test_mon_partial(const void *data)
     g_assert(strstr(s, "node 1 cpus: 4 5"));
     g_free(s);

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

@@ -113,7 +113,7 @@ static void test_query_cpus(const void *data)
     }

     QDECREF(resp);
-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

@@ -166,7 +166,7 @@ static void pc_numa_cpu(const void *data)
     }

     QDECREF(resp);
-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

@@ -211,7 +211,7 @@ static void spapr_numa_cpu(const void *data)
     }

     QDECREF(resp);
-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

@@ -254,7 +254,7 @@ static void aarch64_numa_cpu(const void *data)
     }

     QDECREF(resp);
-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(cli);
 }

diff --git a/tests/nvme-test.c b/tests/nvme-test.c
index 7674a446e4..3d6c0f39cf 100644
--- a/tests/nvme-test.c
+++ b/tests/nvme-test.c
@@ -26,7 +26,7 @@ int main(int argc, char **argv)
                 "-device nvme,drive=drv0,serial=foo");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/pc-cpu-test.c b/tests/pc-cpu-test.c
index c4211a4e85..3ff7115625 100644
--- a/tests/pc-cpu-test.c
+++ b/tests/pc-cpu-test.c
@@ -44,7 +44,7 @@ static void test_pc_with_cpu_add(gconstpointer data)
         QDECREF(response);
     }

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(args);
 }

@@ -67,7 +67,7 @@ static void test_pc_without_cpu_add(gconstpointer data)
     g_assert(qdict_haskey(response, "error"));
     QDECREF(response);

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(args);
 }

diff --git a/tests/pcnet-test.c b/tests/pcnet-test.c
index efb1ef44e9..98246d3504 100644
--- a/tests/pcnet-test.c
+++ b/tests/pcnet-test.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
     qtest_start("-device pcnet");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/pvpanic-test.c b/tests/pvpanic-test.c
index 71ebb5c02c..5d99b3d9e2 100644
--- a/tests/pvpanic-test.c
+++ b/tests/pvpanic-test.c
@@ -40,7 +40,7 @@ int main(int argc, char **argv)
     qtest_start("-device pvpanic");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/q35-test.c b/tests/q35-test.c
index e149c4c51d..a8e24e5b71 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -119,7 +119,7 @@ static void test_smram_lock(void)
     g_free(pcidev);
     qpci_free_pc(pcibus);

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_tseg_size(const void *data)
@@ -185,7 +185,7 @@ static void test_tseg_size(const void *data)

     g_free(pcidev);
     qpci_free_pc(pcibus);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 4e6198c9fa..a31c0f7de1 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -188,7 +188,7 @@ static void test_query(const void *data)
     }
     QDECREF(resp);

-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static bool query_is_blacklisted(const char *cmd)
@@ -232,7 +232,7 @@ static void qmp_schema_init(QmpSchema *schema)
     visit_free(qiv);

     QDECREF(resp);
-    qtest_end();
+    qtest_quit(global_qtest);

     schema->hash = g_hash_table_new(g_str_hash, g_str_equal);

diff --git a/tests/qom-test.c b/tests/qom-test.c
index ab0595dc75..661a6edefd 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -102,7 +102,7 @@ static void test_machine(gconstpointer data)
     g_assert(qdict_haskey(response, "return"));
     QDECREF(response);

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(args);
     g_free((void *)machine);
 }
diff --git a/tests/rtl8139-test.c b/tests/rtl8139-test.c
index 68bfc42178..317eb586b5 100644
--- a/tests/rtl8139-test.c
+++ b/tests/rtl8139-test.c
@@ -205,7 +205,7 @@ int main(int argc, char **argv)

     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/spapr-phb-test.c b/tests/spapr-phb-test.c
index d3522ea093..e76987ace9 100644
--- a/tests/spapr-phb-test.c
+++ b/tests/spapr-phb-test.c
@@ -29,7 +29,7 @@ int main(int argc, char **argv)

     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/tco-test.c b/tests/tco-test.c
index 0387971953..3d4b3db308 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -49,7 +49,7 @@ static void test_end(TestData *d)
 {
     g_free(d->dev);
     qpci_free_pc(d->bus);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_init(TestData *d)
diff --git a/tests/test-arm-mptimer.c b/tests/test-arm-mptimer.c
index cb8f2df914..823db9ebc9 100644
--- a/tests/test-arm-mptimer.c
+++ b/tests/test-arm-mptimer.c
@@ -1099,7 +1099,7 @@ tests_with_prescaler_arg:

     qtest_start("-machine vexpress-a9");
     ret = g_test_run();
-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index d569d27657..85fb38976d 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -86,7 +86,7 @@ int main(int argc, char **argv)

     qtest_add_func("/netfilter/mirror", test_mirror);
     ret = g_test_run();
-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index 3afd41110d..d3a0b1cdf4 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -135,7 +135,7 @@ static void test_redirector_tx(void)
     close(recv_sock);
     unlink(sock_path0);
     unlink(sock_path1);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void test_redirector_rx(void)
@@ -204,7 +204,7 @@ static void test_redirector_rx(void)
     g_free(recv_buf);
     unlink(sock_path0);
     unlink(sock_path1);
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 729c0339f7..752f4b63bd 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -127,7 +127,7 @@ static void test_machine(gconstpointer data)
     test_info_commands();
     test_commands();

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(args);
     g_free((void *)data);
 }
diff --git a/tests/test-netfilter.c b/tests/test-netfilter.c
index 2506473365..ffb11dbfb7 100644
--- a/tests/test-netfilter.c
+++ b/tests/test-netfilter.c
@@ -202,7 +202,7 @@ int main(int argc, char **argv)
     qtest_start(args);
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(args);

     return ret;
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 58a2dd9fe8..4e88f9e4e2 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -64,7 +64,7 @@ static void test_cpuid_prop(const void *data)
     value = qobject_to_qnum(qom_get(path, args->property));
     g_assert(qnum_get_try_int(value, &val));
     g_assert_cmpint(val, ==, args->expected_value);
-    qtest_end();
+    qtest_quit(global_qtest);

     QDECREF(value);
     g_free(path);
@@ -137,7 +137,7 @@ static void test_feature_flag(const void *data)
     filtered = qobject_to_qlist(qom_get(path, "filtered-features"));
     value = get_feature_word(present, args->in_eax, args->in_ecx, args->reg);
     value |= get_feature_word(filtered, args->in_eax, args->in_ecx, args->reg);
-    qtest_end();
+    qtest_quit(global_qtest);

     g_assert(!!(value & (1U << args->bitnr)) == args->expected_value);

@@ -195,7 +195,7 @@ static void test_plus_minus_subprocess(void)
     g_assert_true(qom_get_bool(path, "sse4-2"));
     g_assert_true(qom_get_bool(path, "sse4.2"));

-    qtest_end();
+    qtest_quit(global_qtest);
     g_free(path);
 }

diff --git a/tests/tpci200-test.c b/tests/tpci200-test.c
index 0321ec27ec..3b756d10f0 100644
--- a/tests/tpci200-test.c
+++ b/tests/tpci200-test.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
     qtest_start("-device tpci200");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
index 55d4743a2a..16d74512cc 100644
--- a/tests/usb-hcd-ehci-test.c
+++ b/tests/usb-hcd-ehci-test.c
@@ -172,7 +172,7 @@ int main(int argc, char **argv)
     ret = g_test_run();
     test_deinit();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/usb-hcd-ohci-test.c b/tests/usb-hcd-ohci-test.c
index 4758813d78..aa38e44d03 100644
--- a/tests/usb-hcd-ohci-test.c
+++ b/tests/usb-hcd-ohci-test.c
@@ -33,7 +33,7 @@ int main(int argc, char **argv)

     qtest_start("-device pci-ohci,id=ohci");
     ret = g_test_run();
-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index c05a339894..e45509741c 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -83,7 +83,7 @@ int main(int argc, char **argv)
     qtest_start("-device nec-usb-xhci,id=xhci"
                 " -drive id=drive0,if=none,file=null-co://,format=raw");
     ret = g_test_run();
-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/virtio-balloon-test.c b/tests/virtio-balloon-test.c
index 0d0046bf25..34ad718601 100644
--- a/tests/virtio-balloon-test.c
+++ b/tests/virtio-balloon-test.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
     qtest_start("-device virtio-balloon-pci");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 0cf33b6810..ce316e753e 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -102,7 +102,7 @@ static void arm_test_start(void)

 static void test_end(void)
 {
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static QVirtioPCIDevice *virtio_blk_pci_init(QPCIBus *bus, int slot)
diff --git a/tests/virtio-console-test.c b/tests/virtio-console-test.c
index 1c3de072f4..5c036ce02a 100644
--- a/tests/virtio-console-test.c
+++ b/tests/virtio-console-test.c
@@ -15,14 +15,14 @@ static void console_pci_nop(void)
 {
     qtest_start("-device virtio-serial-pci,id=vser0 "
                 "-device virtconsole,bus=vser0.0");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 static void serialport_pci_nop(void)
 {
     qtest_start("-device virtio-serial-pci,id=vser0 "
                 "-device virtserialport,bus=vser0.0");
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 int main(int argc, char **argv)
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index acecef0a3e..e1085c7e77 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -30,7 +30,7 @@

 static void test_end(void)
 {
-    qtest_end();
+    qtest_quit(global_qtest);
 }

 #ifndef _WIN32
diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index 0e21125cb4..a3a8bde491 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -41,7 +41,7 @@ int main(int argc, char **argv)
     qtest_start("-device virtio-rng-pci");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
index b14d943ada..d0bbc2a8c9 100644
--- a/tests/virtio-serial-test.c
+++ b/tests/virtio-serial-test.c
@@ -52,7 +52,7 @@ int main(int argc, char **argv)
     qtest_start("-device virtio-serial-pci");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
diff --git a/tests/vmxnet3-test.c b/tests/vmxnet3-test.c
index 159c0ad728..631630b4d0 100644
--- a/tests/vmxnet3-test.c
+++ b/tests/vmxnet3-test.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
     qtest_start("-device vmxnet3");
     ret = g_test_run();

-    qtest_end();
+    qtest_quit(global_qtest);

     return ret;
 }
-- 
2.13.5
