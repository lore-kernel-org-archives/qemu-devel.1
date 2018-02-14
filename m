Received: from eggs.gnu.org ([2001:4830:134:3::10]:43438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7K-0006Ih-Gy
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7H-00078k-Bl
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elv7H-00078L-6b
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:47 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Feb 2018 12:20:17 +0100
Message-Id: <1518607234-17739-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1518607234-17739-1-git-send-email-thuth@redhat.com>
References: <1518607234-17739-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 01/18] tests: Clean up wait for event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

We still use hacks like qmp("") to wait for an event, even though we
have qmp_eventwait() since commit 8fe941f, and qmp_eventwait_ref()
since commit 7ffe312.  Both commits neglected to convert all the
existing hacks.  Make up what they missed.

Bonus: gets rid of empty format strings.  A step towards compile-time
format string checking without triggering -Wformat-zero-length.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
[thuth: dropped the hunks from the usb tests - not needed anymore]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-order-test.c |  2 +-
 tests/libqos/pci-pc.c   |  6 +-----
 tests/tco-test.c        |  3 +--
 tests/wdt_ib700-test.c  | 35 ++++++++++-------------------------
 4 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index 60c5545..508469a 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -41,7 +41,7 @@ static void test_a_boot_order(const char *machine,
      * system_reset only requests reset.  We get a RESET event after
      * the actual reset completes.  Need to wait for that.
      */
-    qmp_discard_response("");   /* HACK: wait for event */
+    qmp_eventwait("RESET");
     actual = read_boot_order();
     g_assert_cmphex(actual, ==, expected_reboot);
     qtest_quit(global_qtest);
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index cd4e20e..368a8a6 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -173,9 +173,5 @@ void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
 
     outb(ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
 
-    response = qmp("");
-    g_assert(response);
-    g_assert(qdict_haskey(response, "event"));
-    g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
-    QDECREF(response);
+    qmp_eventwait("DEVICE_DELETED");
 }
diff --git a/tests/tco-test.c b/tests/tco-test.c
index 8ab43d7..cc7663d 100644
--- a/tests/tco-test.c
+++ b/tests/tco-test.c
@@ -237,9 +237,8 @@ static void test_tco_max_timeout(void)
 
 static QDict *get_watchdog_action(void)
 {
-    QDict *ev = qmp("");
+    QDict *ev = qmp_eventwait_ref("WATCHDOG");
     QDict *data;
-    g_assert(!strcmp(qdict_get_str(ev, "event"), "WATCHDOG"));
 
     data = qdict_get_qdict(ev, "data");
     QINCREF(data);
diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index 6062d4e..d777f32 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -19,26 +19,10 @@ static void qmp_check_no_event(void)
     QDECREF(resp);
 }
 
-static QDict *qmp_get_event(const char *name)
-{
-    QDict *event = qmp("");
-    QDict *data;
-    g_assert(qdict_haskey(event, "event"));
-    g_assert(!strcmp(qdict_get_str(event, "event"), name));
-
-    if (qdict_haskey(event, "data")) {
-        data = qdict_get_qdict(event, "data");
-        QINCREF(data);
-    } else {
-        data = NULL;
-    }
-
-    QDECREF(event);
-    return data;
-}
-
 static QDict *ib700_program_and_wait(QTestState *s)
 {
+    QDict *event, *data;
+
     clock_step(NANOSECONDS_PER_SECOND * 40);
     qmp_check_no_event();
 
@@ -62,7 +46,11 @@ static QDict *ib700_program_and_wait(QTestState *s)
     clock_step(3 * NANOSECONDS_PER_SECOND);
     qmp_check_no_event();
     clock_step(2 * NANOSECONDS_PER_SECOND);
-    return qmp_get_event("WATCHDOG");
+    event = qmp_eventwait_ref("WATCHDOG");
+    data = qdict_get_qdict(event, "data");
+    QINCREF(data);
+    QDECREF(event);
+    return data;
 }
 
 
@@ -74,8 +62,7 @@ static void ib700_pause(void)
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "pause"));
     QDECREF(d);
-    d = qmp_get_event("STOP");
-    QDECREF(d);
+    qmp_eventwait("STOP");
     qtest_end();
 }
 
@@ -87,8 +74,7 @@ static void ib700_reset(void)
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
     QDECREF(d);
-    d = qmp_get_event("RESET");
-    QDECREF(d);
+    qmp_eventwait("RESET");
     qtest_end();
 }
 
@@ -100,8 +86,7 @@ static void ib700_shutdown(void)
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
     QDECREF(d);
-    d = qmp_get_event("SHUTDOWN");
-    QDECREF(d);
+    qmp_eventwait("SHUTDOWN");
     qtest_end();
 }
 
-- 
1.8.3.1
