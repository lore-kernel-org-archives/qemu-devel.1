Received: from eggs.gnu.org ([2001:4830:134:3::10]:46657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2T-0006DU-Gm
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2S-0003zJ-E1
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:21 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Aug 2017 17:03:54 +1000
Message-Id: <20170809070357.28723-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170809070357.28723-1-david@gibson.dropbear.id.au>
References: <20170809070357.28723-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/6] target/ppc: Implement TIDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

This adds a trivial implementation of the TIDR register added in
POWER9.  This isn't particularly important to qemu directly - it's
used by accelerator modules that we don't emulate.

However, since qemu isn't aware of it, its state is not synchronized
with KVM and therefore not migrated, which can be a problem.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/cpu.h            | 1 +
 target/ppc/translate_init.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6ee2a26a96..f6e5413fad 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1451,6 +1451,7 @@ void ppc_compat_add_property(Object *obj, const cha=
r *name,
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
=20
+    /* POWER9 Specific registers */
+    spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
+                     spr_read_generic, spr_write_generic,
+                     KVM_REG_PPC_TIDR, 0);
+
     /* env variables */
 #if !defined(CONFIG_USER_ONLY)
     env->slb_nr =3D 32;
--=20
2.13.4
