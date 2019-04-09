Received: from eggs.gnu.org ([209.51.188.92]:56286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1hDoba-0004wy-1M
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1hDobZ-00078w-4s
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:07:54 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:28595)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hDobY-00071L-Q0
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:07:53 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 09 Apr 2019 12:56:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190409110732.5C5FF7465DB@zero.eik.bme.hu>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ati-vga: Fix check for blt outside vram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Andrew Randrianasulu <randrianasulu@gmail.com>

Fix the check preventing calling pixman functions that would access
memory outside allocated vram. The r128 X driver sometimes seem to try
blits that span outside vram, this check prevents crashing QEMU in
that case. (The r128 X driver may have problems even on real hardware
so I'm not sure if it's a client bug or emulation problem but at least
QEMU should survive.)

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>
---
 hw/display/ati_2d.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index bc98ba6eeb..fe3ae14864 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -79,10 +79,10 @@ void ati_2d_blt(ATIVGAState *s)
                 s->regs.dst_width, s->regs.dst_height);
         end =3D s->vga.vram_ptr + s->vga.vram_size;
         if (src_bits >=3D end || dst_bits >=3D end ||
-            src_bits + (s->regs.src_y + s->regs.dst_height) * src_stride=
 +
-            s->regs.src_x >=3D end ||
-            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_stride=
 +
-            s->regs.dst_x >=3D end) {
+            src_bits + s->regs.src_x + (s->regs.src_y + s->regs.dst_heig=
ht) *
+            src_stride * sizeof(uint32_t) >=3D end ||
+            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_heig=
ht) *
+            dst_stride * sizeof(uint32_t) >=3D end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n=
");
             return;
         }
@@ -140,8 +140,8 @@ void ati_2d_blt(ATIVGAState *s)
                 filler);
         end =3D s->vga.vram_ptr + s->vga.vram_size;
         if (dst_bits >=3D end ||
-            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_stride=
 +
-            s->regs.dst_x >=3D end) {
+            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_heig=
ht) *
+            dst_stride * sizeof(uint32_t) >=3D end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n=
");
             return;
         }
--=20
2.13.7
