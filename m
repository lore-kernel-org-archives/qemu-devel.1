Received: from eggs.gnu.org ([2001:4830:134:3::10]:37953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1uzu-00045R-Re
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1uzr-0007VU-Nh
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:55:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1uzr-0007UI-D2
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:54:59 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 15:54:50 +0200
Message-Id: <20171010135453.6704-4-kraxel@redhat.com>
In-Reply-To: <20171010135453.6704-1-kraxel@redhat.com>
References: <20171010135453.6704-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] opengl: add flipping vertex shader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>

Add vertex shader which flips the texture upside down while blitting it.
Add argument to qemu_gl_run_texture_blit() to enable flipping.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile                         |  4 +++-
 include/ui/shader.h              |  2 +-
 ui/console-gl.c                  |  2 +-
 ui/shader.c                      | 12 +++++++++---
 ui/shader/texture-blit-flip.vert | 10 ++++++++++
 5 files changed, 24 insertions(+), 6 deletions(-)
 create mode 100644 ui/shader/texture-blit-flip.vert

diff --git a/Makefile b/Makefile
index e4275691fb..cb6a974a6f 100644
--- a/Makefile
+++ b/Makefile
@@ -672,7 +672,9 @@ ui/shader/%-frag.h: $(SRC_PATH)/ui/shader/%.frag $(SRC_PATH)/scripts/shaderinclu
 		"FRAG","$@")
 
 ui/shader.o: $(SRC_PATH)/ui/shader.c \
-	ui/shader/texture-blit-vert.h ui/shader/texture-blit-frag.h
+	ui/shader/texture-blit-vert.h \
+	ui/shader/texture-blit-flip-vert.h \
+	ui/shader/texture-blit-frag.h
 
 # documentation
 MAKEINFO=makeinfo
diff --git a/include/ui/shader.h b/include/ui/shader.h
index 369e49865f..4c5acb2ce8 100644
--- a/include/ui/shader.h
+++ b/include/ui/shader.h
@@ -5,7 +5,7 @@
 
 typedef struct QemuGLShader QemuGLShader;
 
-void qemu_gl_run_texture_blit(QemuGLShader *gls);
+void qemu_gl_run_texture_blit(QemuGLShader *gls, bool flip);
 
 QemuGLShader *qemu_gl_init_shader(void);
 void qemu_gl_fini_shader(QemuGLShader *gls);
diff --git a/ui/console-gl.c b/ui/console-gl.c
index 9b50daedbd..5b77e7aa88 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -109,7 +109,7 @@ void surface_gl_render_texture(QemuGLShader *gls,
     glClearColor(0.1f, 0.1f, 0.1f, 0.0f);
     glClear(GL_COLOR_BUFFER_BIT);
 
-    qemu_gl_run_texture_blit(gls);
+    qemu_gl_run_texture_blit(gls, false);
 }
 
 void surface_gl_destroy_texture(QemuGLShader *gls,
diff --git a/ui/shader.c b/ui/shader.c
index d36e7af232..008458bf94 100644
--- a/ui/shader.c
+++ b/ui/shader.c
@@ -29,10 +29,12 @@
 #include "ui/shader.h"
 
 #include "shader/texture-blit-vert.h"
+#include "shader/texture-blit-flip-vert.h"
 #include "shader/texture-blit-frag.h"
 
 struct QemuGLShader {
     GLint texture_blit_prog;
+    GLint texture_blit_flip_prog;
     GLint texture_blit_vao;
 };
 
@@ -68,9 +70,11 @@ static GLuint qemu_gl_init_texture_blit(GLint texture_blit_prog)
     return vao;
 }
 
-void qemu_gl_run_texture_blit(QemuGLShader *gls)
+void qemu_gl_run_texture_blit(QemuGLShader *gls, bool flip)
 {
-    glUseProgram(gls->texture_blit_prog);
+    glUseProgram(flip
+                 ? gls->texture_blit_flip_prog
+                 : gls->texture_blit_prog);
     glBindVertexArray(gls->texture_blit_vao);
     glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
 }
@@ -150,7 +154,9 @@ QemuGLShader *qemu_gl_init_shader(void)
 
     gls->texture_blit_prog = qemu_gl_create_compile_link_program
         (texture_blit_vert_src, texture_blit_frag_src);
-    if (!gls->texture_blit_prog) {
+    gls->texture_blit_flip_prog = qemu_gl_create_compile_link_program
+        (texture_blit_flip_vert_src, texture_blit_frag_src);
+    if (!gls->texture_blit_prog || !gls->texture_blit_flip_prog) {
         exit(1);
     }
 
diff --git a/ui/shader/texture-blit-flip.vert b/ui/shader/texture-blit-flip.vert
new file mode 100644
index 0000000000..ba081fa5a6
--- /dev/null
+++ b/ui/shader/texture-blit-flip.vert
@@ -0,0 +1,10 @@
+
+#version 300 es
+
+in vec2  in_position;
+out vec2 ex_tex_coord;
+
+void main(void) {
+    gl_Position = vec4(in_position, 0.0, 1.0);
+    ex_tex_coord = vec2(1.0 + in_position.x, 1.0 + in_position.y) * 0.5;
+}
-- 
2.9.3
