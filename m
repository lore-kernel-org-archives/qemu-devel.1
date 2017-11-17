Received: from eggs.gnu.org ([2001:4830:134:3::10]:49711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvB-0000lq-Jp
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvA-0007KO-Ch
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvA-0007Jf-6E
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54057C01F291
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:30 +0100
Message-Id: <20171117103046.15943-9-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 08/24] egl-headless: use DisplayOptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Switch egl-headless ui to use qapi DisplayOptions for configuration.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 2 +-
 ui/egl-headless.c    | 2 +-
 vl.c                 | 3 ++-
 qapi/ui.json         | 5 +++--
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index deee5bb606..4cb623112e 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -530,6 +530,6 @@ static inline void early_gtk_display_init(DisplayOptions *opts)
 #endif
 
 /* egl-headless.c */
-void egl_headless_init(void);
+void egl_headless_init(DisplayOptions *opts);
 
 #endif
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 5d50226869..38b3766548 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -154,7 +154,7 @@ static const DisplayChangeListenerOps egl_ops = {
     .dpy_gl_update           = egl_scanout_flush,
 };
 
-void egl_headless_init(void)
+void egl_headless_init(DisplayOptions *opts)
 {
     QemuConsole *con;
     egl_dpy *edpy;
diff --git a/vl.c b/vl.c
index d461800f13..b5cf02bb46 100644
--- a/vl.c
+++ b/vl.c
@@ -2214,6 +2214,7 @@ static LegacyDisplayType select_display(const char *p)
         request_opengl = 1;
         display_opengl = 1;
         display = DT_EGL;
+        dpy.type = DISPLAY_TYPE_EGL_HEADLESS;
 #else
         fprintf(stderr, "egl support is disabled\n");
         exit(1);
@@ -4845,7 +4846,7 @@ int main(int argc, char **argv, char **envp)
 
 #ifdef CONFIG_OPENGL_DMABUF
     if (display_type == DT_EGL) {
-        egl_headless_init();
+        egl_headless_init(&dpy);
     }
 #endif
 
diff --git a/qapi/ui.json b/qapi/ui.json
index e7d3e8729b..372205c98f 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1009,7 +1009,7 @@
 #
 ##
 { 'enum'    : 'DisplayType',
-  'data'    : [ 'default', 'none', 'gtk', 'sdl' ] }
+  'data'    : [ 'default', 'none', 'gtk', 'sdl', 'egl-headless' ] }
 
 ##
 # @DisplayOptions:
@@ -1026,4 +1026,5 @@
   'data'    : { 'default'        : 'DisplayNoOpts',
                 'none'           : 'DisplayNoOpts',
                 'gtk'            : 'DisplayGTK',
-                'sdl'            : 'DisplayNoOpts' } }
+                'sdl'            : 'DisplayNoOpts',
+                'egl-headless'   : 'DisplayNoOpts' } }
-- 
2.9.3
