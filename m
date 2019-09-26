Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D7EC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CA7222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHkm5AyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CA7222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYvS-0004Kx-2A
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcW-0007vr-LL
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcV-0006SM-6Q
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:04 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:43020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYcU-0006Q6-Up
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:03 -0400
Received: by mail-wr1-x42c.google.com with SMTP id q17so3603011wrx.10
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r6VB6s6RyVCLLZJnL81+AXJC9Jog/tQxpVEu0gxuGjg=;
 b=AHkm5AyVSVJTSuZAo+piGRYuqdg2e3cDYHXqJwqRSLXwlPm98k6C+k3BSGIG/Nk29r
 wGRxLYJfGfgzfOW/tZnF0iihBND8Y5BfkQCJ7W6wnl+FIAxfRjK1GOBT8yJyv/ANuX50
 u6/NzxI8BlqFFoMIKpUpsXGty2e4Ioa0Z+700AGYp/CywZQDhhcTjQK5X/b8pLv01CuH
 X3rwG/aMqPy/Mhi94BV1ycizeR5ReEUhZH67VWDzoRHwvbCn7YLXiDlhl2KhOeI7VhyV
 QM0J9dBXHphzSaWZaoO3gYMfMjJT1YDuZ2pfr6cq97Roq7GrybmHMSI7m02XPG6/JvFA
 5kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r6VB6s6RyVCLLZJnL81+AXJC9Jog/tQxpVEu0gxuGjg=;
 b=NaHqX6QnyWRu9tBNC6epitgLypcNFtUo5phuon5bKyYZ/LFi2LfIG4DCK55rQSZpOo
 /TwyOJvpjIQgUNvjn4AjntADAvF9VTB/G7nsvWGsxvpWE7IQQukF9C/sznN/ow26pRUY
 eH0RCt8R6CvDpQKiY32pjU2REJaTK3QaI1gHCMrDdYG1Apj8LAkwvtObEK8gxcE2PSTZ
 sF06RjYLqYc43K/XZW1kJZYf6PrdwECvhzAgpeZPULLcw09QJ8NKiAaTeTXLo1WLOWB3
 FqA8Dc5PuSkM2VgIQ5/TRXBKNS8Gwt8OusvVwlfiNYvthKM+r/Aj2fbQbg3mOwUN7Zsd
 AF+w==
X-Gm-Message-State: APjAAAV1sG6ZkYUgSetbVJeyBsk42T1ehhxWV5agtWiDlKUlbMp7XNHB
 XSndTs4IyPlFmbFudxEYxwjKBw==
X-Google-Smtp-Source: APXvYqxCyg37qa47PGra+PbYk1bvMo9AUxcps0kByhd0tb4lwi2zviQfjo5KTtdozxXRnip+E/JI4A==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr3769064wrv.215.1569522960669; 
 Thu, 26 Sep 2019 11:36:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k9sm132135wrd.7.2019.09.26.11.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:35:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DD6C31FF98;
 Thu, 26 Sep 2019 19:35:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 08/28] target/ppc: fix signal delivery for ppc64abi32
Date: Thu, 26 Sep 2019 19:35:33 +0100
Message-Id: <20190926183553.13895-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were incorrectly using the 64-bit AIX ABI instead of the 32-bit
SYSV ABI for setting NIP for the signal handler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 619a56950d..5b82af6cb6 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -501,7 +501,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     int i, err = 0;
 #if defined(TARGET_PPC64)
     struct target_sigcontext *sc = 0;
+#if !defined(TARGET_ABI32)
     struct image_info *image = ((TaskState *)thread_cpu->opaque)->info;
+#endif
 #endif
 
     rt_sf_addr = get_sigframe(ka, env, sizeof(*rt_sf));
@@ -557,7 +559,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->gpr[5] = (target_ulong) h2g(&rt_sf->uc);
     env->gpr[6] = (target_ulong) h2g(rt_sf);
 
-#if defined(TARGET_PPC64)
+#if defined(TARGET_PPC64) && !defined(TARGET_ABI32)
     if (get_ppc64_abi(image) < 2) {
         /* ELFv1 PPC64 function pointers are pointers to OPD entries. */
         struct target_func_ptr *handler =
-- 
2.20.1


