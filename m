Received: from eggs.gnu.org ([2001:4830:134:3::10]:47161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJTI-0006Zs-1J
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJTH-0003af-7k
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:46:04 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:40904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJTH-0003aT-24
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:46:03 -0500
Received: by mail-pl0-x242.google.com with SMTP id i6-v6so12545788plt.7
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:46:02 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:43:50 +1300
Message-Id: <1520369037-37977-16-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369037-37977-1-git-send-email-mjc@sifive.com>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 15/22] RISC-V: Use memory_region_is_ram in
 atomic pte
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches update <patches@groups.riscv.org>

After reading cpu_physical_memory_write and friends, it seems
that memory_region_is_ram is a more appropriate interface,
and matches the intent of the code that is calling it.

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index 2165ecb..88551be 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -235,7 +235,7 @@ restart:
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
