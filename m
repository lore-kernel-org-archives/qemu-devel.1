Received: from eggs.gnu.org ([209.51.188.92]:60099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gvn9B-0006fC-BA
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gvn9A-0004Le-Ir
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:56:05 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:43414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gvn94-000494-TC
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:56:00 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 18 Feb 2019 18:55:29 +0100
Message-Id: <20190218175529.11237-2-svens@stackframe.org>
In-Reply-To: <20190218175529.11237-1-svens@stackframe.org>
References: <20190218175529.11237-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] lsi: use ldn_le_p()/stn_le_p()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Sven Schnelle <svens@stackframe.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index c493e3c4c7..93c4434bfb 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2078,29 +2078,14 @@ static void lsi_ram_write(void *opaque, hwaddr addr,
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
+    stn_le_p(((void*)s->script_ram) + addr, size, val);
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
+    return ldn_le_p(((void *)s->script_ram) + addr, size);
 }
 
 static const MemoryRegionOps lsi_ram_ops = {
-- 
2.20.1
