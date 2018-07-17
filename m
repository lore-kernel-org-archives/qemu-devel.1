Received: from eggs.gnu.org ([2001:4830:134:3::10]:58753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dayeol@berkeley.edu>) id 1ffXA8-0002jI-W6
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dayeol@berkeley.edu>) id 1ffXA4-0003NL-Oe
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:05:36 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dayeol@berkeley.edu>) id 1ffXA4-0003Mu-IR
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:05:32 -0400
Received: by mail-qt0-x244.google.com with SMTP id m13-v6so2227295qth.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 14:05:32 -0700 (PDT)
From: Dayeol Lee <dayeol@berkeley.edu>
Date: Tue, 17 Jul 2018 21:05:13 +0000
Message-Id: <1531861513-6549-1-git-send-email-dayeol@berkeley.edu>
Subject: [Qemu-devel] [PATCH] target/riscv/pmp.c: Fix PMP NAPOT decoding bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, Dayeol Lee <dayeol@berkeley.edu>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

According to the RISC-V priv. v1.10 ISA document,
pmpaddr register stores (base_addr | (size/2 - 1)) >> 2 for a
NAPOT-encoded address.
However, the current code decodes (base_addr | (size - 1)) >> 3 which
leads to a wrong base address and size.

Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index f432f3b..c4c6b09 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -138,7 +138,7 @@ static void pmp_decode_napot(target_ulong a, target_ulong *sa, target_ulong *ea)
         return;
     } else {
         target_ulong t1 = ctz64(~a);
-        target_ulong base = (a & ~(((target_ulong)1 << t1) - 1)) << 3;
+        target_ulong base = (a & ~(((target_ulong)1 << t1) - 1)) << 2;
         target_ulong range = ((target_ulong)1 << (t1 + 3)) - 1;
         *sa = base;
         *ea = base + range;
-- 
2.7.4
