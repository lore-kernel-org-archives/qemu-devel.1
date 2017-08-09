Received: from eggs.gnu.org ([2001:4830:134:3::10]:46686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2V-0006Di-HJ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2S-0003zE-Dw
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Aug 2017 17:03:55 +1000
Message-Id: <20170809070357.28723-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170809070357.28723-1-david@gibson.dropbear.id.au>
References: <20170809070357.28723-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/6] target/ppc: Add stub implementation of the
 PSSCR
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

The PSSCR register added in POWER9 controls certain power saving mode
behaviours.  Mostly, it's not relevant to TCG, however because qemu
doesn't know about it yet, it doesn't synchronize the state with KVM,
and thus it doesn't get migrated.

To fix that, this adds a minimal stub implementation of the register.
This isn't complete, even to the extent that an implementation is
possible in TCG, just enough to get migration working.  We need to
come back later and at least properly filter the various fields in the
register based on privilege level.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/cpu.h            | 1 +
 target/ppc/translate_init.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f6e5413fad..46d3dd88f6 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1771,6 +1771,7 @@ void ppc_compat_add_property(Object *obj, const cha=
r *name,
 #define SPR_IC                (0x350)
 #define SPR_VTB               (0x351)
 #define SPR_MMCRC             (0x353)
+#define SPR_PSSCR             (0x357)
 #define SPR_440_INV0          (0x370)
 #define SPR_440_INV1          (0x371)
 #define SPR_440_INV2          (0x372)
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 94800cd29d..8fb407ed73 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8846,6 +8846,11 @@ static void init_proc_POWER9(CPUPPCState *env)
                      spr_read_generic, spr_write_generic,
                      KVM_REG_PPC_TIDR, 0);
=20
+    /* FIXME: Filter fields properly based on privilege level */
+    spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
+                        spr_read_generic, spr_write_generic,
+                        KVM_REG_PPC_PSSCR, 0);
+
     /* env variables */
 #if !defined(CONFIG_USER_ONLY)
     env->slb_nr =3D 32;
--=20
2.13.4
