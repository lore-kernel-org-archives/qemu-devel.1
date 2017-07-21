Received: from eggs.gnu.org ([2001:4830:134:3::10]:48335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYN3-0007gW-B7
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYN1-00046T-NH
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYYN1-00045W-F1
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59476C07046F
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 13:53:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 21 Jul 2017 15:53:24 +0200
Message-Id: <1500645206-13559-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-1-git-send-email-armbru@redhat.com>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 7/9] tests: Clean up wait for event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We still use hacks like qmp("") to wait for an event, even though we
have qmp_eventwait() since commit 8fe941f, and qmp_eventwait_ref()
since commit 7ffe312.  Both commits neglected to convert all the
existing hacks.  Make up what they missed.

Bonus: gets rid of empty format strings.  A step towards compile-time
format string checking without triggering -Wformat-zero-length.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/boot-order-test.c   |  2 +-
 tests/libqos/pci-pc.c     |  6 +-----
 tests/tco-test.c          |  3 +--
 tests/usb-hcd-uhci-test.c |  6 +-----
 tests/usb-hcd-xhci-test.c | 12 ++----------
 tests/wdt_ib700-test.c    | 35 ++++++++++-------------------------
 6 files changed, 16 insertions(+), 48 deletions(-)

diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index fc1e794..9d51683 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -43,7 +43,7 @@ static void test_a_boot_order(const char *machine,
      * system_reset only requests reset.  We get a RESET event after
      * the actual reset completes.  Need to wait for that.
      */
-    qmp_discard_response("");   /* HACK: wait for event */
+    qmp_eventwait("RESET");
     actual = read_boot_order();
     g_assert_cmphex(actual, ==, expected_reboot);
     qtest_quit(global_qtest);
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index d40aa9d..e4be809 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -168,9 +168,5 @@ void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
 
     outb(ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
 
-    response = qmp("");
-    g_assert(response);
-    g_assert(qdict_haskey(response, "event"));
-    g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
-    QDECREF(response);
+    qmp_eventwait("DEVICE_DELETED");
 }
diff --git a/tests/tco-test.c b/tests/tco-test.c
index c4c264e..f2ed6ed 100644
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
diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
index 5b500fe..0fb7f8d 100644
--- a/tests/usb-hcd-uhci-test.c
+++ b/tests/usb-hcd-uhci-test.c
@@ -68,11 +68,7 @@ static void test_usb_storage_hotplug(void)
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
 
-    response = qmp("");
-    g_assert(response);
-    g_assert(qdict_haskey(response, "event"));
-    g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
-    QDECREF(response);
+    qmp_eventwait("DEVICE_DELETED");
 }
 
 int main(int argc, char **argv)
diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index 031764d..c05a339 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -57,11 +57,7 @@ static void test_usb_uas_hotplug(void)
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
 
-    response = qmp("");
-    g_assert(qdict_haskey(response, "event"));
-    g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
-    QDECREF(response);
-
+    qmp_eventwait("DEVICE_DELETED");
 
     response = qmp("{'execute': 'device_del',"
                            " 'arguments': {"
@@ -71,11 +67,7 @@ static void test_usb_uas_hotplug(void)
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
 
-    response = qmp("");
-    g_assert(response);
-    g_assert(qdict_haskey(response, "event"));
-    g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
-    QDECREF(response);
+    qmp_eventwait("DEVICE_DELETED");
 }
 
 int main(int argc, char **argv)
diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index 49f4f0c..4fc8eea 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -18,26 +18,10 @@ static void qmp_check_no_event(void)
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
 
@@ -61,7 +45,11 @@ static QDict *ib700_program_and_wait(QTestState *s)
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
 
 
@@ -73,8 +61,7 @@ static void ib700_pause(void)
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "pause"));
     QDECREF(d);
-    d = qmp_get_event("STOP");
-    QDECREF(d);
+    qmp_eventwait("STOP");
     qtest_end();
 }
 
@@ -86,8 +73,7 @@ static void ib700_reset(void)
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
     QDECREF(d);
-    d = qmp_get_event("RESET");
-    QDECREF(d);
+    qmp_eventwait("RESET");
     qtest_end();
 }
 
@@ -99,8 +85,7 @@ static void ib700_shutdown(void)
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
     QDECREF(d);
-    d = qmp_get_event("SHUTDOWN");
-    QDECREF(d);
+    qmp_eventwait("SHUTDOWN");
     qtest_end();
 }
 
-- 
2.7.5
