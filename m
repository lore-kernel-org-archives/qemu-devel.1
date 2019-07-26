Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA65C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAD9218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNMjh3w8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAD9218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4cQ-0007C7-7v
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60006)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4OB-0008Rw-60
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4O8-0001hG-35
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:17 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Nq-0001CM-Hi
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:14 -0400
Received: by mail-pg1-x541.google.com with SMTP id i70so14372259pgd.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CpCg1eLgsmeNBuXSBMKJnkt//MK4VjGPzn8vhxLPYT4=;
 b=QNMjh3w8HR3G0vPDqCVV1OMzSsqKpgoqDpwu/LU8YFxUHa4kQaBqG+uioKMmdFuWTW
 hUBr+I48dQ/YYVR456EjtWF2zNlNT8VLGcf9QrtuHWcBuF2EbEY4P0nQBeNAdkggrqQq
 wJWebg3i8Om8Dwz/kvHaNOxP0BTWKXZYrCmoE3yu048+k0r30HiBPgDAijS3cLbOsd3d
 k+V6qSRB/dw8ouyY2nlW2DWrY7gLnrtd/JcSNmovAib/syRZHuLk0e6/VFcH1vJxDMmX
 egcROH59F0gd6umRJZGVnBjb+ChYll7z8GlRFmNLM0TnSCVi12YhfPlr9SqizaMv+ZA1
 StGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CpCg1eLgsmeNBuXSBMKJnkt//MK4VjGPzn8vhxLPYT4=;
 b=pleFhxQa9+WIKrkJNLAI6HdllS0ZUvdKarik4fiiiAQa0Eyh4o3J2QZUjl6KEnNRcX
 cz+VWwFsGzgZOeOQRiHhE4mdnfPbG5SR5osVdihDjfWkd9Ug18g70nE6ke5JfSJd1OaB
 zjIGsvOssW2HJkpc68P/QeW9NC6En7JW0MjAGO3XQDlFUHjAlaIufDMc2IniEeXki/7Y
 qpSNcq6FAzkMNfF26k5ZyYyTkeCA12Bj+btozQ81NvlwUg+ey/tic56o+4u2LR+s9n5h
 vSext6UunTDeUi5Wg4V6nUF3o3CEb+IKRrJhQ6HQEKCbcX4gmjgmexdidaydkV3mI7lp
 1LPg==
X-Gm-Message-State: APjAAAURK1xe1Sr7qNdM0MBgu/m/zKm7+opkXFB8RhFIM1ZlTmN9T6Rh
 KtSWp2q9B1U5Ana7WcEd890oRyto0aU=
X-Google-Smtp-Source: APXvYqzKCOAkEGfTHNztVAyyb3bE75Fpu8/PkllTbGLXMo9IesjJOtIdOukYO8/VmqXjJXRde5ioLg==
X-Received: by 2002:a17:90a:ac11:: with SMTP id
 o17mr100551920pjq.134.1564163512683; 
 Fri, 26 Jul 2019 10:51:52 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:31 -0700
Message-Id: <20190726175032.6769-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 66/67] target/arm: Move singlestep check from
 gen_jmp to gen_goto_tb
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We miss quite a number of single-step events by having
the check in the wrong place.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c2b8b86fd2..9ae9b23823 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2740,7 +2740,10 @@ static void gen_goto_ptr(void)
  */
 static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
 {
-    if (use_goto_tb(s, dest)) {
+    if (unlikely(is_singlestepping(s))) {
+        gen_set_pc_im(s, dest);
+        gen_singlestep_exception(s);
+    } else if (use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(n);
         gen_set_pc_im(s, dest);
         tcg_gen_exit_tb(s->base.tb, n);
@@ -2751,16 +2754,9 @@ static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static inline void gen_jmp (DisasContext *s, uint32_t dest)
+static inline void gen_jmp(DisasContext *s, uint32_t dest)
 {
-    if (unlikely(is_singlestepping(s))) {
-        /* An indirect jump so that we still trigger the debug exception.  */
-        if (s->thumb)
-            dest |= 1;
-        gen_bx_im(s, dest);
-    } else {
-        gen_goto_tb(s, 0, dest);
-    }
+    gen_goto_tb(s, 0, dest);
 }
 
 static inline void gen_mulxy(TCGv_i32 t0, TCGv_i32 t1, int x, int y)
-- 
2.17.1


