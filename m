Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A8C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B50206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8f+V00u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B50206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4MI-0003e3-IR
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 18:01:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48023)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Jr-0006WI-CC
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Jo-000458-Cl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:54:33 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:50291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3Jo-00044h-5p
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:54:32 -0400
Received: by mail-wm1-f43.google.com with SMTP id n9so848147wmi.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vI8UZn5YgvLXUBbGW41e3aj469sfNMLp6oyJ3oBawnQ=;
 b=W8f+V00unL4RCehArWvfE8qiiSJ+d4wqsZTiKW6cKnSUhOpXoqIsCJEJHulltqZA8n
 o2aXkZDsY3W0g4sjFy0b+Q/oN+WcpcE5NDBSXTZeSGlbWVxAQi/Z4hsBUb8/PRLMMop/
 8fEoajmFUXJdomE3YZAKoiQCv94k9F0zsgaV2b58X1SQ2GaVN6+3Wx5zTEiI14yecrxU
 O+fZ4OH8YzifrOd90QjHDNVSR0K+XvV0T4r2WWsGLowI3o/i5EuNzfoIsSewoT2HYbB4
 T1QfGw0qT+jWKAuUpde1Tp5zJufL9n21cI3s/pfyMEkOpYNAGIaZEzyZKdt9bSFWg0ah
 modw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vI8UZn5YgvLXUBbGW41e3aj469sfNMLp6oyJ3oBawnQ=;
 b=hEwXCxDw4+1JPV6chayJG45pXEDlzIdaaYdD6syGuQHD7KbAYh7SiEVwbPCTNtcPki
 ryTd/hJyO6txIsOhVi5+gTiS9PYRWvdrSVeVk9p7073TRGCz64f36/f3IDbJ7pFLwmv9
 05ryJ77fskD55pkqK9Ob5reIFoXOQKVPDUuW486Z1Tx9ROVKGn/l8UAKc0az11QaszWn
 tCC3uENOJi7k7kBVA6xiyjPGMb+/MOWHXUYYkHJzYpAsFRM+1fODa7afcZZphkzHCROM
 KVDYVZHZ4AgWDSXndlIDU50aan6My3SqMUbXPR2DNdMNCQExPWPIg5qVDg+lYhW0fAya
 6AWg==
X-Gm-Message-State: APjAAAX5iYvWmh99rjcykfHDhLsU/9VG9Clhqs4LT3ahvNvB8bvCUq19
 LSCjJLfb2wUCxPGryKj0euCxR8nMGh/rsw==
X-Google-Smtp-Source: APXvYqwYy2lZl+DwG0N4YokSPQ4JLYdcVzaf+iODcPG3PEj+vqoQQ750lmjGv5hfB8nxtTWZoLpy5Q==
X-Received: by 2002:a1c:b707:: with SMTP id h7mr114963wmf.45.1561999216099;
 Mon, 01 Jul 2019 09:40:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:25 +0100
Message-Id: <20190701163943.22313-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.43
Subject: [Qemu-devel] [PULL 28/46] target/arm: Makefile cleanup (Aarch64)
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Group Aarch64 rules together, TCG related ones at the bottom.
This will help when restricting TCG-only objects.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-2-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/Makefile.objs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index dfa736a3752..7c31fa01c1c 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -7,8 +7,7 @@ obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += neon_helper.o iwmmxt_helper.o vec_helper.o vfp_helper.o
 obj-y += gdbstub.o
-obj-$(TARGET_AARCH64) += cpu64.o translate-a64.o helper-a64.o gdbstub64.o
-obj-$(TARGET_AARCH64) += pauth_helper.o
+obj-$(TARGET_AARCH64) += cpu64.o gdbstub64.o
 obj-y += crypto_helper.o
 obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
 
@@ -33,4 +32,6 @@ target/arm/translate-sve.o: target/arm/decode-sve.inc.c
 target/arm/translate.o: target/arm/decode-vfp.inc.c
 target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
 
+obj-$(TARGET_AARCH64) += translate-a64.o helper-a64.o
 obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
+obj-$(TARGET_AARCH64) += pauth_helper.o
-- 
2.20.1


