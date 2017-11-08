Received: from eggs.gnu.org ([2001:4830:134:3::10]:35115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZND-00013O-LR
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZNA-0003py-Bh
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:03:07 -0500
Received: from mail-bl2nam02on0065.outbound.protection.outlook.com
	([104.47.38.65]:45792
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZNA-0003pk-72
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:03:04 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:58:50 -0800
Message-ID: <10f1bca388976b18119fd4fc28d6fdcf7106f7d3.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 40/45] hw/watchdog: Replace fprintf(stderr,
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

Some lines were then manually tweaked to pass checkpatch.

Some lines in wdt_i6300esb.c were manuallly changed to qemu_log_mask().

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
V3:
 - Use qemu_log_mask(LOG_UNIMP,... in wdt_i6300esb.c
V2:
 - Split hw patch into individual directories

 hw/watchdog/watchdog.c     | 11 +++++------
 hw/watchdog/wdt_i6300esb.c | 10 +++++++---
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 670114ecfe..9594457082 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/queue.h"
@@ -52,8 +53,7 @@ int select_watchdog(const char *p)
     /* -watchdog ? lists available devices and exits cleanly. */
     if (is_help_option(p)) {
         QLIST_FOREACH(model, &watchdog_list, entry) {
-            fprintf(stderr, "\t%s\t%s\n",
-                     model->wdt_name, model->wdt_description);
+            error_report("\t%s\t%s", model->wdt_name, model->wdt_description);
         }
         return 2;
     }
@@ -68,10 +68,9 @@ int select_watchdog(const char *p)
         }
     }
 
-    fprintf(stderr, "Unknown -watchdog device. Supported devices are:\n");
+    error_report("Unknown -watchdog device. Supported devices are:");
     QLIST_FOREACH(model, &watchdog_list, entry) {
-        fprintf(stderr, "\t%s\t%s\n",
-                 model->wdt_name, model->wdt_description);
+        error_report("\t%s\t%s", model->wdt_name, model->wdt_description);
     }
     return 1;
 }
@@ -126,7 +125,7 @@ void watchdog_perform_action(void)
 
     case WATCHDOG_ACTION_DEBUG:
         qapi_event_send_watchdog(WATCHDOG_ACTION_DEBUG, &error_abort);
-        fprintf(stderr, "watchdog: timer fired\n");
+        error_report("watchdog: timer fired");
         break;
 
     case WATCHDOG_ACTION_NONE:
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index e596b0804d..967f3ebc0d 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-
+#include "include/qemu/log.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "sysemu/watchdog.h"
@@ -186,10 +186,14 @@ static void i6300esb_timer_expired(void *vp)
         /* What to do at the end of stage 1? */
         switch (d->int_type) {
         case INT_TYPE_IRQ:
-            fprintf(stderr, "i6300esb_timer_expired: I would send APIC 1 INT 10 here if I knew how (XXX)\n");
+               qemu_log_mask(LOG_UNIMP,
+                             "i6300esb: timer expired but System "
+                             "APIC 1 INT10 not emitted\n");
             break;
         case INT_TYPE_SMI:
-            fprintf(stderr, "i6300esb_timer_expired: I would send SMI here if I knew how (XXX)\n");
+               qemu_log_mask(LOG_UNIMP,
+                             "i6300esb: timer expired but System "
+                             "Management Interrupt not emitted\n");
             break;
         }
 
-- 
2.14.1
