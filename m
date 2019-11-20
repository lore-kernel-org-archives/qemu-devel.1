Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB09C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACB12230F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPuLurvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACB12230F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNjr-0001k8-0l
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iXNgW-0006yk-ER
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iXNgV-0006sa-7Q
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:08 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iXNgU-0006qh-Us
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:07 -0500
Received: by mail-wr1-x436.google.com with SMTP id i12so27602225wro.5
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8t5kqmOG1TchdK98D192qu2xreWTn22UibKxxRh5FTw=;
 b=YPuLurvi0pYCdiGZsXvJHM0FRTDktG+pTHbzeQinSm+2cZm22+hS70vW5M5VeFliAi
 uwoaifoRo1XMjYz9C59Q+osvTq6jrf8Ans87c0+pk4Wx8Z7GmrR+B2uLPl7Mscdoyakl
 WMp7dDh6CadEPX9w7icT9gBUTtdX2S+SW13o+NUa5QzWbAhGJVM7TISAxAsjlBX8sEWk
 5o2djDLn/EiuFoK3lldy6NOYbBKRRBCjOf94mJbgN4IvLMaumNsHkuhtqCa4n1HDREbY
 yfd1zdaqyavOZJb3d5T2ZQq5AAIqAu/5Jy91DOG5RX2/L9L9HVq270pYZf1BeMRD+iNd
 rbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8t5kqmOG1TchdK98D192qu2xreWTn22UibKxxRh5FTw=;
 b=UF/zoUzRgRqL0R2eey80KOciIaEm9KIn/Vh5YoVzXQV/5PdSYxXsgmo0+i0UfBYSoy
 4mFjU8CD1TkK08XnCFCv0WQ28l2CMPlZ4nAVZwP/JFZ+reWqtkrKPmGCm5HA0N9ohTSY
 fRoghZ6UfvkJV/vIGVJTlxOhX3wh3mDeHp7du0P0PLE8mKUiiAB0rkT2ZHKSafbfZtUn
 v4WOJpNLythSE8rsxyJ7tTOKGZNFyhU7OofQQt4iWBTUgVbRQ0ppVXBpRi9tGPO4oPt/
 tMll/IplVA9duw1baSh3vyXUwGzbYNWD99HCBzOkRXszwowgZylmHaWHH4rhezbxZhN0
 Okbg==
X-Gm-Message-State: APjAAAUic60fos0735b18C32OVVl85v2PluKgHAHcyni1VIwMi5XxRUE
 /Ahqxa702+44jKK7tXdhf7rLIFFlulQ=
X-Google-Smtp-Source: APXvYqxNGbL73gVjdhchKqXq5hJO8cLBiI7FPmoqid7MDkA8sXXV9QWAwK+vG74ayD/hfmpuWQGJpw==
X-Received: by 2002:adf:f4c9:: with SMTP id h9mr2408400wrp.354.1574247485817; 
 Wed, 20 Nov 2019 02:58:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h124sm6644615wmf.30.2019.11.20.02.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 02:58:02 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 58E4C1FF8C;
 Wed, 20 Nov 2019 10:58:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 1/5] tests/vm: make --interactive (and therefore DEBUG=1)
 unconditional
Date: Wed, 20 Nov 2019 10:57:57 +0000
Message-Id: <20191120105801.2735-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120105801.2735-1-alex.bennee@linaro.org>
References: <20191120105801.2735-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While the concept of only dropping to ssh if a test fails is nice it
is more useful for this to be unconditional. You usually just want to
get the build up and running and then noodle around debugging or
attempting to replicate.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 91a9226026d..0b8c1b26576 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -403,7 +403,7 @@ def main(vmcls):
     exitcode = 0
     if vm.ssh(*cmd) != 0:
         exitcode = 3
-    if exitcode != 0 and args.interactive:
+    if args.interactive:
         vm.ssh()
 
     if not args.snapshot:
-- 
2.20.1


