Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BB4C38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7D02054F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 15:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGSkfEtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7D02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPp5J-0004cs-1k
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 11:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPp13-00076W-Jp
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPp12-0003Es-Cg
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:21 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPp12-00038w-6N
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 11:04:20 -0400
Received: by mail-pg1-x541.google.com with SMTP id 188so2651799pgj.13
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XzOExfY3LqCZ8KkyShXQQH+aniJsYLCzLWdtJXU+p94=;
 b=zGSkfEtYU7Ugb3/XbquDTf3du/ody1A3ZvJO3ALfMo5QVw7H2kLzZiTbqZ6C7ehoxk
 F4du6T/hB2lvg2rQrXs7m5ztEL45z9GNd7TuaI+mHZ5tapKr9derb2OSUo+YmwhTe0cM
 osRPx8To6FJ/Asn5iGqZkhrhjcVY6vSzYKDeumscY9O2+G66+TUWGYDHc3c3Nvo5Z0DW
 Fft7hmp+FRo0OOxRG3VzPB7fKTelX2iTmp2Eaxttrjf0mySRZESHy89IFOze0fBfjywl
 52XT0eFWeQJwGy6H4Uujc0vnzYLoYBOYFlCq2/JiLGcYE0dXy7Nu0qrx7ddGqnSMGYWX
 oiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XzOExfY3LqCZ8KkyShXQQH+aniJsYLCzLWdtJXU+p94=;
 b=ek//N34GZrsDD05Zmljuz/iiZPac011jQ+YegCYeqI7BrhDLbLkD/F5vbKqtUlBDJg
 5a6cYAkmUYx9Is91krtBUDc4y7SWX7nLm1Dneqvyvs5SLrmTWDqI56yk/io/4x69SP+z
 5UBP5Eu0xG6jJzXGZ0r6T/KCY0w45PCtEVwd+eFYTQ7oTOS8QyC+LFTcfWkwESfhwyRh
 4IHNypfnXybJ2r1V6O6wTz/zMUOgFTMl6GWmzrvZZcHF/dMc5ipHqyVhOm2Nnjlp5sb7
 G0QX+1hy7WnaSnZSP3LXRbKn+nu7l1qgzk8AER4W3UNQXjd5U55c2SuL1d2vJx6kTZba
 UqMQ==
X-Gm-Message-State: AGi0PuZAA7fG5KTtWDjZNYmQLf357E5JKPA7hOSC6pYKKCdS+dRmpAPF
 AhDT3LZ6cEKXDCXQG3Bf4SpLzesGauo=
X-Google-Smtp-Source: APiQypIWFA5RMJ3o0ZMuGuP3OraCtKUQkYA6QhvEuSVrnoKiZWNQA2gokSYDO3VT3m7Nm2FxjHWd1g==
X-Received: by 2002:a62:6103:: with SMTP id v3mr8823911pfb.279.1587222258558; 
 Sat, 18 Apr 2020 08:04:18 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id t103sm8668601pjb.46.2020.04.18.08.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 08:04:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] target/ppc: Use tcg_gen_gvec_dup_imm
Date: Sat, 18 Apr 2020 08:04:07 -0700
Message-Id: <20200418150411.1831-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418150411.1831-1-richard.henderson@linaro.org>
References: <20200418150411.1831-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, david@redhat.com, zhiwei_liu@c-sky.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can now unify the implementation of the 3 VSPLTI instructions.

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


