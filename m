Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B53C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D9B206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iO2f8HVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D9B206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmR0-0001qx-Sz
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKJ-0004Ih-T3
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:35 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:41753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKI-0005zF-5L
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:35 -0400
Received: by mail-pl1-x634.google.com with SMTP id l9so1610571plt.8
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m3MYH1ZpDTZxIcPbri13lEz6BY7Q37pNtVKufrg+PL0=;
 b=iO2f8HVeuM/oIfYyxVyt2Vo5YvVjQ16mVl2in0qFsBq5wHHT1RLRfyPXqxChF5kw4N
 WsAJp9ZE2mdD9GNuSHDyJTkJhZr/yEryba8nQP/Ug8a7SfcWE6Enad6lJ7BSEm15723O
 c4xEKiSti9Hy1sF8YqVkA/ufzUHPQnOWOwwGrmT7cqiY6Q/QI3dVBY5wKmqQ79kAC4uw
 s6B0OWT6onLiN5G9K9Aul+AsHq2gJMnNlHNCKQQwHsMnm6WJRq0ro4BZXlueyvrZXLe7
 gGzWOGFDEwBWC7uz/IlElW2ZXZhEYKObQT6Soy1aqjUFsGvd/bNl2cmQ1g0o3s2cs4JB
 taQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m3MYH1ZpDTZxIcPbri13lEz6BY7Q37pNtVKufrg+PL0=;
 b=lWFZb/tVWoJOHXu7KOAUy4lzAXlYC3tGuhpS+bfJjYtZBSIvL77fNFVTrMwdXqdTPw
 7Qr0seUwPfTxTfGymYQqgfv8CwhkjBLEMVdxJzWy6eY4bG1q1/qYtvtNlWzp4G15hVqk
 TIYplKHPn4w/g+nr84e3t10lmOdmWyw2hQrc58qsuxgsnUZBCTx+aqFh+s8+WyypBUSQ
 QNDd1QOkZS1s8rAfXDXatbKvezYTasfa1RRVnMBGAcwTYnRk1VpO5rDMBetPYx6Z+3fp
 P6i8j8KblxE/66Izsqi2C3IjXVRR+imnHvQmtX2uaoz5qZT+rIbv1/mODz6gGdQDoEbL
 KnEw==
X-Gm-Message-State: AOAM531iaG1yM/fQZu/3zmZkCJwdXMPxk4uEbcMRW5EyCf0Yye03ccxp
 NAIar2L2tevcWEDt+1Lrm6IvXx3Ticbz8A==
X-Google-Smtp-Source: ABdhPJzYVNkDh76QEFpxW9rTCs4yTIbmM0jRdJyhBG7T/7n9hcbh6awL/Rj0K18MX4l0QZlOILlBkw==
X-Received: by 2002:a17:902:a58c:: with SMTP id
 az12mr1585331plb.109.1598889992311; 
 Mon, 31 Aug 2020 09:06:32 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/76] target/microblaze: Mark raise_exception as noreturn
Date: Mon, 31 Aug 2020 09:05:06 -0700
Message-Id: <20200831160601.833692-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will allow tcg to remove any dead code that might
follow an exception.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 2f8bdea22b..820711366d 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,4 +1,4 @@
-DEF_HELPER_2(raise_exception, void, env, i32)
+DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_1(debug, void, env)
 DEF_HELPER_FLAGS_3(carry, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(cmp, i32, i32, i32)
-- 
2.25.1


