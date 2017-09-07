Received: from eggs.gnu.org ([2001:4830:134:3::10]:54454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dprop-0003DK-N8
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dprol-0000TP-ER
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:05:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dprol-0000Sq-6C
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:05:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4807E85542
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:05:42 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Thu,  7 Sep 2017 10:05:25 +0200
Message-Id: <ce2790634e6a1b3b6cf90462399d17bad83f0290.1504771369.git.mprivozn@redhat.com>
In-Reply-To: <cover.1504771369.git.mprivozn@redhat.com>
References: <cover.1504771369.git.mprivozn@redhat.com>
In-Reply-To: <cover.1504771369.git.mprivozn@redhat.com>
References: <cover.1504771369.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH v5 2/3] watchdog.h: Drop local redefinition of
 actions enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com

We already have enum that enumerates all the actions that a
watchdog can take when hitting its timeout: WatchdogAction.
Use that instead of inventing our own.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 hw/watchdog/watchdog.c    | 45 ++++++++++++++++++++-------------------------
 hw/watchdog/wdt_diag288.c |  6 +++---
 include/sysemu/watchdog.h | 12 ++----------
 3 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 358d79804d..0d3eeed187 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -30,7 +30,7 @@
 #include "hw/nmi.h"
 #include "qemu/help_option.h"
 
-static int watchdog_action = WDT_RESET;
+static WatchdogAction watchdog_action = WATCHDOG_ACTION_RESET;
 static QLIST_HEAD(watchdog_list, WatchdogTimerModel) watchdog_list;
 
 void watchdog_add_model(WatchdogTimerModel *model)
@@ -77,27 +77,19 @@ int select_watchdog(const char *p)
 
 int select_watchdog_action(const char *p)
 {
-    if (strcasecmp(p, "reset") == 0)
-        watchdog_action = WDT_RESET;
-    else if (strcasecmp(p, "shutdown") == 0)
-        watchdog_action = WDT_SHUTDOWN;
-    else if (strcasecmp(p, "poweroff") == 0)
-        watchdog_action = WDT_POWEROFF;
-    else if (strcasecmp(p, "pause") == 0)
-        watchdog_action = WDT_PAUSE;
-    else if (strcasecmp(p, "debug") == 0)
-        watchdog_action = WDT_DEBUG;
-    else if (strcasecmp(p, "none") == 0)
-        watchdog_action = WDT_NONE;
-    else if (strcasecmp(p, "inject-nmi") == 0)
-        watchdog_action = WDT_NMI;
-    else
-        return -1;
+    int action;
+    char *qapi_value;
 
+    qapi_value = g_ascii_strdown(p, -1);
+    action = qapi_enum_parse(&WatchdogAction_lookup, qapi_value, -1, NULL);
+    g_free(qapi_value);
+    if (action < 0)
+        return -1;
+    watchdog_action = action;
     return 0;
 }
 
-int get_watchdog_action(void)
+WatchdogAction get_watchdog_action(void)
 {
     return watchdog_action;
 }
@@ -108,21 +100,21 @@ int get_watchdog_action(void)
 void watchdog_perform_action(void)
 {
     switch (watchdog_action) {
-    case WDT_RESET:             /* same as 'system_reset' in monitor */
+    case WATCHDOG_ACTION_RESET:     /* same as 'system_reset' in monitor */
         qapi_event_send_watchdog(WATCHDOG_ACTION_RESET, &error_abort);
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         break;
 
-    case WDT_SHUTDOWN:          /* same as 'system_powerdown' in monitor */
+    case WATCHDOG_ACTION_SHUTDOWN:  /* same as 'system_powerdown' in monitor */
         qapi_event_send_watchdog(WATCHDOG_ACTION_SHUTDOWN, &error_abort);
         qemu_system_powerdown_request();
         break;
 
-    case WDT_POWEROFF:          /* same as 'quit' command in monitor */
+    case WATCHDOG_ACTION_POWEROFF:  /* same as 'quit' command in monitor */
         qapi_event_send_watchdog(WATCHDOG_ACTION_POWEROFF, &error_abort);
         exit(0);
 
-    case WDT_PAUSE:             /* same as 'stop' command in monitor */
+    case WATCHDOG_ACTION_PAUSE:     /* same as 'stop' command in monitor */
         /* In a timer callback, when vm_stop calls qemu_clock_enable
          * you would get a deadlock.  Bypass the problem.
          */
@@ -131,19 +123,22 @@ void watchdog_perform_action(void)
         qemu_system_vmstop_request(RUN_STATE_WATCHDOG);
         break;
 
-    case WDT_DEBUG:
+    case WATCHDOG_ACTION_DEBUG:
         qapi_event_send_watchdog(WATCHDOG_ACTION_DEBUG, &error_abort);
         fprintf(stderr, "watchdog: timer fired\n");
         break;
 
-    case WDT_NONE:
+    case WATCHDOG_ACTION_NONE:
         qapi_event_send_watchdog(WATCHDOG_ACTION_NONE, &error_abort);
         break;
 
-    case WDT_NMI:
+    case WATCHDOG_ACTION_INJECT_NMI:
         qapi_event_send_watchdog(WATCHDOG_ACTION_INJECT_NMI,
                                  &error_abort);
         nmi_monitor_handle(0, NULL);
         break;
+
+    default:
+        assert(0);
     }
 }
diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index 47f289216a..1475743527 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -57,9 +57,9 @@ static void diag288_timer_expired(void *dev)
      * the BQL; reset before triggering the action to avoid races with
      * diag288 instructions. */
     switch (get_watchdog_action()) {
-    case WDT_DEBUG:
-    case WDT_NONE:
-    case WDT_PAUSE:
+    case WATCHDOG_ACTION_DEBUG:
+    case WATCHDOG_ACTION_NONE:
+    case WATCHDOG_ACTION_PAUSE:
         break;
     default:
         wdt_diag288_reset(dev);
diff --git a/include/sysemu/watchdog.h b/include/sysemu/watchdog.h
index 72a4da07a6..677ace3945 100644
--- a/include/sysemu/watchdog.h
+++ b/include/sysemu/watchdog.h
@@ -23,15 +23,7 @@
 #define QEMU_WATCHDOG_H
 
 #include "qemu/queue.h"
-
-/* Possible values for action parameter. */
-#define WDT_RESET        1      /* Hard reset. */
-#define WDT_SHUTDOWN     2      /* Shutdown. */
-#define WDT_POWEROFF     3      /* Quit. */
-#define WDT_PAUSE        4      /* Pause. */
-#define WDT_DEBUG        5      /* Prints a message and continues running. */
-#define WDT_NONE         6      /* Do nothing. */
-#define WDT_NMI          7      /* Inject nmi into the guest. */
+#include "qapi-types.h"
 
 struct WatchdogTimerModel {
     QLIST_ENTRY(WatchdogTimerModel) entry;
@@ -46,7 +38,7 @@ typedef struct WatchdogTimerModel WatchdogTimerModel;
 /* in hw/watchdog.c */
 int select_watchdog(const char *p);
 int select_watchdog_action(const char *action);
-int get_watchdog_action(void);
+WatchdogAction get_watchdog_action(void);
 void watchdog_add_model(WatchdogTimerModel *model);
 void watchdog_perform_action(void);
 
-- 
2.13.5
