Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C970DC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97101208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pME6FuNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97101208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBWp-0007TF-RV
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42101)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvQ-0002Bt-7S
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvK-0004lL-6K
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvI-0004ef-3m
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id r18so1351378wrm.10
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ORtsrdcOtlazSV007+SAu/zrWhHGlOaKswTJZUeVrI=;
 b=pME6FuNHoGE2J2PTCtiwuV1NhW5fxi1kNlW/LBAi2EuD5xjL1kvNapVP738Cmx1Jqr
 k90bEBqlKktqp35L7KhxZX/kH+QwgubJK9ZUovIDnzJ4w4PHcPjCGENE3eaNXMC7B6rt
 jr9aDyjMCXfa7NyLBiQN333Et0uyLjmVtnMOMOju5pBiqHVmfLnR+LKxZIOh6TFnaXSc
 kY0SJhRTl/FamMUOQuHTNArILU/znaClY4yUqNkpxofoFm4/Bm4jaWuKuzQ9CEVDNGKS
 +UYQmNxal+J1srgTYlRXprygl23dtosZso8lNcHbIW7iSooLDPwlE/K4WLljACzj7LAT
 +MYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ORtsrdcOtlazSV007+SAu/zrWhHGlOaKswTJZUeVrI=;
 b=YLwWqsgoHAAG0shDpPfBwHfDRNsbyXp8/kQFNq8sGkZWRSJ0cZ+EMmpDfcuTymiL5N
 R63gFO4Jo3V9AI5psMy6oehmDafIWIJuxgh4PeE5wmUIMtNNuR+Z/t/XsWIGtXNLRTJn
 OJc5I9gkKhkWzC4Ol6vblKqC+VSL9skydrCO0AUlxLPrsBlMNXAjHDtK8grXjuG/QgoZ
 4uVKkkA47lizmoH+rpQt4PTnGGI10EgGT9QZYizZtPz84m1PVRUoG3bUJAQkHEID5+0e
 sEvHngQvEhSPh6WalkREEQBCbgiIZOkWXkzRF48GjFkANNXG58/48rxfmmp5zGybVSMd
 9zEw==
X-Gm-Message-State: APjAAAXNQQFJ/ExbeBobhnZiLJy71VWpr0x6ZKZOIQcIwikcCSxKBmeS
 o/KmVvj0Evog9L4h+wdmNpoi4g==
X-Google-Smtp-Source: APXvYqyAwtpVI6dmea+QXjJTkNT6NZlz887PO7VFx1qrP5jhtFwNtL4l8L8B/OIvKTVMuGMJ4m6xDw==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr23256095wrq.251.1559898749728; 
 Fri, 07 Jun 2019 02:12:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g5sm1694727wrp.29.2019.06.07.02.12.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 57ACB1FFB4;
 Fri,  7 Jun 2019 10:05:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:28 +0100
Message-Id: <20190607090552.12434-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 29/52] tests/tcg: clean-up VPATH/TESTS for i386
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we only run build the multiarch tests and we use a fully
resolved path for the crt object we don't need the wildcard or VPATH
messing about.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index e1f98177aa..e1d880f9b5 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -8,15 +8,10 @@
 
 I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
 X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
-# Set search path for all sources
-VPATH+=$(I386_SYSTEM_SRC)
 
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
 
-X86_TEST_SRCS=$(wildcard $(I386_SYSTEM_SRC)/*.c)
-X86_TESTS = $(patsubst $(I386_SYSTEM_SRC)/%.c, %, $(X86_TEST_SRCS))
-
 ifeq ($(TARGET_X86_64), y)
 CRT_PATH=$(X64_SYSTEM_SRC)
 LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
@@ -26,12 +21,12 @@ CRT_PATH=$(I386_SYSTEM_SRC)
 CFLAGS+=-m32
 LINK_SCRIPT=$(I386_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
-# FIXME: move to common once x86_64 is bootstrapped
-TESTS+=$(X86_TESTS) $(MULTIARCH_TESTS)
 endif
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
+TESTS+=$(MULTIARCH_TESTS)
+
 # building head blobs
 .PRECIOUS: $(CRT_OBJS)
 
-- 
2.20.1


