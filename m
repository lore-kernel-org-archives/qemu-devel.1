Received: from eggs.gnu.org ([2001:4830:134:3::10]:55729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9QX-0004AP-9b
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9QW-0006xq-Gf
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:41 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:46603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eu9QW-0006xZ-9g
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:40 -0500
Received: by mail-pg0-x241.google.com with SMTP id r26so3113105pgv.13
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 20:14:40 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri,  9 Mar 2018 17:12:32 +1300
Message-Id: <1520568765-58189-11-git-send-email-mjc@sifive.com>
In-Reply-To: <1520568765-58189-1-git-send-email-mjc@sifive.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 10/23] RISC-V: Hold rcu_read_lock when
 accessing memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Stefan O'Rear <sorear2@gmail.com>, Palmer Dabbelt <palmer@sifive.com>

>From reading other code that accesses memory regions directly,
it appears that the rcu_read_lock needs to be held. Note: the
original code for accessing RAM directly was added because
there is no other way to use atomic_cmpxchg on guest physical
address space.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
CC: Stefan O'Rear <sorear2@gmail.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index 02cbcea..228933c 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -209,6 +209,7 @@ restart:
                    as the PTE is no longer valid */
                 MemoryRegion *mr;
                 hwaddr l = sizeof(target_ulong), addr1;
+                rcu_read_lock();
                 mr = address_space_translate(cs->as, pte_addr,
                     &addr1, &l, false);
                 if (memory_access_is_direct(mr, true)) {
@@ -222,16 +223,19 @@ restart:
                     target_ulong old_pte =
                         atomic_cmpxchg(pte_pa, pte, updated_pte);
                     if (old_pte != pte) {
+                        rcu_read_unlock();
                         goto restart;
                     } else {
                         pte = updated_pte;
                     }
 #endif
                 } else {
+                    rcu_read_unlock();
                     /* misconfigured PTE in ROM (AD bits are not preset) or
                      * PTE is in IO space and can't be updated atomically */
                     return TRANSLATE_FAIL;
                 }
+                rcu_read_unlock();
             }
 
             /* for superpage mappings, make a fake leaf PTE for the TLB's
-- 
2.7.0
