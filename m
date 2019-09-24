Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDBEC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454142146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXSpLfYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454142146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCsDe-0002ME-Qf
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw4-0002au-L8
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw2-0004Wx-Dk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrw2-0004Vh-1O
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id h7so3622528wrw.8
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nw6PVinSAUrcIMGIAvVonphLXCK81yYui4fSQKYKk34=;
 b=AXSpLfYcj/xcmzMtw+K4+NWtnz7PgT/2uX1kAYlDKCIwZH1yWEk2PYNhMqSr1sSFJO
 1povLVEasmA4SzJAJAh6ozR07ELQ9UeDF68pS1UGbGjBiyWPr2sBtI4dFyFHfEYyWJpt
 EmMP+iPPSuqMmueUS+uGpq42H1rAMsqwqgDcr2dSgQQ0bNsbaVnMII1XCuILGbGWWsWO
 AC7tYBxQ53lLHVM1thPeArtuJEWGuXbGaCFEJtO6eZeJBhrQ7jEMS/HiU2imn3Kwa/07
 ClLS/ptniLJE8kT8HkhKflnIDKiah0Bkl3gIrLir1dTSGVZIX9RiYLIuAlDzTzSFz3oK
 ASDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nw6PVinSAUrcIMGIAvVonphLXCK81yYui4fSQKYKk34=;
 b=jkMxBspoGGAI3lA05JKRyfe7YAs6Ljr9a+aooWiOBnXR3ncIhaAEI4J+j7wIYuoUEi
 hVS9JL613zo7eP0sjgu1Vxtlr1NflKeb8ZlMcx9OOrUzMEBjIJZaMgEpTcuSL8EVIV+d
 JyKfNgcV8wNq0EP5k6gbU7RI21fb9s0FVtcmhcEKuhbcgbBxy8xrAP1gTRnJ0Ph74kZr
 IvZq6h/3qVoZFQ/cEEUjHrkKK135UiAZ/yxDYgWa0YfytiKT0fvLE+LZdb5So05FeMK5
 CM8WPzpAqQnQS4b0tjzTFb13HrRwbkezG7N4ITLFDJSFnN3MPZ/iIV+h6zylgEEwNTKt
 VKSg==
X-Gm-Message-State: APjAAAXyuLhAC1urcfepuyY9ymFWai56uwjaUEqc0aEYq0GaXh1Xdq2h
 cr2qhS5ZEB9gPxOoLmLj0nCHeQ==
X-Google-Smtp-Source: APXvYqyf6oztHkdD+I7LRAQ8MFyV7dwMMo7kCQdpfHqPkGzvX2Zcpfy3b+igeAeY08F3Dc25UdIWkg==
X-Received: by 2002:adf:fe92:: with SMTP id l18mr4574664wrr.369.1569358880701; 
 Tue, 24 Sep 2019 14:01:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l10sm4654754wrh.20.2019.09.24.14.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CD5021FF8F;
 Tue, 24 Sep 2019 22:01:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 21/33] tests/tcg: add simple record/replay smoke test for
 aarch64
Date: Tue, 24 Sep 2019 22:00:54 +0100
Message-Id: <20190924210106.27117-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jsnow@redhat.com, f4bug@amsat.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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


