Received: from eggs.gnu.org ([2001:4830:134:3::10]:47046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJT5-0006M8-5j
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJT0-0003TS-91
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:45:51 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJT0-0003TJ-34
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:45:46 -0500
Received: by mail-pl0-x241.google.com with SMTP id m22-v6so9033222pls.5
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:45:45 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:43:45 +1300
Message-Id: <1520369037-37977-11-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369037-37977-1-git-send-email-mjc@sifive.com>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 10/22] RISC-V: Hold rcu_read_lock when
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
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches directly <patches@groups.riscv.org>, Stefan O'Rear <sorear2@gmail.com>

>From reading other code that accesses memory regions directly,
it appears that the rcu_read_lock needs to be held. Note: the
original code for accessing RAM directly was added because
there is no other way to use atomic_cmpxchg easily.

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Stefan O'Rear <sorear2@gmail.com>
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
