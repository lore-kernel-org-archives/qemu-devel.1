Received: from eggs.gnu.org ([2001:4830:134:3::10]:49889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvG-0000pj-88
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvE-0007QD-6h
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvD-0007OY-UC
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:56 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:38 +0100
Message-Id: <20171117103046.15943-17-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 16/24] cocoa: hook up to display registry
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
index 63534ac20a..81db3a0f67 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -445,18 +445,6 @@ void qemu_display_register(QemuDisplay *ui);
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
index 474d982da9..d57671b755 100644
--- a/vl.c
+++ b/vl.c
@@ -4773,9 +4773,6 @@ int main(int argc, char **argv, char **envp)
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
index 9560c07105..16d760eae5 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1671,7 +1671,7 @@ static void addRemovableDevicesMenuItems(void)
     qapi_free_BlockInfoList(pointerToFree);
 }
 
-void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
+static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
 
@@ -1701,3 +1701,15 @@ void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
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
