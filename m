Received: from eggs.gnu.org ([2001:4830:134:3::10]:55337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1U02-0002jb-6q
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1U01-0002qV-9V
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:33:06 -0400
Received: from chuckie.co.uk ([82.165.15.123]:50209
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1U01-0002qE-3Q
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:33:05 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 21 Apr 2017 09:28:46 +0100
Message-Id: <1492763327-12742-13-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 12/13] tcx: use tcx_set_dirty() for
 accelerated ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Rather than calling memory_region_set_dirty() directly, make sure that we call
tcx_set_dirty() instead. This ensures that the 24-bit plane and cplane are
also invalidated correctly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/tcx.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 6da6dfb..3f00735 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -525,7 +525,7 @@ static void tcx_stip_writel(void *opaque, hwaddr addr,
                 val <<= 1;
             }
         }
-        memory_region_set_dirty(&s->vram_mem, addr, 32);
+        tcx_set_dirty(s, addr, 32);
     }
 }
 
@@ -558,7 +558,7 @@ static void tcx_rstip_writel(void *opaque, hwaddr addr,
                 val <<= 1;
             }
         }
-        memory_region_set_dirty(&s->vram_mem, addr, 32);
+        tcx_set_dirty(s, addr, 32);
     }
 }
 
@@ -616,7 +616,7 @@ static void tcx_blit_writel(void *opaque, hwaddr addr,
                 memcpy(&s->vram24[addr], &s->vram24[adsr], len * 4);
             }
         }
-        memory_region_set_dirty(&s->vram_mem, addr, len);
+        tcx_set_dirty(s, addr, len);
     }
 }
 
@@ -650,7 +650,7 @@ static void tcx_rblit_writel(void *opaque, hwaddr addr,
                 memcpy(&s->cplane[addr], &s->cplane[adsr], len * 4);
             }
         }
-        memory_region_set_dirty(&s->vram_mem, addr, len);
+        tcx_set_dirty(s, addr, len);
     }
 }
 
@@ -687,7 +687,7 @@ static void tcx_invalidate_cursor_position(TCXState *s)
     start = ymin * 1024;
     end   = ymax * 1024;
 
-    memory_region_set_dirty(&s->vram_mem, start, end-start);
+    tcx_set_dirty(s, start, end - start);
 }
 
 static uint64_t tcx_thc_readl(void *opaque, hwaddr addr,
-- 
1.7.10.4
