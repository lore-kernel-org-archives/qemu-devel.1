Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49689C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A14216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Zb7un8ND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A14216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiD4C-0003ET-8r
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59120)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzs-0005qT-B7
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzp-0003ZW-Vh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:32 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47479 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBzm-0003Rv-9z; Tue, 02 Jul 2019 02:10:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMp1MFbz9sQv; Tue,  2 Jul 2019 16:09:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047750;
 bh=7oein1WT021O+cXNPaZUlzRFsuFWH4WqTrPgmAzQ37c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zb7un8NDoYWWufI7MHc8k+JjSAwBupmhZGJ7NLEbIBlRuAUSK5lKAeefFKUcJ4Nsd
 lKqu0nhIHx7+t+5T9iHrDBSjoKYwZvnIDahVQxXHmhd50E0a1Th24pkGuhpVxlKYRE
 aj8IKgQqo4G7oB4pZwRYR0PrwhNioKnvLfKbaI/o=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:47 +1000
Message-Id: <20190702060857.3926-40-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 39/49] target/ppc: decode target register in
 VSX_VECTOR_LOAD_STORE_LENGTH at translation time
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190616123751.781-14-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  8 ++---
 target/ppc/mem_helper.c             |  6 ++--
 target/ppc/translate/vsx-impl.inc.c | 47 +++++++++++++++--------------
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index a5e12a3933..7ed9effff2 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -279,10 +279,10 @@ DEF_HELPER_3(stvebx, void, env, avr, tl)
 DEF_HELPER_3(stvehx, void, env, avr, tl)
 DEF_HELPER_3(stvewx, void, env, avr, tl)
 #if defined(TARGET_PPC64)
-DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
-DEF_HELPER_4(lxvll, void, env, tl, tl, tl)
-DEF_HELPER_4(stxvl, void, env, tl, tl, tl)
-DEF_HELPER_4(stxvll, void, env, tl, tl, tl)
+DEF_HELPER_4(lxvl, void, env, tl, vsr, tl)
+DEF_HELPER_4(lxvll, void, env, tl, vsr, tl)
+DEF_HELPER_4(stxvl, void, env, tl, vsr, tl)
+DEF_HELPER_4(stxvll, void, env, tl, vsr, tl)
 #endif
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 87632ccf53..6f4ffa3661 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -415,9 +415,8 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
=20
 #define VSX_LXVL(name, lj)                                              =
\
 void helper_##name(CPUPPCState *env, target_ulong addr,                 =
\
-                   target_ulong xt_num, target_ulong rb)                =
\
+                   ppc_vsr_t *xt, target_ulong rb)                      =
\
 {                                                                       =
\
-    ppc_vsr_t *xt =3D &env->vsr[xt_num];                                =
  \
     ppc_vsr_t t;                                                        =
\
     uint64_t nb =3D GET_NB(rb);                                         =
  \
     int i;                                                              =
\
@@ -446,9 +445,8 @@ VSX_LXVL(lxvll, 1)
=20
 #define VSX_STXVL(name, lj)                                       \
 void helper_##name(CPUPPCState *env, target_ulong addr,           \
-                   target_ulong xt_num, target_ulong rb)          \
+                   ppc_vsr_t *xt, target_ulong rb)                \
 {                                                                 \
-    ppc_vsr_t *xt =3D &env->vsr[xt_num];                            \
     target_ulong nb =3D GET_NB(rb);                                 \
     int i;                                                        \
                                                                   \
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 5cf053e7f2..e853ee1386 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -344,29 +344,30 @@ VSX_VECTOR_STORE(stxv, st_i64, 0)
 VSX_VECTOR_STORE(stxvx, st_i64, 1)
=20
 #ifdef TARGET_PPC64
-#define VSX_VECTOR_LOAD_STORE_LENGTH(name)                      \
-static void gen_##name(DisasContext *ctx)                       \
-{                                                               \
-    TCGv EA, xt;                                                \
-                                                                \
-    if (xT(ctx->opcode) < 32) {                                 \
-        if (unlikely(!ctx->vsx_enabled)) {                      \
-            gen_exception(ctx, POWERPC_EXCP_VSXU);              \
-            return;                                             \
-        }                                                       \
-    } else {                                                    \
-        if (unlikely(!ctx->altivec_enabled)) {                  \
-            gen_exception(ctx, POWERPC_EXCP_VPU);               \
-            return;                                             \
-        }                                                       \
-    }                                                           \
-    EA =3D tcg_temp_new();                                        \
-    xt =3D tcg_const_tl(xT(ctx->opcode));                         \
-    gen_set_access_type(ctx, ACCESS_INT);                       \
-    gen_addr_register(ctx, EA);                                 \
-    gen_helper_##name(cpu_env, EA, xt, cpu_gpr[rB(ctx->opcode)]); \
-    tcg_temp_free(EA);                                          \
-    tcg_temp_free(xt);                                          \
+#define VSX_VECTOR_LOAD_STORE_LENGTH(name)                         \
+static void gen_##name(DisasContext *ctx)                          \
+{                                                                  \
+    TCGv EA;                                                       \
+    TCGv_ptr xt;                                                   \
+                                                                   \
+    if (xT(ctx->opcode) < 32) {                                    \
+        if (unlikely(!ctx->vsx_enabled)) {                         \
+            gen_exception(ctx, POWERPC_EXCP_VSXU);                 \
+            return;                                                \
+        }                                                          \
+    } else {                                                       \
+        if (unlikely(!ctx->altivec_enabled)) {                     \
+            gen_exception(ctx, POWERPC_EXCP_VPU);                  \
+            return;                                                \
+        }                                                          \
+    }                                                              \
+    EA =3D tcg_temp_new();                                           \
+    xt =3D gen_vsr_ptr(xT(ctx->opcode));                             \
+    gen_set_access_type(ctx, ACCESS_INT);                          \
+    gen_addr_register(ctx, EA);                                    \
+    gen_helper_##name(cpu_env, EA, xt, cpu_gpr[rB(ctx->opcode)]);  \
+    tcg_temp_free(EA);                                             \
+    tcg_temp_free_ptr(xt);                                         \
 }
=20
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
--=20
2.21.0


