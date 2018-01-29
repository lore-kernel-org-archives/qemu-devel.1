Received: from eggs.gnu.org ([2001:4830:134:3::10]:45807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCED-0007xw-Us
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCEC-0002SM-PP
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egCEC-0002RV-Ii
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D734A28219
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 16:24:15 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Jan 2018 17:24:08 +0100
Message-Id: <20180129162408.415-13-kraxel@redhat.com>
In-Reply-To: <20180129162408.415-1-kraxel@redhat.com>
References: <20180129162408.415-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/12] vl: drop request_opengl variable
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

Switch over the one leftover user to qapi DisplayType.
The delete the unused request_opengl variable.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/vl.c b/vl.c
index 827ab2a3b0..42867d60f8 100644
--- a/vl.c
+++ b/vl.c
@@ -135,7 +135,6 @@ static const char *data_dir[16];
 static int data_dir_idx;
 const char *bios_name = NULL;
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
-int request_opengl = -1;
 int display_opengl;
 const char* keyboard_layout = NULL;
 ram_addr_t ram_size;
@@ -2137,10 +2136,8 @@ static void parse_display(const char *p)
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
@@ -2165,7 +2162,6 @@ static void parse_display(const char *p)
         }
     } else if (strstart(p, "egl-headless", &opts)) {
 #ifdef CONFIG_OPENGL_DMABUF
-        request_opengl = 1;
         display_opengl = 1;
         dpy.type = DISPLAY_TYPE_EGL_HEADLESS;
 #else
@@ -2199,10 +2195,8 @@ static void parse_display(const char *p)
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
@@ -4356,7 +4350,7 @@ int main(int argc, char **argv, char **envp)
 
     qemu_console_early_init();
 
-    if (request_opengl == 1 && display_opengl == 0) {
+    if (dpy.has_gl && dpy.gl && display_opengl == 0) {
 #if defined(CONFIG_OPENGL)
         error_report("OpenGL is not supported by the display");
 #else
-- 
2.9.3
