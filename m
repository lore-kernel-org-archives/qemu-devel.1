Received: from eggs.gnu.org ([2001:4830:134:3::10]:49797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvD-0000mP-Pt
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvB-0007M7-EU
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvB-0007Ku-5C
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A16B37E8F
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:52 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:39 +0100
Message-Id: <20171117103046.15943-18-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 17/24] curses: hook up to display registry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 12 ------------
 ui/curses.c          | 14 +++++++++++++-
 vl.c                 | 17 ++---------------
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 81db3a0f67..c93a331d35 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -475,18 +475,6 @@ static inline int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
 }
 #endif
 
-/* curses.c */
-#ifdef CONFIG_CURSES
-void curses_display_init(DisplayState *ds, DisplayOptions *opts);
-#else
-static inline void curses_display_init(DisplayState *ds, DisplayOptions *opts)
-{
-    /* This must never be called if CONFIG_CURSES is disabled */
-    error_report("curses support is disabled");
-    abort();
-}
-#endif
-
 /* input.c */
 int index_from_key(const char *key, size_t key_length);
 
diff --git a/ui/curses.c b/ui/curses.c
index 479b77bd03..d55e6d74a1 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -434,7 +434,7 @@ static const DisplayChangeListenerOps dcl_ops = {
     .dpy_text_cursor = curses_cursor_position,
 };
 
-void curses_display_init(DisplayState *ds, DisplayOptions *opts)
+static void curses_display_init(DisplayState *ds, DisplayOptions *opts)
 {
 #ifndef _WIN32
     if (!isatty(1)) {
@@ -455,3 +455,15 @@ void curses_display_init(DisplayState *ds, DisplayOptions *opts)
 
     invalidate = 1;
 }
+
+static QemuDisplay qemu_display_curses = {
+    .type       = DISPLAY_TYPE_CURSES,
+    .init       = curses_display_init,
+};
+
+static void register_curses(void)
+{
+    qemu_display_register(&qemu_display_curses);
+}
+
+type_init(register_curses);
diff --git a/vl.c b/vl.c
index d57671b755..07f049044b 100644
--- a/vl.c
+++ b/vl.c
@@ -2197,12 +2197,7 @@ static void parse_display(const char *p)
         exit(1);
 #endif
     } else if (strstart(p, "curses", &opts)) {
-#ifdef CONFIG_CURSES
         dpy.type = DISPLAY_TYPE_CURSES;
-#else
-        error_report("curses support is disabled");
-        exit(1);
-#endif
     } else if (strstart(p, "gtk", &opts)) {
         dpy.type = DISPLAY_TYPE_GTK;
         while (*opts) {
@@ -4766,17 +4761,9 @@ int main(int argc, char **argv, char **envp)
         qemu_register_reset(restore_boot_order, g_strdup(boot_order));
     }
 
-    ds = init_displaystate();
-
     /* init local displays */
-    switch (dpy.type) {
-    case DISPLAY_TYPE_CURSES:
-        curses_display_init(ds, &dpy);
-        break;
-    default:
-        qemu_display_init(ds, &dpy);
-        break;
-    }
+    ds = init_displaystate();
+    qemu_display_init(ds, &dpy);
 
     /* must be after terminal init, SDL library changes signal handlers */
     os_setup_signal_handling();
-- 
2.9.3
