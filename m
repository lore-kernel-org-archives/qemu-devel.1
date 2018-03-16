Received: from eggs.gnu.org ([2001:4830:134:3::10]:40325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFH-0007Th-5M
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFD-0003l5-2Z
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:31 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:37687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ewvFC-0003ki-SW
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:26 -0400
Received: by mail-pf0-x242.google.com with SMTP id h11so4548144pfn.4
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:42:26 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 16 Mar 2018 12:41:07 -0700
Message-Id: <1521229281-73637-11-git-send-email-mjc@sifive.com>
In-Reply-To: <1521229281-73637-1-git-send-email-mjc@sifive.com>
References: <1521229281-73637-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v3 10/24] RISC-V: Hold rcu_read_lock when
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
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

>From reading other code that accesses memory regions directly,
it appears that the rcu_read_lock needs to be held. Note: the
original code for accessing RAM directly was added because
there is no other way to use atomic_cmpxchg on guest physical
address space.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/helper.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index 02cbcea..e71633a 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -209,6 +209,9 @@ restart:
                    as the PTE is no longer valid */
                 MemoryRegion *mr;
                 hwaddr l = sizeof(target_ulong), addr1;
+                enum { success, translate_fail, restart_walk} action = success;
+
+                rcu_read_lock();
                 mr = address_space_translate(cs->as, pte_addr,
                     &addr1, &l, false);
                 if (memory_access_is_direct(mr, true)) {
@@ -222,7 +225,7 @@ restart:
                     target_ulong old_pte =
                         atomic_cmpxchg(pte_pa, pte, updated_pte);
                     if (old_pte != pte) {
-                        goto restart;
+                        action = restart_walk;
                     } else {
                         pte = updated_pte;
                     }
@@ -230,7 +233,14 @@ restart:
                 } else {
                     /* misconfigured PTE in ROM (AD bits are not preset) or
                      * PTE is in IO space and can't be updated atomically */
-                    return TRANSLATE_FAIL;
+                    action = translate_fail;
+                }
+                rcu_read_unlock();
+
+                switch (action) {
+                    case success: break;
+                    case translate_fail: return TRANSLATE_FAIL;
+                    case restart_walk: goto restart;
                 }
             }
 
-- 
2.7.0
