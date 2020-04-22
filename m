Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226E3C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45E5206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yACwE71F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45E5206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR48t-0006jF-VA
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41m-0002Gb-Bn
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41i-0002r1-IT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:14 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41g-0002oX-Jv
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:08 -0400
Received: by mail-pg1-x544.google.com with SMTP id f20so241070pgl.12
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r3EFMKVRtS/SD5amlAn44uoEdKbs7LUTfz55GuERBtY=;
 b=yACwE71FyqjCj0CIXsduUWq/DVP3GUFy9k+4bG3HjOeaUJgNxjloSbHtl2mb4PfZd5
 T54Ktz5yens6qJOG+PZxdSj1vhQoLeV+8vhg7uOkVoSvN04E5eHp/MXmp+yApSSENDo8
 4onOSMHIBGim5qtZyhTAVnSqmg1HmaPo+Arq64RvLmExbQkZDJ87MpZKJRzzB6lSBwMT
 2Bf3JUJlwHmgxjEbgK5jT395aLhNnInDJLW0kE0fE8R1lxzfPu2mNQPJwNKvseF6SgRI
 hzVnzJl9/CkDoHsDqynfckby96OVW53IznRGhP90E9sjlnIDwqcGRfRSlr/UY9cKA+Gh
 XuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r3EFMKVRtS/SD5amlAn44uoEdKbs7LUTfz55GuERBtY=;
 b=gsRkciAs9Hzf7i5oPaunL7YeFNqD9OSTZC+48e2dnK2oJksimy5A8r35pQNsPtMQaC
 MS+yzgjB3i0bhNjPmaywafqeRfhyDUsEmSQkg6XHKihP6H8mOd0ORCQx+54fc/Hx5JlZ
 btLHO9bAdPJAxjl1fhKQSrfxzBTLWT0cMl2TS2w/QhYM5LLStM3dEnKAodYM4vUPKvNs
 HRI8STwyKgbHJjQJo0sEJUa4h7mIsWcIXMYzxCK85+Dd2zPF2utKsU1AtjjZfKjgV0Bm
 Gi7IURryAC/iN3b5VbSDUN2kjMLHheIu1DpRkqxBJDw1KB+L6raBqFz09Pw9GagwS/lL
 IJSg==
X-Gm-Message-State: AGi0PuabyMNzS/lNsNygIrgy3CphlAWDuI7NYcO4/Yoc58R7xG1Gi/3p
 scn5hH1DuuHwz5RWKpRfYL+oQigvHYQ=
X-Google-Smtp-Source: APiQypKR4KtL1k2CI6TT6+K2GqrN7+OweCMPmOzrhpjOA0xWrKwNQ8giyB2RFzDbeT5IqB7EheOK4g==
X-Received: by 2002:a63:77c4:: with SMTP id
 s187mr17879919pgc.169.1587518286386; 
 Tue, 21 Apr 2020 18:18:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:18:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 34/36] tcg/ppc: Implement INDEX_op_rot[lr]v_vec
Date: Tue, 21 Apr 2020 18:17:20 -0700
Message-Id: <20200422011722.13287-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already had support for rotlv, using a target-specific opcode;
convert to use the generic opcode.  Handle rotrv via simple negation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.h     |  2 +-
 tcg/ppc/tcg-target.opc.h |  1 -
 tcg/ppc/tcg-target.inc.c | 23 +++++++++++++++++++----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 4a17aebc5a..be5b2901c3 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -163,7 +163,7 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_rotv_vec         1
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/tcg/ppc/tcg-target.opc.h b/tcg/ppc/tcg-target.opc.h
index 1373f77e82..db514403c3 100644
--- a/tcg/ppc/tcg-target.opc.h
+++ b/tcg/ppc/tcg-target.opc.h
@@ -30,4 +30,3 @@ DEF(ppc_msum_vec, 1, 3, 0, IMPLVEC)
 DEF(ppc_muleu_vec, 1, 2, 0, IMPLVEC)
 DEF(ppc_mulou_vec, 1, 2, 0, IMPLVEC)
 DEF(ppc_pkum_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_rotl_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 3333b55766..3f9690418f 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -2988,6 +2988,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_rotlv_vec:
         return vece <= MO_32 || have_isa_2_07;
     case INDEX_op_ssadd_vec:
     case INDEX_op_sssub_vec:
@@ -2998,6 +2999,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
+    case INDEX_op_rotli_vec:
         return vece <= MO_32 || have_isa_2_07 ? -1 : 0;
     case INDEX_op_neg_vec:
         return vece >= MO_32 && have_isa_3_00;
@@ -3012,6 +3014,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
         return 0;
     case INDEX_op_bitsel_vec:
         return have_vsx;
+    case INDEX_op_rotrv_vec:
+        return -1;
     default:
         return 0;
     }
@@ -3294,7 +3298,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_ppc_pkum_vec:
         insn = pkum_op[vece];
         break;
-    case INDEX_op_ppc_rotl_vec:
+    case INDEX_op_rotlv_vec:
         insn = rotl_op[vece];
         break;
     case INDEX_op_ppc_msum_vec:
@@ -3401,7 +3405,7 @@ static void expand_vec_mul(TCGType type, unsigned vece, TCGv_vec v0,
         t3 = tcg_temp_new_vec(type);
         t4 = tcg_temp_new_vec(type);
         tcg_gen_dupi_vec(MO_8, t4, -16);
-        vec_gen_3(INDEX_op_ppc_rotl_vec, type, MO_32, tcgv_vec_arg(t1),
+        vec_gen_3(INDEX_op_rotlv_vec, type, MO_32, tcgv_vec_arg(t1),
                   tcgv_vec_arg(v2), tcgv_vec_arg(t4));
         vec_gen_3(INDEX_op_ppc_mulou_vec, type, MO_16, tcgv_vec_arg(t2),
                   tcgv_vec_arg(v1), tcgv_vec_arg(v2));
@@ -3426,7 +3430,7 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
     va_list va;
-    TCGv_vec v0, v1, v2;
+    TCGv_vec v0, v1, v2, t0;
     TCGArg a2;
 
     va_start(va, a0);
@@ -3444,6 +3448,9 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     case INDEX_op_sari_vec:
         expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_sarv_vec);
         break;
+    case INDEX_op_rotli_vec:
+        expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_rotlv_vec);
+        break;
     case INDEX_op_cmp_vec:
         v2 = temp_tcgv_vec(arg_temp(a2));
         expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
@@ -3452,6 +3459,13 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         v2 = temp_tcgv_vec(arg_temp(a2));
         expand_vec_mul(type, vece, v0, v1, v2);
         break;
+    case INDEX_op_rotlv_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        t0 = tcg_temp_new_vec(type);
+        tcg_gen_neg_vec(vece, t0, v2);
+        tcg_gen_rotlv_vec(vece, v0, v1, t0);
+        tcg_temp_free_vec(t0);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -3656,12 +3670,13 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_rotrv_vec:
     case INDEX_op_ppc_mrgh_vec:
     case INDEX_op_ppc_mrgl_vec:
     case INDEX_op_ppc_muleu_vec:
     case INDEX_op_ppc_mulou_vec:
     case INDEX_op_ppc_pkum_vec:
-    case INDEX_op_ppc_rotl_vec:
     case INDEX_op_dup2_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
-- 
2.20.1


