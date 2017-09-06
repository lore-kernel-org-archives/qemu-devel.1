Received: from eggs.gnu.org ([2001:4830:134:3::10]:58256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpWAu-0003X4-0w
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpWAo-0000nR-DC
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:59:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dpWAo-0000n9-46
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:59:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0AADA37EE9
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 08:59:01 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Wed,  6 Sep 2017 10:58:53 +0200
Message-Id: <dbd61a0928821348486d0d6260be2bd3b02b6402.1504688205.git.mprivozn@redhat.com>
In-Reply-To: <cover.1504688205.git.mprivozn@redhat.com>
References: <cover.1504688205.git.mprivozn@redhat.com>
In-Reply-To: <cover.1504688205.git.mprivozn@redhat.com>
References: <cover.1504688205.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] qapi: Rename WatchdogExpirationAction
 enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com

The new name is WatchdogAction which is shorter,

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
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
index 9239f7adde..e6a6675c15 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3537,8 +3537,8 @@ void watchdog_action_completion(ReadLineState *rs, int nb_args, const char *str)
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
2.13.5
