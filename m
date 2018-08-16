Received: from eggs.gnu.org ([2001:4830:134:3::10]:50607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmf-0000yl-HL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmQ-0005F7-J9
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDmH-00059p-O7
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D69FC5A753
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 718F32156714
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:36:58 +0200
Message-Id: <20180816083701.3932-23-armbru@redhat.com>
In-Reply-To: <20180816083701.3932-1-armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 22/25] libqtest: Replace qtest_startf() by
 qtest_initf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qtest_init() creates a new QTestState, and leaves @global_qtest alone.
qtest_start() additionally assigns it to @global_qtest, but
qtest_startf() additionally assigns NULL to @global_qtest.  This makes
no sense.  Replace it by qtest_initf() that works like qtest_init(),
i.e. leaves @global_qtest alone.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180806065344.7103-23-armbru@redhat.com>
---
 tests/boot-order-test.c        |  8 ++++----
 tests/boot-serial-test.c       | 10 +++++-----
 tests/cdrom-test.c             |  6 +++---
 tests/endianness-test.c        | 24 ++++++++++++------------
 tests/ipmi-bt-test.c           |  2 +-
 tests/libqtest.c               |  9 ++++-----
 tests/libqtest.h               | 17 ++++++++---------
 tests/m25p80-test.c            |  6 +++---
 tests/m48t59-test.c            |  2 +-
 tests/machine-none-test.c      |  2 +-
 tests/numa-test.c              |  4 ++--
 tests/pnv-xscom-test.c         |  8 ++++----
 tests/prom-env-test.c          | 10 +++++-----
 tests/qmp-test.c               |  2 +-
 tests/sdhci-test.c             |  6 +++---
 tests/tco-test.c               |  6 +++---
 tests/test-filter-mirror.c     |  2 +-
 tests/test-filter-redirector.c |  4 ++--
 tests/virtio-balloon-test.c    |  4 ++--
 tests/virtio-blk-test.c        |  8 ++++----
 tests/virtio-console-test.c    | 12 ++++++------
 tests/virtio-serial-test.c     |  4 ++--
 tests/vmgenid-test.c           |  6 +++---
 23 files changed, 80 insertions(+), 82 deletions(-)

diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index 9096a4b5df..9d98c48a3d 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -33,10 +33,10 @@ static void test_a_boot_order(const char *machine,
 {
     uint64_t actual;
 
-    global_qtest = qtest_startf("-nodefaults%s%s %s",
-                                machine ? " -M " : "",
-                                machine ?: "",
-                                test_args);
+    global_qtest = qtest_initf("-nodefaults%s%s %s",
+                               machine ? " -M " : "",
+                               machine ?: "",
+                               test_args);
     actual = read_boot_order();
     g_assert_cmphex(actual, ==, expected_boot);
     qmp_discard_response("{ 'execute': 'system_reset' }");
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 952a2e7ead..1355df924d 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -172,11 +172,11 @@ static void test_machine(const void *data)
      * Make sure that this test uses tcg if available: It is used as a
      * fast-enough smoketest for that.
      */
-    global_qtest = qtest_startf("%s %s -M %s,accel=tcg:kvm "
-                                "-chardev file,id=serial0,path=%s "
-                                "-no-shutdown -serial chardev:serial0 %s",
-                                codeparam, code ? codetmp : "",
-                                test->machine, serialtmp, test->extra);
+    global_qtest = qtest_initf("%s %s -M %s,accel=tcg:kvm "
+                               "-chardev file,id=serial0,path=%s "
+                               "-no-shutdown -serial chardev:serial0 %s",
+                               codeparam, code ? codetmp : "",
+                               test->machine, serialtmp, test->extra);
     if (code) {
         unlink(codetmp);
     }
diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
index 7a1fce5dfb..9b43dc9ab4 100644
--- a/tests/cdrom-test.c
+++ b/tests/cdrom-test.c
@@ -99,7 +99,7 @@ static void test_cdrom_param(gconstpointer data)
     QTestState *qts;
     char *resp;
 
-    qts = qtest_startf("-M %s -cdrom %s", (const char *)data, isoimage);
+    qts = qtest_initf("-M %s -cdrom %s", (const char *)data, isoimage);
     resp = qtest_hmp(qts, "info block");
     g_assert(strstr(resp, isoimage) != 0);
     g_free(resp);
@@ -120,8 +120,8 @@ static void test_cdboot(gconstpointer data)
 {
     QTestState *qts;
 
-    qts = qtest_startf("-accel kvm:tcg -no-shutdown %s%s", (const char *)data,
-                       isoimage);
+    qts = qtest_initf("-accel kvm:tcg -no-shutdown %s%s", (const char *)data,
+                      isoimage);
     boot_sector_test(qts);
     qtest_quit(qts);
 }
diff --git a/tests/endianness-test.c b/tests/endianness-test.c
index 546e0969e4..48680cd131 100644
--- a/tests/endianness-test.c
+++ b/tests/endianness-test.c
@@ -115,10 +115,10 @@ static void test_endianness(gconstpointer data)
 {
     const TestCase *test = data;
 
-    global_qtest = qtest_startf("-M %s%s%s -device pc-testdev",
-                                test->machine,
-                                test->superio ? " -device " : "",
-                                test->superio ?: "");
+    global_qtest = qtest_initf("-M %s%s%s -device pc-testdev",
+                               test->machine,
+                               test->superio ? " -device " : "",
+                               test->superio ?: "");
     isa_outl(test, 0xe0, 0x87654321);
     g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654321);
     g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
@@ -187,10 +187,10 @@ static void test_endianness_split(gconstpointer data)
 {
     const TestCase *test = data;
 
-    global_qtest = qtest_startf("-M %s%s%s -device pc-testdev",
-                                test->machine,
-                                test->superio ? " -device " : "",
-                                test->superio ?: "");
+    global_qtest = qtest_initf("-M %s%s%s -device pc-testdev",
+                               test->machine,
+                               test->superio ? " -device " : "",
+                               test->superio ?: "");
     isa_outl(test, 0xe8, 0x87654321);
     g_assert_cmphex(isa_inl(test, 0xe0), ==, 0x87654321);
     g_assert_cmphex(isa_inw(test, 0xe2), ==, 0x8765);
@@ -231,10 +231,10 @@ static void test_endianness_combine(gconstpointer data)
 {
     const TestCase *test = data;
 
-    global_qtest = qtest_startf("-M %s%s%s -device pc-testdev",
-                                test->machine,
-                                test->superio ? " -device " : "",
-                                test->superio ?: "");
+    global_qtest = qtest_initf("-M %s%s%s -device pc-testdev",
+                               test->machine,
+                               test->superio ? " -device " : "",
+                               test->superio ?: "");
     isa_outl(test, 0xe0, 0x87654321);
     g_assert_cmphex(isa_inl(test, 0xe8), ==, 0x87654321);
     g_assert_cmphex(isa_inw(test, 0xea), ==, 0x8765);
diff --git a/tests/ipmi-bt-test.c b/tests/ipmi-bt-test.c
index 8be18e3f42..f4a81b5265 100644
--- a/tests/ipmi-bt-test.c
+++ b/tests/ipmi-bt-test.c
@@ -414,7 +414,7 @@ int main(int argc, char **argv)
     /* Run the tests */
     g_test_init(&argc, &argv, NULL);
 
-    global_qtest = qtest_startf(
+    global_qtest = qtest_initf(
         " -chardev socket,id=ipmi0,host=localhost,port=%d,reconnect=10"
         " -device ipmi-bmc-extern,chardev=ipmi0,id=bmc0"
         " -device isa-ipmi-bt,bmc=bmc0", emu_port);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 2f81bc6382..a0d44793fa 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -259,24 +259,23 @@ QTestState *qtest_init(const char *extra_args)
     return s;
 }
 
-QTestState *qtest_vstartf(const char *fmt, va_list ap)
+QTestState *qtest_vinitf(const char *fmt, va_list ap)
 {
     char *args = g_strdup_vprintf(fmt, ap);
     QTestState *s;
 
-    s = qtest_start(args);
+    s = qtest_init(args);
     g_free(args);
-    global_qtest = NULL;
     return s;
 }
 
-QTestState *qtest_startf(const char *fmt, ...)
+QTestState *qtest_initf(const char *fmt, ...)
 {
     va_list ap;
     QTestState *s;
 
     va_start(ap, fmt);
-    s = qtest_vstartf(fmt, ap);
+    s = qtest_vinitf(fmt, ap);
     va_end(ap);
     return s;
 }
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 712ac023d6..b92a8070a5 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -22,33 +22,32 @@ typedef struct QTestState QTestState;
 extern QTestState *global_qtest;
 
 /**
- * qtest_startf:
+ * qtest_initf:
  * @fmt...: Format for creating other arguments to pass to QEMU, formatted
  * like sprintf().
  *
- * Start QEMU and return the resulting #QTestState (but unlike qtest_start(),
- * #global_qtest is left at NULL).
+ * Convenience wrapper around qtest_start().
  *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_startf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
+QTestState *qtest_initf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
 /**
- * qtest_vstartf:
+ * qtest_vinitf:
  * @fmt: Format for creating other arguments to pass to QEMU, formatted
  * like vsprintf().
  * @ap: Format arguments.
  *
- * Start QEMU and return the resulting #QTestState (but unlike qtest_start(),
- * #global_qtest is left at NULL).
+ * Convenience wrapper around qtest_start().
  *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_vstartf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
+QTestState *qtest_vinitf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 
 /**
  * qtest_init:
- * @extra_args: other arguments to pass to QEMU.
+ * @extra_args: other arguments to pass to QEMU.  CAUTION: these
+ * arguments are subject to word splitting and shell evaluation.
  *
  * Returns: #QTestState instance.
  */
diff --git a/tests/m25p80-test.c b/tests/m25p80-test.c
index c276e738e9..055f7246a8 100644
--- a/tests/m25p80-test.c
+++ b/tests/m25p80-test.c
@@ -363,9 +363,9 @@ int main(int argc, char **argv)
     g_assert(ret == 0);
     close(fd);
 
-    global_qtest = qtest_startf("-m 256 -machine palmetto-bmc "
-                                "-drive file=%s,format=raw,if=mtd",
-                                tmp_path);
+    global_qtest = qtest_initf("-m 256 -machine palmetto-bmc "
+                               "-drive file=%s,format=raw,if=mtd",
+                               tmp_path);
 
     qtest_add_func("/m25p80/read_jedec", test_read_jedec);
     qtest_add_func("/m25p80/erase_sector", test_erase_sector);
diff --git a/tests/m48t59-test.c b/tests/m48t59-test.c
index 5b695971c7..4abf9c605c 100644
--- a/tests/m48t59-test.c
+++ b/tests/m48t59-test.c
@@ -146,7 +146,7 @@ static void cmos_get_date_time(QTestState *s, struct tm *date)
 
 static QTestState *m48t59_qtest_start(void)
 {
-    return qtest_startf("-M %s -rtc clock=vm", base_machine);
+    return qtest_initf("-M %s -rtc clock=vm", base_machine);
 }
 
 static void bcd_check_time(void)
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index f286557b3e..7e72466354 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -84,7 +84,7 @@ static void test_machine_cpu_cli(void)
         }
         return; /* TODO: die here to force all targets have a test */
     }
-    global_qtest = qtest_startf("-machine none -cpu '%s'", cpu_model);
+    global_qtest = qtest_initf("-machine none -cpu '%s'", cpu_model);
 
     response = qmp("{ 'execute': 'quit' }");
     g_assert(qdict_haskey(response, "return"));
diff --git a/tests/numa-test.c b/tests/numa-test.c
index 893f826acb..9824fdd587 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -267,8 +267,8 @@ static void pc_dynamic_cpu_cfg(const void *data)
     QList *cpus;
     QTestState *qs;
 
-    qs = qtest_startf("%s %s", data ? (char *)data : "",
-                              "-nodefaults --preconfig -smp 2");
+    qs = qtest_initf("%s -nodefaults --preconfig -smp 2",
+                     data ? (char *)data : "");
 
     /* create 2 numa nodes */
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index efb7c838b5..70f4c84d1b 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -79,8 +79,8 @@ static void test_cfam_id(const void *data)
 {
     const PnvChip *chip = data;
 
-    global_qtest = qtest_startf("-M powernv,accel=tcg -cpu %s",
-                                chip->cpu_model);
+    global_qtest = qtest_initf("-M powernv,accel=tcg -cpu %s",
+                               chip->cpu_model);
     test_xscom_cfam_id(chip);
     qtest_quit(global_qtest);
 }
@@ -114,8 +114,8 @@ static void test_core(const void *data)
 {
     const PnvChip *chip = data;
 
-    global_qtest = qtest_startf("-M powernv,accel=tcg -cpu %s",
-                                chip->cpu_model);
+    global_qtest = qtest_initf("-M powernv,accel=tcg -cpu %s",
+                               chip->cpu_model);
     test_xscom_core(chip);
     qtest_quit(global_qtest);
 }
diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index 8c867e631a..198d007f1b 100644
--- a/tests/prom-env-test.c
+++ b/tests/prom-env-test.c
@@ -49,11 +49,11 @@ static void test_machine(const void *machine)
     /* The pseries firmware boots much faster without the default devices */
     extra_args = strcmp(machine, "pseries") == 0 ? "-nodefaults" : "";
 
-    global_qtest = qtest_startf("-M %s,accel=tcg %s "
-                                "-prom-env 'use-nvramrc?=true' "
-                                "-prom-env 'nvramrc=%x %x l!' ",
-                                (const char *)machine, extra_args,
-                                MAGIC, ADDRESS);
+    global_qtest = qtest_initf("-M %s,accel=tcg %s "
+                               "-prom-env 'use-nvramrc?=true' "
+                               "-prom-env 'nvramrc=%x %x l!' ",
+                               (const char *)machine, extra_args,
+                               MAGIC, ADDRESS);
     check_guest_memory();
     qtest_quit(global_qtest);
 }
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 5eb15daebc..487ef946ed 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -436,7 +436,7 @@ static void add_query_tests(QmpSchema *schema)
 static void test_qmp_preconfig(void)
 {
     QDict *rsp, *ret;
-    QTestState *qs = qtest_startf("%s --preconfig", common_args);
+    QTestState *qs = qtest_initf("%s --preconfig", common_args);
 
     /* preconfig state */
     /* enabled commands, no error expected  */
diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 1d825eb010..982f5ebbb2 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -184,8 +184,8 @@ static QSDHCI *machine_start(const struct sdhci_t *test)
         uint16_t vendor_id, device_id;
         uint64_t barsize;
 
-        global_qtest = qtest_startf("-machine %s -device sdhci-pci",
-                                    test->machine);
+        global_qtest = qtest_initf("-machine %s -device sdhci-pci",
+                                   test->machine);
 
         s->pci.bus = qpci_init_pc(global_qtest, NULL);
 
@@ -200,7 +200,7 @@ static QSDHCI *machine_start(const struct sdhci_t *test)
         qpci_device_enable(s->pci.dev);
     } else {
         /* SysBus */
-        global_qtest = qtest_startf("-machine %s", test->machine);
+        global_qtest = qtest_initf("-machine %s", test->machine);
         s->addr = test->sdhci.addr;
     }
 
diff --git a/tests/tco-test.c b/tests/tco-test.c
index 9945fb8469..6bee9a37d3 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -58,9 +58,9 @@ static void test_init(TestData *d)
 {
     QTestState *qs;
 
-    qs = qtest_startf("-machine q35 %s %s",
-                      d->noreboot ? "" : "-global ICH9-LPC.noreboot=false",
-                      !d->args ? "" : d->args);
+    qs = qtest_initf("-machine q35 %s %s",
+                     d->noreboot ? "" : "-global ICH9-LPC.noreboot=false",
+                     !d->args ? "" : d->args);
     global_qtest = qs;
     qtest_irq_intercept_in(qs, "ioapic");
 
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index de5ba155db..d15917e2cf 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -40,7 +40,7 @@ static void test_mirror(void)
     ret = mkstemp(sock_path);
     g_assert_cmpint(ret, !=, -1);
 
-    global_qtest = qtest_startf(
+    global_qtest = qtest_initf(
         "-netdev socket,id=qtest-bn0,fd=%d "
         "-device %s,netdev=qtest-bn0,id=qtest-e0 "
         "-chardev socket,id=mirror0,path=%s,server,nowait "
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index 896f900e98..615ff5cb9f 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -90,7 +90,7 @@ static void test_redirector_tx(void)
     ret = mkstemp(sock_path1);
     g_assert_cmpint(ret, !=, -1);
 
-    global_qtest = qtest_startf(
+    global_qtest = qtest_initf(
         "-netdev socket,id=qtest-bn0,fd=%d "
         "-device %s,netdev=qtest-bn0,id=qtest-e0 "
         "-chardev socket,id=redirector0,path=%s,server,nowait "
@@ -159,7 +159,7 @@ static void test_redirector_rx(void)
     ret = mkstemp(sock_path1);
     g_assert_cmpint(ret, !=, -1);
 
-    global_qtest = qtest_startf(
+    global_qtest = qtest_initf(
         "-netdev socket,id=qtest-bn0,fd=%d "
         "-device %s,netdev=qtest-bn0,id=qtest-e0 "
         "-chardev socket,id=redirector0,path=%s,server,nowait "
diff --git a/tests/virtio-balloon-test.c b/tests/virtio-balloon-test.c
index 0a07e036bb..5a1d0ccbb7 100644
--- a/tests/virtio-balloon-test.c
+++ b/tests/virtio-balloon-test.c
@@ -23,8 +23,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/virtio/balloon/nop", balloon_nop);
 
-    global_qtest = qtest_startf("-device virtio-balloon-%s",
-                                qvirtio_get_dev_type());
+    global_qtest = qtest_initf("-device virtio-balloon-%s",
+                               qvirtio_get_dev_type());
     ret = g_test_run();
 
     qtest_end();
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 571489d763..04c608764b 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -93,10 +93,10 @@ static void arm_test_start(void)
 
     tmp_path = drive_create();
 
-    global_qtest = qtest_startf("-machine virt "
-                                "-drive if=none,id=drive0,file=%s,format=raw "
-                                "-device virtio-blk-device,drive=drive0",
-                                tmp_path);
+    global_qtest = qtest_initf("-machine virt "
+                               "-drive if=none,id=drive0,file=%s,format=raw "
+                               "-device virtio-blk-device,drive=drive0",
+                               tmp_path);
     unlink(tmp_path);
     g_free(tmp_path);
 }
diff --git a/tests/virtio-console-test.c b/tests/virtio-console-test.c
index 945bae5a15..a7c6f167c3 100644
--- a/tests/virtio-console-test.c
+++ b/tests/virtio-console-test.c
@@ -14,17 +14,17 @@
 /* Tests only initialization so far. TODO: Replace with functional tests */
 static void console_nop(void)
 {
-    global_qtest = qtest_startf("-device virtio-serial-%s,id=vser0 "
-                                "-device virtconsole,bus=vser0.0",
-                                qvirtio_get_dev_type());
+    global_qtest = qtest_initf("-device virtio-serial-%s,id=vser0 "
+                               "-device virtconsole,bus=vser0.0",
+                               qvirtio_get_dev_type());
     qtest_end();
 }
 
 static void serialport_nop(void)
 {
-    global_qtest = qtest_startf("-device virtio-serial-%s,id=vser0 "
-                                "-device virtserialport,bus=vser0.0",
-                                qvirtio_get_dev_type());
+    global_qtest = qtest_initf("-device virtio-serial-%s,id=vser0 "
+                               "-device virtserialport,bus=vser0.0",
+                               qvirtio_get_dev_type());
     qtest_end();
 }
 
diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
index e4b18b1c8a..8da9980a24 100644
--- a/tests/virtio-serial-test.c
+++ b/tests/virtio-serial-test.c
@@ -31,8 +31,8 @@ int main(int argc, char **argv)
     qtest_add_func("/virtio/serial/nop", virtio_serial_nop);
     qtest_add_func("/virtio/serial/hotplug", hotplug);
 
-    global_qtest = qtest_startf("-device virtio-serial-%s",
-                                qvirtio_get_dev_type());
+    global_qtest = qtest_initf("-device virtio-serial-%s",
+                               qvirtio_get_dev_type());
     ret = g_test_run();
 
     qtest_end();
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 8d915c610c..0a6fb55f2e 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -142,7 +142,7 @@ static void vmgenid_set_guid_test(void)
 
     g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);
 
-    global_qtest = qtest_startf(GUID_CMD(VGID_GUID));
+    global_qtest = qtest_initf(GUID_CMD(VGID_GUID));
 
     /* Read the GUID from accessing guest memory */
     read_guid_from_memory(&measured);
@@ -155,7 +155,7 @@ static void vmgenid_set_guid_auto_test(void)
 {
     QemuUUID measured;
 
-    global_qtest = qtest_startf(GUID_CMD("auto"));
+    global_qtest = qtest_initf(GUID_CMD("auto"));
 
     read_guid_from_memory(&measured);
 
@@ -171,7 +171,7 @@ static void vmgenid_query_monitor_test(void)
 
     g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);
 
-    global_qtest = qtest_startf(GUID_CMD(VGID_GUID));
+    global_qtest = qtest_initf(GUID_CMD(VGID_GUID));
 
     /* Read the GUID via the monitor */
     read_guid_from_monitor(&measured);
-- 
2.17.1
