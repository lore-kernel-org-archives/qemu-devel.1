Received: from eggs.gnu.org ([2001:4830:134:3::10]:41581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciO0i-0002RL-JK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciO0h-0002n5-K9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ciO0h-0002mV-EY
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:51 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A32F23B731
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:18:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Feb 2017 17:18:42 +0100
Message-Id: <1488212323-26882-9-git-send-email-kraxel@redhat.com>
In-Reply-To: <1488212323-26882-1-git-send-email-kraxel@redhat.com>
References: <1488212323-26882-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] spice: add display & head options
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
Message-id: 1487663858-11731-1-git-send-email-kraxel@redhat.com
---
 ui/spice-core.c    |  6 ++++++
 ui/spice-display.c | 22 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 39ccab7..804abc5 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -497,6 +497,12 @@ static QemuOptsList qemu_spice_opts = {
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
index 23ccf2a..b353445 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1035,9 +1035,26 @@ static void qemu_spice_display_init_one(QemuConsole *con)
 
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
@@ -1046,6 +1063,9 @@ void qemu_spice_display_init(void)
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
