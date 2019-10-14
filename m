Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4BDECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984B6206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7Ojxmkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984B6206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47843 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyZT-0002Zj-FJ
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy2E-0006mz-Ny
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy2D-0005FR-Hj
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy2D-0005E3-Bo
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id a6so16737470wma.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eKrMpcgiWZC+DVZc7vkQy9WeCAb7Sz4gQtueyAwrb/8=;
 b=D7Ojxmkw4cvmOzKkado6gVVj2DOcKqQissrY8svyjqVXwvgtogHyBPZBopxgQbpWiN
 rp2Mij1G96sxQm80gyLWoCf+iSDW3nJqHsONi3vCG1C1B7pEq/Fy2lQbYhPrmtxjlks8
 9rtS/5at8YuKIMOsl958FpdIBkSEvZPA/xcFNxogInaRFnv5TFPHrWFwhXIPUl3PPL1O
 tAFKGuHk/qaVqWZ65zuljf+qEggzaY7G3qr837zzN2OQ+y1aUAQAQKataHqxFa3d/QcY
 FClQW7HOUExAbFgUJarAet+Pdk9KGTKyfuSekI8NqYGotxbckowgkgK3+vSub0HAcYdx
 dmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eKrMpcgiWZC+DVZc7vkQy9WeCAb7Sz4gQtueyAwrb/8=;
 b=I5COyhTcDDW+IQinW03Bgsk0MD6n3KGXAqbsFdScOo+7wBaITbXIS/hQjSrEH1S4E5
 aV2KwC22PVM2asUAz8BNXjCng5AkbA5C6uTPvgWUrxox+MqAIesFPMHYCCqu+QkDRCNz
 Wtq+ztYsKBn1vEmVpOjDHNJMdyXfKGq4rp1EyczcpLWJZM87/oJ8zdtcxOZ08C0HIwu6
 ldDp9AyOePBWgJPERY4b6D0E5QxsZcHln5a+I5mCoXRhAyK5hmGiD+fPcYyuB0IDqPma
 U8Z8iPXHqxKjBRMHSDRv2ornMHRFqxEeFVuL//HjiMbJbaXoPpidHq5r8CYvvvjKphat
 f0MA==
X-Gm-Message-State: APjAAAUMblsIfbw3lRgRt7vj7Juc3ql6hUfH3XuyTyCjmImDmFpDqHFT
 6Hc/zH9n/ClD3FhmylWi0eO/cA==
X-Google-Smtp-Source: APXvYqwrbUNEH2jMsP4ZHD0JlPSqnyfIe9vBEP1GHoFbDDe/r6hAWifPadWc8/1eIEqf6p3BFcsCpg==
X-Received: by 2002:a1c:804d:: with SMTP id b74mr14868065wmd.170.1571050624091; 
 Mon, 14 Oct 2019 03:57:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r2sm28759471wrm.3.2019.10.14.03.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:57:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EF01B1FF9A;
 Mon, 14 Oct 2019 11:49:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 13/55] tcg: add tcg_gen_st_ptr
Date: Mon, 14 Oct 2019 11:49:06 +0100
Message-Id: <20191014104948.4291-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tcg/tcg-op.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index e9cf172762..7c778f96f3 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1249,6 +1249,11 @@ static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
     glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
 }
 
+static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
+{
+    glue(tcg_gen_st_, PTR)((NAT)r, a, o);
+}
+
 static inline void tcg_gen_discard_ptr(TCGv_ptr a)
 {
     glue(tcg_gen_discard_,PTR)((NAT)a);
-- 
2.20.1


