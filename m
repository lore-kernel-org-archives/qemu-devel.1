Received: from eggs.gnu.org ([2001:4830:134:3::10]:46579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3Am-0005SZ-7V
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3Aj-0002J8-K6
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL3Aj-0002IY-Ds
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:57:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E6925F7B6
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:57:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 09:56:53 +0200
Message-Id: <20170614075653.26420-6-kraxel@redhat.com>
In-Reply-To: <20170614075653.26420-1-kraxel@redhat.com>
References: <20170614075653.26420-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] spice: don't enter opengl mode in case
 another UI provides opengl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170606110618.10393-1-kraxel@redhat.com
---
 include/ui/spice-display.h | 2 ++
 ui/spice-core.c            | 1 +
 ui/spice-display.c         | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 184d4c373a..4ba9444dba 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -140,6 +140,8 @@ struct SimpleSpiceCursor {
     QXLCursor cursor;
 };
 
+extern bool spice_opengl;
+
 int qemu_spice_rect_is_empty(const QXLRect* r);
 void qemu_spice_rect_union(QXLRect *dest, const QXLRect *r);
 
diff --git a/ui/spice-core.c b/ui/spice-core.c
index a087ad5da9..182f550f1f 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -847,6 +847,7 @@ void qemu_spice_init(void)
             exit(1);
         }
         display_opengl = 1;
+        spice_opengl = 1;
     }
 #endif
 }
diff --git a/ui/spice-display.c b/ui/spice-display.c
index b353445f58..042292cc90 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -27,6 +27,7 @@
 #include "ui/spice-display.h"
 
 static int debug = 0;
+bool spice_opengl;
 
 static void GCC_FMT_ATTR(2, 3) dprint(int level, const char *fmt, ...)
 {
@@ -1013,7 +1014,7 @@ static void qemu_spice_display_init_one(QemuConsole *con)
 
     ssd->dcl.ops = &display_listener_ops;
 #ifdef HAVE_SPICE_GL
-    if (display_opengl) {
+    if (spice_opengl) {
         ssd->dcl.ops = &display_listener_gl_ops;
         ssd->gl_unblock_bh = qemu_bh_new(qemu_spice_gl_unblock_bh, ssd);
         ssd->gl_unblock_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
-- 
2.9.3
