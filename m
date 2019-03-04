Received: from eggs.gnu.org ([209.51.188.92]:42025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h0s2T-0002Yo-0n
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h0s2S-0004t5-7x
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:10:08 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:54875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h0s2R-0004rk-Pz
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:10:08 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Mon,  4 Mar 2019 19:09:16 +0100
Message-Id: <20190304180920.21534-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/5] lsi: use ldn_le_p()/stn_le_p()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sven Schnelle <svens@stackframe.org>, Fam Zheng <fam@euphon.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 25c6926039..6d280f8b77 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -289,8 +289,7 @@ typedef struct {
     uint8_t sbr;
     uint32_t adder;
 
-    /* Script ram is stored as 32-bit words in host byteorder.  */
-    uint32_t script_ram[2048];
+    uint8_t script_ram[8192];
 } LSIState;
 
 #define TYPE_LSI53C810  "lsi53c810"
@@ -2077,29 +2076,14 @@ static void lsi_ram_write(void *opaque, hwaddr addr,
                           uint64_t val, unsigned size)
 {
     LSIState *s = opaque;
-    uint32_t newval;
-    uint32_t mask;
-    int shift;
-
-    newval = s->script_ram[addr >> 2];
-    shift = (addr & 3) * 8;
-    mask = ((uint64_t)1 << (size * 8)) - 1;
-    newval &= ~(mask << shift);
-    newval |= val << shift;
-    s->script_ram[addr >> 2] = newval;
+    stn_le_p(s->script_ram + addr, size, val);
 }
 
 static uint64_t lsi_ram_read(void *opaque, hwaddr addr,
                              unsigned size)
 {
     LSIState *s = opaque;
-    uint32_t val;
-    uint32_t mask;
-
-    val = s->script_ram[addr >> 2];
-    mask = ((uint64_t)1 << (size * 8)) - 1;
-    val >>= (addr & 3) * 8;
-    return val & mask;
+    return ldn_le_p(s->script_ram + addr, size);
 }
 
 static const MemoryRegionOps lsi_ram_ops = {
@@ -2242,7 +2226,7 @@ static const VMStateDescription vmstate_lsi_scsi = {
         VMSTATE_BUFFER_UNSAFE(scratch, LSIState, 0, 18 * sizeof(uint32_t)),
         VMSTATE_UINT8(sbr, LSIState),
 
-        VMSTATE_BUFFER_UNSAFE(script_ram, LSIState, 0, 2048 * sizeof(uint32_t)),
+        VMSTATE_BUFFER_UNSAFE(script_ram, LSIState, 0, 8192),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.20.1
