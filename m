Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D762C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD4224679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irOjJcd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD4224679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHEJ-0004fT-2A
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1V-0004eB-UH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1U-0007ZT-Ey
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:49 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiH1U-0007UX-28
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:04:48 -0500
Received: by mail-wr1-x442.google.com with SMTP id w15so9212200wru.4
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KcowZQvidWsL6K9vNr5PA0mK1ZdxCgzSQNRXFm9TCF8=;
 b=irOjJcd5Hps147k7K/cpd9lmlTA7CoOSFEYeMIn3AxcVDzfW/1bPFDx7d1OyfT9u0j
 08aW6EQExY29yRo7vbR8MqtFEScD9Jm7yu7bq6l2uN7lEfrVaNQmAv1HsTAYgByEnp0d
 x7VcJoGuW2RKtf2RVKxUlBLmzxL/hQ+VurnkW+IQcoI4R58hRpMX+LHxfbmhGIceJyOB
 pRU06rLCKUl0wBQyAJraU1pDP4tZq3LYPl6q54TvIJ914Ik3ABTp+N4JQJpy/IJCox9D
 EmNdJFZ8EMy8W2V7rJpjy8bBL5cy0Vz4x7CAAiBWn/lEvmbScYag7nUWlc6SF0SzuWYr
 2YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KcowZQvidWsL6K9vNr5PA0mK1ZdxCgzSQNRXFm9TCF8=;
 b=JCDEShW6mHNHKZvS2lonAbiKedIO3hLJ7fBLtptxJlLkiMWlqA3nIgba6OeUMInM4d
 sG2joAMYu3Qf7zKAVV7FwsHeOcySbN1ri7FMVYIeTOECwHuYFNbc+tfV+J/0rmdhXJNt
 uADEc17BJP2kz4CFuGmRksF3hoagSKV6kdnLmbU+4/uXtCRpQp8Zp1AKxzue4KMbmE0+
 YxLo5FwaajDUDzUOgCikn4m0WZLQlf/BIb+1ngb7g+eSbGXIb/uygDZk57KNBjPfaifj
 r28foXqQO3oCANFzjrs4vv3mRPw1rn4Vg0r/2rdccfM10MwYG3Gf/Cw8FaYJQUB0nflB
 BA2A==
X-Gm-Message-State: APjAAAXmFkdSdgVWxmIsM32M2rq1khjtqJwF03vHmQDT3IWsT5m2F3ND
 fbTR3ELqSVXdaQrL2L9ywwg6hIpvSaI=
X-Google-Smtp-Source: APXvYqwZedeq56y5ptMtDO7Pj6gwgnXhmslFk8lijGsWEpWYOrwyHZtxT+ihtS5SAoejiT8UwvW8IA==
X-Received: by 2002:adf:f78d:: with SMTP id q13mr15035764wrp.365.1576843486808; 
 Fri, 20 Dec 2019 04:04:46 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u22sm9804594wru.30.2019.12.20.04.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 04:04:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5367F1FF92;
 Fri, 20 Dec 2019 12:04:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 05/21] gdbstub: add helper for 128 bit registers
Date: Fri, 20 Dec 2019 12:04:22 +0000
Message-Id: <20191220120438.16114-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220120438.16114-1-alex.bennee@linaro.org>
References: <20191220120438.16114-1-alex.bennee@linaro.org>
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - take care of endianess of the whole 128 bit word
---
 include/exec/gdbstub.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 08363969c14..59e366ba3af 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -102,6 +102,19 @@ static inline int gdb_get_reg64(uint8_t *mem_buf, uint64_t val)
     return 8;
 }
 
+static inline int gdb_get_reg128(uint8_t *mem_buf, uint64_t val_hi,
+                                 uint64_t val_lo)
+{
+#ifdef TARGET_WORDS_BIGENDIAN
+    stq_p(mem_buf, val_hi);
+    stq_p(mem_buf + 8, val_lo);
+#else
+    stq_p(mem_buf, val_lo);
+    stq_p(mem_buf + 8, val_hi);
+#endif
+    return 16;
+}
+
 #if TARGET_LONG_BITS == 64
 #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
 #define ldtul_p(addr) ldq_p(addr)
-- 
2.20.1


