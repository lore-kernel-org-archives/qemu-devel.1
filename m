Received: from eggs.gnu.org ([2001:4830:134:3::10]:58014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs5Xr-0007Ax-3U
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs5Pw-0008Ic-9t
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:05:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs5Pw-0008Gx-0X
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:05:48 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 14:05:34 +0200
Message-Id: <20180821120542.22610-5-kraxel@redhat.com>
In-Reply-To: <20180821120542.22610-1-kraxel@redhat.com>
References: <20180821120542.22610-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 04/12] sdl2: redraw correctly when scanout_mode
 enabled.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Tao Wu <lepton@google.com>

From: Tao Wu via Qemu-devel <qemu-devel@nongnu.org>

When scanout_mode enabled, surface is out of sync with actual screen.
In such case, we just call sdl2_gl_scanout_flush to do redraw. This
fixes bug reported in
https://lists.freedesktop.org/archives/virglrenderer-devel/2018-July/001330.html

Signed-off-by: Tao Wu <lepton@google.com>
Message-id: 20180726225900.180698-1-lepton@google.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-gl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 83b71853d1..1bf4542d8d 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -124,6 +124,11 @@ void sdl2_gl_redraw(struct sdl2_console *scon)
 {
     assert(scon->opengl);
 
+    if (scon->scanout_mode) {
+        /* sdl2_gl_scanout_flush actually only care about
+         * the first argument. */
+        return sdl2_gl_scanout_flush(&scon->dcl, 0, 0, 0, 0);
+    }
     if (scon->surface) {
         sdl2_gl_render_surface(scon);
     }
-- 
2.9.3
