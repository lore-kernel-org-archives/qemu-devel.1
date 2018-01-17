Received: from eggs.gnu.org ([2001:4830:134:3::10]:58036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1ebp4i-0001IC-WC
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1ebp4h-0002EH-W2
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:52:25 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1ebp4h-0002DH-PZ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:52:23 -0500
Received: by mail-wm0-x243.google.com with SMTP id 81so22225224wmb.1
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 06:52:23 -0800 (PST)
From: Elie Tournier <tournier.elie@gmail.com>
Date: Wed, 17 Jan 2018 14:50:28 +0000
Message-Id: <20180117145029.28736-2-tournier.elie@gmail.com>
In-Reply-To: <20180117145029.28736-1-tournier.elie@gmail.com>
References: <20180117145029.28736-1-tournier.elie@gmail.com>
Subject: [Qemu-devel] [RFC 1/2] sdl2: Add gles options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kraxel@redhat.com, Elie Tournier <tournier.elie@gmail.com>, Elie Tournier <elie.tournier@collabora.com>

This commit add an option to the sdl display: `-display sdl,gles=on`
This will allow the user to create an OpenGL ES context.

Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
---
 qemu-options.hx |  5 ++++-
 ui/sdl2.c       |  1 +
 vl.c            | 11 ++++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 678181c599..18a616e339 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1257,7 +1257,7 @@ ETEXI
 
 DEF("display", HAS_ARG, QEMU_OPTION_display,
     "-display sdl[,frame=on|off][,alt_grab=on|off][,ctrl_grab=on|off]\n"
-    "            [,window_close=on|off][,gl=on|off]\n"
+    "            [,window_close=on|off][,gl=on|off][,gles=on|off]\n"
     "-display gtk[,grab_on_hover=on|off][,gl=on|off]|\n"
     "-display vnc=<display>[,<optargs>]\n"
     "-display curses\n"
@@ -1492,6 +1492,9 @@ Enable/disable spice seamless migration. Default is off.
 @item gl=[on|off]
 Enable/disable OpenGL context. Default is off.
 
+@item gles=[on|off]
+Enable/disable OpenGL ES context. Default is off.
+
 @item rendernode=<file>
 DRM render node for OpenGL rendering. If not specified, it will pick
 the first available. (Since 2.9)
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 89c6a2633c..e78cff1a6f 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -762,6 +762,7 @@ void sdl_display_early_init(int opengl)
     case 0:  /* off */
         break;
     case 1: /* on */
+    case 2: /* gles = on */
 #ifdef CONFIG_OPENGL
         display_opengl = 1;
 #endif
diff --git a/vl.c b/vl.c
index 2586f25952..3fe325222e 100644
--- a/vl.c
+++ b/vl.c
@@ -2154,6 +2154,15 @@ static DisplayType select_display(const char *p)
                 } else {
                     goto invalid_sdl_args;
                 }
+            } else if (strstart(opts, ",gles=", &nextopt)) {
+                opts = nextopt;
+                if (strstart(opts, "on", &nextopt)) {
+                    request_opengl = 2;
+                } else if (strstart(opts, "off", &nextopt)) {
+                    request_opengl = 0;
+                } else {
+                    goto invalid_sdl_args;
+                }
             } else if (strstart(opts, ",gl=", &nextopt)) {
                 opts = nextopt;
                 if (strstart(opts, "on", &nextopt)) {
@@ -4364,7 +4373,7 @@ int main(int argc, char **argv, char **envp)
 
     qemu_console_early_init();
 
-    if (request_opengl == 1 && display_opengl == 0) {
+    if ((request_opengl == 1 || request_opengl == 2) && display_opengl == 0) {
 #if defined(CONFIG_OPENGL)
         error_report("OpenGL is not supported by the display");
 #else
-- 
2.15.1
