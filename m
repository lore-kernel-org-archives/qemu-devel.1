Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BCAC04A6B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 00:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41CD216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 00:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="XhUMs3rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41CD216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45632 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOX3M-0000zt-VC
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 20:36:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hOX2R-0008B4-9N
	for qemu-devel@nongnu.org; Wed, 08 May 2019 20:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hOX2O-0002yw-WE
	for qemu-devel@nongnu.org; Wed, 08 May 2019 20:35:54 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60833)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton@ozlabs.org>)
	id 1hOX2M-0002xd-8T; Wed, 08 May 2019 20:35:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
	server-digest SHA256) (No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 44zvX22vN5z9s9T;
	Thu,  9 May 2019 10:35:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
	t=1557362146; bh=Gh9OyftXIB3hj3vlvF7lMN+Rn57Pzw69jTkVRQfsN9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XhUMs3rxOzXPQehurCv8nmvg5OQPXqis3fDm+eufIVVSa2gwHkCC0jAPykNTD9Nvp
	L5oCl7JG7t7WFUMrAZSOLsehHtmKbIl09IuKT7mOITIbue7sU1qBVSgL/HdFNlzvAS
	uUfrJ+QbC0ALvy/hP1qo/HSkoHErmCIK9gNo40w0fvuvNLIRdgY/SbDBfGTb8SUBan
	liww4qDqxcSQYVyub24s1bhM9a1aXqenhlkRZ/akllHIA7blIMsvTxQFwdA8vzzze7
	LXdWuWfy+1xbaV8748wP86JTSUz64+9ySTnFaeSy0LgAxYskY2r/65HcisY0HSmp6Y
	phL7oaBgZHtIw==
Date: Thu, 9 May 2019 10:35:45 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20190509103545.4a7fa71a@kryten>
In-Reply-To: <c69c4513-417b-8415-c48b-61d0a05c1680@ilande.co.uk>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-4-anton@ozlabs.org>
	<20190507052815.GK7073@umbus.fritz.box>
	<c69c4513-417b-8415-c48b-61d0a05c1680@ilande.co.uk>
X-Mailer: Mutt/1.8.0 (2017-02-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH] target/ppc: Optimise VSX_LOAD_SCALAR_DS and
 VSX_VECTOR_LOAD_STORE
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
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	richard.henderson@linaro.org, f4bug@amsat.org,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A few small optimisations:

In VSX_LOAD_SCALAR_DS() we can don't need to read the VSR via
get_cpu_vsrh().

Split VSX_VECTOR_LOAD_STORE() into two functions. Loads only need to
write the VSRs (set_cpu_vsr*()) and stores only need to read the VSRs
(get_cpu_vsr*())

Thanks to Mark Cave-Ayland for the suggestions.

Signed-off-by: Anton Blanchard <anton@ozlabs.org>
---
 target/ppc/translate/vsx-impl.inc.c | 68 ++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 4b7627f53b..cdb44b8b70 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -228,7 +228,7 @@ static void gen_lxvb16x(DisasContext *ctx)
     tcg_temp_free_i64(xtl);
 }
 
-#define VSX_VECTOR_LOAD_STORE(name, op, indexed)            \
+#define VSX_VECTOR_LOAD(name, op, indexed)                  \
 static void gen_##name(DisasContext *ctx)                   \
 {                                                           \
     int xt;                                                 \
@@ -255,8 +255,6 @@ static void gen_##name(DisasContext *ctx)                   \
     }                                                       \
     xth = tcg_temp_new_i64();                               \
     xtl = tcg_temp_new_i64();                               \
-    get_cpu_vsrh(xth, xt);                                  \
-    get_cpu_vsrl(xtl, xt);                                  \
     gen_set_access_type(ctx, ACCESS_INT);                   \
     EA = tcg_temp_new();                                    \
     if (indexed) {                                          \
@@ -282,10 +280,61 @@ static void gen_##name(DisasContext *ctx)                   \
     tcg_temp_free_i64(xtl);                                 \
 }
 
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
+        xt = xT(ctx->opcode);                               \
+    } else {                                                \
+        xt = DQxT(ctx->opcode);                             \
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
+    xth = tcg_temp_new_i64();                               \
+    xtl = tcg_temp_new_i64();                               \
+    get_cpu_vsrh(xth, xt);                                  \
+    get_cpu_vsrl(xtl, xt);                                  \
+    gen_set_access_type(ctx, ACCESS_INT);                   \
+    EA = tcg_temp_new();                                    \
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
 
 #ifdef TARGET_PPC64
 #define VSX_VECTOR_LOAD_STORE_LENGTH(name)                      \
@@ -330,7 +379,6 @@ static void gen_##name(DisasContext *ctx)                         \
         return;                                                   \
     }                                                             \
     xth = tcg_temp_new_i64();                                     \
-    get_cpu_vsrh(xth, rD(ctx->opcode) + 32);                      \
     gen_set_access_type(ctx, ACCESS_INT);                         \
     EA = tcg_temp_new();                                          \
     gen_addr_imm_index(ctx, EA, 0x03);                            \
@@ -514,8 +562,8 @@ static void gen_##name(DisasContext *ctx)                         \
     tcg_temp_free_i64(xth);                                       \
 }
 
-VSX_LOAD_SCALAR_DS(stxsd, st64_i64)
-VSX_LOAD_SCALAR_DS(stxssp, st32fs)
+VSX_STORE_SCALAR_DS(stxsd, st64_i64)
+VSX_STORE_SCALAR_DS(stxssp, st32fs)
 
 static void gen_mfvsrwz(DisasContext *ctx)
 {
-- 
2.20.1


