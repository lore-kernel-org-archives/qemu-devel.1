Received: from eggs.gnu.org ([2001:4830:134:3::10]:56191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e5DaQ-000655-7z
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e5DaN-0002D2-1W
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:22:22 -0400
Received: from mail-sn1nam01on0043.outbound.protection.outlook.com
	([104.47.32.43]:65360
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1e5DaM-0002Ce-NC
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:22:18 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 19 Oct 2017 09:18:11 -0700
Message-ID: <d34071814ded4ba1ffd2482b3bdfbb71175fc06f.1508390588.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1508390588.git.alistair.francis@xilinx.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 40/46] hw/watchdog: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
V2:
 - Split hw patch into individual directories

 hw/watchdog/watchdog.c     | 9 +++++----
 hw/watchdog/wdt_i6300esb.c | 8 +++++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 670114ecfe..d6d11ef1e5 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/queue.h"
@@ -52,7 +53,7 @@ int select_watchdog(const char *p)
     /* -watchdog ? lists available devices and exits cleanly. */
     if (is_help_option(p)) {
         QLIST_FOREACH(model, &watchdog_list, entry) {
-            fprintf(stderr, "\t%s\t%s\n",
+            error_report("\t%s\t%s",
                      model->wdt_name, model->wdt_description);
         }
         return 2;
@@ -68,9 +69,9 @@ int select_watchdog(const char *p)
         }
     }
 
-    fprintf(stderr, "Unknown -watchdog device. Supported devices are:\n");
+    error_report("Unknown -watchdog device. Supported devices are:");
     QLIST_FOREACH(model, &watchdog_list, entry) {
-        fprintf(stderr, "\t%s\t%s\n",
+        error_report("\t%s\t%s",
                  model->wdt_name, model->wdt_description);
     }
     return 1;
@@ -126,7 +127,7 @@ void watchdog_perform_action(void)
 
     case WATCHDOG_ACTION_DEBUG:
         qapi_event_send_watchdog(WATCHDOG_ACTION_DEBUG, &error_abort);
-        fprintf(stderr, "watchdog: timer fired\n");
+        error_report("watchdog: timer fired");
         break;
 
     case WATCHDOG_ACTION_NONE:
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index e596b0804d..c5f5190e55 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "sysemu/watchdog.h"
@@ -186,10 +186,12 @@ static void i6300esb_timer_expired(void *vp)
         /* What to do at the end of stage 1? */
         switch (d->int_type) {
         case INT_TYPE_IRQ:
-            fprintf(stderr, "i6300esb_timer_expired: I would send APIC 1 INT 10 here if I knew how (XXX)\n");
+            error_report("i6300esb_timer_expired: I would send APIC 1 INT 10"
+                          "here if I knew how (XXX)");
             break;
         case INT_TYPE_SMI:
-            fprintf(stderr, "i6300esb_timer_expired: I would send SMI here if I knew how (XXX)\n");
+            error_report("i6300esb_timer_expired: I would send SMI here if I"
+                         "knew how (XXX)");
             break;
         }
 
-- 
2.11.0
