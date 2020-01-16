Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1736BC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D271D2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXBXpD55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D271D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isEIB-0005va-Vk
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 18:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isEFZ-0002ix-Dd
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isEFY-00085Y-BM
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:29 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:45625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isEFY-00085G-6L
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 18:08:28 -0500
Received: by mail-pg1-x535.google.com with SMTP id b9so10655000pgk.12
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 15:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tr0oxdmAfzE1nW8KiWlCJDKgMy/qK0eB4ARHFT7qrQI=;
 b=PXBXpD555MuimMsvzvUvu/yFuV61mYbPW7BErCgkYo3m1v/dm2qfjmbOxxUKK2z48f
 umWOyCx0NQDytwBwcHui2OUCkTv9ojUpDu7YuxVcd0IdRkcs0tkNtYfUM0ZQMXawBUBq
 9ctitZkvBBfvAkAH3GpJAyS94ObiaGfq/HyknG8kpX+j56Ae78Ud3wExDo6ziVEV35hu
 lawwzkcRsVqObrQJk/4kUpVDf7fFfbWyLZzG8DeaIrUzE1D+/HNhC99CKkrTXElU8eBC
 ALUWY5O4sFNSx9dCTVnkoJ9JGllHXioA90+7oIzYwgE0DcPocV8FfKjy/O3L0BEU3hoW
 GxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tr0oxdmAfzE1nW8KiWlCJDKgMy/qK0eB4ARHFT7qrQI=;
 b=hDjr6cfOgJoBI+ymzNp/DgXDX2ZMyhAoNfAfALwGApKkztraePxp0vFAh9JG24jW2c
 yAK5Aq0TqTU+gXpLH3tnid9ltJAcpbVUbRYC4zwxX+xNd+2+x9BHtIH3Wn5rUeKGbr6w
 3sDp1yupoYmvumivOhC652zNEEAwuWIFMQ8aXLE428j4Aaezhaxv2S3EPCQZDQQxAGos
 PpIVKlw5zUJ3mfz2JR93mFXsX5Hfx1ZKA52r5iO5DddoGMZAe0f2g/g2JIwI73jgbJYa
 OhBYQM9H/+4MRToMb16ArD/XI+qtMSN0i+XGirvCbFE5LtiwwaLBsnXujpUN28T6YHB4
 gEHA==
X-Gm-Message-State: APjAAAWMhEHsWyCUtH4+GHcpHSqJwEpvnh6bE2AxGe1rUWVnPiHqXJKW
 zrb+jVuBf+CEF9OQibaEMvk2aoGx6Wo=
X-Google-Smtp-Source: APXvYqyOiXAOqTSky9MAEDwVv2DNq+yVeywQx46rb51Rq45g6S9fOYx3D/pDtzN4qU/saIvfpBWgtA==
X-Received: by 2002:a63:5964:: with SMTP id j36mr42477266pgm.225.1579216106685; 
 Thu, 16 Jan 2020 15:08:26 -0800 (PST)
Received: from cloudburst.ASUS (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id s7sm5111578pjk.22.2020.01.16.15.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 15:08:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] tests/tcg/aarch64: Add pauth-4
Date: Thu, 16 Jan 2020 13:08:09 -1000
Message-Id: <20200116230809.19078-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116230809.19078-1-richard.henderson@linaro.org>
References: <20200116230809.19078-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::535
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
Cc: peter.maydell@linaro.org, vincent.dehors@smile.fr, alex.bennee@linaro.org,
 adrien.grassein@smile.fr
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Perform the set of operations and test described in LP 1859713.

Suggested-by: Adrien GRASSEIN <adrien.grassein@smile.fr>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/pauth-4.c       | 25 +++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 2 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/pauth-4.c

diff --git a/tests/tcg/aarch64/pauth-4.c b/tests/tcg/aarch64/pauth-4.c
new file mode 100644
index 0000000000..4b22e6e282
--- /dev/null
+++ b/tests/tcg/aarch64/pauth-4.c
@@ -0,0 +1,25 @@
+#include <stdint.h>
+#include <assert.h>
+
+int main()
+{
+  uintptr_t x, y;
+
+  asm("mov %0, lr\n\t"
+      "pacia %0, sp\n\t"	/* sigill if pauth not supported */
+      "eor %0, %0, #4\n\t"	/* corrupt single bit */
+      "mov %1, %0\n\t"
+      "autia %1, sp\n\t"	/* validate corrupted pointer */
+      "xpaci %0\n\t"		/* strip pac from corrupted pointer */
+      : "=r"(x), "=r"(y));
+
+  /*
+   * Once stripped, the corrupted pointer is of the form 0x0000...wxyz.
+   * We expect the autia to indicate failure, producing a pointer of the
+   * form 0x000e....wxyz.  Use xpaci and != for the test, rather than
+   * extracting explicit bits from the top, because the location of the
+   * error code "e" depends on the configuration of virtual memory.
+   */
+  assert(x != y);
+  return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 374c8d6830..efa67cf1e9 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -18,7 +18,7 @@ run-fcvt: fcvt
 	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
 
 # Pauth Tests
-AARCH64_TESTS += pauth-1 pauth-2
+AARCH64_TESTS += pauth-1 pauth-2 pauth-4
 run-pauth-%: QEMU_OPTS += -cpu max
 pauth-%: CFLAGS += -march=armv8.3-a
 
-- 
2.20.1


