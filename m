Received: from eggs.gnu.org ([209.51.188.92]:60868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODc-00078i-KC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODb-0003I7-Q7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:54940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODb-0003GD-G5
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id f3so5367451wmj.4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:56:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:26 +0100
Message-Id: <1552323335-46779-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 22/31] lsi: use ldn_le_p()/stn_le_p()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>

From: Sven Schnelle <svens@stackframe.org>

Instead of using the open-coded versions, use the helper already
present as this makes the code easier to read and less error-prone.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190305195519.24303-2-svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index bcff859..402b785 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -289,8 +289,7 @@ typedef struct {
     uint8_t sbr;
     uint32_t adder;
 
-    /* Script ram is stored as 32-bit words in host byteorder.  */
-    uint32_t script_ram[2048];
+    uint8_t script_ram[2048 * sizeof(uint32_t)];
 } LSIState;
 
 #define TYPE_LSI53C810  "lsi53c810"
@@ -2079,29 +2078,14 @@ static void lsi_ram_write(void *opaque, hwaddr addr,
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
@@ -2244,7 +2228,7 @@ static const VMStateDescription vmstate_lsi_scsi = {
         VMSTATE_BUFFER_UNSAFE(scratch, LSIState, 0, 18 * sizeof(uint32_t)),
         VMSTATE_UINT8(sbr, LSIState),
 
-        VMSTATE_BUFFER_UNSAFE(script_ram, LSIState, 0, 2048 * sizeof(uint32_t)),
+        VMSTATE_BUFFER_UNSAFE(script_ram, LSIState, 0, 8192),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
1.8.3.1
