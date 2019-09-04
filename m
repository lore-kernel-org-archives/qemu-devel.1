Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332BEC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24A522CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbPthGKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24A522CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bM3-0002zY-I3
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0K-0004uj-JW
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0I-0002bj-PW
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:44 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0I-0002ab-FK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:42 -0400
Received: by mail-pg1-x543.google.com with SMTP id 4so8228490pgm.12
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=U7L/XkW0Sx1L9zkCTuOn1y4+61r+0iIpJsvReD5rmxY=;
 b=RbPthGKhSrOSS/iRPvl4YUByTNVFLfRkCYR0MMaJdkJP1MXbEvc9Eh8/eOAWr5UL2q
 5dwl8TcXzfR8zbmekhwzfQGlI2dcHwjqkfxtxrLZZbjWxne3v5fSMsCKNtbaw1mknDO9
 I5sjMs1PhysxDvBOWqbKfyqjhuWXF+oXB9gXK8vxwaDRfFyK7trqAldSkS1XR8+M8+rR
 A6ccsgl+RtlC1vL88j6i4d7cMfC09bowUN0RT6yZJK8zgCI7OISbdnvjTzl2gqfIIXnB
 Zw+EfhqjKRZxHGR3mf1KbE8vw1VUJ2MGxZIIbJNbwXI58Fx91kbReSAfDCk/9lbS7PN6
 G2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=U7L/XkW0Sx1L9zkCTuOn1y4+61r+0iIpJsvReD5rmxY=;
 b=pBVrgAECmLI6EzzxhCxdzGrjF2hbiAR47E/tWV28/l02Ik0o+T3F9F9fMYVfmdYEZM
 n3TuT1Yvjz0mSPsXQpa1T+70LRSxd0cnU94UJg41M0cnSOovy9N0HHKw+3WdJ7ZdXVdX
 Ca5KOQ94sk0j/ZEiBuTSVSn38F/5cMx/rrzgrOvtTTsdGw2LADCYHFsm+aJ7cdK/Jllb
 2ulzC7ggvFTT2VWJ5lrEArkRpS3AzHDjcRb9dJYhZFCQKX1llJ401IUjDWileN8YdHfx
 n0WbyDGb+BtnJO4X7+kdnQg0Mmk5QRPDN/i3/lIugOBabtoB/vft1Fs4CHHMvqbPrs2L
 h9GQ==
X-Gm-Message-State: APjAAAWJ1oi7OGLO2HlR2PLsQretCuekKqp996nTRxOT9RIF9whkZ/sY
 75vXcLUHSdqlqGR4RzHOj0powxjgSrU=
X-Google-Smtp-Source: APXvYqxwtfbKSp8K0QvXtfQ+Jt1eP5HJ1f8k485c+oZo715zqU2ssjUNAHpB4WOu81zfyhg776Gf6w==
X-Received: by 2002:a65:6557:: with SMTP id a23mr36592316pgw.439.1567625500863; 
 Wed, 04 Sep 2019 12:31:40 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:21 -0700
Message-Id: <20190904193059.26202-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v4 31/69] target/arm: Diagnose base == pc for
 LDM/STM
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

We have been using store_reg and not store_reg_for_load when writing
back a loaded value into the base register.  At first glance this is
incorrect when base == pc, however that case is UNPREDICTABLE.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b623dbcd48..d0fc916ff9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9863,7 +9863,7 @@ static bool op_stm(DisasContext *s, arg_ldst_block *a, int min_n)
 
     list = a->list;
     n = ctpop16(list);
-    if (n < min_n) {
+    if (n < min_n || a->rn == 15) {
         unallocated_encoding(s);
         return true;
     }
@@ -9943,7 +9943,7 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a, int min_n)
 
     list = a->list;
     n = ctpop16(list);
-    if (n < min_n) {
+    if (n < min_n || a->rn == 15) {
         unallocated_encoding(s);
         return true;
     }
@@ -9983,6 +9983,7 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a, int min_n)
     op_addr_block_post(s, a, addr, n);
 
     if (loaded_base) {
+        /* Note that we reject base == pc above.  */
         store_reg(s, a->rn, loaded_var);
     }
 
-- 
2.17.1


