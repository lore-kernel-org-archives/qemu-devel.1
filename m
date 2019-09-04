Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41803C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C410208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7dq5PIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C410208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5czY-0005kn-Ds
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9f-0006Lo-VV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9e-0006wr-6O
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:27 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:36738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5c9d-0006uS-Rr
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:26 -0400
Received: by mail-pf1-x432.google.com with SMTP id y22so43020pfr.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NowncHpSDSkPNMutAvoqlBrylOrG45DqZfrkIkTwcGo=;
 b=U7dq5PIApEKMxfyC3GQLtXN64XNtz7tZ0YKauAe1qs31PFMxrzyRzGbyhkJtqIt+q1
 R0NVD6GMI/TyJzv0Y8X2LROpA+PFNuUEEjg/XccJxKfXIcwzMyVj78fsdVDJ4F1sSZ9x
 9Dp8WO5Qb9+MnWLnkWOu8SrNud9mkxZDyCOK5ppBY1M2hKF7UG3bAea/frFi+lLIYrB1
 tc6X5w3keVpPfWyYU0acsyZMtvnwqcN0VawP1qzf+WNxqOYvA18XlRq2msw9/6JTCAVS
 Ki+HpdGrGcgjA8QXUln7Ti0Bs8SWwKFlgS4ablsJgtSE1gNw+K22m7H4grcDzGvdEHax
 tIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NowncHpSDSkPNMutAvoqlBrylOrG45DqZfrkIkTwcGo=;
 b=KoAs6dmrIJE6CD9BpH0HnCDFMweRmuTD7T9t/rOs7YUHFhH0tb9Ylmnk2kRKJSPFy1
 RfpQdwpijZSBSWnp4lqd2FmGurPFin6qogPuPV9g8l6Pv/m/oyWw3W9vjeTsOY6w1nbn
 AAzqtlAIFO00AL8tUss7l+OkdaHhgYM4eBh6ix2gnVs1heu5TFG6uGOkSY5FtFQBlg8S
 Dw0isHSTMoXmVCcXzSRyyOhXtDOQowIC52EIi3hAFVDtkc36FwKUT8b8JsVo5JdW4dF1
 GDEWcXF/2W/vOg9TlRRD4SFSdfJB+P5e4rl4HYUwusmK0QywyekgPBg4Le6DLZQPwHey
 1Amg==
X-Gm-Message-State: APjAAAUtXnDS4qSn0iHW9EiUKPwh0i6qOkEKTNYO1IwQaY6lMbRZ4Pfj
 tSLwfK2kMiJRoP/NpcAPT27JducvHeM=
X-Google-Smtp-Source: APXvYqyp3kBv11Aqqp+e7O1pfnBQWxooid3mIazeAY/dh2AOB0dEPlt2PzuitzvVJioRsOeislviqA==
X-Received: by 2002:a17:90a:f0c9:: with SMTP id
 fa9mr120822pjb.137.1567629924024; 
 Wed, 04 Sep 2019 13:45:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n66sm8104610pfn.90.2019.09.04.13.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:45:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 13:45:06 -0700
Message-Id: <20190904204507.32457-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904204507.32457-1-richard.henderson@linaro.org>
References: <20190904204507.32457-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::432
Subject: [Qemu-devel] [PULL 12/13] target/openrisc: Implement l.adrp
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This was added to the 1.3 spec.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/disas.c      |  1 +
 target/openrisc/translate.c  | 13 +++++++++++++
 target/openrisc/insns.decode |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/target/openrisc/disas.c b/target/openrisc/disas.c
index e51cbb24c6..ce112640b9 100644
--- a/target/openrisc/disas.c
+++ b/target/openrisc/disas.c
@@ -98,6 +98,7 @@ INSN(sw,     "%d(r%d), r%d", a->i, a->a, a->b)
 INSN(sb,     "%d(r%d), r%d", a->i, a->a, a->b)
 INSN(sh,     "%d(r%d), r%d", a->i, a->a, a->b)
 INSN(nop,    "")
+INSN(adrp,   "r%d, %d", a->d, a->i)
 INSN(addi,   "r%d, r%d, %d", a->d, a->a, a->i)
 INSN(addic,  "r%d, r%d, %d", a->d, a->a, a->i)
 INSN(muli,   "r%d, r%d, %d", a->d, a->a, a->i)
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 6e8bc23568..6addbac8d6 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -799,6 +799,19 @@ static bool trans_l_nop(DisasContext *dc, arg_l_nop *a)
     return true;
 }
 
+static bool trans_l_adrp(DisasContext *dc, arg_l_adrp *a)
+{
+    if (!check_v1_3(dc)) {
+        return false;
+    }
+    check_r0_write(dc, a->d);
+
+    tcg_gen_movi_i32(cpu_R(dc, a->d),
+                     (dc->base.pc_next & TARGET_PAGE_MASK) +
+                     ((target_long)a->i << TARGET_PAGE_BITS));
+    return true;
+}
+
 static bool trans_l_addi(DisasContext *dc, arg_rri *a)
 {
     TCGv t0;
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index 71e0d740db..0d6f7c29f8 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -102,6 +102,8 @@ l_maci          010011 ----- a:5 i:s16
 l_movhi         000110 d:5 ----0 k:16
 l_macrc         000110 d:5 ----1 00000000 00000000
 
+l_adrp          000010 d:5 i:s21
+
 ####
 # Arithmetic Instructions
 ####
-- 
2.17.1


