Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739BDC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202F320659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPOOQhu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202F320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOSg-0007dE-Az
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOId-0007z8-3g
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOIb-000767-QZ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:14 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOIb-000703-Gh
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:13 -0500
Received: by mail-wr1-x441.google.com with SMTP id z9so3674565wrs.10
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=06upHfcJvurHEqRqXZxgM7CdWpLdWAWn6DtNQywwJZ8=;
 b=YPOOQhu1V2Ba6gaLU+p+4L3H+OBdjAn2T/W6FJaeRrC525bp/kKMW8TbZFVpiz6DUc
 8SfFS9Tbzjd4FI3gokOaNMjk5YX08kfQFoUler/NJGaONJOmGQJXMlad1od0wzCtZOFY
 wwbszFcWpTor7usA7j+FcuLHM64C8fhwnFp/27v2ffAhZf23hSsvtz1H00sZqJq8p/O1
 sSQnf8pxClTAmAmEGPXBkIhs1uNoRzDGWhnPBNoEOzIDrbZRU1jpi0JvauBc4wqE043w
 iSYXo2gz2eYCnBpWYxy+BNOPKOAT0LAI12l0NcCYb9dOFpi9iJjygYp7TQJmE/bCPGOo
 rH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=06upHfcJvurHEqRqXZxgM7CdWpLdWAWn6DtNQywwJZ8=;
 b=RVAIYvMxBjBISr6i37V94bcLPG+Irqd9gdWwkhJk1Ybu8837uNdPMR9HLRqtkdEdUc
 ARkJPLjRZS64OiXMJj9f+G3iycGSzStZqE8SWbR+mJN+gAC/OnAnMhxhhqcBXDOh0AgQ
 80LcMtb+HLLWUDnpojTP07/jAfmBwjVvKzqx4obRwEwKrTlaWWi9AIfpVYfJjY9dWz2l
 fPJLp6sHDx0VAeYdSWN/47LuhCh8M6Mf7ZfCNu8ccPbIVwR3Ql0HPVRiYlxTFQmcsEPI
 768Eb+Jjpaws20AeO2lRDV2hHsDe8JJ1FAZlxWd3OeT3I+nMM+uETPge4CyMcaPyEwIZ
 390w==
X-Gm-Message-State: APjAAAU2L/FBDW5J4NvPd09t4ZCADlhWL0/mF6LtsMeqGgpS3oE/FnMW
 lwJJzgZ62Pc5o4sHOAGVyETz+g==
X-Google-Smtp-Source: APXvYqzFI8d5hbhU6xIgsRPa4c+PxX+9YJYWBG4iDr/Slr8Z89ueW8XbfI+dwN8Wb9OviLyTc+n7xw==
X-Received: by 2002:a05:6000:1:: with SMTP id
 h1mr27102480wrx.380.1580923032497; 
 Wed, 05 Feb 2020 09:17:12 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y131sm293115wmc.13.2020.02.05.09.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:17:10 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8CA331FFAA;
 Wed,  5 Feb 2020 17:10:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 19/22] tests/tcg/aarch64: add SVE iotcl test
Date: Wed,  5 Feb 2020 17:10:28 +0000
Message-Id: <20200205171031.22582-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171031.22582-1-alex.bennee@linaro.org>
References: <20200205171031.22582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a fairly bare-bones test of setting the various vector sizes
for SVE which will only fail if the PR_SVE_SET_VL can't reduce the
user-space vector length by powers of 2.

However we will also be able to use it in a future test which
exercises the GDB stub.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - use index to fill zreg
  - CROSS_CC_HAS_SVE
v5
  - merge conflicts
v6
  - drop id check
---
 tests/tcg/aarch64/sve-ioctls.c    | 70 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  4 ++
 2 files changed, 74 insertions(+)
 create mode 100644 tests/tcg/aarch64/sve-ioctls.c

diff --git a/tests/tcg/aarch64/sve-ioctls.c b/tests/tcg/aarch64/sve-ioctls.c
new file mode 100644
index 00000000000..9544dffa0ee
--- /dev/null
+++ b/tests/tcg/aarch64/sve-ioctls.c
@@ -0,0 +1,70 @@
+/*
+ * SVE ioctls tests
+ *
+ * Test the SVE width setting ioctls work and provide a base for
+ * testing the gdbstub.
+ *
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <sys/prctl.h>
+#include <asm/hwcap.h>
+#include <stdio.h>
+#include <sys/auxv.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+#ifndef HWCAP_CPUID
+#define HWCAP_CPUID (1 << 11)
+#endif
+
+#define SVE_MAX_QUADS  (2048 / 128)
+#define BYTES_PER_QUAD (128 / 8)
+
+#define get_cpu_reg(id) ({                                      \
+            unsigned long __val;                                \
+            asm("mrs %0, "#id : "=r" (__val));                  \
+            __val;                                              \
+        })
+
+static int do_sve_ioctl_test(void)
+{
+    int i, res, init_vq;
+
+    res = prctl(PR_SVE_GET_VL, 0, 0, 0, 0);
+    if (res < 0) {
+        printf("FAILED to PR_SVE_GET_VL (%d)", res);
+        return -1;
+    }
+    init_vq = res & PR_SVE_VL_LEN_MASK;
+
+    for (i = init_vq; i > 15; i /= 2) {
+        printf("Checking PR_SVE_SET_VL=%d\n", i);
+        res = prctl(PR_SVE_SET_VL, i, 0, 0, 0, 0);
+        if (res < 0) {
+            printf("FAILED to PR_SVE_SET_VL (%d)", res);
+            return -1;
+        }
+        asm("index z0.b, #0, #1\n"
+            ".global __sve_ld_done\n"
+            "__sve_ld_done:\n"
+            "mov z0.b, #0\n"
+            : /* no outputs kept */
+            : /* no inputs */
+            : "memory", "z0");
+    }
+    printf("PASS\n");
+    return 0;
+}
+
+int main(int argc, char **argv)
+{
+    /* we also need to probe for the ioctl support */
+    if (getauxval(AT_HWCAP) & HWCAP_SVE) {
+        return do_sve_ioctl_test();
+    } else {
+        printf("SKIP: no HWCAP_SVE on this system\n");
+        return 0;
+    }
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index b61b53e4dd1..c879932ff6c 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -47,6 +47,10 @@ ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_SVE),)
 AARCH64_TESTS += sysregs
 sysregs: CFLAGS+=-march=armv8.1-a+sve
 
+# SVE ioctl test
+AARCH64_TESTS += sve-ioctls
+sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
+
 ifneq ($(HAVE_GDB_BIN),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
-- 
2.20.1


