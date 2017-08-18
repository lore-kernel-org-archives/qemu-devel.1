Received: from eggs.gnu.org ([2001:4830:134:3::10]:59529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diocb-000739-UJ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dioca-0000wq-5h
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:16:01 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 18 Aug 2017 16:15:37 -0500
Message-Id: <20170818211542.5380-9-eblake@redhat.com>
In-Reply-To: <20170818211542.5380-1-eblake@redhat.com>
References: <20170818211542.5380-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 08/13] tests: Rely more on global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, John Snow <jsnow@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>

libqtest provides two layers of functions: qtest_*() that operate
on an explicit object, and a plain version that operates on the
'global_qtest' object.  However, very few tests care about the
distinction, and even the tests that manipulate multiple qtest
connections at once are just fine reassigning global_qtest around
the blocks of code that will then operate on the updated global,
rather than calling the verbose form.  Before the next few patches
get rid of the qtest_* layer, we first need to update the remaining
few spots that were using the long form where we can instead rely
on the short form.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/fdc-test.c         |  2 +-
 tests/ide-test.c         | 10 +++++-----
 tests/ipmi-bt-test.c     |  2 +-
 tests/ipmi-kcs-test.c    |  2 +-
 tests/libqos/libqos-pc.c |  2 +-
 tests/postcopy-test.c    | 14 +++++++-------
 tests/rtc-test.c         |  9 +++------
 tests/tco-test.c         |  5 ++---
 tests/wdt_ib700-test.c   | 30 +++++++++++++++++-------------
 9 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index 325712e0f2..0b68d9aec4 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -565,7 +565,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);

     qtest_start("-device floppy,id=floppy0");
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in("ioapic");
     qtest_add_func("/fdc/cmos", test_cmos);
     qtest_add_func("/fdc/no_media_on_start", test_no_media_on_start);
     qtest_add_func("/fdc/read_without_media", test_read_without_media);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index aa9de065fc..505a800b44 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -462,7 +462,7 @@ static void test_bmdma_setup(void)
         "-drive file=%s,if=ide,serial=%s,cache=writeback,format=raw "
         "-global ide-hd.ver=%s",
         tmp_path, "testdisk", "version");
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in("ioapic");
 }

 static void test_bmdma_teardown(void)
@@ -584,7 +584,7 @@ static void test_flush(void)

     dev = get_pci_device(&bmdma_bar, &ide_bar);

-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in("ioapic");

     /* Dirty media so that CMD_FLUSH_CACHE will actually go to disk */
     make_dirty(0);
@@ -635,7 +635,7 @@ static void test_retry_flush(const char *machine)

     dev = get_pci_device(&bmdma_bar, &ide_bar);

-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in("ioapic");

     /* Dirty media so that CMD_FLUSH_CACHE will actually go to disk */
     make_dirty(0);
@@ -826,7 +826,7 @@ static void cdrom_pio_impl(int nblocks)
     ide_test_start("-drive if=none,file=%s,media=cdrom,format=raw,id=sr0,index=0 "
                    "-device ide-cd,drive=sr0,bus=ide.0", tmp_path);
     dev = get_pci_device(&bmdma_bar, &ide_bar);
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in("ioapic");

     /* PACKET command on device 0 */
     qpci_io_writeb(dev, ide_bar, reg_device, 0);
@@ -909,7 +909,7 @@ static void test_cdrom_dma(void)

     ide_test_start("-drive if=none,file=%s,media=cdrom,format=raw,id=sr0,index=0 "
                    "-device ide-cd,drive=sr0,bus=ide.0", tmp_path);
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in("ioapic");

     guest_buf = guest_alloc(guest_malloc, len);
     prdt[0].addr = cpu_to_le32(guest_buf);
diff --git a/tests/ipmi-bt-test.c b/tests/ipmi-bt-test.c
index 7e21a9bbcb..891f5bfb13 100644
--- a/tests/ipmi-bt-test.c
+++ b/tests/ipmi-bt-test.c
@@ -421,7 +421,7 @@ int main(int argc, char **argv)
           " -device isa-ipmi-bt,bmc=bmc0", emu_port);
     qtest_start(cmdline);
     g_free(cmdline);
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in("ioapic");
     qtest_add_func("/ipmi/extern/connect", test_connect);
     qtest_add_func("/ipmi/extern/bt_base", test_bt_base);
     qtest_add_func("/ipmi/extern/bt_enable_irq", test_enable_irq);
diff --git a/tests/ipmi-kcs-test.c b/tests/ipmi-kcs-test.c
index 178ffc1797..53127d2884 100644
--- a/tests/ipmi-kcs-test.c
+++ b/tests/ipmi-kcs-test.c
@@ -280,7 +280,7 @@ int main(int argc, char **argv)
                               " -device isa-ipmi-kcs,bmc=bmc0");
     qtest_start(cmdline);
     g_free(cmdline);
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in("ioapic");
     qtest_add_func("/ipmi/local/kcs_base", test_kcs_base);
     qtest_add_func("/ipmi/local/kcs_abort", test_kcs_abort);
     qtest_add_func("/ipmi/local/kcs_enable_irq", test_enable_irq);
diff --git a/tests/libqos/libqos-pc.c b/tests/libqos/libqos-pc.c
index b554758802..6a2ff6608b 100644
--- a/tests/libqos/libqos-pc.c
+++ b/tests/libqos/libqos-pc.c
@@ -25,7 +25,7 @@ QOSState *qtest_pc_boot(const char *cmdline_fmt, ...)
     qs = qtest_vboot(&qos_ops, cmdline_fmt, ap);
     va_end(ap);

-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    irq_intercept_in("ioapic");

     return qs;
 }
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 8142f2ab90..9c4e37473d 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -236,7 +236,7 @@ static QDict *return_or_event(QDict *response)
         got_stop = true;
     }
     QDECREF(response);
-    return return_or_event(qtest_qmp_receive(global_qtest));
+    return return_or_event(qmp_receive());
 }


@@ -318,13 +318,13 @@ static void check_guests_ram(void)
     bool hit_edge = false;
     bool bad = false;

-    qtest_memread(global_qtest, start_address, &first_byte, 1);
+    memread(start_address, &first_byte, 1);
     last_byte = first_byte;

     for (address = start_address + 4096; address < end_address; address += 4096)
     {
         uint8_t b;
-        qtest_memread(global_qtest, address, &b, 1);
+        memread(address, &b, 1);
         if (b != last_byte) {
             if (((b + 1) % 256) == last_byte && !hit_edge) {
                 /* This is OK, the guest stopped at the point of
@@ -474,19 +474,19 @@ static void test_migrate(void)

     global_qtest = to;

-    qtest_memread(to, start_address, &dest_byte_a, 1);
+    memread(start_address, &dest_byte_a, 1);

     /* Destination still running, wait for a byte to change */
     do {
-        qtest_memread(to, start_address, &dest_byte_b, 1);
+        memread(start_address, &dest_byte_b, 1);
         usleep(10 * 1000);
     } while (dest_byte_a == dest_byte_b);

     qmp_discard_response("{ 'execute' : 'stop'}");
     /* With it stopped, check nothing changes */
-    qtest_memread(to, start_address, &dest_byte_c, 1);
+    memread(start_address, &dest_byte_c, 1);
     sleep(1);
-    qtest_memread(to, start_address, &dest_byte_d, 1);
+    memread(start_address, &dest_byte_d, 1);
     g_assert_cmpint(dest_byte_c, ==, dest_byte_d);

     check_guests_ram();
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index d7a96cbd79..bdd234d316 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -685,13 +685,12 @@ static void periodic_timer(void)

 int main(int argc, char **argv)
 {
-    QTestState *s = NULL;
     int ret;

     g_test_init(&argc, &argv, NULL);

-    s = qtest_start("-rtc clock=vm");
-    qtest_irq_intercept_in(s, "ioapic");
+    qtest_start("-rtc clock=vm");
+    irq_intercept_in("ioapic");

     qtest_add_func("/rtc/check-time/bcd", bcd_check_time);
     qtest_add_func("/rtc/check-time/dec", dec_check_time);
@@ -711,9 +710,7 @@ int main(int argc, char **argv)

     ret = g_test_run();

-    if (s) {
-        qtest_quit(s);
-    }
+    qtest_end();

     return ret;
 }
diff --git a/tests/tco-test.c b/tests/tco-test.c
index c4c264eb3d..5b87bc16b9 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -54,14 +54,13 @@ static void test_end(TestData *d)

 static void test_init(TestData *d)
 {
-    QTestState *qs;
     char *s;

     s = g_strdup_printf("-machine q35 %s %s",
                         d->noreboot ? "" : "-global ICH9-LPC.noreboot=false",
                         !d->args ? "" : d->args);
-    qs = qtest_start(s);
-    qtest_irq_intercept_in(qs, "ioapic");
+    qtest_start(s);
+    irq_intercept_in("ioapic");
     g_free(s);

     d->bus = qpci_init_pc(NULL);
diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index 49f4f0c221..59ba184a82 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -36,7 +36,7 @@ static QDict *qmp_get_event(const char *name)
     return data;
 }

-static QDict *ib700_program_and_wait(QTestState *s)
+static QDict *ib700_program_and_wait(void)
 {
     clock_step(NANOSECONDS_PER_SECOND * 40);
     qmp_check_no_event();
@@ -68,9 +68,10 @@ static QDict *ib700_program_and_wait(QTestState *s)
 static void ib700_pause(void)
 {
     QDict *d;
-    QTestState *s = qtest_start("-watchdog-action pause -device ib700");
-    qtest_irq_intercept_in(s, "ioapic");
-    d = ib700_program_and_wait(s);
+
+    qtest_start("-watchdog-action pause -device ib700");
+    irq_intercept_in("ioapic");
+    d = ib700_program_and_wait();
     g_assert(!strcmp(qdict_get_str(d, "action"), "pause"));
     QDECREF(d);
     d = qmp_get_event("STOP");
@@ -81,9 +82,10 @@ static void ib700_pause(void)
 static void ib700_reset(void)
 {
     QDict *d;
-    QTestState *s = qtest_start("-watchdog-action reset -device ib700");
-    qtest_irq_intercept_in(s, "ioapic");
-    d = ib700_program_and_wait(s);
+
+    qtest_start("-watchdog-action reset -device ib700");
+    irq_intercept_in("ioapic");
+    d = ib700_program_and_wait();
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
     QDECREF(d);
     d = qmp_get_event("RESET");
@@ -94,9 +96,10 @@ static void ib700_reset(void)
 static void ib700_shutdown(void)
 {
     QDict *d;
-    QTestState *s = qtest_start("-watchdog-action reset -no-reboot -device ib700");
-    qtest_irq_intercept_in(s, "ioapic");
-    d = ib700_program_and_wait(s);
+
+    qtest_start("-watchdog-action reset -no-reboot -device ib700");
+    irq_intercept_in("ioapic");
+    d = ib700_program_and_wait();
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
     QDECREF(d);
     d = qmp_get_event("SHUTDOWN");
@@ -107,9 +110,10 @@ static void ib700_shutdown(void)
 static void ib700_none(void)
 {
     QDict *d;
-    QTestState *s = qtest_start("-watchdog-action none -device ib700");
-    qtest_irq_intercept_in(s, "ioapic");
-    d = ib700_program_and_wait(s);
+
+    qtest_start("-watchdog-action none -device ib700");
+    irq_intercept_in("ioapic");
+    d = ib700_program_and_wait();
     g_assert(!strcmp(qdict_get_str(d, "action"), "none"));
     QDECREF(d);
     qtest_end();
-- 
2.13.5
