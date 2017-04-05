Received: from eggs.gnu.org ([2001:4830:134:3::10]:57311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQD-0002Mx-Ac
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ6-0005YH-Al
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:07 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42829
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvgQ6-0005XO-3y
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:02 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  5 Apr 2017 09:35:21 +0100
Message-Id: <1491381329-3995-7-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 06/14] tcx: ensure tcx_set_dirty() also
 invalidates the 24-bit plane and cplane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/tcx.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index d24466f..6817bd2 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -96,6 +96,13 @@ typedef struct TCXState {
 static void tcx_set_dirty(TCXState *s, ram_addr_t addr, int len)
 {
     memory_region_set_dirty(&s->vram_mem, addr, len);
+
+    if (s->depth == 24) {
+        memory_region_set_dirty(&s->vram_mem, s->vram24_offset + addr * 4,
+                                len * 4);
+        memory_region_set_dirty(&s->vram_mem, s->cplane_offset + addr * 4,
+                                len * 4);
+    }
 }
 
 static inline int tcx24_check_dirty(TCXState *s, ram_addr_t page,
-- 
1.7.10.4
