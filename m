Received: from eggs.gnu.org ([2001:4830:134:3::10]:57495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dekKT-0007y6-Un
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dekKP-0005nj-69
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:52:30 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:44810
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dekKO-0005mt-W5
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:52:25 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Mon,  7 Aug 2017 17:50:47 +0200
Message-Id: <1502121048-1816-4-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1502121048-1816-1-git-send-email-frederic.konrad@adacore.com>
References: <1502121048-1816-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH for-2.11 3/4] booke206: allow to specify an
 mmucfg value at the init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, agraf@suse.de
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, frederic.konrad@adacore.com

This allows to init the MMUCFG SPR with a non NULL value.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 target/ppc/translate_init.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 01723bd..2627cbe 100644
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
1.8.3.1
