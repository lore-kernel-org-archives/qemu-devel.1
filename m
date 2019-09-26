Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE99FC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A646222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="krPm1BbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A646222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDZGU-0003kU-QB
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 15:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYm8-0002Ig-Pg
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYm6-00050U-Mz
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:00 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:52263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYm4-0004vc-BU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:45:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id r19so3926208wmh.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gro+z/wFLTJjm9Dv+fnOwNEEEX5E90hn1M3fFFejlAU=;
 b=krPm1BbQJvHKVpCrZeEjVwF2f1J4EFQiSP3qi2QhwCuSRyecWg8iS4bvsa4GP2z8KJ
 5aTb8r39E9Zb7Id1WkoRtB5x71V9Hd7mjy7vZuDp1ETfSbJ2OXQYh/FIfMmoEdIsvyJW
 hTYcNnCH1PXT8VEW45mfjW46WhjQa5r7PMhdSuzKxDXR3sKroC/Lf6qx1AVvmPbc9het
 5UFAcLB3qQfoZTkO2vIUZU5pQ+vDKU4I7HjXToGTbRjdanLbNQMiSMwq15uaWXMw5Mkx
 OKnuyoPFNX1CVDeZO8jLeX3T7Ms0Zq0J7v1pSJJmgwVAtE+DBadexCeHM7gE+OpUw/Vn
 /BIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gro+z/wFLTJjm9Dv+fnOwNEEEX5E90hn1M3fFFejlAU=;
 b=DzdALigvq41jszFEt6/CtkVHh55btDlMq5aD3kNmixt2e/dq6aK01MP4bjuavj3h7H
 lAmxJFpvopTd5ZjbPQLebV0fOESLbEgXQ9dGpup+1F/9oV99ZkSZNkyoDQGWAsC9MOCd
 A0EFOyWHLqqWmpbppDxZwirXp/kcncSCYX1jG9ZBFetIY8gdYiUkFA2ioe33jarLa31M
 NXvEF56fo5uAnPuVW6tH5JNzvh4IBY5o7w+DAqJVlQ5+QjZoI0I6MMkOdPrYqr1bsm9H
 QAcjXJYX2LZGsRGXP4MSmld08dwIwch2p65zuhdsltgOmmtauVOLQFKyqLNvsm5WChAB
 p3Yg==
X-Gm-Message-State: APjAAAWtTJsyvn4EZfWo037ICFwfbzWsRQu/y6T4UhlL+xDPVW1eQjgr
 l3Lc7T+0GCJDRnBT0IE2FxVdOQ==
X-Google-Smtp-Source: APXvYqwidT+Jr03F0zCTQomOhN86yGVAUesIEkRPeBKxm8ZsyZFkJiQLYR79TAsVyAxTSu5ceqgH0Q==
X-Received: by 2002:a05:600c:2059:: with SMTP id
 p25mr4410734wmg.50.1569523551010; 
 Thu, 26 Sep 2019 11:45:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v20sm2145002wml.26.2019.09.26.11.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:45:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DFE071FFA5;
 Thu, 26 Sep 2019 19:35:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 18/28] tests/tcg: add simple record/replay smoke test for
 aarch64
Date: Thu, 26 Sep 2019 19:35:43 +0100
Message-Id: <20190926183553.13895-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds two new tests that re-use the memory test to check basic
record replay functionality is still working. We have to define our
own runners rather than using the default pattern as we want to change
the test name but re-use the memory binary.

We declare the test binaries as PHONY as they don't really exist.

[AJB: A better test would output some sort of timer value or other
otherwise variable value so we could compare the record and replay
outputs and ensure they match]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 4c4aaf61dd..b4b3957963 100644
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


