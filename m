Received: from eggs.gnu.org ([209.51.188.92]:46052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hBJhS-0007Nl-NJ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hBJhR-00072Q-8L
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:43:38 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35227 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hBJhP-0006zn-OT
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:43:36 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Tue,  2 Apr 2019 15:43:25 +0200
Message-Id: <1554212605-16457-6-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 5/5] target/mips: Refactor and fix
 INSERT.<B|H|W|D> instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

The old version of the helper for the INSERT.<B|H|W|D> MSA instructions
has been replaced with four helpers that don't use switch, and change
the endianness of the given index, when executed on a big endian host.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/helper.h     |  5 +++-
 target/mips/msa_helper.c | 65 ++++++++++++++++++++++++++++++++++++------------
 target/mips/translate.c  | 19 +++++++++++++-
 3 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 8b6703c..82f6a40 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -875,7 +875,6 @@ DEF_HELPER_5(msa_hsub_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_sldi_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_splati_df, void, env, i32, i32, i32, i32)
 
-DEF_HELPER_5(msa_insert_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_insve_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_3(msa_ctcmsa, void, env, tl, i32)
 DEF_HELPER_2(msa_cfcmsa, tl, env, i32)
@@ -942,6 +941,10 @@ DEF_HELPER_4(msa_copy_s_d, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_copy_u_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_copy_u_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_copy_u_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_insert_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_insert_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_insert_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_insert_d, void, env, i32, i32, i32)
 
 DEF_HELPER_4(msa_fclass_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ftrunc_s_df, void, env, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index d5bf4dc..d5c3842 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1323,28 +1323,61 @@ void helper_msa_copy_u_w(CPUMIPSState *env, uint32_t rd,
     env->active_tc.gpr[rd] = (uint32_t)env->active_fpu.fpr[ws].wr.w[n];
 }
 
-void helper_msa_insert_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void helper_msa_insert_b(CPUMIPSState *env, uint32_t wd,
                           uint32_t rs_num, uint32_t n)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     target_ulong rs = env->active_tc.gpr[rs_num];
+    n %= 16;
+#if defined(HOST_WORDS_BIGENDIAN)
+    if (n < 8) {
+        n = 8 - n - 1;
+    } else {
+        n = 24 - n - 1;
+    }
+#endif
+    pwd->b[n] = (int8_t)rs;
+}
 
-    switch (df) {
-    case DF_BYTE:
-        pwd->b[n] = (int8_t)rs;
-        break;
-    case DF_HALF:
-        pwd->h[n] = (int16_t)rs;
-        break;
-    case DF_WORD:
-        pwd->w[n] = (int32_t)rs;
-        break;
-    case DF_DOUBLE:
-        pwd->d[n] = (int64_t)rs;
-        break;
-    default:
-        assert(0);
+void helper_msa_insert_h(CPUMIPSState *env, uint32_t wd,
+                          uint32_t rs_num, uint32_t n)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    target_ulong rs = env->active_tc.gpr[rs_num];
+    n %= 8;
+#if defined(HOST_WORDS_BIGENDIAN)
+    if (n < 4) {
+        n = 4 - n - 1;
+    } else {
+        n = 12 - n - 1;
+    }
+#endif
+    pwd->h[n] = (int16_t)rs;
+}
+
+void helper_msa_insert_w(CPUMIPSState *env, uint32_t wd,
+                          uint32_t rs_num, uint32_t n)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    target_ulong rs = env->active_tc.gpr[rs_num];
+    n %= 4;
+#if defined(HOST_WORDS_BIGENDIAN)
+    if (n < 2) {
+        n = 2 - n - 1;
+    } else {
+        n = 6 - n - 1;
     }
+#endif
+    pwd->w[n] = (int32_t)rs;
+}
+
+void helper_msa_insert_d(CPUMIPSState *env, uint32_t wd,
+                          uint32_t rs_num, uint32_t n)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    target_ulong rs = env->active_tc.gpr[rs_num];
+    n %= 2;
+    pwd->d[n] = (int64_t)rs;
 }
 
 void helper_msa_insve_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 72ed0a8..64587c4 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29446,7 +29446,24 @@ static void gen_msa_elm_df(CPUMIPSState *env, DisasContext *ctx, uint32_t df,
             }
             break;
         case OPC_INSERT_df:
-            gen_helper_msa_insert_df(cpu_env, tdf, twd, tws, tn);
+            switch (df) {
+            case DF_BYTE:
+                gen_helper_msa_insert_b(cpu_env, twd, tws, tn);
+                break;
+            case DF_HALF:
+                gen_helper_msa_insert_h(cpu_env, twd, tws, tn);
+                break;
+            case DF_WORD:
+                gen_helper_msa_insert_w(cpu_env, twd, tws, tn);
+                break;
+#if defined(TARGET_MIPS64)
+            case DF_DOUBLE:
+                gen_helper_msa_insert_d(cpu_env, twd, tws, tn);
+                break;
+#endif
+            default:
+                assert(0);
+            }
             break;
         }
         break;
-- 
2.7.4
