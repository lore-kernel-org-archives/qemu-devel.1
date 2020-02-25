Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B35C35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D260D24650
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvbyuFBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D260D24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Qiv-0006zF-2E
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 22:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qfu-0002xg-IW
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qft-0005MP-LB
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:22 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6Qft-0005M7-GL
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:21 -0500
Received: by mail-pj1-x1044.google.com with SMTP id dw13so627785pjb.4
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 19:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JkrdoiqyX4e8gyA45brKzFD6ph+2yRZImswzRk/mIGc=;
 b=WvbyuFBzKcpNlyrzXqv4JHYynosDt9HBCGEUJjDhjupzslc/PCVu35vlzWdlhLdHNp
 RWhgD6M3HmpWfdCyCxCuYbIhH4bTrnSns37enZm/t8e4ZYGGABg4nXAqs3EqLc3AGd1p
 S2+oL0QyBCElPZNUrcpZ9SFJuf1Rf58uXtK4jeEwxFbpK/PpKIxbZftminz4v3s5UmA3
 G56t3gl8Qe9dbHNOFs66uyEhOTJqqwQ5wSUwht/PdwydIYPWgawbon4Yab4KfsmG9ixj
 0nEe63Rgp4iElpVflbR1u1lwDlCWcK2sMgQQJDTSbrppGGT8d+l5bCQRW89CKbkynWvO
 iEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JkrdoiqyX4e8gyA45brKzFD6ph+2yRZImswzRk/mIGc=;
 b=TzAmjMTmGUm3E0uGJG5z+MhYr6uYlsQRAl2P6G6Ku8l/8RdTot1Mz9TOLvQo72JH79
 KNmL70bPHyqZSnvC7Muj9lSIWFXUk6tiOzl23Nt5Fufib3W2fUHjoXr7hmLF6kWROT+i
 x1JOhILQ74ptdRPUlOIWhlRjyfCvl0g8WWRvnJjSCBst2OoUbwJzNgJlfDnFk9az1GB2
 pkWQmkQKWdiQPs8q/o3pV/yc02PmEKfJYiyI/waxfRUBnJsLVHVC+vGQC4Pt3eMUTr9a
 sf7MRY8Qon7qn7cyvzsRnXt506J5wqAHBIg3yDMq3oatX+fRf4wYKI+p+w8T5BZp53AG
 2kpQ==
X-Gm-Message-State: APjAAAUTRuusZ615sF6d2OB3TRDru7CtZtJ/ooW49Z72K28NDyeiryM5
 F/jL6knhvIFJZHu97UkQepXtBPRS23Q=
X-Google-Smtp-Source: APXvYqziTIueZeJSM2hDWRd47BfL6RneZpbB7/Y+Axw9YHq51fdIsHj+CDZHXGgHfj60olSkKl3fow==
X-Received: by 2002:a17:902:6ac2:: with SMTP id
 i2mr52311070plt.221.1582600460209; 
 Mon, 24 Feb 2020 19:14:20 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id q66sm14975242pfq.27.2020.02.24.19.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 19:14:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] target/arm: Use DEF_HELPER_FLAGS for helper_dc_zva
Date: Mon, 24 Feb 2020 19:14:11 -0800
Message-Id: <20200225031414.15649-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225031414.15649-1-richard.henderson@linaro.org>
References: <20200225031222.15434-1-richard.henderson@linaro.org>
 <20200225031414.15649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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

The function does not write registers, and only reads them by
implication via the exception path.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index b1a5935f61..3df7c185aa 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -90,7 +90,7 @@ DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
 DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
 
 DEF_HELPER_2(exception_return, void, env, i64)
-DEF_HELPER_2(dc_zva, void, env, i64)
+DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
 
 DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
-- 
2.20.1


