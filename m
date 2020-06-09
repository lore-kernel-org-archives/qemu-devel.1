Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6016C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC7320734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWPDB9JU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC7320734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihDI-000542-Ma
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7F-0005wR-2o
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7C-00016r-LM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id t18so22032137wru.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vpjGR3SSo/dqO1sryzCVOBY48tat7koG6WnUT5kfYuU=;
 b=nWPDB9JU+nbTxbn4pF5AmPVsDUttMUjsBfIKqzfnLIB8zuEuo/nzb+yf8Wp8NHQo/J
 BQJ81QE1F7BJmLvIf2Wlu6ed3/tgPoGCTbaXv2nBcCZ1SvlE0Rw/HIR1IIw95WYoGf4t
 rrRhKy2ZX5rQWV3aTtoDnbIaSpI28qdyQj6R4Z9SM/ihnNklC+NYWW8oKhToHMWFPfqn
 rRLPRWKRhZQF8heAKp/+U0k6dUs2BAsvUHfIe0BJ4UNWA+91l24dM8OT8V9DJaXe7734
 AnkH47FUGPGdFFgtAkbQJTZhFVHhnyo5QxpHwgH246yIwJG1C9smdtiwA9a/nNdUio9Q
 mZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vpjGR3SSo/dqO1sryzCVOBY48tat7koG6WnUT5kfYuU=;
 b=aWbN78bc4MKpoYjAfhZu00nmiWbWx+dHTQHhwao0cz0nUzPMPzSdunLpIFy7NK8mj/
 iDvfBi+XWAr+SPFg1CPXz1Y/R8HqGdYKPziJPe3esihyzLaRSiSCjhR6NLLvEfLRZO8L
 u7qW2I2x0CRvsVZEOX5ZzZcvz5TU6e6t/795sjgSPXbI3qrdM2n+K606xdaABHG2+cZe
 +0CZH9j6gxOO7jV2HEnwtk6abV7Zw2fuzS4iYKZWZzqhYMGpfGvCQX9hrMZ9mPUPQkYU
 4hnUFprmQhzT/BvQZzQgQvHuOHBV0dcobWBrW9zXV5CORO9bKp6ATJ3ZWlfz4puq+G91
 XWIQ==
X-Gm-Message-State: AOAM531rZSM14wckgM4RwSG2zwnfyGyOBnar0NC5WDQFDKOIoKI+alBq
 R6NB9vUbM6y9u/nz+/QmSv/qjtQ4
X-Google-Smtp-Source: ABdhPJyS50Qy5oXcVIlU9JKUPXKJF5VZHhH3RGyv2x6BjdoPTHyf8423br6FTgScxEdButsPpx84kA==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr5341131wrl.265.1591720121137; 
 Tue, 09 Jun 2020 09:28:41 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 23sm3643598wmo.18.2020.06.09.09.28.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jun 2020 09:28:40 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 02/20] mailmap: Change email address of Stefan Brankovic
Date: Tue,  9 Jun 2020 18:28:20 +0200
Message-Id: <1591720118-7378-3-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Brankovic wants to use his new email address for his future
work in QEMU.

CC: Stefan Brankovic <stefan.brankovic@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Stefan Brankovic <stefan.brankovic@syrmia.com>
Message-Id: <20200602085215.12585-3-aleksandar.qemu.devel@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 9f2a3a5..84f3659 100644
--- a/.mailmap
+++ b/.mailmap
@@ -52,6 +52,7 @@ Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
 Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
 Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
 Philippe Mathieu-Daudé <philmd@redhat.com> <f4bug@amsat.org>
+Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
 # Also list preferred name forms where people have changed their
-- 
2.7.4


