Received: from eggs.gnu.org ([2001:4830:134:3::10]:34814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1g9MML-0003ev-52
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1g9MBI-0008Gg-VG
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:26:05 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon,  8 Oct 2018 14:25:38 +1100
Message-Id: <20181008032539.6437-3-sjitindarsingh@gmail.com>
In-Reply-To: <20181008032539.6437-1-sjitindarsingh@gmail.com>
References: <20181008032539.6437-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V2 2/3] target/ppc: Add one reg id
 for ptcr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, paulus@ozlabs.org, sjitindarsingh@gmail.com

The ptcr (partition table control register) is used to store the address
and size of the partition table. For nested kvm-hv we have a level 1
guest register the location of it's partition table with the hypervisor.
Thus to support migration we need to be able to read this out of kvm
and restore it post migration.

Add the one reg id for the ptcr.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/translate_init.inc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 263e63cb03..487196800b 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8197,11 +8197,11 @@ static void gen_spr_power9_mmu(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     /* Partition Table Control */
-    spr_register_hv(env, SPR_PTCR, "PTCR",
-                    SPR_NOACCESS, SPR_NOACCESS,
-                    SPR_NOACCESS, SPR_NOACCESS,
-                    &spr_read_generic, &spr_write_ptcr,
-                    0x00000000);
+    spr_register_kvm_hv(env, SPR_PTCR, "PTCR",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_generic, &spr_write_ptcr,
+                        KVM_REG_PPC_PTCR, 0x00000000);
 #endif
 }
 
-- 
2.13.6
