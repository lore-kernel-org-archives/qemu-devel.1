Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B06C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1141220872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bx3X3xnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1141220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCs4d-0001wb-FA
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw2-0002Yb-6e
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw0-0004Ud-Lt
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrvy-0004SQ-JN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id p7so1866588wmp.4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m1eRzofoxuQrMbNNK2k2mREITVN8XrZ/G/+Fv6KDucg=;
 b=bx3X3xnJ+Wk+zLpj44cb+0EeOuyRBxSc+YaqhfRUh6XW9FJu8v38q7GiFs4UfbazCM
 yp6Rb/R4N93RSDY6hfJJ5G4/nScrX6BDOzIF2/G3jkxxdouAWObADxUuhPhqosNI5vL1
 LTV+uQvDvKzjqMkV0B/sXvqW6dfgQZHmv370EdHjMbbaH7yMkn7TWmS6QEEOaD/vMwc8
 hAXx4/RC+wEwwGMAD8r2/R5TmhSQ1dzV3JUZq4gzWXZrS5g72twoogNsxECwpqsnT20S
 kGLtIOPj3y97rU56LyW1239gZDV68SOy4yw8WlGolo8kC7FpFdcIKgbOfHlKU5lWwwq+
 nwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m1eRzofoxuQrMbNNK2k2mREITVN8XrZ/G/+Fv6KDucg=;
 b=S4K69irWZkcIKJXCUQxFdQAggQzkkAa82Y8xCEDXz7CkRugGrU6o8/TSRtmeuTqE5p
 TwVKyTH63BUwUYbT4/lpvSrs8capwNw1ypCZ3MwVKYjZMvouIGoh+2OGui1KAg+spwyl
 ejsebRA37r4Sh/gqv4zYpgfNnL4qGygJjkhxC3JKmQsVCI3zi0A39JZt0iFnt4M4K+X+
 yd5Em/QcEBWPpZi7kER+CLT1O5vwkE8VpvPVUTRmqf5XKfj8cwZgireGnZ9+PK5/1dCb
 GYCxodZVNN+6sVy5ZaUyYNIzV21NnuBNBBlZ5Q9YyVcT6lcNGEPPvAtOgFqSloKFsLZw
 lHEQ==
X-Gm-Message-State: APjAAAWYzjQyX+ZzDTdtlQdajMxSNsNpyk7lvIHYIViNi0W54FaVUzpc
 bmqVMSeBsyCeTik96rmj4u3bgg==
X-Google-Smtp-Source: APXvYqxR6DlIkVJNJpUkKbFD9M1AoTmjSZZ/8fc7F5SumH8MWFSFZGz1/YrpyKyxnY66OBp2ZrQ87w==
X-Received: by 2002:a05:600c:40f:: with SMTP id
 q15mr2379363wmb.23.1569358871926; 
 Tue, 24 Sep 2019 14:01:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u22sm4841053wru.72.2019.09.24.14.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5EC321FF93;
 Tue, 24 Sep 2019 22:01:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/33] target/alpha: Mask IOV exception with INV for
 user-only
Date: Tue, 24 Sep 2019 22:00:39 +0100
Message-Id: <20190924210106.27117-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The kernel masks the integer overflow exception with the
software invalid exception mask.  Include IOV in the set
of exception bits masked by fpcr_exc_enable.

Fixes the new float_convs test.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190921043256.4575-7-richard.henderson@linaro.org>
---
 target/alpha/helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 1b3479738b7..55d7274d946 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -58,6 +58,13 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
      */
     uint32_t soft_fpcr = alpha_ieee_swcr_to_fpcr(env->swcr) >> 32;
     fpcr |= soft_fpcr & (FPCR_STATUS_MASK | FPCR_DNZ);
+
+    /*
+     * The IOV exception is disabled by the kernel with SWCR_TRAP_ENABLE_INV,
+     * which got mapped by alpha_ieee_swcr_to_fpcr to FPCR_INVD.
+     * Add FPCR_IOV to fpcr_exc_enable so that it is handled identically.
+     */
+    t |= CONVERT_BIT(soft_fpcr, FPCR_INVD, FPCR_IOV);
 #endif
 
     t |= CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);
-- 
2.20.1


