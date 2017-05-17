Received: from eggs.gnu.org ([2001:4830:134:3::10]:38710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAy3X-0001Yb-Va
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAy3T-0004dy-3H
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:27:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dAy3S-0004dq-TM
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:27:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC3B5804ED
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 12:27:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 17 May 2017 14:27:44 +0200
Message-Id: <20170517122744.3541-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2] ui: egl-headless requires dmabuf support
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

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c             | 4 ++--
 ui/Makefile.objs | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index 5c9b40eb1c..2d7aeec186 100644
--- a/vl.c
+++ b/vl.c
@@ -2129,7 +2129,7 @@ static DisplayType select_display(const char *p)
             exit(1);
         }
     } else if (strstart(p, "egl-headless", &opts)) {
-#ifdef CONFIG_OPENGL
+#ifdef CONFIG_OPENGL_DMABUF
         request_opengl = 1;
         display_opengl = 1;
         display = DT_EGL;
@@ -4668,7 +4668,7 @@ int main(int argc, char **argv, char **envp)
         qemu_spice_display_init();
     }
 
-#ifdef CONFIG_OPENGL
+#ifdef CONFIG_OPENGL_DMABUF
     if (display_type == DT_EGL) {
         egl_headless_init();
     }
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index aac6ae8bef..3369451285 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -33,7 +33,7 @@ common-obj-y += shader.o
 common-obj-y += console-gl.o
 common-obj-y += egl-helpers.o
 common-obj-y += egl-context.o
-common-obj-y += egl-headless.o
+common-obj-$(CONFIG_OPENGL_DMABUF) += egl-headless.o
 ifeq ($(CONFIG_GTK_GL),y)
 common-obj-$(CONFIG_GTK) += gtk-gl-area.o
 else
-- 
2.9.3
