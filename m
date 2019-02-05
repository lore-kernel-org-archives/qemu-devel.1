Received: from eggs.gnu.org ([209.51.188.92]:40035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqvAv-000548-LE
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqvAu-0007Im-3u
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:29:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gqvAs-00078y-63
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:29:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2305081F0C
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 07:29:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  5 Feb 2019 08:29:29 +0100
Message-Id: <1549351769-19620-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Remove deprecated -no-frame option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

The -no-frame option has been deprecated with QEMU v2.12. It was only
useful with SDL1.2 - now that we've removed support for SDL1.2, we
can certainly remove the -no-frame option, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/sysemu/sysemu.h |  1 -
 qemu-deprecated.texi    |  6 ------
 qemu-options.hx         | 11 -----------
 vl.c                    | 23 +++--------------------
 4 files changed, 3 insertions(+), 38 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 85877b7..4b5a6b7 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -102,7 +102,6 @@ extern const char *keyboard_layout;
 extern int win2k_install_hack;
 extern int alt_grab;
 extern int ctrl_grab;
-extern int no_frame;
 extern int smp_cpus;
 extern unsigned int max_cpus;
 extern int cursor_hide;
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 9cc20b3..0b508e7 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -37,12 +37,6 @@ would automatically enable USB support on the machine type.
 If using the new syntax, USB support must be explicitly
 enabled via the ``-machine usb=on'' argument.
 
-@subsection -no-frame (since 2.12.0)
-
-The @code{--no-frame} argument works with SDL 1.2 only. The other user
-interfaces never implemented this in the first place. So this will be
-removed together with SDL 1.2 support.
-
 @subsection -virtioconsole (since 3.0.0)
 
 Option @option{-virtioconsole} has been replaced by
diff --git a/qemu-options.hx b/qemu-options.hx
index 521511e..0180467 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1294,17 +1294,6 @@ mode using a curses/ncurses interface. Nothing is displayed in graphical
 mode.
 ETEXI
 
-DEF("no-frame", 0, QEMU_OPTION_no_frame,
-    "-no-frame       open SDL window without a frame and window decorations\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -no-frame
-@findex -no-frame
-Do not use decorations for SDL windows and start them using the whole
-available screen space. This makes the using QEMU in a dedicated desktop
-workspace more convenient.
-ETEXI
-
 DEF("alt-grab", 0, QEMU_OPTION_alt_grab,
     "-alt-grab       use Ctrl-Alt-Shift to grab mouse (instead of Ctrl-Alt)\n",
     QEMU_ARCH_ALL)
diff --git a/vl.c b/vl.c
index 9cf0fbe..33d226f 100644
--- a/vl.c
+++ b/vl.c
@@ -160,7 +160,6 @@ static int rtc_host_datetime_offset = -1; /* valid & used only with
 QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
 static DisplayOptions dpy;
-int no_frame;
 static int num_serial_hds;
 static Chardev **serial_hds;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
@@ -2113,18 +2112,7 @@ static void parse_display(const char *p)
         while (*opts) {
             const char *nextopt;
 
-            if (strstart(opts, ",frame=", &nextopt)) {
-                g_printerr("The frame= sdl option is deprecated, and will be\n"
-                           "removed in a future release.\n");
-                opts = nextopt;
-                if (strstart(opts, "on", &nextopt)) {
-                    no_frame = 0;
-                } else if (strstart(opts, "off", &nextopt)) {
-                    no_frame = 1;
-                } else {
-                    goto invalid_sdl_args;
-                }
-            } else if (strstart(opts, ",alt_grab=", &nextopt)) {
+            if (strstart(opts, ",alt_grab=", &nextopt)) {
                 opts = nextopt;
                 if (strstart(opts, "on", &nextopt)) {
                     alt_grab = 1;
@@ -3596,11 +3584,6 @@ int main(int argc, char **argv, char **envp)
                 dpy.has_full_screen = true;
                 dpy.full_screen = true;
                 break;
-            case QEMU_OPTION_no_frame:
-                g_printerr("The -no-frame switch is deprecated, and will be\n"
-                           "removed in a future release.\n");
-                no_frame = 1;
-                break;
             case QEMU_OPTION_alt_grab:
                 alt_grab = 1;
                 break;
@@ -4279,8 +4262,8 @@ int main(int argc, char **argv, char **envp)
         dpy.type = DISPLAY_TYPE_NONE;
     }
 
-    if ((no_frame || alt_grab || ctrl_grab) && dpy.type != DISPLAY_TYPE_SDL) {
-        error_report("-no-frame, -alt-grab and -ctrl-grab are only valid "
+    if ((alt_grab || ctrl_grab) && dpy.type != DISPLAY_TYPE_SDL) {
+        error_report("-alt-grab and -ctrl-grab are only valid "
                      "for SDL, ignoring option");
     }
     if (dpy.has_window_close &&
-- 
1.8.3.1
