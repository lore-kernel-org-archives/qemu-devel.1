Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EC8C55186
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3D5206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtym6svX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3D5206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR440-0006Ti-Gl
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR415-00014Y-HR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR414-0001DM-RP
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:31 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR414-00018W-Ds
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:30 -0400
Received: by mail-pj1-x1043.google.com with SMTP id mq3so151098pjb.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J8tKD8Dhorc/rZ7Pqa63r7FVSLYqB5ObHvXNIyPd1G0=;
 b=dtym6svXNRG09FaGUE3ydgDPAHdq75PwjHlZmkv9dUpKnow+5xOQ6iVrmPRH/++edq
 BknPQcOJVlIbfmhzPIpKnUwU9EL/wglHYLXgV0IUzYV4E+jQgOxArKBEuRtWu6W4G/Jg
 NHhkrn1CYkkyIWFlXiu837rH8LLL9/ZfTulbnhtL8t5URgZvy4qlI1Qs3EJ7+1fYN+zr
 A/Age6F5/g97RPCdvrXm1PdAupRPNjHV2eVvsZ5qwO2eR70jkQzsYuuezWvCTN9fwSoH
 Bx1o70Y7/XayfEvlQhG0QdCcTR9e7aEXRUEh17jmJ7/YtnVTGkGjdX0959lY63X+fXhM
 iT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J8tKD8Dhorc/rZ7Pqa63r7FVSLYqB5ObHvXNIyPd1G0=;
 b=a31qhfr4F6UlPsplkGoNp4vwdDPo4ango/9Y3WkbLVTofOfP+5SuS2osaw52T4rSEu
 VkEgL58qsDKvlEX/9vvi3b26pX4vWU5CkmtsLK1DnjeQ4e8B5SktN1jZYq3PsSxBmznT
 F5Lx8oC6zal4H70X4R0UCX6/EITBg+SJAWG3lKs6Sf/jxMy/LLDP6ab4nAmT155UiDZX
 Nv73cx2WdaW238VG+ZoQz/H10om3ZFJlUf2caamJ7yOzST3mvImJhIVXtp7lOe7vHFpJ
 Gd6yPtnnQFDOiVdXGcpDgAczNrTjC/UDSBSne/Gpb4FdtQmGHTy7kWCUgf3Xoe5Hnr5V
 Bsfw==
X-Gm-Message-State: AGi0PubHn2k2WSRqsy7dSsVifdSMvXFpLcpf3PRuiO/9DeaBq4wPguWJ
 tLGD0k6HfqMHmVL4zZXvMq7ZI1hyy20=
X-Google-Smtp-Source: APiQypJ5opnTHkF4yu5J+qJkhXapaO4wW2DLmcV8a98hcilSst+pF13UpudIfYxdhQBm4cQDZVJXJw==
X-Received: by 2002:a17:90a:a484:: with SMTP id
 z4mr8656936pjp.40.1587518248653; 
 Tue, 21 Apr 2020 18:17:28 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/36] target/ppc: Use tcg_gen_gvec_dup_imm
Date: Tue, 21 Apr 2020 18:16:49 -0700
Message-Id: <20200422011722.13287-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: alex.bennee@linaro.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can now unify the implementation of the 3 VSPLTI instructions.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate/vmx-impl.inc.c | 32 ++++++++++++++++-------------
 target/ppc/translate/vsx-impl.inc.c |  2 +-
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 81d5a7a341..403ed3a01c 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -1035,21 +1035,25 @@ GEN_VXRFORM_DUAL(vcmpbfp, PPC_ALTIVEC, PPC_NONE, \
 GEN_VXRFORM_DUAL(vcmpgtfp, PPC_ALTIVEC, PPC_NONE, \
                  vcmpgtud, PPC_NONE, PPC2_ALTIVEC_207)
 
-#define GEN_VXFORM_DUPI(name, tcg_op, opc2, opc3)                       \
-static void glue(gen_, name)(DisasContext *ctx)                         \
-    {                                                                   \
-        int simm;                                                       \
-        if (unlikely(!ctx->altivec_enabled)) {                          \
-            gen_exception(ctx, POWERPC_EXCP_VPU);                       \
-            return;                                                     \
-        }                                                               \
-        simm = SIMM5(ctx->opcode);                                      \
-        tcg_op(avr_full_offset(rD(ctx->opcode)), 16, 16, simm);         \
+static void gen_vsplti(DisasContext *ctx, int vece)
+{
+    int simm;
+
+    if (unlikely(!ctx->altivec_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VPU);
+        return;
     }
 
-GEN_VXFORM_DUPI(vspltisb, tcg_gen_gvec_dup8i, 6, 12);
-GEN_VXFORM_DUPI(vspltish, tcg_gen_gvec_dup16i, 6, 13);
-GEN_VXFORM_DUPI(vspltisw, tcg_gen_gvec_dup32i, 6, 14);
+    simm = SIMM5(ctx->opcode);
+    tcg_gen_gvec_dup_imm(vece, avr_full_offset(rD(ctx->opcode)), 16, 16, simm);
+}
+
+#define GEN_VXFORM_VSPLTI(name, vece, opc2, opc3) \
+static void glue(gen_, name)(DisasContext *ctx) { gen_vsplti(ctx, vece); }
+
+GEN_VXFORM_VSPLTI(vspltisb, MO_8, 6, 12);
+GEN_VXFORM_VSPLTI(vspltish, MO_16, 6, 13);
+GEN_VXFORM_VSPLTI(vspltisw, MO_32, 6, 14);
 
 #define GEN_VXFORM_NOA(name, opc2, opc3)                                \
 static void glue(gen_, name)(DisasContext *ctx)                         \
@@ -1559,7 +1563,7 @@ GEN_VXFORM_DUAL(vsldoi, PPC_ALTIVEC, PPC_NONE,
 #undef GEN_VXRFORM_DUAL
 #undef GEN_VXRFORM1
 #undef GEN_VXRFORM
-#undef GEN_VXFORM_DUPI
+#undef GEN_VXFORM_VSPLTI
 #undef GEN_VXFORM_NOA
 #undef GEN_VXFORM_UIMM
 #undef GEN_VAFORM_PAIRED
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 8287e272f5..b518de46db 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1579,7 +1579,7 @@ static void gen_xxspltib(DisasContext *ctx)
             return;
         }
     }
-    tcg_gen_gvec_dup8i(vsr_full_offset(rt), 16, 16, uim8);
+    tcg_gen_gvec_dup_imm(MO_8, vsr_full_offset(rt), 16, 16, uim8);
 }
 
 static void gen_xxsldwi(DisasContext *ctx)
-- 
2.20.1


