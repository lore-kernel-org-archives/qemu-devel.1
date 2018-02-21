Received: from eggs.gnu.org ([2001:4830:134:3::10]:57720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoUFS-0003G3-2R
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoUFO-0007UW-U0
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:15:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55776 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoUFO-0007Su-LX
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:15:46 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Feb 2018 14:15:28 +0100
Message-Id: <20180221131537.31341-4-kraxel@redhat.com>
In-Reply-To: <20180221131537.31341-1-kraxel@redhat.com>
References: <20180221131537.31341-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 03/12] cocoa: switch over to new display
 registry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 12 ------------
 vl.c                 |  3 ---
 ui/cocoa.m           | 14 +++++++++++++-
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 82bbea0242..b97d9ccae4 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -441,18 +441,6 @@ void qemu_display_register(QemuDisplay *ui);
 void qemu_display_early_init(DisplayOptions *opts);
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
 
-/* cocoa.m */
-#ifdef CONFIG_COCOA
-void cocoa_display_init(DisplayState *ds, DisplayOptions *opts);
-#else
-static inline void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
-{
-    /* This must never be called if CONFIG_COCOA is disabled */
-    error_report("Cocoa support is disabled");
-    abort();
-}
-#endif
-
 /* vnc.c */
 void vnc_display_init(const char *id);
 void vnc_display_open(const char *id, Error **errp);
diff --git a/vl.c b/vl.c
index 45900ba7e6..2c3cb4651c 100644
--- a/vl.c
+++ b/vl.c
@@ -4654,9 +4654,6 @@ int main(int argc, char **argv, char **envp)
     case DISPLAY_TYPE_CURSES:
         curses_display_init(ds, &dpy);
         break;
-    case DISPLAY_TYPE_COCOA:
-        cocoa_display_init(ds, &dpy);
-        break;
     default:
         qemu_display_init(ds, &dpy);
         break;
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 90d9aa57ea..8b0dce90cb 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1683,7 +1683,7 @@ static void addRemovableDevicesMenuItems(void)
     qapi_free_BlockInfoList(pointerToFree);
 }
 
-void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
+static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
 
@@ -1713,3 +1713,15 @@ void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
      */
     addRemovableDevicesMenuItems();
 }
+
+static QemuDisplay qemu_display_cocoa = {
+    .type       = DISPLAY_TYPE_COCOA,
+    .init       = cocoa_display_init,
+};
+
+static void register_cocoa(void)
+{
+    qemu_display_register(&qemu_display_cocoa);
+}
+
+type_init(register_cocoa);
-- 
2.9.3
