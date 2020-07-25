Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9E3C433E4
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 16:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DAC206D7
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 16:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJon6ZFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DAC206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzMho-0003lk-8Q
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 12:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jzMgP-0001sp-FH
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 12:05:57 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jzMgN-0001rW-40
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 12:05:57 -0400
Received: by mail-pl1-x644.google.com with SMTP id x9so6058801plr.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P3LyPyeEcuWa2/MKIfNsGrObBE0H+KsTUZiQvWcLS7o=;
 b=qJon6ZFTh5G2iYoodM/FL3VyvM6wRxCtLL1MAPg741Lm9LZs3zgo7Q0SruRxYrfG46
 UIpNkPD56LpYgBNOr3o0TcsYo5Xr2pe9bnD13iv2n8G+/N0bqmjMqenZBuH6tXHri3h3
 36lQw2+SGiWIl9Fa53cwQxk/ga1p7obiNrKyY+WNIiJYsa1XWCz8M2ymV+hZf+gBB3m3
 1BAOgwiVCT6/YTQ9UOhU+q67/Vsjmb1lAfIT5sN9VJXcoIWWVzcoXf7f7L8QOjzFSMYi
 JqPj9Imi7Ke2xSC+Z7VbF0FfOtCBaWfjY998MxH4PVqt2yxIRvDDNF1YLUFNxGt+k0mA
 ZeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P3LyPyeEcuWa2/MKIfNsGrObBE0H+KsTUZiQvWcLS7o=;
 b=ujYfYc2DIdRh/NR0mZBxLvRsJBe1Lg6tD63t6zRsHYI6QuBYUoSD8F87BxwqGxJGx8
 idCgHZvJYpMpuYBXIEOCjSmnppxtc+QaSZ584MrOi3Rzg6xNOI2qmXlZIaLulfNwZY4h
 FugaFDHyQcqGrKvkH4Y2Dj/M3aV8DLtHySsFXbD6eHh+OIUCF7RmJsJRKf5zpyDOUsgs
 pYso4deCRuBClCM808YlQCXKQGL9UIWGV37hAxpBG5cUPG3IdAYyW1VJMrcbCJrgDfWQ
 noTTvRHgI66jAQ4xnJgGQqQH3y170e23sbYT3kb/mEcvKR3j7Hrmo/Xlgm8EcVvgQg8D
 HcyA==
X-Gm-Message-State: AOAM533r97xVZw5ExlMTp7hLWP23yipbsPXuTinZIZBFbTAtJNOkIcsu
 Xr00/vMaEhwdrhsg8Y6Bb9Bgln25/YI=
X-Google-Smtp-Source: ABdhPJzJRj5ekfNF7+rp5uGs1XTJhf5SIPY1HSfChRkwNUoUM/4t9XF4CHKJFpOsGobl2YZffvYBZQ==
X-Received: by 2002:a17:90a:7103:: with SMTP id
 h3mr8705954pjk.34.1595693152811; 
 Sat, 25 Jul 2020 09:05:52 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id e18sm9731801pff.37.2020.07.25.09.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2020 09:05:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] target/hppa: Free some temps in do_sub
Date: Sat, 25 Jul 2020 09:05:47 -0700
Message-Id: <20200725160548.750749-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200725160548.750749-1-richard.henderson@linaro.org>
References: <20200725160548.750749-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two temps allocated but not freed.  Do enough subtractions
within a single TB and one can run out of temps entirely.

Fixes: b2167459ae ("target-hppa: Implement basic arithmetic")
Buglink: https://bugs.launchpad.net/qemu/+bug/1880287
Tested-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200720174039.517902-1-richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 52d7bea1ea..4bd22d4820 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1294,6 +1294,8 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     save_or_nullify(ctx, cpu_psw_cb_msb, cb_msb);
     save_gpr(ctx, rt, dest);
     tcg_temp_free(dest);
+    tcg_temp_free(cb);
+    tcg_temp_free(cb_msb);
 
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
-- 
2.25.1


