Received: from eggs.gnu.org ([2001:4830:134:3::10]:49160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dVPuh-0000oz-T4
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 18:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dVPue-0005v5-NR
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 18:15:19 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dVPue-0005th-Ir
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 18:15:16 -0400
Received: by mail-yw0-f196.google.com with SMTP id a12so2118619ywh.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 15:15:16 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 12 Jul 2017 18:14:14 -0400
Message-Id: <20170712221414.3867-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH] tcg/aarch64: Use ADR for shorter jumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

Use ADR instruction for shorter jumps.

I was going through rth's email and realized that I should have done
this the first time.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 tcg/aarch64/tcg-target.inc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 04bc369a92..5121ebc1a1 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -886,12 +886,16 @@ void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
         i1 = I3206_B | ((offset >> 2) & 0x3ffffff);
         i2 = NOP;
     } else {
-        offset = (addr >> 12) - (jmp_addr >> 12);
+        if (offset == sextract64(offset, 0, 21)) {
+            i1 = I3406_ADR;
+            i2 = NOP;
+        } else {
+            offset = (addr >> 12) - (jmp_addr >> 12);
 
-        /* patch ADRP */
-        i1 = I3406_ADRP | (offset & 3) << 29 | (offset & 0x1ffffc) << (5 - 2) | rd;
-        /* patch ADDI */
-        i2 = I3401_ADDI | rt << 31 | (addr & 0xfff) << 10 | rd << 5 | rd;
+            i1 = I3406_ADRP;
+            i2 = I3401_ADDI | rt << 31 | (addr & 0xfff) << 10 | rd << 5 | rd;
+        }
+        i1 |= (offset & 3) << 29 | (offset & 0x1ffffc) << (5 - 2) | rd;
     }
     pair = (uint64_t)i2 << 32 | i1;
     atomic_set((uint64_t *)jmp_addr, pair);
-- 
2.13.0
