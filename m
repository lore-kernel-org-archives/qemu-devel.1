Received: from eggs.gnu.org ([2001:4830:134:3::10]:45811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCEE-0007y8-71
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCED-0002TK-AF
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egCED-0002S6-4A
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7878410F3DC
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 16:24:16 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Jan 2018 17:24:03 +0100
Message-Id: <20180129162408.415-8-kraxel@redhat.com>
In-Reply-To: <20180129162408.415-1-kraxel@redhat.com>
References: <20180129162408.415-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/12] egl-headless: use DisplayOptions
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
index c17dedfa4e..1d801dd96d 100644
--- a/vl.c
+++ b/vl.c
@@ -2181,6 +2181,7 @@ static LegacyDisplayType select_display(const char *p)
         request_opengl = 1;
         display_opengl = 1;
         display = DT_EGL;
+        dpy.type = DISPLAY_TYPE_EGL_HEADLESS;
 #else
         fprintf(stderr, "egl support is disabled\n");
         exit(1);
@@ -4737,7 +4738,7 @@ int main(int argc, char **argv, char **envp)
 
 #ifdef CONFIG_OPENGL_DMABUF
     if (display_type == DT_EGL) {
-        egl_headless_init();
+        egl_headless_init(&dpy);
     }
 #endif
 
diff --git a/qapi/ui.json b/qapi/ui.json
index 9fbd2b0398..8f0ae1d76b 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1017,7 +1017,7 @@
 #
 ##
 { 'enum'    : 'DisplayType',
-  'data'    : [ 'default', 'none', 'gtk', 'sdl' ] }
+  'data'    : [ 'default', 'none', 'gtk', 'sdl', 'egl-headless' ] }
 
 ##
 # @DisplayOptions:
@@ -1041,4 +1041,5 @@
   'data'    : { 'default'        : 'DisplayNoOpts',
                 'none'           : 'DisplayNoOpts',
                 'gtk'            : 'DisplayGTK',
-                'sdl'            : 'DisplayNoOpts' } }
+                'sdl'            : 'DisplayNoOpts',
+                'egl-headless'   : 'DisplayNoOpts' } }
-- 
2.9.3
