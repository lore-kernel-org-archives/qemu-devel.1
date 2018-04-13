Received: from eggs.gnu.org ([2001:4830:134:3::10]:46938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f6zJs-0004Ab-Ve
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f6zJs-00018J-2V
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:04:52 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1f6zJr-000185-SG
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:04:52 -0400
Received: by mail-wr0-x242.google.com with SMTP id z73so8441528wrb.0
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 07:04:51 -0700 (PDT)
From: Elie Tournier <tournier.elie@gmail.com>
Date: Fri, 13 Apr 2018 14:58:40 +0100
Message-Id: <20180413135842.21325-2-tournier.elie@gmail.com>
In-Reply-To: <20180413135842.21325-1-tournier.elie@gmail.com>
References: <20180413135842.21325-1-tournier.elie@gmail.com>
Subject: [Qemu-devel] [PATCH v3 1/3] qapi: Parameter gl of DisplayType now
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
Cc: eblake@redhat.com, kraxel@redhat.com, Elie Tournier <tournier.elie@gmail.com>, Elie Tournier <elie.tournier@collabora.com>

v2: Rebase on top of master
v3: Fix the json format (Eric Blake)
    Fix a comparison issue (Gerd Hoffmann)

Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
---
 qapi/ui.json | 20 +++++++++++++++++++-
 vl.c         | 10 +++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

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
diff --git a/vl.c b/vl.c
index fce1fd12d8..99284fd518 100644
--- a/vl.c
+++ b/vl.c
@@ -2142,9 +2142,9 @@ static void parse_display(const char *p)
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
@@ -2185,9 +2185,9 @@ static void parse_display(const char *p)
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
@@ -4343,7 +4343,7 @@ int main(int argc, char **argv, char **envp)
     qemu_display_early_init(&dpy);
     qemu_console_early_init();
 
-    if (dpy.has_gl && dpy.gl && display_opengl == 0) {
+    if (dpy.has_gl && dpy.gl != DISPLAYGL_MODE_OFF && display_opengl == 0) {
 #if defined(CONFIG_OPENGL)
         error_report("OpenGL is not supported by the display");
 #else
-- 
2.17.0
