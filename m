Received: from eggs.gnu.org ([2001:4830:134:3::10]:51664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dexgt-0001tS-7c
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dexgo-000349-AL
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:08:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  8 Aug 2017 16:08:16 +1000
Message-Id: <20170808060817.2832-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170808060817.2832-1-david@gibson.dropbear.id.au>
References: <20170808060817.2832-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH for-2.10 1/2] target/ppc: Implement TIDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org
Cc: mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, agraf@suse.de, David Gibson <david@gibson.dropbear.id.au>

This adds a trivial implementation of the TIDR register added in
POWER9.  This isn't particularly important to qemu directly - it's
used by accelerator modules that we don't emulate.

However, since qemu isn't aware of it, its state is not synchronized
with KVM and therefore not migrated, which can be a problem.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h            | 1 +
 target/ppc/translate_init.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6ee2a26a96..f6e5413fad 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1451,6 +1451,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_TEXASR            (0x082)
 #define SPR_TEXASRU           (0x083)
 #define SPR_UCTRL             (0x088)
+#define SPR_TIDR              (0x090)
 #define SPR_MPC_CMPA          (0x090)
 #define SPR_MPC_CMPB          (0x091)
 #define SPR_MPC_CMPC          (0x092)
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 01723bdfec..94800cd29d 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8841,6 +8841,11 @@ static void init_proc_POWER9(CPUPPCState *env)
     gen_spr_power8_book4(env);
     gen_spr_power8_rpr(env);
 
+    /* POWER9 Specific registers */
+    spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
+                     spr_read_generic, spr_write_generic,
+                     KVM_REG_PPC_TIDR, 0);
+
     /* env variables */
 #if !defined(CONFIG_USER_ONLY)
     env->slb_nr = 32;
-- 
2.13.4
