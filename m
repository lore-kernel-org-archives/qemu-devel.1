Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FE2ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E46821A4C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNFSjOXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E46821A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL700-0004f8-QD
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wF-00063L-77
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wD-0004X9-3J
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5wB-0004Sl-0N
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:33 -0400
Received: by mail-wr1-x443.google.com with SMTP id w18so1831167wrt.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O//gTJ1ccAn0kLqEOJo6VegQQGC/e2rAI1ZBzD10O1k=;
 b=RNFSjOXl9v9bTA5OvDtJOyOS8h2aXGXrde9DC+4IxO9k8VgdrdfC3yt7Qg6g+Avtv2
 iFcF2M0K9hSplqXK7iYFixgYZ3lIle6StsO4T8vJy7aGSEaY5k2nQSy7QrKHDT0jZ3mb
 Qihi8RC0OKMLjhf4M4yqr+B9osx43RqgGM9tufDgpw1MkSWAwiMsc5SsLXbLQ5nqa49L
 r4LJmGNrJadYLEz91liA50zMotyA5fbUIMqRfBjiyLJ64EFj7Bh+N3kj+y3SXLD7y3J1
 dcfP6qNjln5p4jMwZX7TmVRxT7dLihDDJnIz5XON2Q5CC4AqLmt4sws3yhnPD6IF0SOx
 26tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O//gTJ1ccAn0kLqEOJo6VegQQGC/e2rAI1ZBzD10O1k=;
 b=CkYlENzLXNe66sxCFBw/1x6hCAEZgjApszHfwhWM/QkWXCzcbiyMSwd7kPSWueVrdQ
 pX1KW2ZFYLnLn3IyVsPdRFR2WseUx3dUk7x0nQSVa+3YUqRorgAxALCV1dJf2vqFJvnx
 +sZ7slqe1/EK8klSwCGQwxX8fW+3t8bCbI0O/Lkpq4Msa4iRFILXDGbBV0cjlFMNnyXf
 he+kIQIquT4GbplezWsiRyA5V6+DckQn8P9OCfx3Neb4q8holL0/doNWFwzbBBpuV7mz
 VyjAXcmwRzj8XFKNC21sj+fMAEmkSSzxgZvDGi0baxUEyu34TcKbVquQTLrhnZacI1c1
 fzWQ==
X-Gm-Message-State: APjAAAUBaW2457qBZy4ekmAH5Yk0VoCd+9fYGQhmQZLQDSVXlPQtGl9x
 zJIgoGdyFz7P4oe7C/QNRoJgyA==
X-Google-Smtp-Source: APXvYqwMZX9dzSPtTi82iEBfRTSQ4SXe06G/XhMKi828qfg113lf8wDVUw+1bpcKQPpxVflzdxahgg==
X-Received: by 2002:a5d:4588:: with SMTP id p8mr3079161wrq.180.1571319329410; 
 Thu, 17 Oct 2019 06:35:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g11sm2227301wmh.45.2019.10.17.06.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C97401FFC9;
 Thu, 17 Oct 2019 14:16:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 52/54] include/exec: wrap cpu_ldst.h in CONFIG_TCG
Date: Thu, 17 Oct 2019 14:16:13 +0100
Message-Id: <20191017131615.19660-53-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This gets around a build problem with --disable-tcg.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index eadcf29d0c..d85e610e85 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,7 +22,9 @@
 
 #include "cpu.h"
 #include "exec/tb-context.h"
+#ifdef CONFIG_TCG
 #include "exec/cpu_ldst.h"
+#endif
 #include "sysemu/cpus.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
-- 
2.20.1


