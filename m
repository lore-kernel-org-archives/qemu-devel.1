Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45D0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5381E2225F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEx5/i1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5381E2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvql-0002Wf-Ep
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvRA-00033R-8p
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:40094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvR8-0006Gt-5e
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id k18so10445809wmj.5
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Eo8B8eKqtkFxDAM1X6l0cuBE2xXVCT/RIfGH6pwI/V0=;
 b=IEx5/i1FFh1fj5Fe+D3Cnm7pWus0uzfQC0T2XgG2XvIa4/1dtinv0hjS1czQxtl2j4
 UKNk+AEUBPDwi6vU3GFWhh9XdRUUUENvr0miDMHaTEmckuU6AtzGzbXH1CKT38AW+Hjf
 JAho3VnFi8GVPuHyX34ZdVkjmjWgmi4qopqC/Y826aC3lrPQY11nO/6HU5/i7Juoo9k5
 3V4j/Ym1a/lH5CYzUdmyGTnEV2PPEmR/BtNoVyAAjR2iR68roTC33JNs4gAmgUgcDYJr
 AYfxiJHxAQYtWOthWW1cmUBi9oDKn4TM4UiBmuzviLqiYxFZYudqRTuoUqUiaIb/3Azt
 vmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eo8B8eKqtkFxDAM1X6l0cuBE2xXVCT/RIfGH6pwI/V0=;
 b=jK6j39RvRsqK6YliucVd3wYTfIxm+tV0F7x2S/0QRWc03qSwke17c1Fe3u8G+UQ+sp
 8qnAupDVcWIrdYG7qXCZ9SH67lrjUg67NpIrIm8jPL2QUXSnIZuxxDV+tFHPTqtPSDtp
 AjfsxzaQ7LZXWc3TQs49guqhCXMKmouJodGy1zaRf2LsYzTxkv+CdUbelrBoeBH6zqHb
 pGefyq1DWK6Ek4PRaKbhtuNZc0Im7f38BUyoqkKdILSFBdqdspRt0tR//qkRfm3hk4pE
 SpdRkGzrtFvBqLpPrL1kYO9o0OD/eH4tIBUwIXebS64aVR0RWRiB3u2JzB16uUhPrFjl
 NItw==
X-Gm-Message-State: AOAM531atQNAAQt8YhXrTAKdFO8uC/qcZrNghD0ZxOiKAn0c66nKoXGh
 FxlXQvFCorjajD0tmpOANdWGXQ==
X-Google-Smtp-Source: ABdhPJyi/3rpYGdyVgTpXoYA1QpFUwrVrT2DeoOw2zPerQZx4+xLUXVTrRYRA5nGTXQnBG/kwyRZrw==
X-Received: by 2002:a7b:cb07:: with SMTP id u7mr14534701wmj.57.1602261604638; 
 Fri, 09 Oct 2020 09:40:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q10sm12913973wrp.83.2020.10.09.09.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:40:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6830B1FF9E;
 Fri,  9 Oct 2020 17:31:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 15/22] contrib/gitdm: Add SUSE to the domain map
Date: Fri,  9 Oct 2020 17:31:40 +0100
Message-Id: <20201009163147.28512-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
Cc: Bruce Rogers <brogers@suse.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Bruce Rogers <brogers@suse.com>
Message-Id: <20201006160653.2391972-10-f4bug@amsat.org>
Message-Id: <20201007160038.26953-16-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 6c5c92260d..d767620837 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -27,6 +27,7 @@ redhat.com      Red Hat
 rt-rk.com       RT-RK
 siemens.com     Siemens
 sifive.com      SiFive
+suse.com        SUSE
 suse.de         SUSE
 virtuozzo.com   Virtuozzo
 wdc.com         Western Digital
-- 
2.20.1


