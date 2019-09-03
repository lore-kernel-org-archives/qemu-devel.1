Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F5CC3A5A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1161622CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="olTZ2R3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1161622CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BSy-0007ZO-Ix
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMg-0000wa-79
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMe-0003bt-NC
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:32981)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMe-0003bW-HT
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:04 -0400
Received: by mail-pf1-x433.google.com with SMTP id q10so6012952pfl.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jbHPhdQZ7x2ZGV52UyjN/NFJrOm1MniRZwVlIjy7loQ=;
 b=olTZ2R3y5GJDgg8sueEejnL6LMZHLCjZpdExlJyUFvbSx089gTh3f9bNjbJ0oYxwxP
 7CtFBZ0YLskkl4Fruh2qpT13feJLMPy63vUoLC8HAjeqbeGB2UWL8CGHQfLEdYtVIRnM
 jgf1Ew4z+txqn9lbJeFq/veuHvrIGTXUnYi6OSsRztnS/hiAeTGh9Wl19xxERhVSsh8s
 jl9rvyfX+uaKFiBQIhKTniiXSvj6XBnGb+etpS95fyttJpwCGZjdDP6/j0wObUgwHJGP
 CuYzkEE0nyfuVf4lmKIm7sVzP0Eb+n3qMYIqO3Km3uSZsKv0P5MMevzNxJwkEbIgoE3q
 0bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jbHPhdQZ7x2ZGV52UyjN/NFJrOm1MniRZwVlIjy7loQ=;
 b=UoZTUbbhujRCMP8AlfTr+yonF6gY0jw3MDVPp/lNOgdMBeSs6FROSv0RwsWSXgXLb0
 dLmIdYCDpYPOdddGidx+zJjJ5uG8f+X5UFRIIj/ysvAdnL0JLmb3CofVXbMVE9q7DFSv
 4X5i4tMekwNTfV7pE1u2X0svwLqUNYQJOvgjQaTCN1FDSWNqYRKABcfwkU74ERZfaJTq
 DjN/kN0Aoxo8L6+7wBMSLJO9YbCMVbdiGKILk6bbjdF81ze3gUL+r9sl0N3cF3QXTo4W
 Lsxmng/EDSXksyfAkmrewp08Vqj3S7HjmNBHwxzzQjnbetwQtrfVdCO4Q+d18iIwITTI
 cDmg==
X-Gm-Message-State: APjAAAUUEmz6+3bXk1SO1g+4kkwMaA7pAEgSeGCf1MXNdDHG6555NxzH
 m7UxdgkFbss9FpO3kRhHR4Vgy8u65Z8=
X-Google-Smtp-Source: APXvYqywtrWCdPX0cen7M+npCdlRP6YhLHI/yPk2AJ+gb82tFadkDkGpZozwriawdk+bKNQRjcfS/w==
X-Received: by 2002:aa7:9e50:: with SMTP id z16mr22416693pfq.83.1567526943260; 
 Tue, 03 Sep 2019 09:09:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:24 -0700
Message-Id: <20190903160858.5296-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::433
Subject: [Qemu-devel] [PATCH 02/36] memory: Introduce size_memop
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
Cc: peter.maydell@linaro.org, Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tony Nguyen <tony.nguyen@bt.com>

The memory_region_dispatch_{read|write} operand "unsigned size" is
being converted into a "MemOp op".

Introduce no-op size_memop to aid preparatory conversion of
interfaces.

Once interfaces are converted, size_memop will be implemented to
return a MemOp from size in bytes.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <35b8ee74020f67cf40848fb7d5f127cf96c851d6.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 7262ca3dfd..dfd76a1604 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -107,4 +107,14 @@ typedef enum MemOp {
     MO_SSIZE = MO_SIZE | MO_SIGN,
 } MemOp;
 
+/* Size in bytes to MemOp.  */
+static inline unsigned size_memop(unsigned size)
+{
+    /*
+     * FIXME: No-op to aid conversion of memory_region_dispatch_{read|write}
+     * "unsigned size" operand into a "MemOp op".
+     */
+    return size;
+}
+
 #endif
-- 
2.17.1


