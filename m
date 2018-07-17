Received: from eggs.gnu.org ([2001:4830:134:3::10]:34871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dayeol@berkeley.edu>) id 1ffXTn-0002CG-C1
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dayeol@berkeley.edu>) id 1ffXTj-0000wm-Dl
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:25:55 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:42695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dayeol@berkeley.edu>) id 1ffXTj-0000we-76
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 17:25:51 -0400
Received: by mail-qt0-x243.google.com with SMTP id z8-v6so2262006qto.9
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 14:25:51 -0700 (PDT)
From: Dayeol Lee <dayeol@berkeley.edu>
Date: Tue, 17 Jul 2018 21:25:45 +0000
Message-Id: <1531862745-8394-1-git-send-email-dayeol@berkeley.edu>
Subject: [Qemu-devel] [PATCH] target/riscv/pmp.c: Fix PMP range boundary
 address bug
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

A wrong address is passed to `pmp_is_in_range` while checking if a
memory access is within a PMP range.
Since the ending address of the pmp range (i.e., pmp_state.addr[i].ea)
is set to the last address in the range (i.e., pmp base + pmp size - 1),
memory accesses containg the last address in the range will always fail.

For example, assume that a PMP range is 4KB from 0x87654000 such that
the last address within the range is 0x87654fff.
1-byte access to 0x87654fff should be considered to be fully inside the
PMP range.
However the access now fails and complains partial inclusion because
pmp_is_in_range(env, i, addr + size) returns 0 whereas
pmp_is_in_range(env, i, addr) returns 1.

Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index c4c6b09..459e556 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -245,7 +245,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
          from low to high */
     for (i = 0; i < MAX_RISCV_PMPS; i++) {
         s = pmp_is_in_range(env, i, addr);
-        e = pmp_is_in_range(env, i, addr + size);
+        e = pmp_is_in_range(env, i, addr + size - 1);
 
         /* partially inside */
         if ((s + e) == 1) {
-- 
2.7.4
