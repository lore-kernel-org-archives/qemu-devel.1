Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16123C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D1E206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVCsUdRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D1E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmQA-0004v5-Eq
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJQ-0006qm-E0
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJP-0000vg-2j
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:04 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:42466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJO-0000v4-TV
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:03 -0400
Received: by mail-pg1-x52f.google.com with SMTP id f14so3818015pgi.9
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sTJW6UTbb1j2FRe7m1NuaoxYc6z6Y7/0xQA7i53LXsg=;
 b=mVCsUdROSDlI5lgvf30ZPysYq9Xgc2jLOsgKpsVLAgHaq9pOLvxhOanzl7GO350z5E
 L8oHFylDw10RUjlRVBbW8RZL1Z4GhdyKgU41fMZx40p8coGIIBqq7zDZlmfotIjlAYVh
 7h3U5GRgMDxklvx4KDmk3iNzFabPZHpo6iCc/JsE5pFgRQzD5j+30KygiYnNXkrczqDU
 lqfaAo+vGLCGBzuWRuK/ed3T3WFoS3MIUqwFR1K+v+WCm/AFmB1pgC4N7TwuJ1W+DVkr
 foFcWJOOusvdYLGJhSNmNROXNnTLchAUNEV2SndGCpS3RN8Y63vZpdTlB4q4jE36KkgS
 cpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sTJW6UTbb1j2FRe7m1NuaoxYc6z6Y7/0xQA7i53LXsg=;
 b=n9ygWgszo+Oy/SUpqgyD0VdzEB7ZFx3fsPhKQJb2TlMpmvDdeeFgPRZJFOll4Bc4Sf
 imqJd/Qf3O4VLJTCndMDiv6ZNZHbmWXAZbAuzfWPHiGl6hZgJhO2lruAJrnBqmQllZwW
 TUp3RQV4K/VtDzadCWzqZvv+YzHUOE2cecsPkVQaCBoJTIPj2/ajr3LIuGehMu4J4F1p
 uVoTSAfh9//FV4zD9KakW/R0OevUsA6osUTGDE/E/GWnPFxpYvahfN2dLiRNwEj0lHxw
 a+biQc93HVi2EH7p+dSMLhWGdVeCRFUXtTL9YCji+r/RYI4Cb3nQHxSCjnU8F6ceOsoa
 m+Dw==
X-Gm-Message-State: APjAAAVmkaScuTYZ5Qbgwh2Eb+kq0qz3gL7BTXinHpqY5D9cpBgyxeO5
 s3Ohqxg1edbqt2CGroeV3D8MhUojaLU=
X-Google-Smtp-Source: APXvYqxrtpLA+rWXgZHAdq0+KHmvoxEzeqsPI3UK9xybhqqbvWG0OnKmu5sciE9ZZlzHv5Eg8CdlFw==
X-Received: by 2002:a63:cf0b:: with SMTP id j11mr17358667pgg.240.1571005561158; 
 Sun, 13 Oct 2019 15:26:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:26:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/23] tcg/ppc: Add support for vector saturated add/subtract
Date: Sun, 13 Oct 2019 15:25:32 -0700
Message-Id: <20191013222544.3679-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52f
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
Cc: peter.maydell@linaro.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for vector saturated add/subtract using Altivec
instructions:
VADDSBS, VADDSHS, VADDSWS, VADDUBS, VADDUHS, VADDUWS, and
VSUBSBS, VSUBSHS, VSUBSWS, VSUBUBS, VSUBUHS, VSUBUWS.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |  2 +-
 tcg/ppc/tcg-target.inc.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 13699f1b63..3ebbbfa77e 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -163,7 +163,7 @@ extern bool have_altivec;
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          0
-#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 6cfc78bb59..a1165209fc 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -471,12 +471,24 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
 
+#define VADDSBS    VX4(768)
+#define VADDUBS    VX4(512)
 #define VADDUBM    VX4(0)
+#define VADDSHS    VX4(832)
+#define VADDUHS    VX4(576)
 #define VADDUHM    VX4(64)
+#define VADDSWS    VX4(896)
+#define VADDUWS    VX4(640)
 #define VADDUWM    VX4(128)
 
+#define VSUBSBS    VX4(1792)
+#define VSUBUBS    VX4(1536)
 #define VSUBUBM    VX4(1024)
+#define VSUBSHS    VX4(1856)
+#define VSUBUHS    VX4(1600)
 #define VSUBUHM    VX4(1088)
+#define VSUBSWS    VX4(1920)
+#define VSUBUWS    VX4(1664)
 #define VSUBUWM    VX4(1152)
 
 #define VMAXSB     VX4(258)
@@ -2844,6 +2856,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
         return vece <= MO_32;
     case INDEX_op_cmp_vec:
         return vece <= MO_32 ? -1 : 0;
@@ -2945,6 +2961,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, 0 },
         gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, 0 },
         gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, 0 },
+        ssadd_op[4] = { VADDSBS, VADDSHS, VADDSWS, 0 },
+        usadd_op[4] = { VADDUBS, VADDUHS, VADDUWS, 0 },
+        sssub_op[4] = { VSUBSBS, VSUBSHS, VSUBSWS, 0 },
+        ussub_op[4] = { VSUBUBS, VSUBUHS, VSUBUWS, 0 },
         umin_op[4] = { VMINUB, VMINUH, VMINUW, 0 },
         smin_op[4] = { VMINSB, VMINSH, VMINSW, 0 },
         umax_op[4] = { VMAXUB, VMAXUH, VMAXUW, 0 },
@@ -2971,6 +2991,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sub_vec:
         insn = sub_op[vece];
         break;
+    case INDEX_op_ssadd_vec:
+        insn = ssadd_op[vece];
+        break;
+    case INDEX_op_sssub_vec:
+        insn = sssub_op[vece];
+        break;
+    case INDEX_op_usadd_vec:
+        insn = usadd_op[vece];
+        break;
+    case INDEX_op_ussub_vec:
+        insn = ussub_op[vece];
+        break;
     case INDEX_op_smin_vec:
         insn = smin_op[vece];
         break;
@@ -3277,6 +3309,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_andc_vec:
     case INDEX_op_orc_vec:
     case INDEX_op_cmp_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
-- 
2.17.1


