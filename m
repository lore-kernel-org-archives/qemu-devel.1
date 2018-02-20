Received: from eggs.gnu.org ([2001:4830:134:3::10]:47844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gj-0005H5-EC
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Ge-0006y6-Cu
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36252 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo8Ge-0006xK-88
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7279D8182D3E
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:47:31 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 14:47:21 +0100
Message-Id: <20180220134723.11776-11-kraxel@redhat.com>
In-Reply-To: <20180220134723.11776-1-kraxel@redhat.com>
References: <20180220134723.11776-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 10/12] vl: drop request_opengl variable
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180202111022.19269-12-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/vl.c b/vl.c
index 6271ad0634..11dc98eba2 100644
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
@@ -2146,10 +2145,8 @@ static LegacyDisplayType select_display(const char *p)
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
@@ -2174,7 +2171,6 @@ static LegacyDisplayType select_display(const char *p)
         }
     } else if (strstart(p, "egl-headless", &opts)) {
 #ifdef CONFIG_OPENGL_DMABUF
-        request_opengl = 1;
         display_opengl = 1;
         display = DT_EGL;
         dpy.type = DISPLAY_TYPE_EGL_HEADLESS;
@@ -2211,10 +2207,8 @@ static LegacyDisplayType select_display(const char *p)
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
@@ -4371,7 +4365,7 @@ int main(int argc, char **argv, char **envp)
 
     qemu_console_early_init();
 
-    if (request_opengl == 1 && display_opengl == 0) {
+    if (dpy.has_gl && dpy.gl && display_opengl == 0) {
 #if defined(CONFIG_OPENGL)
         error_report("OpenGL is not supported by the display");
 #else
-- 
2.9.3
