Received: from eggs.gnu.org ([2001:4830:134:3::10]:37417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg5Kb-0000kH-7D
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg5KW-0002BK-Ec
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:57:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg5KW-0002B1-8s
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:57:48 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A6F2C012844
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:57:48 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 08:57:37 +0100
Message-Id: <1487663858-11731-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] spice: add display & head options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This allows to specify display and head to use, simliar to vnc.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-core.c    |  6 ++++++
 ui/spice-display.c | 22 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index d613f1a..e18ad77 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -498,6 +498,12 @@ static QemuOptsList qemu_spice_opts = {
         },{
             .name = "seamless-migration",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "display",
+            .type = QEMU_OPT_STRING,
+        },{
+            .name = "head",
+            .type = QEMU_OPT_NUMBER,
 #ifdef HAVE_SPICE_GL
         },{
             .name = "gl",
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 64e472e..9c58e5a 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1029,9 +1029,26 @@ static void qemu_spice_display_init_one(QemuConsole *con)
 
 void qemu_spice_display_init(void)
 {
-    QemuConsole *con;
+    QemuOptsList *olist = qemu_find_opts("spice");
+    QemuOpts *opts = QTAILQ_FIRST(&olist->head);
+    QemuConsole *spice_con, *con;
+    const char *str;
     int i;
 
+    str = qemu_opt_get(opts, "display");
+    if (str) {
+        int head = qemu_opt_get_number(opts, "head", 0);
+        Error *err = NULL;
+
+        spice_con = qemu_console_lookup_by_device_name(str, head, &err);
+        if (err) {
+            error_report("Failed to lookup display/head");
+            exit(1);
+        }
+    } else {
+        spice_con = NULL;
+    }
+
     for (i = 0;; i++) {
         con = qemu_console_lookup_by_index(i);
         if (!con || !qemu_console_is_graphic(con)) {
@@ -1040,6 +1057,9 @@ void qemu_spice_display_init(void)
         if (qemu_spice_have_display_interface(con)) {
             continue;
         }
+        if (spice_con != NULL && spice_con != con) {
+            continue;
+        }
         qemu_spice_display_init_one(con);
     }
 }
-- 
1.8.3.1
