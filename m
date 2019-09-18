Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA43C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DE8208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIDoOFEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DE8208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdly-00084h-LJ
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAdHZ-0003wu-9E
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAdHX-00022N-M1
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:58:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAdHX-00021n-BJ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:58:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id r3so183396wrj.6
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ORDEN7jiztS7uczUBqCzJ8KnmEaF/pHAiuQlY+j2gcw=;
 b=cIDoOFErpym6c77BebgSvuRgwsxy5cu5Ov3FG9u2Tvazz62x0NSAn+BcZ5vtLBerRU
 cbHQ/dfhoF1YnlmvfRdyNjvCAoCBE5zVzbBhWBPVAgqSBWo7qU+DxoR4cxW4xm6iox02
 qct4asAFn43gWtPyU10TrtDTuwfRS9y4/b3+V+niZIVHU4CjykMAw3HE9zl75NZpWOiQ
 mhWdC3DyaqpclcoRLUhfCYNJWXNC6GICv6KZkABJL8YijRs7w+rC3u6CauCun2RIpg7J
 P+fX+akiqrSKXlgOEL/9W7tTT4AIxK0GlGFeBHCFaxZeBs0U0KxBYpHRtfKIy++7r4hA
 oe3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ORDEN7jiztS7uczUBqCzJ8KnmEaF/pHAiuQlY+j2gcw=;
 b=lgGgtkkyaHx5MqYqTskbvWsidqBxRsCoNtPdmcI8sNArPkgg9jLSaftYvsEiUR0Suy
 ylIAWcEHxtOnVWuAnf3u4YiP7BLZgoi02sHKdzgBFGwUoM7/lId//A4j3wssMNl0qu4a
 UKNPXxpHmDBviC7eeT11BPHzNWQzFL7+SVbdiZJS33qKfpjYCm4Swr7t9A3GV8ErFGZn
 hGJNKBeFdGVwdeSvs+49XqY6rK/+3g8YKi5PRPL1J1EWIolK4/EjT+cWmee0TTqpRlXh
 oO6+wYmQCYAEQMKb2cRz1mGFW/YSRximIp3HCkoy4I9VmyqQHWXMDZE/QrwpCLNsPLKW
 ZYAA==
X-Gm-Message-State: APjAAAWNd1NZwinpRN8y9BMqLGNfA7rIL5y6EeEy1rpKdJSTFtfuy98A
 BJijLEwkgA8fSRFloyvNaFD9+A==
X-Google-Smtp-Source: APXvYqwrK3KMrgwinYPcTqRIIzoGLxUUAIA/lkkOVfLVOe75VI12xgrdCjQjOqIVCvVDFvyIAZPuQg==
X-Received: by 2002:adf:eb4d:: with SMTP id u13mr3554846wrn.224.1568825897681; 
 Wed, 18 Sep 2019 09:58:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y13sm13204858wrg.8.2019.09.18.09.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 09:58:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 497281FF87;
 Wed, 18 Sep 2019 17:58:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 17:58:09 +0100
Message-Id: <20190918165809.3719-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190918153335.20797-1-alex.bennee@linaro.org>
References: <20190918153335.20797-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [RFC PATCH] tests/tcg: add time counter to memory test
 (WIP, aarch64 only)
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

To better support testing record/replay we should output something
that would otherwise be variable had it not been pegged to icount.

[AJB: needs a bit of work to nicely work across architectures although
most have some sort of counter].

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 1 +
 tests/tcg/aarch64/system/boot.S           | 6 ++++++
 tests/tcg/minilib/minilib.h               | 3 +++
 tests/tcg/multiarch/system/memory.c       | 6 +++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index b4b39579634..698d9b26b63 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -51,5 +51,6 @@ run-memory-replay: memory-replay run-memory-record
 		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
 	   	  $(QEMU_OPTS) memory, \
 	  "$< on $(TARGET_NAME)")
+	$(call diff-out,memory-record,memory-replay.out)
 
 TESTS+=memory-record memory-replay
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index b14e94f332d..fb7574e9c06 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -220,6 +220,12 @@ __sys_outc:
 	ldp x0, x1, [sp], #16
 	ret
 
+	/* return some sort of counter value */
+	.global __sys_counter
+__sys_counter:
+	mrs x0, CNTV_TVAL_EL0
+	ret
+
 	.data
 	.align	12
 
diff --git a/tests/tcg/minilib/minilib.h b/tests/tcg/minilib/minilib.h
index e23361380ae..29c097c545b 100644
--- a/tests/tcg/minilib/minilib.h
+++ b/tests/tcg/minilib/minilib.h
@@ -12,10 +12,13 @@
 #ifndef _MINILIB_H_
 #define _MINILIB_H_
 
+#include <inttypes.h>
+
 /*
  * Provided by the individual arch
  */
 extern void __sys_outc(char c);
+extern uint64_t __sys_counter(void);
 
 /*
  * Provided by the common minilib
diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index d124502d730..fe32ed27bf8 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -454,6 +454,8 @@ int main(void)
 {
     int i;
     bool ok = true;
+    uint64_t start = __sys_counter();
+    uint64_t end;
 
     /* Run through the unsigned tests first */
     for (i = 0; i < ARRAY_SIZE(init_ufns) && ok; i++) {
@@ -470,6 +472,8 @@ int main(void)
         ok = do_signed_reads(true);
     }
 
-    ml_printf("Test complete: %s\n", ok ? "PASSED" : "FAILED");
+    end = __sys_counter();
+
+    ml_printf("Test complete in %" PRId64 ": %s\n", start - end, ok ? "PASSED" : "FAILED");
     return ok ? 0 : -1;
 }
-- 
2.20.1


