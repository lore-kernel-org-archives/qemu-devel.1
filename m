Received: from eggs.gnu.org ([2001:4830:134:3::10]:47215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyyd3-00057T-1N
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyyd0-0001bL-Hp
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:11:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dyyd0-0001ac-9Z
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:11:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5835D4A6E4
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 11:11:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 13:11:09 +0200
Message-Id: <20171002111111.26932-2-armbru@redhat.com>
In-Reply-To: <20171002111111.26932-1-armbru@redhat.com>
References: <20171002111111.26932-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] qapi: Rename WatchdogExpirationAction enum
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>
List-ID: <qemu-devel.nongnu.org>

From: Michal Privoznik <mprivozn@redhat.com>

The new name is WatchdogAction which is shorter,

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Message-Id: <dbd61a0928821348486d0d6260be2bd3b02b6402.1504771369.git.mprivozn@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/watchdog/watchdog.c | 14 +++++++-------
 monitor.c              |  4 ++--
 qapi/run-state.json    |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 0c5c9cde1c..358d79804d 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -109,17 +109,17 @@ void watchdog_perform_action(void)
 {
     switch (watchdog_action) {
     case WDT_RESET:             /* same as 'system_reset' in monitor */
-        qapi_event_send_watchdog(WATCHDOG_EXPIRATION_ACTION_RESET, &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_RESET, &error_abort);
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         break;
 
     case WDT_SHUTDOWN:          /* same as 'system_powerdown' in monitor */
-        qapi_event_send_watchdog(WATCHDOG_EXPIRATION_ACTION_SHUTDOWN, &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_SHUTDOWN, &error_abort);
         qemu_system_powerdown_request();
         break;
 
     case WDT_POWEROFF:          /* same as 'quit' command in monitor */
-        qapi_event_send_watchdog(WATCHDOG_EXPIRATION_ACTION_POWEROFF, &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_POWEROFF, &error_abort);
         exit(0);
 
     case WDT_PAUSE:             /* same as 'stop' command in monitor */
@@ -127,21 +127,21 @@ void watchdog_perform_action(void)
          * you would get a deadlock.  Bypass the problem.
          */
         qemu_system_vmstop_request_prepare();
-        qapi_event_send_watchdog(WATCHDOG_EXPIRATION_ACTION_PAUSE, &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_PAUSE, &error_abort);
         qemu_system_vmstop_request(RUN_STATE_WATCHDOG);
         break;
 
     case WDT_DEBUG:
-        qapi_event_send_watchdog(WATCHDOG_EXPIRATION_ACTION_DEBUG, &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_DEBUG, &error_abort);
         fprintf(stderr, "watchdog: timer fired\n");
         break;
 
     case WDT_NONE:
-        qapi_event_send_watchdog(WATCHDOG_EXPIRATION_ACTION_NONE, &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_NONE, &error_abort);
         break;
 
     case WDT_NMI:
-        qapi_event_send_watchdog(WATCHDOG_EXPIRATION_ACTION_INJECT_NMI,
+        qapi_event_send_watchdog(WATCHDOG_ACTION_INJECT_NMI,
                                  &error_abort);
         nmi_monitor_handle(0, NULL);
         break;
diff --git a/monitor.c b/monitor.c
index f4856b9268..94fb197c0d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3541,8 +3541,8 @@ void watchdog_action_completion(ReadLineState *rs, int nb_args, const char *str)
         return;
     }
     readline_set_completion_index(rs, strlen(str));
-    for (i = 0; i < WATCHDOG_EXPIRATION_ACTION__MAX; i++) {
-        add_completion_option(rs, str, WatchdogExpirationAction_str(i));
+    for (i = 0; i < WATCHDOG_ACTION__MAX; i++) {
+        add_completion_option(rs, str, WatchdogAction_str(i));
     }
 }
 
diff --git a/qapi/run-state.json b/qapi/run-state.json
index d36ff49834..bca46a8785 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -253,10 +253,10 @@
 #
 ##
 { 'event': 'WATCHDOG',
-  'data': { 'action': 'WatchdogExpirationAction' } }
+  'data': { 'action': 'WatchdogAction' } }
 
 ##
-# @WatchdogExpirationAction:
+# @WatchdogAction:
 #
 # An enumeration of the actions taken when the watchdog device's timer is
 # expired
@@ -279,7 +279,7 @@
 #
 # Since: 2.1
 ##
-{ 'enum': 'WatchdogExpirationAction',
+{ 'enum': 'WatchdogAction',
   'data': [ 'reset', 'shutdown', 'poweroff', 'pause', 'debug', 'none',
             'inject-nmi' ] }
 
-- 
2.13.6
