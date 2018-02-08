Received: from eggs.gnu.org ([2001:4830:134:3::10]:42182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejqqK-0006ak-Fi
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejqqG-0007mr-Gt
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:22:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejqqG-0007mX-CZ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:22:40 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  8 Feb 2018 19:22:23 +0100
Message-Id: <20180208182223.2562-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] g364fb: switch to using DirtyBitmapSnapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

This removes the last user of memory_region_test_and_clear_dirty
outside memory.c.

Cc: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        Untested... not sure where to get mips_bios.bin, or a kernel
        that works with -M magnum.  Can anybody help?  I'd like to
        get rid of memory_region_test_and_clear_dirty.

 hw/display/g364fb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 86557d14a9..86452de780 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -62,15 +62,15 @@ typedef struct G364State {
=20
 #define G364_PAGE_SIZE 4096
=20
-static inline int check_dirty(G364State *s, ram_addr_t page)
+static inline int check_dirty(G364State *s, DirtyBitmapSnapshot *snap, r=
am_addr_t page)
 {
-    return memory_region_test_and_clear_dirty(&s->mem_vram, page, G364_P=
AGE_SIZE,
-                                              DIRTY_MEMORY_VGA);
+    return memory_region_snapshot_get_dirty(&s->mem_vram, snap, page, G3=
64_PAGE_SIZE);
 }
=20
 static void g364fb_draw_graphic8(G364State *s)
 {
     DisplaySurface *surface =3D qemu_console_surface(s->con);
+    DirtyBitmapSnapshot *snap;
     int i, w;
     uint8_t *vram;
     uint8_t *data_display, *dd;
@@ -122,8 +122,10 @@ static void g364fb_draw_graphic8(G364State *s)
     vram =3D s->vram + s->top_of_screen;
     /* XXX: out of range in vram? */
     data_display =3D dd =3D surface_data(surface);
+    snap =3D memory_region_snapshot_and_clear_dirty(&s->mem_vram, 0, s->=
vram_size,
+                                                  DIRTY_MEMORY_VGA);
     while (y < s->height) {
-        if (check_dirty(s, page)) {
+        if (check_dirty(s, snap, page)) {
             if (y < ymin)
                 ymin =3D ymax =3D y;
             if (x < xmin)
--=20
2.14.3
