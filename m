Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC9C35280
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9EB22508
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEycODM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9EB22508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2RP-0004Gz-NK
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2B1-0004lu-HK
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2B0-0005hH-Ci
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:47 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2B0-0005gv-7R
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:46 -0400
Received: by mail-pl1-x643.google.com with SMTP id e5so4327174pls.9
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eU6/QJc2xrfxfZzNiKt2RQhZfpRk2OkG4frCv/G8gNE=;
 b=yEycODM/0oxECnH4Tbbm22S75MbJYCQHK818mSScyjNAe0kBVVtaKvn8hAy8RtMb2O
 tMKpNjObClShVvO+22v7qWPd58eaMGqnCsFsILy+KipEzGOWKbXIAlqGfQ218THyBUUE
 Th5nb11vsmjcnwjCPEDVK2bC7tpOSX+Bux/w+cSgI1KBnHHQ8209QKnTUvyQNEjj3Jlq
 pj1ETMQHHC+JKIHlPinLrOudCJOiyDNHllYv2x4LkvddIO/ogi4fa8V0pzMv4qz+rNtV
 aInxKETCApN89cM4xTccWMgLwrMHS13UVIBGd3XH+tZ4/+HuPec8bjeVWC/fK7usVnOv
 29iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eU6/QJc2xrfxfZzNiKt2RQhZfpRk2OkG4frCv/G8gNE=;
 b=OqEl+R2TmN7ELBbxvkZXtvZobK4Ui5x7D5mVz0mY0L5OoIcHA0TeWz5Vd3rf4nz7Nu
 zZ5CaLmhh2kAlIJrFW5VAN37qqx6fq4Oghf+k6DxezFcfFmUPO50GoFq9eeVQkXuzycI
 G4sQ1qOgDRhyHnm7OeWUeKSO/p3jrpAO0fKS193tYh/K80WxOcB7yzQdRgeRWNikMHQL
 wgB6UvI1Sc5TdNZI62D/yB2ti5+w/dbHf9k5klxoQ1gbcDbghdQLoJ9EWoDTjBIVEpps
 kYFoS/GlOYWXSyHF4P7vlFZ9tJi69zi7x9OhPzleYLyuYPjvm5K1KoO6RMxJJZodakhr
 VNbw==
X-Gm-Message-State: APjAAAUTKVoGkbz4zWYu4ibfBSzgpkYsWdGApeJSaLZOanE+UMvi4Tee
 Hsrce4Dn0XRwmonvkWW7Eyyf+4jmS0o=
X-Google-Smtp-Source: APXvYqwNyai+oNom2mA/ZtunPzB4O1K7qgGIgIEItxSt2AzsLrskJmJZomy4GCyALJ5364kTEFQh/Q==
X-Received: by 2002:a17:902:fe81:: with SMTP id
 x1mr21917300plm.66.1569874905017; 
 Mon, 30 Sep 2019 13:21:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 14/22] tcg/ppc: Support vector dup2
Date: Mon, 30 Sep 2019 13:21:17 -0700
Message-Id: <20190930202125.21064-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

This is only used for 32-bit hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.inc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index d4b3354626..8a508136ce 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -3102,6 +3102,14 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_dup2_vec:
+        assert(TCG_TARGET_REG_BITS == 32);
+        /* With inputs a1 = xLxx, a2 = xHxx  */
+        tcg_out32(s, VMRGHW | VRT(a0) | VRA(a2) | VRB(a1));  /* a0  = xxHL */
+        tcg_out_vsldoi(s, TCG_VEC_TMP1, a0, a0, 8);          /* tmp = HLxx */
+        tcg_out_vsldoi(s, a0, a0, TCG_VEC_TMP1, 8);          /* a0  = HLHL */
+        return;
+
     case INDEX_op_ppc_mrgh_vec:
         insn = mrgh_op[vece];
         break;
@@ -3480,6 +3488,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ppc_mulou_vec:
     case INDEX_op_ppc_pkum_vec:
     case INDEX_op_ppc_rotl_vec:
+    case INDEX_op_dup2_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
     case INDEX_op_dup_vec:
-- 
2.17.1


