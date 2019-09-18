Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499F5C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EC8218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v9ZHGN5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EC8218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcyy-0006Mu-BX
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAbyJ-0004It-VN
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAbyI-0002O9-EZ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:34:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAbyI-0002NM-4t
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:34:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id f16so574210wmb.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nw6PVinSAUrcIMGIAvVonphLXCK81yYui4fSQKYKk34=;
 b=v9ZHGN5XYk/54c177sVnFKjbEPkLxncglg7jsdAcsu22tqJ+RxztVVzU99jX/ARyrd
 j8Iv6/hi3IoJwFHhqZ2sWP6l9nLdrs8xJpwZAbZBiwDBjyBNH8I/r+U0b7mzCD9c1qgx
 xuENWXFtjPL4n0JUsiBYJfi2iB6ByZEgF+eWsspKgsscMry1J1h+LgSC/aISg9GoN37S
 1Fkt0a1Be77NA10HE0gs4B3U7xoBwXeDm+iFnbT7RUw7Miw1F3JcVOP0GLvEtHxItICx
 QPBbXdDfhDEnVbAJX1XnOcDzup+miOZh2HylW5iIrq93biH1ZxY7sK65F4qPzFEK4Ao9
 ohQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nw6PVinSAUrcIMGIAvVonphLXCK81yYui4fSQKYKk34=;
 b=I6Je9vEsdRNDn8N5QWljR1LXIaN3CjGUxe19mDjcXdP730hR05oZ9QyNcvvkjwx7mN
 VVncMG3hyeZgRXQfq3ftFHd9MDR+JR+n+MdSEMQJ61pDqerlDeXn+mZKVrG5klCZqES2
 p3zANKxFXzx2Do9zmQkRUnblQQ8P6eUHZsBxoUtDzDemchYsregOD7xso56Yy4dTca1N
 ns/3AEyBs361LOtQ8f1z0mJoxxcVbOBCLsHBQ23LiUJwuGAwsvXjsAFQP8y1JoZT2o3s
 CGUI5lLD37d0ARf2bs22EDz8sfWkdOfP1OzR2Uue46ECPTlCKJejeKcFMilB6ruFew3a
 W61Q==
X-Gm-Message-State: APjAAAW4onnRIL28uiF84k2myeWVMUtKdqLCQM6D3+mmXiE8UXzHwP55
 AZwM0kJRwhoqfz4pv9FjUorHeg==
X-Google-Smtp-Source: APXvYqxeMjaSv9noz3Ge8jCt7NSLGZ448kl2U1xp4tRHmzqkrp5abidEFYFNhFvyzdVn4yTHKq+a/Q==
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr3133293wmj.4.1568820860786; 
 Wed, 18 Sep 2019 08:34:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g1sm5199698wrv.68.2019.09.18.08.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:34:20 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 68DD11FF87;
 Wed, 18 Sep 2019 16:34:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 16:33:35 +0100
Message-Id: <20190918153335.20797-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH] tests/tcg: add simple record/replay smoke test
 for aarch64
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
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds two new tests that re-use the memory test to check basic
record replay functionality is still working. We have to define our
own runners rather than using the default pattern as we want to change
the test name but re-use the memory binary.

We declare the test binaries as PHONY as they don't rely exist.

[AJB: A better test would output some sort of timer value or other
otherwise variable value so we could compare the record and replay
outputs and ensure they match]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 4c4aaf61dd3..b4b39579634 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -32,3 +32,24 @@ memory: CFLAGS+=-DCHECK_UNALIGNED=1
 
 # Running
 QEMU_OPTS+=-M virt -cpu max -display none -semihosting-config enable=on,target=native,chardev=output -kernel
+
+# Simple Record/Replay Test
+.PHONY: memory-record
+run-memory-record: memory-record memory
+	$(call run-test, $<, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
+		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
+	   	  $(QEMU_OPTS) memory, \
+	  "$< on $(TARGET_NAME)")
+
+.PHONY: memory-replay
+run-memory-replay: memory-replay run-memory-record
+	$(call run-test, $<, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
+		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
+	   	  $(QEMU_OPTS) memory, \
+	  "$< on $(TARGET_NAME)")
+
+TESTS+=memory-record memory-replay
-- 
2.20.1


