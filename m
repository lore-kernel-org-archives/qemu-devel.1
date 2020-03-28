Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A80AC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 09:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D787B20675
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 09:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="XnCXd7jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D787B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI7Us-0004cB-VE
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 05:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jI7U8-0004Cc-Hv
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 05:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jI7U6-00075w-Cx
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 05:10:32 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jI7U4-0006hu-AQ
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 05:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585386542; 
 s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
 h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=OBMT9C/TvCGGt6YpplfyoXUd2f+rMneGz12LRIjVhz8=;
 b=XnCXd7jhCBmw0ACxo7Q6SvKvb1fFEUkLcJXrcQ2HVP3Nlke2CKrHjRJ5L3sMjURU
 AwJ1/R/snkhJHgkOvVERKtoktTLNURKyNZwlncw5TO/r3WwaCVQefvv8RU3Yqls+Gq1
 OVadqjlwn6j63SX4aX07QFdAQ7re7KoxByk9g5Ec=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by
 mx.zoho.com.cn with SMTPS id 15853865400272.886188759601623;
 Sat, 28 Mar 2020 17:09:00 +0800 (CST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Message-ID: <20200328090853.645433-1-jiaxun.yang@flygoat.com>
Subject: [PATCH] target/mips: Add MAC2008 support
Date: Sat, 28 Mar 2020 17:08:53 +0800
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 124.251.121.243
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com,
 aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MAC2008 was introduced in MIPS Release 3 but removed in MIPS Release 5.
However, there are some processors implemented this feature.
some Ingenic MCU can config MAC2008 status runtime while whole
Loongson-64 family are MAC2008 only.

FCSR.MAC2008 bit indicates FMA family of instructions on these
processors have fused behavior, similiar to FMA in Release 6,
so we can reuse helpers with them.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/cpu.h        |  1 +
 target/mips/fpu_helper.c | 61 +++++++++++++++++++++------------
 target/mips/helper.h     | 12 +++----
 target/mips/translate.c  | 74 +++++++++++++++++++++++++++++++++-------
 4 files changed, 107 insertions(+), 41 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 94d01ea798..b20e6e3387 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -63,6 +63,7 @@ struct CPUMIPSFPUContext {
     uint32_t fcr31_rw_bitmask;
     uint32_t fcr31;
 #define FCR31_FS 24
+#define FCR31_MAC2008 20
 #define FCR31_ABS2008 19
 #define FCR31_NAN2008 18
 #define SET_FP_COND(num, env)     do { ((env).fcr31) |=3D                 =
\
diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 5287c86c61..2e50d50f36 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1357,7 +1357,7 @@ FLOAT_MINMAX(mina_d, 64, minnummag)
     }                                                                \
 }
=20
-/* FMA based operations */
+/* FMA based operations (both unfused and fused) */
 #define FLOAT_FMA(name, type)                                        \
 uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,              \
                                      uint64_t fdt0, uint64_t fdt1,   \
@@ -1392,33 +1392,52 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState =
*env,             \
     UNFUSED_FMA(float32, fsth0, fsth1, fsth2, type);                 \
     update_fcr31(env, GETPC());                                      \
     return ((uint64_t)fsth0 << 32) | fst0;                           \
+}                                                                    \
+uint64_t helper_float_ ## name ## f_d(CPUMIPSState *env,             \
+                                     uint64_t fdt0, uint64_t fdt1,   \
+                                     uint64_t fdt2)                  \
+{                                                                    \
+    fdt0 =3D float64_muladd(fdt0, fdt1, fdt2, type,                    \
+                            &env->active_fpu.fp_status);             \
+    update_fcr31(env, GETPC());                                      \
+    return fdt0;                                                     \
+}                                                                    \
+                                                                     \
+uint32_t helper_float_ ## name ## f_s(CPUMIPSState *env,             \
+                                     uint32_t fst0, uint32_t fst1,   \
+                                     uint32_t fst2)                  \
+{                                                                    \
+    fst0 =3D float32_muladd(fst0, fst1, fst2, type,                    \
+                            &env->active_fpu.fp_status);             \
+    update_fcr31(env, GETPC());                                      \
+    return fst0;                                                     \
+}                                                                    \
+                                                                     \
+uint64_t helper_float_ ## name ## f_ps(CPUMIPSState *env,            \
+                                      uint64_t fdt0, uint64_t fdt1,  \
+                                      uint64_t fdt2)                 \
+{                                                                    \
+    uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;                               \
+    uint32_t fsth0 =3D fdt0 >> 32;                                     \
+    uint32_t fst1 =3D fdt1 & 0XFFFFFFFF;                               \
+    uint32_t fsth1 =3D fdt1 >> 32;                                     \
+    uint32_t fst2 =3D fdt2 & 0XFFFFFFFF;                               \
+    uint32_t fsth2 =3D fdt2 >> 32;                                     \
+                                                                     \
+    fst0 =3D float32_muladd(fst0, fst1, fst2, type,                    \
+                            &env->active_fpu.fp_status);             \
+    fsth0 =3D float32_muladd(fsth0, fsth1, fsth2, type,                \
+                            &env->active_fpu.fp_status);             \
+    update_fcr31(env, GETPC());                                      \
+    return ((uint64_t)fsth0 << 32) | fst0;                           \
 }
+
 FLOAT_FMA(madd, 0)
 FLOAT_FMA(msub, float_muladd_negate_c)
 FLOAT_FMA(nmadd, float_muladd_negate_result)
 FLOAT_FMA(nmsub, float_muladd_negate_result | float_muladd_negate_c)
 #undef FLOAT_FMA
=20
-#define FLOAT_FMADDSUB(name, bits, muladd_arg)                          \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
-                                         uint ## bits ## _t fs,         \
-                                         uint ## bits ## _t ft,         \
-                                         uint ## bits ## _t fd)         \
-{                                                                       \
-    uint ## bits ## _t fdret;                                           \
-                                                                        \
-    fdret =3D float ## bits ## _muladd(fs, ft, fd, muladd_arg,            =
\
-                                     &env->active_fpu.fp_status);       \
-    update_fcr31(env, GETPC());                                         \
-    return fdret;                                                       \
-}
-
-FLOAT_FMADDSUB(maddf_s, 32, 0)
-FLOAT_FMADDSUB(maddf_d, 64, 0)
-FLOAT_FMADDSUB(msubf_s, 32, float_muladd_negate_product)
-FLOAT_FMADDSUB(msubf_d, 64, float_muladd_negate_product)
-#undef FLOAT_FMADDSUB
-
 /* compare operations */
 #define FOP_COND_D(op, cond)                                   \
 void helper_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,     \
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 84fdd9fd27..56aad63931 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -232,13 +232,6 @@ DEF_HELPER_3(float_mulr_ps, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(float_class_s, TCG_CALL_NO_RWG_SE, i32, env, i32)
 DEF_HELPER_FLAGS_2(float_class_d, TCG_CALL_NO_RWG_SE, i64, env, i64)
=20
-#define FOP_PROTO(op)                                     \
-DEF_HELPER_4(float_ ## op ## _s, i32, env, i32, i32, i32) \
-DEF_HELPER_4(float_ ## op ## _d, i64, env, i64, i64, i64)
-FOP_PROTO(maddf)
-FOP_PROTO(msubf)
-#undef FOP_PROTO
-
 #define FOP_PROTO(op)                                \
 DEF_HELPER_3(float_ ## op ## _s, i32, env, i32, i32) \
 DEF_HELPER_3(float_ ## op ## _d, i64, env, i64, i64)
@@ -305,7 +298,10 @@ FOP_PROTO(rsqrt2)
 #define FOP_PROTO(op)                                      \
 DEF_HELPER_4(float_ ## op ## _s, i32, env, i32, i32, i32)  \
 DEF_HELPER_4(float_ ## op ## _d, i64, env, i64, i64, i64)  \
-DEF_HELPER_4(float_ ## op ## _ps, i64, env, i64, i64, i64)
+DEF_HELPER_4(float_ ## op ## _ps, i64, env, i64, i64, i64) \
+DEF_HELPER_4(float_ ## op ## f_s, i32, env, i32, i32, i32)  \
+DEF_HELPER_4(float_ ## op ## f_d, i64, env, i64, i64, i64)  \
+DEF_HELPER_4(float_ ## op ## f_ps, i64, env, i64, i64, i64)
 FOP_PROTO(madd)
 FOP_PROTO(msub)
 FOP_PROTO(nmadd)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index d745bd2803..3ce159df97 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2547,6 +2547,7 @@ typedef struct DisasContext {
     bool mrp;
     bool nan2008;
     bool abs2008;
+    bool mac2008;
     bool saar;
     bool mi;
     int gi;
@@ -12776,7 +12777,11 @@ static void gen_flt3_arith(DisasContext *ctx, uint=
32_t opc,
             gen_load_fpr32(ctx, fp0, fs);
             gen_load_fpr32(ctx, fp1, ft);
             gen_load_fpr32(ctx, fp2, fr);
-            gen_helper_float_madd_s(fp2, cpu_env, fp0, fp1, fp2);
+            if (ctx->mac2008) {
+                gen_helper_float_madd_s(fp2, cpu_env, fp0, fp1, fp2);
+            } else {
+                gen_helper_float_maddf_s(fp2, cpu_env, fp0, fp1, fp2);
+            }
             tcg_temp_free_i32(fp0);
             tcg_temp_free_i32(fp1);
             gen_store_fpr32(ctx, fp2, fd);
@@ -12794,7 +12799,11 @@ static void gen_flt3_arith(DisasContext *ctx, uint=
32_t opc,
             gen_load_fpr64(ctx, fp0, fs);
             gen_load_fpr64(ctx, fp1, ft);
             gen_load_fpr64(ctx, fp2, fr);
-            gen_helper_float_madd_d(fp2, cpu_env, fp0, fp1, fp2);
+            if (ctx->mac2008) {
+                gen_helper_float_madd_d(fp2, cpu_env, fp0, fp1, fp2);
+            } else {
+                gen_helper_float_maddf_d(fp2, cpu_env, fp0, fp1, fp2);
+            }
             tcg_temp_free_i64(fp0);
             tcg_temp_free_i64(fp1);
             gen_store_fpr64(ctx, fp2, fd);
@@ -12811,7 +12820,11 @@ static void gen_flt3_arith(DisasContext *ctx, uint=
32_t opc,
             gen_load_fpr64(ctx, fp0, fs);
             gen_load_fpr64(ctx, fp1, ft);
             gen_load_fpr64(ctx, fp2, fr);
-            gen_helper_float_madd_ps(fp2, cpu_env, fp0, fp1, fp2);
+            if (ctx->mac2008) {
+                gen_helper_float_madd_ps(fp2, cpu_env, fp0, fp1, fp2);
+            } else {
+                gen_helper_float_maddf_ps(fp2, cpu_env, fp0, fp1, fp2);
+            }
             tcg_temp_free_i64(fp0);
             tcg_temp_free_i64(fp1);
             gen_store_fpr64(ctx, fp2, fd);
@@ -12828,7 +12841,11 @@ static void gen_flt3_arith(DisasContext *ctx, uint=
32_t opc,
             gen_load_fpr32(ctx, fp0, fs);
             gen_load_fpr32(ctx, fp1, ft);
             gen_load_fpr32(ctx, fp2, fr);
-            gen_helper_float_msub_s(fp2, cpu_env, fp0, fp1, fp2);
+            if (ctx->mac2008) {
+                gen_helper_float_msub_s(fp2, cpu_env, fp0, fp1, fp2);
+            } else {
+                gen_helper_float_msubf_s(fp2, cpu_env, fp0, fp1, fp2);
+            }
             tcg_temp_free_i32(fp0);
             tcg_temp_free_i32(fp1);
             gen_store_fpr32(ctx, fp2, fd);
@@ -12846,7 +12863,11 @@ static void gen_flt3_arith(DisasContext *ctx, uint=
32_t opc,
             gen_load_fpr64(ctx, fp0, fs);
             gen_load_fpr64(ctx, fp1, ft);
             gen_load_fpr64(ctx, fp2, fr);
-            gen_helper_float_msub_d(fp2, cpu_env, fp0, fp1, fp2);
+            if (ctx->mac2008) {
+                gen_helper_float_msub_d(fp2, cpu_env, fp0, fp1, fp2);
+            } else {
+                gen_helper_float_msubf_d(fp2, cpu_env, fp0, fp1, fp2);
+            }
             tcg_temp_free_i64(fp0);
             tcg_temp_free_i64(fp1);
             gen_store_fpr64(ctx, fp2, fd);
@@ -12863,7 +12884,11 @@ static void gen_flt3_arith(DisasContext *ctx, uint=
32_t opc,
             gen_load_fpr64(ctx, fp0, fs);
             gen_load_fpr64(ctx, fp1, ft);
             gen_load_fpr64(ctx, fp2, fr);
-            gen_helper_float_msub_ps(fp2, cpu_env, fp0, fp1, fp2);
+            if (ctx->mac2008) {
+                gen_helper_float_msub_ps(fp2, cpu_env, fp0, fp1, fp2);
+            } else {
+                gen_helper_float_msubf_ps(fp2, cpu_env, fp0, fp1, fp2);
+            }
             tcg_temp_free_i64(fp0);
             tcg_temp_free_i64(fp1);
             gen_store_fpr64(ctx, fp2, fd);
@@ -12880,7 +12905,11 @@ static void gen_flt3_arith(DisasContext *ctx, uint=
32_t opc,
             gen_load_fpr32(ctx, fp0, fs);
             gen_load_fpr32(ctx, fp1, ft);
             gen_load_fpr32(ctx, fp2, fr);
-            gen_helper_float_nmadd_s(fp2, cpu_env, fp0, fp1, fp2);
+            if (ctx->mac2008) {
+                gen_helper_float_nmadd_s(fp2, cpu_env, fp0, fp1, fp2);
+            } else {
+                gen_helper_float_nmaddf_s(fp2, cpu_env, fp0, fp1, fp2);
+            }
             tcg_temp_free_i32(fp0);
             tcg_temp_free_i32(fp1);
             gen_store_fpr32(ctx, fp2, fd);
@@ -12898,7 +12927,11 @@ static void gen_flt3_arith(DisasContext *ctx, uint=
32_t opc,
             gen_load_fpr64(ctx, fp0, fs);
             gen_load_fpr64(ctx, fp1, ft);
             gen_load_fpr64(ctx, fp2, fr);
-            gen_helper_float_nmadd_d(fp2, cpu_env, fp0, fp1, fp2);
+            if (ctx->mac2008) {
+                gen_helper_float_nmadd_d(fp2, cpu_env, fp0, fp1, fp2);
+            } else {
+                gen_helper_float_nmaddf_d(fp2, cpu_env, fp0, fp1, fp2);
+            }
             tcg_temp_free_i64(fp0);
             tcg_temp_free_i64(fp1);
             gen_store_fpr64(ctx, fp2, fd);
@@ -12915,7 +12948,11 @@ static void gen_flt3_arith(DisasContext *ctx, uint=
32_t opc,
             gen_load_fpr64(ctx, fp0, fs);
             gen_load_fpr64(ctx, fp1, ft);
             gen_load_fpr64(ctx, fp2, fr);
-            gen_helper_float_nmadd_ps(fp2, cpu_env, fp0, fp1, fp2);
+            if (ctx->mac2008) {
+                gen_helper_float_nmadd_ps(fp2, cpu_env, fp0, fp1, fp2);
+            } else {
+                gen_helper_float_nmaddf_ps(fp2, cpu_env, fp0, fp1, fp2);
+            }
             tcg_temp_free_i64(fp0);
             tcg_temp_free_i64(fp1);
             gen_store_fpr64(ctx, fp2, fd);
@@ -12932,7 +12969,11 @@ static void gen_flt3_arith(DisasContext *ctx, uint=
32_t opc,
             gen_load_fpr32(ctx, fp0, fs);
             gen_load_fpr32(ctx, fp1, ft);
             gen_load_fpr32(ctx, fp2, fr);
-            gen_helper_float_nmsub_s(fp2, cpu_env, fp0, fp1, fp2);
+            if (ctx->mac2008) {
+                gen_helper_float_nmsub_s(fp2, cpu_env, fp0, fp1, fp2);
+            } else {
+                gen_helper_float_nmsubf_s(fp2, cpu_env, fp0, fp1, fp2);
+            }
             tcg_temp_free_i32(fp0);
             tcg_temp_free_i32(fp1);
             gen_store_fpr32(ctx, fp2, fd);
@@ -12950,7 +12991,11 @@ static void gen_flt3_arith(DisasContext *ctx, uint=
32_t opc,
             gen_load_fpr64(ctx, fp0, fs);
             gen_load_fpr64(ctx, fp1, ft);
             gen_load_fpr64(ctx, fp2, fr);
-            gen_helper_float_nmsub_d(fp2, cpu_env, fp0, fp1, fp2);
+            if (ctx->mac2008) {
+                gen_helper_float_nmsub_d(fp2, cpu_env, fp0, fp1, fp2);
+            } else {
+                gen_helper_float_nmsubf_d(fp2, cpu_env, fp0, fp1, fp2);
+            }
             tcg_temp_free_i64(fp0);
             tcg_temp_free_i64(fp1);
             gen_store_fpr64(ctx, fp2, fd);
@@ -12967,7 +13012,11 @@ static void gen_flt3_arith(DisasContext *ctx, uint=
32_t opc,
             gen_load_fpr64(ctx, fp0, fs);
             gen_load_fpr64(ctx, fp1, ft);
             gen_load_fpr64(ctx, fp2, fr);
-            gen_helper_float_nmsub_ps(fp2, cpu_env, fp0, fp1, fp2);
+            if (ctx->mac2008) {
+                gen_helper_float_nmsub_ps(fp2, cpu_env, fp0, fp1, fp2);
+            } else {
+                gen_helper_float_nmsubf_ps(fp2, cpu_env, fp0, fp1, fp2);
+            }
             tcg_temp_free_i64(fp0);
             tcg_temp_free_i64(fp1);
             gen_store_fpr64(ctx, fp2, fd);
@@ -30807,6 +30856,7 @@ static void mips_tr_init_disas_context(DisasContext=
Base *dcbase, CPUState *cs)
     ctx->mrp =3D (env->CP0_Config5 >> CP0C5_MRP) & 1;
     ctx->nan2008 =3D (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
     ctx->abs2008 =3D (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
+    ctx->mac2008 =3D (env->active_fpu.fcr31 >> FCR31_MAC2008) & 1;
     ctx->mi =3D (env->CP0_Config5 >> CP0C5_MI) & 1;
     ctx->gi =3D (env->CP0_Config5 >> CP0C5_GI) & 3;
     restore_cpu_state(env, ctx);
--=20
2.26.0.rc2



