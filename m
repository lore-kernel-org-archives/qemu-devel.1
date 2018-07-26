Received: from eggs.gnu.org ([2001:4830:134:3::10]:51893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1fipDz-0007kh-6j
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 18:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1fipDy-00083H-7O
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 18:59:11 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1fipDx-00080n-W0
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 18:59:10 -0400
Received: by mail-pf1-x443.google.com with SMTP id d14-v6so1054692pfo.3
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 15:59:09 -0700 (PDT)
From: Tao Wu <lepton@google.com>
Date: Thu, 26 Jul 2018 15:59:00 -0700
Message-Id: <20180726225900.180698-1-lepton@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] sdl2: redraw correctly when scanout_mode
 enabled.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: Tao Wu <lepton@google.com>

When scanout_mode enabled, surface is out of sync with actual screen.
In such case, we just call sdl2_gl_scanout_flush to do redraw. This
fixes bug reported in
https://lists.freedesktop.org/archives/virglrenderer-devel/2018-July/001330.html

Signed-off-by: Tao Wu <lepton@google.com>
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
2.18.0.345.g5c9ce644c3-goog
