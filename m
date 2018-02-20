Received: from eggs.gnu.org ([2001:4830:134:3::10]:47811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gi-0005Gj-9c
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Ge-0006yG-EP
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33822 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo8Ge-0006xI-7y
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FC2CEB70A
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:47:31 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 14:47:17 +0100
Message-Id: <20180220134723.11776-7-kraxel@redhat.com>
In-Reply-To: <20180220134723.11776-1-kraxel@redhat.com>
References: <20180220134723.11776-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 06/12] egl-headless: use DisplayOptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Switch egl-headless ui to use qapi DisplayOptions for configuration.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180202111022.19269-8-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 2 +-
 ui/egl-headless.c    | 2 +-
 vl.c                 | 3 ++-
 qapi/ui.json         | 5 +++--
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 4e4d027936..183d9f2913 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -505,6 +505,6 @@ static inline void early_gtk_display_init(DisplayOptions *opts)
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
index f52bc3b879..38c18ef2e6 100644
--- a/vl.c
+++ b/vl.c
@@ -2178,6 +2178,7 @@ static LegacyDisplayType select_display(const char *p)
         request_opengl = 1;
         display_opengl = 1;
         display = DT_EGL;
+        dpy.type = DISPLAY_TYPE_EGL_HEADLESS;
 #else
         error_report("egl support is disabled");
         exit(1);
@@ -4726,7 +4727,7 @@ int main(int argc, char **argv, char **envp)
 
 #ifdef CONFIG_OPENGL_DMABUF
     if (display_type == DT_EGL) {
-        egl_headless_init();
+        egl_headless_init(&dpy);
     }
 #endif
 
diff --git a/qapi/ui.json b/qapi/ui.json
index 2efe9675b7..43de75fa27 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1020,7 +1020,7 @@
 #
 ##
 { 'enum'    : 'DisplayType',
-  'data'    : [ 'none', 'gtk', 'sdl' ] }
+  'data'    : [ 'none', 'gtk', 'sdl', 'egl-headless' ] }
 
 ##
 # @DisplayOptions:
@@ -1043,4 +1043,5 @@
   'discriminator' : 'type',
   'data'    : { 'none'           : 'DisplayNoOpts',
                 'gtk'            : 'DisplayGTK',
-                'sdl'            : 'DisplayNoOpts' } }
+                'sdl'            : 'DisplayNoOpts',
+                'egl-headless'   : 'DisplayNoOpts' } }
-- 
2.9.3
