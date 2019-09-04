Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B78C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FDA208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptVHTZ5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FDA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5c3B-00080O-58
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0n-0005NE-9v
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0l-000332-8e
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:13 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:41494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0j-0002xn-9u
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id m9so10055597pls.8
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mvEFFgpnrevoU+lFhaPzzFj5g1KNJYV0Nc7dBdlUE/w=;
 b=ptVHTZ5pCK4x2SKJbJUky/7nYPfFcEFhzxz/9NLAUKkyY2bo+dJml+ycY3W/9hDVLp
 BC1ElBZzE8A+2o3b/o3rR1O+kWNKeStrpPDyB4XPv5x7RV6LcmHz3AjEuwABU4K0rP1F
 sxvBFp0ELizYO4TdIOr7crjzXymYMb7EiJiC/wB5pUEMuU0lOvU4MtJeQ4vnqPr+tlTI
 luJs4DDy/umrZVPa/3o5P4B2OOvmwPXECTq0x/Gc4bXvOChniIfV6brkTeAXm3R2MHcb
 Pn9JcddA1bdJUkBbEjWXjNGmOUfZtFr4HcxgIBUcPAcsoHhW++T/q8ybaNloLUrnj//r
 tmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mvEFFgpnrevoU+lFhaPzzFj5g1KNJYV0Nc7dBdlUE/w=;
 b=bNPUGS2ulw2Qq2sPAm5e+Y8Dt1J5XOw8alqjawSwTnuNms2gOxE4peOyZ3gGiXMOZG
 vj8djZzjkUPtfrnBo+yymJA8Jvz38JGCuVxrNd3TOQY+Kvz2/7wqy498X5Iw2FHCTtT/
 3E4cPKVLArvbEKCxkyngV+198ls9k0qaT27H7yp7gXMwqjDS5+WcYmZ8ZSjgJVEAqxoE
 Tq4Ynj2mTrtayToMNCqmp4T/8VkQ/DG0ya6aDLRbVD+8dL6WiHIpjbxfFkkeBKlBc7V5
 +kiVKPiOfeVZng+0gxxQxR5HlfHSTqAl67xfwVMbEpiIqLSbfrzr25//ebUoJBdbMn1k
 isnA==
X-Gm-Message-State: APjAAAVAM9UsJMJsxybhLi2CpLg7A0UiFd3DKPjuYbK852PrBYItE+fw
 vfamIr9kfovxZQKkWjspTuID411akew=
X-Google-Smtp-Source: APXvYqyv8XicDnwQanoC2IvuGVAdIbWJq+dXjUXTh9T2BYo4l19d/B4hThOGZ6zACOc2GGkqINwStA==
X-Received: by 2002:a17:902:36a:: with SMTP id 97mr4447000pld.75.1567625523206; 
 Wed, 04 Sep 2019 12:32:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:39 -0700
Message-Id: <20190904193059.26202-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
Subject: [Qemu-devel] [PATCH v4 49/69] target/arm: Convert T16 add pc/sp
 (immediate)
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 12 +-----------
 target/arm/t16.decode  |  7 +++++++
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4ae73d1c92..d8a4c7bf99 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10868,19 +10868,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     case 7: /* load/store byte immediate offset, in decodetree */
     case 8: /* load/store halfword immediate offset, in decodetree */
     case 9: /* load/store from stack, in decodetree */
+    case 10: /* add PC/SP (immediate), in decodetree */
         goto illegal_op;
 
-    case 10:
-        /*
-         * 0b1010_xxxx_xxxx_xxxx
-         *  - Add PC/SP (immediate)
-         */
-        rd = (insn >> 8) & 7;
-        val = (insn & 0xff) * 4;
-        tmp = add_reg_for_lit(s, insn & (1 << 11) ? 13 : 15, val);
-        store_reg(s, rd, tmp);
-        break;
-
     case 11:
         /* misc */
         op = (insn >> 8) & 0xf;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 1cf79789ac..71b3e8f02e 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -23,6 +23,7 @@
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
+&ri              !extern rd imm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
 
@@ -102,3 +103,9 @@ LDRH_ri         10001 ..... ... ...             @ldst_ri_2
 
 STR_ri          10010 ... ........              @ldst_spec_i rn=13
 LDR_ri          10011 ... ........              @ldst_spec_i rn=13
+
+# Add PC/SP (immediate)
+
+ADR             10100 rd:3 ........             imm=%imm8_0x4
+ADD_rri         10101 rd:3 ........ \
+                &s_rri_rot rn=13 s=0 rot=0 imm=%imm8_0x4  # SP
-- 
2.17.1


