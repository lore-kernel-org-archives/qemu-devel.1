Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE9C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F94821743
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qRxJFzVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F94821743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47488 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSyTF-0007hY-Cy
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 02:41:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSyHY-0005wp-SL
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSyHW-0007tb-Vb
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:29:52 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:33527)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hSyHW-0007mP-87; Tue, 21 May 2019 02:29:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 457Qpg42P7z9sNm; Tue, 21 May 2019 16:29:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558420171;
	bh=h2GmXgrQc1s9kQJu5WILh6Hn0igXNXT6J623+KGV/t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRxJFzVwMdLGNqX6XZVm3JqQu62r8KXS2zmy+IGjNef577jfcf7muXmDdqfaG0byu
	K72tvVS+G+tnJ9msvo6wSoF+mXF9MeGf5wgBBYywQGncDQDdxLNN0fc0ijPiVoxVdX
	WuAOoqrdCNNbHT1kFWrDWE9cGC5eJz40lWDin38c=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue, 21 May 2019 16:29:03 +1000
Message-Id: <20190521062924.6930-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521062924.6930-1-david@gibson.dropbear.id.au>
References: <20190521062924.6930-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 17/38] target/ppc: Optimise VSX_LOAD_SCALAR_DS
 and VSX_VECTOR_LOAD_STORE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, gkurz@kaod.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
	Anton Blanchard <anton@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anton Blanchard <anton@ozlabs.org>

A few small optimisations:

In VSX_LOAD_SCALAR_DS() we can don't need to read the VSR via
get_cpu_vsrh().

Split VSX_VECTOR_LOAD_STORE() into two functions. Loads only need to
write the VSRs (set_cpu_vsr*()) and stores only need to read the VSRs
(get_cpu_vsr*())

Thanks to Mark Cave-Ayland for the suggestions.

Signed-off-by: Anton Blanchard <anton@ozlabs.org>
Message-Id: <20190509103545.4a7fa71a@kryten>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 68 ++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 4b8f6cefe3..c39829cf33 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -227,7 +227,7 @@ static void gen_lxvb16x(DisasContext *ctx)
     tcg_temp_free_i64(xtl);
 }
=20
-#define VSX_VECTOR_LOAD_STORE(name, op, indexed)            \
+#define VSX_VECTOR_LOAD(name, op, indexed)                  \
 static void gen_##name(DisasContext *ctx)                   \
 {                                                           \
     int xt;                                                 \
@@ -254,8 +254,6 @@ static void gen_##name(DisasContext *ctx)            =
       \
     }                                                       \
     xth =3D tcg_temp_new_i64();                               \
     xtl =3D tcg_temp_new_i64();                               \
-    get_cpu_vsrh(xth, xt);                                  \
-    get_cpu_vsrl(xtl, xt);                                  \
     gen_set_access_type(ctx, ACCESS_INT);                   \
     EA =3D tcg_temp_new();                                    \
     if (indexed) {                                          \
@@ -281,10 +279,61 @@ static void gen_##name(DisasContext *ctx)          =
         \
     tcg_temp_free_i64(xtl);                                 \
 }
=20
-VSX_VECTOR_LOAD_STORE(lxv, ld_i64, 0)
-VSX_VECTOR_LOAD_STORE(stxv, st_i64, 0)
-VSX_VECTOR_LOAD_STORE(lxvx, ld_i64, 1)
-VSX_VECTOR_LOAD_STORE(stxvx, st_i64, 1)
+VSX_VECTOR_LOAD(lxv, ld_i64, 0)
+VSX_VECTOR_LOAD(lxvx, ld_i64, 1)
+
+#define VSX_VECTOR_STORE(name, op, indexed)                 \
+static void gen_##name(DisasContext *ctx)                   \
+{                                                           \
+    int xt;                                                 \
+    TCGv EA;                                                \
+    TCGv_i64 xth;                                           \
+    TCGv_i64 xtl;                                           \
+                                                            \
+    if (indexed) {                                          \
+        xt =3D xT(ctx->opcode);                               \
+    } else {                                                \
+        xt =3D DQxT(ctx->opcode);                             \
+    }                                                       \
+                                                            \
+    if (xt < 32) {                                          \
+        if (unlikely(!ctx->vsx_enabled)) {                  \
+            gen_exception(ctx, POWERPC_EXCP_VSXU);          \
+            return;                                         \
+        }                                                   \
+    } else {                                                \
+        if (unlikely(!ctx->altivec_enabled)) {              \
+            gen_exception(ctx, POWERPC_EXCP_VPU);           \
+            return;                                         \
+        }                                                   \
+    }                                                       \
+    xth =3D tcg_temp_new_i64();                               \
+    xtl =3D tcg_temp_new_i64();                               \
+    get_cpu_vsrh(xth, xt);                                  \
+    get_cpu_vsrl(xtl, xt);                                  \
+    gen_set_access_type(ctx, ACCESS_INT);                   \
+    EA =3D tcg_temp_new();                                    \
+    if (indexed) {                                          \
+        gen_addr_reg_index(ctx, EA);                        \
+    } else {                                                \
+        gen_addr_imm_index(ctx, EA, 0x0F);                  \
+    }                                                       \
+    if (ctx->le_mode) {                                     \
+        tcg_gen_qemu_##op(xtl, EA, ctx->mem_idx, MO_LEQ);   \
+        tcg_gen_addi_tl(EA, EA, 8);                         \
+        tcg_gen_qemu_##op(xth, EA, ctx->mem_idx, MO_LEQ);   \
+    } else {                                                \
+        tcg_gen_qemu_##op(xth, EA, ctx->mem_idx, MO_BEQ);   \
+        tcg_gen_addi_tl(EA, EA, 8);                         \
+        tcg_gen_qemu_##op(xtl, EA, ctx->mem_idx, MO_BEQ);   \
+    }                                                       \
+    tcg_temp_free(EA);                                      \
+    tcg_temp_free_i64(xth);                                 \
+    tcg_temp_free_i64(xtl);                                 \
+}
+
+VSX_VECTOR_STORE(stxv, st_i64, 0)
+VSX_VECTOR_STORE(stxvx, st_i64, 1)
=20
 #ifdef TARGET_PPC64
 #define VSX_VECTOR_LOAD_STORE_LENGTH(name)                      \
@@ -329,7 +378,6 @@ static void gen_##name(DisasContext *ctx)            =
             \
         return;                                                   \
     }                                                             \
     xth =3D tcg_temp_new_i64();                                     \
-    get_cpu_vsrh(xth, rD(ctx->opcode) + 32);                      \
     gen_set_access_type(ctx, ACCESS_INT);                         \
     EA =3D tcg_temp_new();                                          \
     gen_addr_imm_index(ctx, EA, 0x03);                            \
@@ -513,8 +561,8 @@ static void gen_##name(DisasContext *ctx)            =
             \
     tcg_temp_free_i64(xth);                                       \
 }
=20
-VSX_LOAD_SCALAR_DS(stxsd, st64_i64)
-VSX_LOAD_SCALAR_DS(stxssp, st32fs)
+VSX_STORE_SCALAR_DS(stxsd, st64_i64)
+VSX_STORE_SCALAR_DS(stxssp, st32fs)
=20
 static void gen_mfvsrwz(DisasContext *ctx)
 {
--=20
2.21.0


