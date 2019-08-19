Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1581EC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C94214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFz8uKuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C94214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq4w-00070k-Vw
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMr-0002n5-TH
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMq-0006rl-PS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:09 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:44075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMq-0006r8-KJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:08 -0400
Received: by mail-pg1-x52f.google.com with SMTP id i18so1919068pgl.11
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kF1CZ99lxVjaTWt754ZyY2to3WouDjLdCBOKNan1m4M=;
 b=vFz8uKuZmit5soS6CguBmZAPzF3kkBtA1A48gMujR2MFkbY4tsMwzX4oxeEn6CMNJV
 EiU5nL0mO+SHTRBHdqHAR/2wlTgH/mx0QgfCZBrYFtfV9F99X+LekJzpH/fImesP1TlL
 8QAwbl9M9QTvCEhz6uE53mFl6trCxZ81XPDLgMSNjAqwKeZqZctl2DBKiJA3kjUwrgfy
 fiJfSeZt+KUi73bc6aIoYHvvrr8f5IKFtlOTkJ0gggjGbt36tQ5ovmhpLRE7P1x1Cp7v
 UstkRFC6Or5DWTFZxcWyLlyIk5cPy2m8OBrasGrP1GvDf2D8HUU3YfpjXtfjOiyId84q
 YDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kF1CZ99lxVjaTWt754ZyY2to3WouDjLdCBOKNan1m4M=;
 b=rs3977nAzr+2XKP4uRCYKFC1ldf0rEVSy88cwru3OOXxXRvjy6y+cxbP0GA1tebbmc
 Jx+2AyiYzrps93MU+ncPDEHVO9/1ke0egfm0rLBxkyxd+SqEpWtjTkLr+Siaq/uqJDyu
 mOvjO/evO+Do+taDj3urTMRCIjDB7qzwCaPkPcqBJETQGO1FN8J0Zy4FCaBJrhfURhN8
 5CtkF9OylpvX5lKk60nuBr/XX2P7a/ZCbZEiujVC9+freQDyDrUpYT65PKGSX7WIEF7m
 +poVhJUIwcmmcBfCi0PhqB6CFuFCb2jVLvXgmKNMflNym3ZjVOTEKjg7Qt/Jinmgqdbg
 DKQA==
X-Gm-Message-State: APjAAAVnAmwnrdEooRf2kkkT0uOHMPSGj39GGDWZ9CSwm7Knqy0hQ8WP
 8Ro8WZiGMLwF8IXeCMiQuKIOpu1b6dI=
X-Google-Smtp-Source: APXvYqxecODNcnLjg5ds3WZ/0Oo9ZFJ9VK7GaPGvIzulEGBK9W8JEWraay0xdnpHc1NRJA1/TT23vQ==
X-Received: by 2002:a63:6106:: with SMTP id v6mr21518924pgb.36.1566250747235; 
 Mon, 19 Aug 2019 14:39:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:44 -0700
Message-Id: <20190819213755.26175-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52f
Subject: [Qemu-devel] [PATCH v2 57/68] target/arm: Convert T16, Reverse bytes
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 18 +++---------------
 target/arm/t16.decode  |  9 +++++++++
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 368f0ab147..176cba2992 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10608,7 +10608,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, op, rm, rn, rd, shift, cond;
+    uint32_t val, op, rm, rd, shift, cond;
     int32_t offset;
     int i;
     TCGv_i32 tmp;
@@ -10805,20 +10805,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                 break;
             }
 
-            /* Otherwise this is rev */
-            ARCH(6);
-            rn = (insn >> 3) & 0x7;
-            rd = insn & 0x7;
-            tmp = load_reg(s, rn);
-            switch (op1) {
-            case 0: tcg_gen_bswap32_i32(tmp, tmp); break;
-            case 1: gen_rev16(tmp, tmp); break;
-            case 3: gen_revsh(tmp, tmp); break;
-            default:
-                g_assert_not_reached();
-            }
-            store_reg(s, rd, tmp);
-            break;
+            /* Otherwise this is rev, in decodetree */
+            goto illegal_op;
         }
 
         case 6: /* setend, cps; in decodetree */
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 3bf1a31731..ec21be7ef0 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -24,6 +24,7 @@
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
 &rrr_rot         !extern rd rn rm rot
+&rr              !extern rd rm
 &ri              !extern rd imm
 &r               !extern rm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
@@ -195,3 +196,11 @@ SETEND          1011 0110 010 1 E:1 000         &setend
   CPS_v6m       1011 0110 011 im:1 00 I:1 F:1
   CPS           1011 0110 011 . 0 A:1 I:1 F:1   &cps mode=0 M=0 %imod
 }
+
+# Reverse bytes
+
+@rdm            .... .... .. rm:3 rd:3          &rr
+
+REV             1011 1010 00 ... ...            @rdm
+REV16           1011 1010 01 ... ...            @rdm
+REVSH           1011 1010 11 ... ...            @rdm
-- 
2.17.1


