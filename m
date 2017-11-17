Received: from eggs.gnu.org ([2001:4830:134:3::10]:49703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvB-0000lj-Hz
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvA-0007K6-7i
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvA-0007JS-1P
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4115AC01F290
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:35 +0100
Message-Id: <20171117103046.15943-14-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 13/24] vl: drop request_opengl variable
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

Switch over the one leftover user to qapi DisplayType.
The delete the unused request_opengl variable.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/vl.c b/vl.c
index 36eec0d1e0..c04cef83da 100644
--- a/vl.c
+++ b/vl.c
@@ -136,7 +136,6 @@ static const char *data_dir[16];
 static int data_dir_idx;
 const char *bios_name = NULL;
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
-int request_opengl = -1;
 int display_opengl;
 const char* keyboard_layout = NULL;
 ram_addr_t ram_size;
@@ -2170,10 +2169,8 @@ static void parse_display(const char *p)
                 opts = nextopt;
                 dpy.has_gl = true;
                 if (strstart(opts, "on", &nextopt)) {
-                    request_opengl = 1;
                     dpy.gl = true;
                 } else if (strstart(opts, "off", &nextopt)) {
-                    request_opengl = 0;
                     dpy.gl = false;
                 } else {
                     goto invalid_sdl_args;
@@ -2198,7 +2195,6 @@ static void parse_display(const char *p)
         }
     } else if (strstart(p, "egl-headless", &opts)) {
 #ifdef CONFIG_OPENGL_DMABUF
-        request_opengl = 1;
         display_opengl = 1;
         dpy.type = DISPLAY_TYPE_EGL_HEADLESS;
 #else
@@ -2232,10 +2228,8 @@ static void parse_display(const char *p)
                 opts = nextopt;
                 dpy.has_gl = true;
                 if (strstart(opts, "on", &nextopt)) {
-                    request_opengl = 1;
                     dpy.gl = true;
                 } else if (strstart(opts, "off", &nextopt)) {
-                    request_opengl = 0;
                     dpy.gl = false;
                 } else {
                     goto invalid_gtk_args;
@@ -4462,7 +4456,7 @@ int main(int argc, char **argv, char **envp)
 
     qemu_console_early_init();
 
-    if (request_opengl == 1 && display_opengl == 0) {
+    if (dpy.has_gl && dpy.gl && display_opengl == 0) {
 #if defined(CONFIG_OPENGL)
         error_report("OpenGL is not supported by the display");
 #else
-- 
2.9.3
