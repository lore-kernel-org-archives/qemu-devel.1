Received: from eggs.gnu.org ([2001:4830:134:3::10]:52876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1f0eJF-00026j-Cs
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1f0eJC-0005BB-4t
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:26:01 -0400
Received: from p3plsmtpa09-06.prod.phx3.secureserver.net
	([173.201.193.235]:35100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1f0eJB-00058x-Vc
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:25:58 -0400
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Mon, 26 Mar 2018 22:25:26 -0400
Message-ID: <1827502.IR1e2a4R2z@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Qemu-devel] PATCH [02/02] leon3: add smp cpu index to asr17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

>From 1ba3070160d5baab73ba9e500ed58d0ace7121aa Mon Sep 17 00:00:00 2001
From: Steven Seeger <steven.seeger@flightsystems.net>
Date: Mon, 26 Mar 2018 20:50:53 -0400
Subject: [PATCH 2/6] leon3: add smp cpu index to asr17

Signed-off-by: Steven Seeger <steven.seeger@flightsystems.net>
---
 target/sparc/helper.c    | 5 +++++
 target/sparc/helper.h    | 1 +
 target/sparc/translate.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 1d854890b4..8304c3e3f3 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -117,6 +117,11 @@ target_ulong helper_udiv_cc(CPUSPARCState *env, 
target_ulong a, target_ulong b)
     return do_udiv(env, a, b, 1, GETPC());
 }
 
+target_ulong helper_asr17(CPUSPARCState *env, target_ulong input)
+{
+    return input | (CPU(sparc_env_get_cpu(env))->cpu_index << 28);
+}
+
 static target_ulong do_sdiv(CPUSPARCState *env, target_ulong a,
                             target_ulong b, int cc, uintptr_t ra)
 {
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index b8f1e78c75..fe6554fd76 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -166,3 +166,4 @@ VIS_CMPHELPER(cmpne)
 #undef VIS_CMPHELPER
 DEF_HELPER_1(compute_psr, void, env)
 DEF_HELPER_FLAGS_1(compute_C_icc, TCG_CALL_NO_WG_SE, i32, env)
+DEF_HELPER_2(asr17, tl, env, tl)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ab8d0a0c72..de482952e1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3440,6 +3440,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned 
int insn)
                         TCGv t = gen_dest_gpr(dc, rd);
                         /* Read Asr17 for a Leon3 monoprocessor */
                         tcg_gen_movi_tl(t, (1 << 8) | (dc->def->nwindows - 
1));
+                        gen_helper_asr17(t, cpu_env, t);
                         gen_store_gpr(dc, rd, t);
                         break;
                     }
-- 
2.16.1
