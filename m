Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C940C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB46220724
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUHLYzN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB46220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4Nk-0006Bw-1g
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41w-0002cV-0Y
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41i-0002sI-UZ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:43782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41h-0002pO-Sw
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:10 -0400
Received: by mail-pl1-x635.google.com with SMTP id z6so234743plk.10
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=usEU+0THdbgtBj9wJbgNK97HinYANEa/S4b+EK/lCNc=;
 b=lUHLYzN667EZT0Nj6H7WyPDr0EqytdYFh7d/UuzMtCvJNu30a/fXT/kwkD3atcC6sE
 khzt3PFpiFmhiMOddcsaGkVVIaKBRAxG9E8H38NxQ5S/J0LmSy2oaTt/18hMOeENN/5N
 IIq0ANOj9SsL4lgpO9h7XJPtV/aRW6gX7ZPwUG0fINNyGhAXQV4ld14uS24rSTK8Rrl0
 PPb5wm7FaLoZZI3LgBcp4+llB/p5EztuKYUKGQ9fIR1lGQNcQ0jlf8lVrEy8aVpJHJzk
 TjI/S7NYUJbCYctmMI1Tq7C7iuO/zTsQseg2jm9rqBhwxYpcBdpbG2GVonlJYs8nvH7J
 PWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=usEU+0THdbgtBj9wJbgNK97HinYANEa/S4b+EK/lCNc=;
 b=ZT53BQQkoirejsNDCU7kfJSI2Ukps9xB0Wyp4QcspKKjx5n8yycx6EMSi0/R/RspAW
 /Ln2TqwD8y6fEquiVRM7cahTEtTFu4eBdY/ZZmhQ+3l+aaFvwb2XskGZQWJ9/DtpRHrm
 caA1mr3m37IoBI88yCRZCkCqQwaYRYONEaGEdjv4FJd/qCKBz04v2y9EJDUQKU2VsgyL
 uTa64qu7cEsWUIcPL9tR+jPaT7CgP0BlVFHettL6XVitoDPN7FMcb2XnjEwkv3RsWBkY
 3E8yKl6N8ogu/v0YRO0qUBTnywrKpcpfvuobtrRwyv0ac7GO8EhtgLRtWa269DQUee2h
 W06Q==
X-Gm-Message-State: AGi0PuZL+Re3XJuxd9G2gLASvJIbRJMgAiCZBGCWGke3eRf0qfJKTxtC
 9fmmSbBN1cmYYxQjjMBnY8yVcnXDbK8=
X-Google-Smtp-Source: APiQypLck6hSzuiqpP7Eu09Wp2BOY37EP0jrOEnMIjpI+0qTr48s78JFcSK8RifKfIjyvcE1UQ5hQQ==
X-Received: by 2002:a17:902:d203:: with SMTP id
 t3mr10526531ply.136.1587518287611; 
 Tue, 21 Apr 2020 18:18:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:18:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 35/36] target/ppc: Use tcg_gen_gvec_rotlv
Date: Tue, 21 Apr 2020 18:17:21 -0700
Message-Id: <20200422011722.13287-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::635
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

Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 |  4 ----
 target/ppc/int_helper.c             | 17 -----------------
 target/ppc/translate/vmx-impl.inc.c |  8 ++++----
 3 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index a95c010391..b0114fc915 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -213,10 +213,6 @@ DEF_HELPER_3(vsubuqm, void, avr, avr, avr)
 DEF_HELPER_4(vsubecuq, void, avr, avr, avr, avr)
 DEF_HELPER_4(vsubeuqm, void, avr, avr, avr, avr)
 DEF_HELPER_3(vsubcuq, void, avr, avr, avr)
-DEF_HELPER_3(vrlb, void, avr, avr, avr)
-DEF_HELPER_3(vrlh, void, avr, avr, avr)
-DEF_HELPER_3(vrlw, void, avr, avr, avr)
-DEF_HELPER_3(vrld, void, avr, avr, avr)
 DEF_HELPER_4(vsldoi, void, avr, avr, avr, i32)
 DEF_HELPER_3(vextractub, void, avr, avr, i32)
 DEF_HELPER_3(vextractuh, void, avr, avr, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 6d238b989d..ee308da2ca 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1347,23 +1347,6 @@ VRFI(p, float_round_up)
 VRFI(z, float_round_to_zero)
 #undef VRFI
 
-#define VROTATE(suffix, element, mask)                                  \
-    void helper_vrl##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   \
-    {                                                                   \
-        int i;                                                          \
-                                                                        \
-        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
-            unsigned int shift = b->element[i] & mask;                  \
-            r->element[i] = (a->element[i] << shift) |                  \
-                (a->element[i] >> (sizeof(a->element[0]) * 8 - shift)); \
-        }                                                               \
-    }
-VROTATE(b, u8, 0x7)
-VROTATE(h, u16, 0xF)
-VROTATE(w, u32, 0x1F)
-VROTATE(d, u64, 0x3F)
-#undef VROTATE
-
 void helper_vrsqrtefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 403ed3a01c..de2fd136ff 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -900,13 +900,13 @@ GEN_VXFORM3(vsubeuqm, 31, 0);
 GEN_VXFORM3(vsubecuq, 31, 0);
 GEN_VXFORM_DUAL(vsubeuqm, PPC_NONE, PPC2_ALTIVEC_207, \
             vsubecuq, PPC_NONE, PPC2_ALTIVEC_207)
-GEN_VXFORM(vrlb, 2, 0);
-GEN_VXFORM(vrlh, 2, 1);
-GEN_VXFORM(vrlw, 2, 2);
+GEN_VXFORM_V(vrlb, MO_8, tcg_gen_gvec_rotlv, 2, 0);
+GEN_VXFORM_V(vrlh, MO_16, tcg_gen_gvec_rotlv, 2, 1);
+GEN_VXFORM_V(vrlw, MO_32, tcg_gen_gvec_rotlv, 2, 2);
 GEN_VXFORM(vrlwmi, 2, 2);
 GEN_VXFORM_DUAL(vrlw, PPC_ALTIVEC, PPC_NONE, \
                 vrlwmi, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM(vrld, 2, 3);
+GEN_VXFORM_V(vrld, MO_64, tcg_gen_gvec_rotlv, 2, 3);
 GEN_VXFORM(vrldmi, 2, 3);
 GEN_VXFORM_DUAL(vrld, PPC_NONE, PPC2_ALTIVEC_207, \
                 vrldmi, PPC_NONE, PPC2_ISA300)
-- 
2.20.1


