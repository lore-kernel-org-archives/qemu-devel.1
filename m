Received: from eggs.gnu.org ([2001:4830:134:3::10]:60729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1er0ff-0007mI-Um
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1er0fc-0002Ft-OT
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:17:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1er0fc-0002FD-K8
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:17:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE1A88D744
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 12:17:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 28 Feb 2018 13:16:58 +0100
Message-Id: <20180228121703.20816-7-kraxel@redhat.com>
In-Reply-To: <20180228121703.20816-1-kraxel@redhat.com>
References: <20180228121703.20816-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 06/11] console: add and use
 qemu_display_find_default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Using the new display registry instead of #ifdefs in vl.c.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180221131537.31341-7-kraxel@redhat.com
---
 include/ui/console.h |  1 +
 ui/console.c         | 19 +++++++++++++++++++
 vl.c                 | 15 +++++----------
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 94726cf190..3a53db9360 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -441,6 +441,7 @@ struct QemuDisplay {
 };
 
 void qemu_display_register(QemuDisplay *ui);
+bool qemu_display_find_default(DisplayOptions *opts);
 void qemu_display_early_init(DisplayOptions *opts);
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
 
diff --git a/ui/console.c b/ui/console.c
index a11b120fc8..25d342cdcb 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2188,6 +2188,25 @@ void qemu_display_register(QemuDisplay *ui)
     dpys[ui->type] = ui;
 }
 
+bool qemu_display_find_default(DisplayOptions *opts)
+{
+    static DisplayType prio[] = {
+        DISPLAY_TYPE_GTK,
+        DISPLAY_TYPE_SDL,
+        DISPLAY_TYPE_COCOA
+    };
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(prio); i++) {
+        if (dpys[prio[i]] == NULL) {
+            continue;
+        }
+        opts->type = prio[i];
+        return true;
+    }
+    return false;
+}
+
 void qemu_display_early_init(DisplayOptions *opts)
 {
     assert(opts->type < DISPLAY_TYPE__MAX);
diff --git a/vl.c b/vl.c
index 47c953f8dc..59e56593f8 100644
--- a/vl.c
+++ b/vl.c
@@ -4285,17 +4285,12 @@ int main(int argc, char **argv, char **envp)
     }
 #endif
     if (dpy.type == DISPLAY_TYPE_DEFAULT && !display_remote) {
-#if defined(CONFIG_GTK)
-        dpy.type = DISPLAY_TYPE_GTK;
-#elif defined(CONFIG_SDL)
-        dpy.type = DISPLAY_TYPE_SDL;
-#elif defined(CONFIG_COCOA)
-        dpy.type = DISPLAY_TYPE_COCOA;
-#elif defined(CONFIG_VNC)
-        vnc_parse("localhost:0,to=99,id=default", &error_abort);
-#else
-        dpy.type = DISPLAY_TYPE_NONE;
+        if (!qemu_display_find_default(&dpy)) {
+            dpy.type = DISPLAY_TYPE_NONE;
+#if defined(CONFIG_VNC)
+            vnc_parse("localhost:0,to=99,id=default", &error_abort);
 #endif
+        }
     }
     if (dpy.type == DISPLAY_TYPE_DEFAULT) {
         dpy.type = DISPLAY_TYPE_NONE;
-- 
2.9.3
