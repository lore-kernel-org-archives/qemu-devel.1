Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE76C73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9857B20820
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWNh56k9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9857B20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmcRa-00079e-Kt
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 07:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60329)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hmcR6-0005WB-9i
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hmcR5-0006Ms-Au
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hmcR5-0006Me-4O
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so14178818wrs.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PPHqcOU6slcSwGsgrcyJjEFtFg9+d324ttSckt/Z6xM=;
 b=eWNh56k93wj+RmSdz9aRxl3EMTH1CZOzmYQtY7HwH4K6XbyLBVGryCpg08oI3eD1pF
 ivcEGZwDO0cUkWJXy/rKojvMY/nmKVXvGX+GslGGkBLR0XHju/pKqnWA4k3s2mU09/6k
 qRI8OcCDSwCT1Tktma9XJ8mJBi3jAthYyP2k3gIstLrRDiF6dysGamhUr8ZtdnblOs1n
 bcEAZuiNb/D4bkHP/MxQ/+WN0UvmSxqvgTuxhBCKa2SbJiHtlPIFEu/5kWMtMwFzPF8Z
 WotIGWuj9zxh4NAlwe2Z4MCC+7Du7ZDik14kFsMFBGP67BSR7/+gctzHGkMo4++d6ubj
 SpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PPHqcOU6slcSwGsgrcyJjEFtFg9+d324ttSckt/Z6xM=;
 b=o+vsQDv92qZHkAc36fiOR0nb71DRsjPc7WhfPGDSLU9hfxAx4iNGVZQVsUkohmiQVZ
 tPNVlWxJuOLecgZxDiFfRNvzMZt+Erbdt1N/u1jQfXFJsHEXzliDPzC1jalJDIE0Z2iq
 lrmtNfeSzVqq4yBUwMABcmLF8avLNOKQZo/w7Y8i+huA8iBJax0dQjU2qqQrCUlQI6IN
 9moEdfcPh9JSZ8dU57mAl44HDaGaO0m/duR7wnjN/nc0WsW3y5GAJ/rgPM+OoIj1PNV7
 WDKiun6ZFuAXS453JFQqdiD7iYHIwlkTWt4+342cxEbLcJxapaKH8KC08Sw6lswOML7O
 LAcA==
X-Gm-Message-State: APjAAAUjNyx4Qbe3nfB51m6OZQaGTd0003PKIWVDkP4JkoIjcsHhMy2F
 qB2sWlPc+We3l+4QhXWNakYR9bQ0hvSHCg==
X-Google-Smtp-Source: APXvYqw0nrJ3OUhd5adBMaWiFnaPLQwDzLz8liwvJl1ckU8cjkQC05JoEqAcSlDgb2oKXG9TMc7s+A==
X-Received: by 2002:a5d:4309:: with SMTP id h9mr22181473wrq.221.1563102774015; 
 Sun, 14 Jul 2019 04:12:54 -0700 (PDT)
Received: from localhost.localdomain ([194.144.248.241])
 by smtp.gmail.com with ESMTPSA id f17sm12675795wmf.27.2019.07.14.04.12.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 14 Jul 2019 04:12:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 14 Jul 2019 11:12:45 +0000
Message-Id: <20190714111249.13859-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190714111249.13859-1-richard.henderson@linaro.org>
References: <20190714111249.13859-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL for-4.1 3/7] include/qemu/atomic.h: Add
 signal_barrier
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have some potential race conditions vs our user-exec signal
handler that will be solved with this barrier.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/atomic.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index a6ac188188..f9cd24c899 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -88,6 +88,13 @@
 #define smp_read_barrier_depends()   barrier()
 #endif
 
+/*
+ * A signal barrier forces all pending local memory ops to be observed before
+ * a SIGSEGV is delivered to the *same* thread.  In practice this is exactly
+ * the same as barrier(), but since we have the correct builtin, use it.
+ */
+#define signal_barrier()    __atomic_signal_fence(__ATOMIC_SEQ_CST)
+
 /* Sanity check that the size of an atomic operation isn't "overly large".
  * Despite the fact that e.g. i686 has 64-bit atomic operations, we do not
  * want to use them because we ought not need them, and this lets us do a
@@ -308,6 +315,10 @@
 #define smp_read_barrier_depends()   barrier()
 #endif
 
+#ifndef signal_barrier
+#define signal_barrier()    barrier()
+#endif
+
 /* These will only be atomic if the processor does the fetch or store
  * in a single issue memory operation
  */
-- 
2.17.1


