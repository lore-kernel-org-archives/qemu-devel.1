Received: from eggs.gnu.org ([2001:4830:134:3::10]:42621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1erL62-0005FR-IT
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1erL5x-0004zi-Gx
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60220 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1erL5x-0004zG-Ba
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE1FE407519A
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 10:05:48 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  1 Mar 2018 11:05:38 +0100
Message-Id: <20180301100547.18962-5-kraxel@redhat.com>
In-Reply-To: <20180301100547.18962-1-kraxel@redhat.com>
References: <20180301100547.18962-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/13] curses: switch over to new display
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
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 12 ------------
 ui/curses.c          | 14 +++++++++++++-
 vl.c                 | 17 ++---------------
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index f8c462106a..3ea6cf0870 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -453,18 +453,6 @@ int vnc_display_pw_expire(const char *id, time_t expires);
 QemuOpts *vnc_parse(const char *str, Error **errp);
 int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
 
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
index 597e47fd4a..59d819fd4d 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -435,7 +435,7 @@ static const DisplayChangeListenerOps dcl_ops = {
     .dpy_text_cursor = curses_cursor_position,
 };
 
-void curses_display_init(DisplayState *ds, DisplayOptions *opts)
+static void curses_display_init(DisplayState *ds, DisplayOptions *opts)
 {
 #ifndef _WIN32
     if (!isatty(1)) {
@@ -456,3 +456,15 @@ void curses_display_init(DisplayState *ds, DisplayOptions *opts)
 
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
index 2c3cb4651c..2b4af34fbb 100644
--- a/vl.c
+++ b/vl.c
@@ -2161,12 +2161,7 @@ static void parse_display(const char *p)
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
@@ -4647,17 +4642,9 @@ int main(int argc, char **argv, char **envp)
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
