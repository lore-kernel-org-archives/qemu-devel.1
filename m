Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6155AC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2766D224FE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQTDhDoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2766D224FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2Oo-00018h-N9
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2B0-0004kI-9K
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Ax-0005eK-Uv
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:46 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2Ax-0005ds-PU
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:43 -0400
Received: by mail-pl1-x641.google.com with SMTP id q15so4317639pll.11
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2nm6apASWDrwzmzKxYCzPimVGo2WIvIIu5cuSVCbrLo=;
 b=tQTDhDoh8kzHSPKPKXfSpUDFpWeHa3dU9cPHI5mAZAx8VBlSEJLKYfZMxtRt9JvRYs
 JisL3c1qtx3qjfVsIJjny9zuvlvkc1LJY64Q6frQ2EAZDxTQV58NTkWAnjnrTXf42yEs
 HVZdbsl+Q//YQIg2jlSRunQgs3oSuO3Qgpusxb0s5aEkagasEyYcFKH/imK9yW5m/JVn
 s3exIrFjb9Z6zKbpKr/vCE5jnyCPvJ/gF5j+3Frpqt3wtZTuzLn+ddIN9SJTG/LUV9vJ
 kKEBeeIz/7jNPJQTQ3109ap4mRry5sGia/30+03A4L2cfcDtmhk0mdAHko1X2y7gF3Ws
 1RAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2nm6apASWDrwzmzKxYCzPimVGo2WIvIIu5cuSVCbrLo=;
 b=TbMGhZPgbCoprrYXm8b12rWETy78D7tlAJwuIyOqIZjSwmze19ME5ojWHO1RrBjZW0
 TgKppP1B8rz9lyfjPQy/A49iTY5DdadCJ4mTwrYvha8J+LmcMPCSDl6KXY8J/22zwjq1
 SJmby+EYSx18z1VNuMbAGUumkdNiuIYMaMKrVnKhcExwUZMTIiUkNrOC92YgTEu1QIxD
 YkdRp0qXoKM+Fi6Ih4dcYR0L5l5l9xum/FEvIq+efvNDUsD126IpepnMLbloUG32uFg8
 1pyxrZjRGCL1VHvS4UVXFlZ75S2icoQ1Hs3y5B3JPPZcUoMzMWchntdsLgcb+310G9xl
 asWQ==
X-Gm-Message-State: APjAAAXzyoJNdGaTkQUkTeaw4qI98ydeBB7bNKPBGJJcvKN5Q7kYE2+b
 MUchiYeMKBjkjzFjEGsDkcFlkDobihE=
X-Google-Smtp-Source: APXvYqxXqb7wn47QULafVerVWYgjp/lBtqeBNDJDh8qz7CEi3eo4BKWjneWCiEBQwQMtk1O1Q0wRVw==
X-Received: by 2002:a17:902:b701:: with SMTP id
 d1mr20476004pls.209.1569874902388; 
 Mon, 30 Sep 2019 13:21:42 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 12/22] tcg/ppc: Support vector shift by immediate
Date: Mon, 30 Sep 2019 13:21:15 -0700
Message-Id: <20190930202125.21064-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For Altivec, this is done via vector shift by vector,
and loading the immediate into a register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |  2 +-
 tcg/ppc/tcg-target.inc.c | 58 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 3ebbbfa77e..ffb226946b 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -160,7 +160,7 @@ extern bool have_altivec;
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          0
 #define TCG_TARGET_HAS_sat_vec          1
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index a1165209fc..a9264eccbe 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -514,6 +514,16 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VCMPGTUH   VX4(582)
 #define VCMPGTUW   VX4(646)
 
+#define VSLB       VX4(260)
+#define VSLH       VX4(324)
+#define VSLW       VX4(388)
+#define VSRB       VX4(516)
+#define VSRH       VX4(580)
+#define VSRW       VX4(644)
+#define VSRAB      VX4(772)
+#define VSRAH      VX4(836)
+#define VSRAW      VX4(900)
+
 #define VAND       VX4(1028)
 #define VANDC      VX4(1092)
 #define VNOR       VX4(1284)
@@ -2860,8 +2870,14 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
         return vece <= MO_32;
     case INDEX_op_cmp_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
         return vece <= MO_32 ? -1 : 0;
     default:
         return 0;
@@ -2968,7 +2984,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         umin_op[4] = { VMINUB, VMINUH, VMINUW, 0 },
         smin_op[4] = { VMINSB, VMINSH, VMINSW, 0 },
         umax_op[4] = { VMAXUB, VMAXUH, VMAXUW, 0 },
-        smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, 0 };
+        smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, 0 },
+        shlv_op[4] = { VSLB, VSLH, VSLW, 0 },
+        shrv_op[4] = { VSRB, VSRH, VSRW, 0 },
+        sarv_op[4] = { VSRAB, VSRAH, VSRAW, 0 };
 
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0 = args[0], a1 = args[1], a2 = args[2];
@@ -3015,6 +3034,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_umax_vec:
         insn = umax_op[vece];
         break;
+    case INDEX_op_shlv_vec:
+        insn = shlv_op[vece];
+        break;
+    case INDEX_op_shrv_vec:
+        insn = shrv_op[vece];
+        break;
+    case INDEX_op_sarv_vec:
+        insn = sarv_op[vece];
+        break;
     case INDEX_op_and_vec:
         insn = VAND;
         break;
@@ -3059,6 +3087,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     tcg_out32(s, insn | VRT(a0) | VRA(a1) | VRB(a2));
 }
 
+static void expand_vec_shi(TCGType type, unsigned vece, TCGv_vec v0,
+                           TCGv_vec v1, TCGArg imm, TCGOpcode opci)
+{
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+
+    /* Splat w/bytes for xxspltib.  */
+    tcg_gen_dupi_vec(MO_8, t1, imm & ((8 << vece) - 1));
+    vec_gen_3(opci, type, vece, tcgv_vec_arg(v0),
+              tcgv_vec_arg(v1), tcgv_vec_arg(t1));
+    tcg_temp_free_vec(t1);
+}
+
 static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
                            TCGv_vec v1, TCGv_vec v2, TCGCond cond)
 {
@@ -3110,14 +3150,25 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 {
     va_list va;
     TCGv_vec v0, v1, v2;
+    TCGArg a2;
 
     va_start(va, a0);
     v0 = temp_tcgv_vec(arg_temp(a0));
     v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
-    v2 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+    a2 = va_arg(va, TCGArg);
 
     switch (opc) {
+    case INDEX_op_shli_vec:
+        expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_shlv_vec);
+        break;
+    case INDEX_op_shri_vec:
+        expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_shrv_vec);
+        break;
+    case INDEX_op_sari_vec:
+        expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_sarv_vec);
+        break;
     case INDEX_op_cmp_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
         expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
         break;
     default:
@@ -3317,6 +3368,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
     case INDEX_op_dup_vec:
-- 
2.17.1


