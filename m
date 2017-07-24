Received: from eggs.gnu.org ([2001:4830:134:3::10]:43117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZcNM-0000YN-EV
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dZcNH-0002KB-KN
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:22:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dZcNH-0002Ii-E1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:22:11 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Jul 2017 14:22:08 +0200
Message-Id: <1500898928-4901-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1500898928-4901-1-git-send-email-armbru@redhat.com>
References: <1500898928-4901-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] error: Revert unwanted change of warning
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>

Commit 97f4030 changed warning messages from

    timestamp-if-enabled progname ":" location "warning: " message

to

    "warning: " timestamp-if-enabled progname ":" location message

This regressed qemu-iotests 051.  Put "warning: " right back where it
was, along with "info: ".

Reported-by: Kevin Wolf <kwolf@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1500449614-16811-1-git-send-email-armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 util/qemu-error.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/util/qemu-error.c b/util/qemu-error.c
index c557c6a..a25d3b9 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -201,17 +201,6 @@ static void vreport(report_type type, const char *fmt, va_list ap)
     GTimeVal tv;
     gchar *timestr;
 
-    switch (type) {
-    case REPORT_TYPE_ERROR:
-        break;
-    case REPORT_TYPE_WARNING:
-        error_printf("warning: ");
-        break;
-    case REPORT_TYPE_INFO:
-        error_printf("info: ");
-        break;
-    }
-
     if (enable_timestamp_msg && !cur_mon) {
         g_get_current_time(&tv);
         timestr = g_time_val_to_iso8601(&tv);
@@ -220,6 +209,18 @@ static void vreport(report_type type, const char *fmt, va_list ap)
     }
 
     print_loc();
+
+    switch (type) {
+    case REPORT_TYPE_ERROR:
+        break;
+    case REPORT_TYPE_WARNING:
+        error_printf("warning: ");
+        break;
+    case REPORT_TYPE_INFO:
+        error_printf("info: ");
+        break;
+    }
+
     error_vprintf(fmt, ap);
     error_printf("\n");
 }
-- 
2.7.5
