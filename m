Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC47C73C56
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490F221537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJimV0Dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490F221537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hktD5-00078R-Ds
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 12:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkt7J-000395-9h
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkt7H-0006Y4-Hd
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:20 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkt7G-0006Sx-NZ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:18 -0400
Received: by mail-pf1-x444.google.com with SMTP id y15so9562249pfn.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PPHqcOU6slcSwGsgrcyJjEFtFg9+d324ttSckt/Z6xM=;
 b=gJimV0DnNvB2buu+xaL3SSJYkWWrzWKaECevoaPtXINGhK9fQ/LT0abPIKhw00iUx5
 POddXPQ2HWzB/cCViEcd4VOx/s167WFxnCxD96qLnKZtb0GPd0nSk9wZCEKNdY2zObDg
 otkt+U1wmQDsOB9jUeEwIJs6E3QbQolm197c2mnvdH2MhTO0FxWAQuOSxraXfTe9nO3l
 KhRjGENPRfUqRFqfVDggyFhdSGpN9LP9d894w6OIriRFSsv2yIWi7AK/35uUsKuC6XH9
 RR+AwW1SHmw9fL8K+Pl974+8gvup2wmpXsgzzadWPAd6sjU5fJKSEWun180kWf4zuWYC
 /K7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PPHqcOU6slcSwGsgrcyJjEFtFg9+d324ttSckt/Z6xM=;
 b=YisuoaCLty//Wj7xMSrxp5cz30jJgI4qjh2Oo/K2zQCTwmFMm/sxhOh8f2wUbJ8mln
 QLQJbA54Faagk/feAFjSbHok4y+SatPvE7X0DU37F1D1evTszp6+CJ3ETbhO74dNvPMC
 p/8OQQ2OWTcc4DtYyw+iSI7v1VZqYp5vuQUdLVfkWzeQYPwfjY2Lzyls2kiKm3HV/I/k
 9gLsHj4+8djnihiSo4Su4LlwFp5drCLwYMFyVmcXv0Gqai7sZIXjTEMbiWJmuuRSoW8F
 T1+Oim9eAvhHj1Ju/fXSxfs+pE33A08WK4A5Gc11dVmlkjcwMKyhSsjKBLPcgofgg9kp
 Kt1A==
X-Gm-Message-State: APjAAAXu6YG15fghtjYR97cOKEM/+EdC6kACN1CWA/pSHPrsenGufErt
 2FlelSodxcFLJJbsfajh0vDBLvpMxYw=
X-Google-Smtp-Source: APXvYqwsC1bzreeUt257r/PydH32OXMMYlU4N42hJjX3gw8RpWCNp9CnycPDekkojGuoV1aQHKRqdw==
X-Received: by 2002:a63:221f:: with SMTP id i31mr32438641pgi.251.1562690231687; 
 Tue, 09 Jul 2019 09:37:11 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id v8sm19225231pgs.82.2019.07.09.09.37.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 09:37:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 18:36:52 +0200
Message-Id: <20190709163656.3100-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709163656.3100-1-richard.henderson@linaro.org>
References: <20190709163656.3100-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 1/5] include/qemu/atomic.h: Add
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 pbonzini@redhat.com
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


