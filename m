Received: from eggs.gnu.org ([2001:4830:134:3::10]:58705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe6-00029h-JP
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe1-0003Fj-Ec
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:37 +1000
Message-Id: <20170908103558.31632-20-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 19/40] booke206: allow to specify an mmucfg
 value at the init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, KONRAD Frederic <frederic.konrad@adacore.com>, David Gibson <david@gibson.dropbear.id.au>

From: KONRAD Frederic <frederic.konrad@adacore.com>

This allows to init the MMUCFG SPR with a non NULL value.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 1586e28055..4104629df7 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -1842,7 +1842,7 @@ static inline uint32_t gen_tlbncfg(uint32_t assoc, uint32_t minsize,
 
 /* BookE 2.06 storage control registers */
 static void gen_spr_BookE206(CPUPPCState *env, uint32_t mas_mask,
-                              uint32_t *tlbncfg)
+                             uint32_t *tlbncfg, uint32_t mmucfg)
 {
 #if !defined(CONFIG_USER_ONLY)
     const char *mas_names[8] = {
@@ -1886,7 +1886,7 @@ static void gen_spr_BookE206(CPUPPCState *env, uint32_t mas_mask,
     spr_register(env, SPR_MMUCFG, "MMUCFG",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, SPR_NOACCESS,
-                 0x00000000); /* TOFIX */
+                 mmucfg);
     switch (env->nb_ways) {
     case 4:
         spr_register(env, SPR_BOOKE_TLB3CFG, "TLB3CFG",
@@ -4615,7 +4615,7 @@ static void init_proc_e200(CPUPPCState *env)
                  &spr_read_spefscr, &spr_write_spefscr,
                  0x00000000);
     /* Memory management */
-    gen_spr_BookE206(env, 0x0000005D, NULL);
+    gen_spr_BookE206(env, 0x0000005D, NULL, 0);
     /* XXX : not implemented */
     spr_register(env, SPR_HID0, "HID0",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -4900,6 +4900,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
                     | 0x0020; /* 32 kb */
     uint32_t l1cfg1 = 0x3800  /* 8 ways */
                     | 0x0020; /* 32 kb */
+    uint32_t mmucfg = 0;
 #if !defined(CONFIG_USER_ONLY)
     int i;
 #endif
@@ -4974,7 +4975,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
     default:
         cpu_abort(CPU(cpu), "Unknown CPU: " TARGET_FMT_lx "\n", env->spr[SPR_PVR]);
     }
-    gen_spr_BookE206(env, 0x000000DF, tlbncfg);
+    gen_spr_BookE206(env, 0x000000DF, tlbncfg, mmucfg);
     /* XXX : not implemented */
     spr_register(env, SPR_HID0, "HID0",
                  SPR_NOACCESS, SPR_NOACCESS,
-- 
2.13.5
