Received: from eggs.gnu.org ([2001:4830:134:3::10]:45443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejsW9-0002Se-Gb
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:10:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejsW8-0002Ou-9W
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:10:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ejsW8-0002OV-3v
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:10:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9A368182D1B
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 20:09:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  8 Feb 2018 21:09:39 +0100
Message-Id: <1518120582-26647-12-git-send-email-thuth@redhat.com>
In-Reply-To: <1518120582-26647-1-git-send-email-thuth@redhat.com>
References: <1518120582-26647-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 11/14] wdt_ib700-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

As a general rule, we prefer avoiding implicit global state
because it makes code harder to safely copy and paste without
thinking about the global state.  Improve this test to be
explicit about the state.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/wdt_ib700-test.c | 63 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/tests/wdt_ib700-test.c b/tests/wdt_ib700-test.c
index 4fc8eea..4bb8374 100644
--- a/tests/wdt_ib700-test.c
+++ b/tests/wdt_ib700-test.c
@@ -11,9 +11,9 @@
 #include "libqtest.h"
 #include "qemu/timer.h"
 
-static void qmp_check_no_event(void)
+static void qmp_check_no_event(QTestState *s)
 {
-    QDict *resp = qmp("{'execute':'query-status'}");
+    QDict *resp = qtest_qmp(s, "{'execute':'query-status'}");
     g_assert(qdict_haskey(resp, "return"));
     QDECREF(resp);
 }
@@ -22,30 +22,30 @@ static QDict *ib700_program_and_wait(QTestState *s)
 {
     QDict *event, *data;
 
-    clock_step(NANOSECONDS_PER_SECOND * 40);
-    qmp_check_no_event();
+    qtest_clock_step(s, NANOSECONDS_PER_SECOND * 40);
+    qmp_check_no_event(s);
 
     /* 2 second limit */
-    outb(0x443, 14);
+    qtest_outb(s, 0x443, 14);
 
     /* Ping */
-    clock_step(NANOSECONDS_PER_SECOND);
-    qmp_check_no_event();
-    outb(0x443, 14);
+    qtest_clock_step(s, NANOSECONDS_PER_SECOND);
+    qmp_check_no_event(s);
+    qtest_outb(s, 0x443, 14);
 
     /* Disable */
-    clock_step(NANOSECONDS_PER_SECOND);
-    qmp_check_no_event();
-    outb(0x441, 1);
-    clock_step(3 * NANOSECONDS_PER_SECOND);
-    qmp_check_no_event();
+    qtest_clock_step(s, NANOSECONDS_PER_SECOND);
+    qmp_check_no_event(s);
+    qtest_outb(s, 0x441, 1);
+    qtest_clock_step(s, 3 * NANOSECONDS_PER_SECOND);
+    qmp_check_no_event(s);
 
     /* Enable and let it fire */
-    outb(0x443, 13);
-    clock_step(3 * NANOSECONDS_PER_SECOND);
-    qmp_check_no_event();
-    clock_step(2 * NANOSECONDS_PER_SECOND);
-    event = qmp_eventwait_ref("WATCHDOG");
+    qtest_outb(s, 0x443, 13);
+    qtest_clock_step(s, 3 * NANOSECONDS_PER_SECOND);
+    qmp_check_no_event(s);
+    qtest_clock_step(s, 2 * NANOSECONDS_PER_SECOND);
+    event = qtest_qmp_eventwait_ref(s, "WATCHDOG");
     data = qdict_get_qdict(event, "data");
     QINCREF(data);
     QDECREF(event);
@@ -56,48 +56,53 @@ static QDict *ib700_program_and_wait(QTestState *s)
 static void ib700_pause(void)
 {
     QDict *d;
-    QTestState *s = qtest_start("-watchdog-action pause -device ib700");
+    QTestState *s = qtest_init("-watchdog-action pause -device ib700");
+
     qtest_irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "pause"));
     QDECREF(d);
-    qmp_eventwait("STOP");
-    qtest_end();
+    qtest_qmp_eventwait(s, "STOP");
+    qtest_quit(s);
 }
 
 static void ib700_reset(void)
 {
     QDict *d;
-    QTestState *s = qtest_start("-watchdog-action reset -device ib700");
+    QTestState *s = qtest_init("-watchdog-action reset -device ib700");
+
     qtest_irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
     QDECREF(d);
-    qmp_eventwait("RESET");
-    qtest_end();
+    qtest_qmp_eventwait(s, "RESET");
+    qtest_quit(s);
 }
 
 static void ib700_shutdown(void)
 {
     QDict *d;
-    QTestState *s = qtest_start("-watchdog-action reset -no-reboot -device ib700");
+    QTestState *s;
+
+    s = qtest_init("-watchdog-action reset -no-reboot -device ib700");
     qtest_irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "reset"));
     QDECREF(d);
-    qmp_eventwait("SHUTDOWN");
-    qtest_end();
+    qtest_qmp_eventwait(s, "SHUTDOWN");
+    qtest_quit(s);
 }
 
 static void ib700_none(void)
 {
     QDict *d;
-    QTestState *s = qtest_start("-watchdog-action none -device ib700");
+    QTestState *s = qtest_init("-watchdog-action none -device ib700");
+
     qtest_irq_intercept_in(s, "ioapic");
     d = ib700_program_and_wait(s);
     g_assert(!strcmp(qdict_get_str(d, "action"), "none"));
     QDECREF(d);
-    qtest_end();
+    qtest_quit(s);
 }
 
 int main(int argc, char **argv)
-- 
1.8.3.1
