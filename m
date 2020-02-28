Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A37C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588A72469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQJ7tLmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588A72469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7lHt-0007Ws-JR
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 14:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j7lFG-0003Wx-8a
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j7lFF-00060J-8M
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:22 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j7lFE-0005zE-RV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:20 -0500
Received: by mail-wr1-x442.google.com with SMTP id v4so4268845wrs.8
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 11:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=60CqZg7BZfR1xnQfWxmp/hW3ExnnXGerh7BjsN5qqsw=;
 b=wQJ7tLmCk2n6mJft+pmcYUL7yRG61S/J3nvLZjtJVivba+it7vyCmCTgHl+MdHOHmj
 38YfbaeRGc62Ya7EuTgkn/lkXJnG4c2TGF1SIIPHZEAfVfrY711uSRPW4HguVAhaCJ/C
 EacS9J0R6MOrcMijLoc40JB+6P6/afgThuWmImSCpiicerT/fEAVXu8QnaARSmeEtoZZ
 PbfTVNgN57AkZiCky3EvvRS1jKubejcLrORGY9eAUb5lzJeT79EopSP8nyYOQjxK+6yn
 Aplhg9Npj3xm176+gAfwcGbG4amf+qoN+LSrk7z0RpT7U08IJyMdYExd4+YID1QP53MY
 YzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=60CqZg7BZfR1xnQfWxmp/hW3ExnnXGerh7BjsN5qqsw=;
 b=Hkg2CwtWQLmsu7Z6iPw3wheA3jkNAGbUOvfGX4+1FFg44rJIrWYlJtOpH1yDo5W4TV
 6XeJMHj9esXI3X2nzIkp4Xa4cCl2iPVIJIXvLoHzk6JvVBkjHCb8s+mWsYcalyvWjVY/
 O8BzcP/fwkcJSCYdjt2jQtzRyiev/dgPUIqJ3SrNziJr/BQvvgOPiTt5tUw4hza8PQd0
 QhvmaxiSlLTZ6icyQTouDBheFv8aSQbgjWyvzuz2sszuc3puO0Aa4/tULPe0AFk03IXs
 C1Bbz8UiZbGtiLkfP2fJy9hc3sg1kzstL7EhUBs1Zr4Yu72mP1q5UB2cRCoNHTp8NAth
 d+4Q==
X-Gm-Message-State: APjAAAUvrktGUuxmr/y0uXhliQZ1TKtrMWhrce7/5NaG+srOu9f6LMJF
 Hp0vOre37EKh72XBVH4+OCQFsg==
X-Google-Smtp-Source: APXvYqwgvtxjGhdW0mhDrhkJSbzRBHz+1Af3ub82MTc8010b5Uzv7Vugw03T8/4oIf4SG+X0yXucyg==
X-Received: by 2002:adf:ded2:: with SMTP id i18mr333585wrn.173.1582917859408; 
 Fri, 28 Feb 2020 11:24:19 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f207sm3486974wme.9.2020.02.28.11.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 11:24:17 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D57A1FF8F;
 Fri, 28 Feb 2020 19:24:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] accel/tcg: remove link between guest ram and TCG cache
 size
Date: Fri, 28 Feb 2020 19:24:13 +0000
Message-Id: <20200228192415.19867-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228192415.19867-1-alex.bennee@linaro.org>
References: <20200228192415.19867-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Basing the TB cache size on the ram_size was always a little heuristic
and was broken by a1b18df9a4 which caused ram_size not to be fully
realised at the time we initialise the TCG translation cache.

The current DEFAULT_CODE_GEN_BUFFER_SIZE may still be a little small
but follow-up patches will address that.

Fixes: a1b18df9a4
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 accel/tcg/translate-all.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 238b0e575bf..5b66af783b5 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -938,15 +938,7 @@ static inline size_t size_code_gen_buffer(size_t tb_size)
 {
     /* Size the buffer.  */
     if (tb_size == 0) {
-#ifdef USE_STATIC_CODE_GEN_BUFFER
         tb_size = DEFAULT_CODE_GEN_BUFFER_SIZE;
-#else
-        /* ??? Needs adjustments.  */
-        /* ??? If we relax the requirement that CONFIG_USER_ONLY use the
-           static buffer, we could size this on RESERVED_VA, on the text
-           segment size of the executable, or continue to use the default.  */
-        tb_size = (unsigned long)(ram_size / 4);
-#endif
     }
     if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
         tb_size = MIN_CODE_GEN_BUFFER_SIZE;
-- 
2.20.1


