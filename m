Received: from eggs.gnu.org ([208.118.235.92]:40222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eznki-0006kW-Gb
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezngU-0003kN-Lx
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:18:52 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:46149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ezngU-0003kB-Fm
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:14:30 -0400
Received: by mail-pl0-x243.google.com with SMTP id f5-v6so9367780plj.13
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 11:14:30 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 11:13:31 -0700
Message-Id: <1521915220-65389-6-git-send-email-mjc@sifive.com>
In-Reply-To: <1521915220-65389-1-git-send-email-mjc@sifive.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v6 14/26] RISC-V: Use memory_region_is_ram in
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
index 9010620..b2e3f45 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -234,7 +234,7 @@ restart:
                 hwaddr l = sizeof(target_ulong), addr1;
                 mr = address_space_translate(cs->as, pte_addr,
                     &addr1, &l, false);
-                if (memory_access_is_direct(mr, true)) {
+                if (memory_region_is_ram(mr)) {
                     target_ulong *pte_pa =
                         qemu_map_ram_ptr(mr->ram_block, addr1);
 #if TCG_OVERSIZED_GUEST
-- 
2.7.0
