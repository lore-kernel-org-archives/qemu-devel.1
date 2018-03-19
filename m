Received: from eggs.gnu.org ([2001:4830:134:3::10]:33302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2CC-0001Qq-Av
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2CB-0002he-HF
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:19:56 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:40252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ey2CB-0002hH-BN
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:19:55 -0400
Received: by mail-pg0-x243.google.com with SMTP id g8so7423106pgv.7
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 14:19:55 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Mon, 19 Mar 2018 14:18:38 -0700
Message-Id: <1521494329-19546-16-git-send-email-mjc@sifive.com>
In-Reply-To: <1521494329-19546-1-git-send-email-mjc@sifive.com>
References: <1521494329-19546-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v4 15/26] RISC-V: Use memory_region_is_ram in
 pte update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

After reading cpu_physical_memory_write and friends, it seems
that memory_region_is_ram is a more appropriate interface,
and matches the intent of the code that is calling it.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index c68826b..cfbf1d1 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -237,7 +237,7 @@ restart:
                 rcu_read_lock();
                 mr = address_space_translate(cs->as, pte_addr,
                     &addr1, &l, false);
-                if (memory_access_is_direct(mr, true)) {
+                if (memory_region_is_ram(mr)) {
                     target_ulong *pte_pa =
                         qemu_map_ram_ptr(mr->ram_block, addr1);
 #if TCG_OVERSIZED_GUEST
-- 
2.7.0
