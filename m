Received: from eggs.gnu.org ([2001:4830:134:3::10]:43587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFQ-0005KG-UX
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFO-00041N-Co
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:20 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:45 +1100
Message-Id: <20181108121646.26173-22-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/22] target/ppc: Add one reg id for ptcr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The ptcr (partition table control register) is used to store the address
and size of the partition table. For nested kvm-hv we have a level 1
guest register the location of it's partition table with the hypervisor.
Thus to support migration we need to be able to read this out of kvm
and restore it post migration.

Add the one reg id for the ptcr.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.inc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 9a2d4a9835..168d0cec28 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8214,11 +8214,11 @@ static void gen_spr_power9_mmu(CPUPPCState *env)
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
=20
--=20
2.19.1
