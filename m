Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE89FC2D0D3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EB221D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMOwENtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EB221D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdf8-0006ld-1o
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 13:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihdcj-0004q1-0V
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihdcg-0002Pj-HU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:36 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihdcg-0002Kr-7N
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:34 -0500
Received: by mail-wm1-x341.google.com with SMTP id m24so2786339wmc.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 10:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1imCrcgM5GABSpEnuVHZaVNMhwJCUodjjwEZVVhX2x8=;
 b=EMOwENtq4MXI8hlYodzhel4IydXy+3VrYIiKguE0ZYOdK5eGZVWd4OjcvNtVo++KBp
 Ea0bRmKkrMQipAjILsWMWK70CG863YL60cwDCRHd2QwemXcuD0THWS4HxkfTP823BzSo
 AXlKKqqXGp8/oeWFsnTr3/V8BtwNfOVz9BSoBfgdN6/ow365mytg64I1qxyZbsNzpAAh
 wZBNxhhy4IZM12gT9z5PFgEyQ+gEGCh1ofUqVjLAbvEjkxHCxGw59SvUNjyPQ1qWKq/n
 YbNNNB8+Xq3qjFF0Ys8pzYAwK9tvA5NE85+Uv2LxXcZ25t+/jrav9Y3yBNfTwZE35Nk6
 OU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1imCrcgM5GABSpEnuVHZaVNMhwJCUodjjwEZVVhX2x8=;
 b=UI9HQJKo6UsT5by3LcQw6krVqO8vm/nuIytDxavTvTsrMDlj8LhNrDnJv7ajin2lqt
 jH9pNZWba5+fm98QbBcefJEkV1py8c6XAZOEFuntRq9JM/yaeKVjKEbh4Xg5W9Zdt7S6
 TvBU04CcY2tlLzhLaBuhd/pILnPr7Nr0Q6oE1m5ZEJRqqpm0SFX8yWA3AEY8pY9CxY1x
 epl0sReJTuxvXS6UyZm4WEcYjvcBNoFFnFbI3PHDPUYx7QZTv6aOvVbBVwgA80sIHdmV
 ZXRaT62zDSJGxj4wFeZM5mag12B0z5dbLXIdePg091fwrt1cEDozAHLGlG9A2ZlbMkVZ
 09GQ==
X-Gm-Message-State: APjAAAUTxQfVfogWbWUXHutlTuPTTEtJ5wjonOZWRQP7ZFQloP6wUWGj
 IUR5HlC44Q1QvY4/lIBvWgSgV1wddmQ=
X-Google-Smtp-Source: APXvYqyB2e7O6uLViS9FZKWHLP1SIBzw+sueD6XYHlO+8LzW4Edt2dNwpJH5YxNXHN6I7J7SKDVd2A==
X-Received: by 2002:a1c:9e58:: with SMTP id h85mr4811878wme.77.1576692033082; 
 Wed, 18 Dec 2019 10:00:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v83sm3304469wmg.16.2019.12.18.10.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 10:00:30 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0EEB91FF8C;
 Wed, 18 Dec 2019 18:00:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/4] target/arm: remove unused EXCP_SEMIHOST leg
Date: Wed, 18 Dec 2019 18:00:26 +0000
Message-Id: <20191218180029.6744-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218180029.6744-1-alex.bennee@linaro.org>
References: <20191218180029.6744-1-alex.bennee@linaro.org>
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
Cc: pbonzini@redhat.com, keithp@keithp.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All semihosting exceptions are dealt with earlier in the common code
so we should never get here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5074b5f69ca..b4dc2274c8b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8554,12 +8554,6 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     case EXCP_VFIQ:
         addr += 0x100;
         break;
-    case EXCP_SEMIHOST:
-        qemu_log_mask(CPU_LOG_INT,
-                      "...handling as semihosting call 0x%" PRIx64 "\n",
-                      env->xregs[0]);
-        env->xregs[0] = do_arm_semihosting(env);
-        return;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
     }
-- 
2.20.1


