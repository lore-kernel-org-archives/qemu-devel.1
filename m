Received: from eggs.gnu.org ([2001:4830:134:3::10]:55493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWB-0006nq-J2
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWA-0005mA-Nm
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:11 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWA-0005lb-JO
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:10 -0500
Received: by mail-pg0-x241.google.com with SMTP id g1so2479520pgn.0
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:10 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:07 -0800
Message-Id: <20161224040042.12654-31-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 30/65] target-mips: Use clz opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>

Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/mips/helper.h    |  7 -------
 target/mips/op_helper.c | 22 ----------------------
 target/mips/translate.c | 23 ++++++++++++++++-------
 3 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 666936c..60efa01 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -20,13 +20,6 @@ DEF_HELPER_4(scd, tl, env, tl, tl, int)
 #endif
 #endif
 
-DEF_HELPER_FLAGS_1(clo, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(clz, TCG_CALL_NO_RWG_SE, tl, tl)
-#ifdef TARGET_MIPS64
-DEF_HELPER_FLAGS_1(dclo, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(dclz, TCG_CALL_NO_RWG_SE, tl, tl)
-#endif
-
 DEF_HELPER_3(muls, tl, env, tl, tl)
 DEF_HELPER_3(mulsu, tl, env, tl, tl)
 DEF_HELPER_3(macc, tl, env, tl, tl)
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 7af4c2f..11d781f 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -103,28 +103,6 @@ HELPER_ST(sd, stq, uint64_t)
 #endif
 #undef HELPER_ST
 
-target_ulong helper_clo (target_ulong arg1)
-{
-    return clo32(arg1);
-}
-
-target_ulong helper_clz (target_ulong arg1)
-{
-    return clz32(arg1);
-}
-
-#if defined(TARGET_MIPS64)
-target_ulong helper_dclo (target_ulong arg1)
-{
-    return clo64(arg1);
-}
-
-target_ulong helper_dclz (target_ulong arg1)
-{
-    return clz64(arg1);
-}
-#endif /* TARGET_MIPS64 */
-
 /* 64 bits arithmetic for 32 bits hosts */
 static inline uint64_t get_HILO(CPUMIPSState *env)
 {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8deffa1..7f8ecf4 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3626,29 +3626,38 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
         /* Treat as NOP. */
         return;
     }
-    t0 = tcg_temp_new();
+    t0 = cpu_gpr[rd];
     gen_load_gpr(t0, rs);
+
     switch (opc) {
     case OPC_CLO:
     case R6_OPC_CLO:
-        gen_helper_clo(cpu_gpr[rd], t0);
+#if defined(TARGET_MIPS64)
+    case OPC_DCLO:
+    case R6_OPC_DCLO:
+#endif
+        tcg_gen_not_tl(t0, t0);
         break;
+    }
+
+    switch (opc) {
+    case OPC_CLO:
+    case R6_OPC_CLO:
     case OPC_CLZ:
     case R6_OPC_CLZ:
-        gen_helper_clz(cpu_gpr[rd], t0);
+        tcg_gen_ext32u_tl(t0, t0);
+        tcg_gen_clzi_tl(t0, t0, TARGET_LONG_BITS);
+        tcg_gen_subi_tl(t0, t0, TARGET_LONG_BITS - 32);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_DCLO:
     case R6_OPC_DCLO:
-        gen_helper_dclo(cpu_gpr[rd], t0);
-        break;
     case OPC_DCLZ:
     case R6_OPC_DCLZ:
-        gen_helper_dclz(cpu_gpr[rd], t0);
+        tcg_gen_clzi_i64(t0, t0, 64);
         break;
 #endif
     }
-    tcg_temp_free(t0);
 }
 
 /* Godson integer instructions */
-- 
2.9.3
