Received: from eggs.gnu.org ([2001:4830:134:3::10]:41142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC05T-0007PA-4C
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC05S-0001fb-9M
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fC05S-0001fN-3L
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:42 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 27 Apr 2018 11:54:30 +0200
Message-Id: <20180427095434.14013-3-kraxel@redhat.com>
In-Reply-To: <20180427095434.14013-1-kraxel@redhat.com>
References: <20180427095434.14013-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/6] qapi: Parameter gl of DisplayType now
 accept an enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Elie Tournier <tournier.elie@gmail.com>, Elie Tournier <elie.tournier@collabora.com>

From: Elie Tournier <tournier.elie@gmail.com>

v2: Rebase on top of master
v3: Fix the json format (Eric Blake)
    Fix a comparison issue (Gerd Hoffmann)

Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
Message-id: 20180413135842.21325-2-tournier.elie@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c         | 10 +++++-----
 qapi/ui.json | 20 +++++++++++++++++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/vl.c b/vl.c
index 616956adf1..f7804f7a18 100644
--- a/vl.c
+++ b/vl.c
@@ -2143,9 +2143,9 @@ static void parse_display(const char *p)
                 opts = nextopt;
                 dpy.has_gl = true;
                 if (strstart(opts, "on", &nextopt)) {
-                    dpy.gl = true;
+                    dpy.gl = DISPLAYGL_MODE_ON;
                 } else if (strstart(opts, "off", &nextopt)) {
-                    dpy.gl = false;
+                    dpy.gl = DISPLAYGL_MODE_OFF;
                 } else {
                     goto invalid_sdl_args;
                 }
@@ -2186,9 +2186,9 @@ static void parse_display(const char *p)
                 opts = nextopt;
                 dpy.has_gl = true;
                 if (strstart(opts, "on", &nextopt)) {
-                    dpy.gl = true;
+                    dpy.gl = DISPLAYGL_MODE_ON;
                 } else if (strstart(opts, "off", &nextopt)) {
-                    dpy.gl = false;
+                    dpy.gl = DISPLAYGL_MODE_OFF;
                 } else {
                     goto invalid_gtk_args;
                 }
@@ -4356,7 +4356,7 @@ int main(int argc, char **argv, char **envp)
     qemu_display_early_init(&dpy);
     qemu_console_early_init();
 
-    if (dpy.has_gl && dpy.gl && display_opengl == 0) {
+    if (dpy.has_gl && dpy.gl != DISPLAYGL_MODE_OFF && display_opengl == 0) {
 #if defined(CONFIG_OPENGL)
         error_report("OpenGL is not supported by the display");
 #else
diff --git a/qapi/ui.json b/qapi/ui.json
index 5d01ad4304..3ad7835992 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1019,6 +1019,24 @@
 { 'struct'  : 'DisplayGTK',
   'data'    : { '*grab-on-hover' : 'bool' } }
 
+ ##
+ # @DisplayGLMode:
+ #
+ # Display OpenGL mode.
+ #
+ # @off: Disable OpenGL (default).
+ # @on: Use OpenGL, pick context type automatically.
+ #      Would better be named 'auto' but is called 'on' for backward
+ #      compatibility with bool type.
+ # @core: Use OpenGL with Core (desktop) Context.
+ # @es: Use OpenGL with ES (embedded systems) Context.
+ #
+ # Since: 2.13
+ #
+ ##
+ { 'enum'    : 'DisplayGLMode',
+   'data'    : [ 'off', 'on', 'core', 'es' ] }
+
 ##
 # @DisplayType:
 #
@@ -1048,7 +1066,7 @@
   'base'    : { 'type'           : 'DisplayType',
                 '*full-screen'   : 'bool',
                 '*window-close'  : 'bool',
-                '*gl'            : 'bool' },
+                '*gl'            : 'DisplayGLMode' },
   'discriminator' : 'type',
   'data'    : { 'default'        : 'DisplayNoOpts',
                 'none'           : 'DisplayNoOpts',
-- 
2.9.3
