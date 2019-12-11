Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65507C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD8920409
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnU0yORb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD8920409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5cU-0001Kp-QK
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5Ql-0005Hr-Qp
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5Qj-0003W9-MU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:43 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5Qj-0003Ts-9E
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:41 -0500
Received: by mail-wr1-x444.google.com with SMTP id z7so24753679wrl.13
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YCeE2L0TGRZ8+dNyp7Q4Gn+JUeo73/cxEQroPrtcLoY=;
 b=tnU0yORb/+or31JcfENc+b/0DEaKzDSPQzbCpC2ocSTX8NQcTMFok65H2hK/BMBF7t
 QM/nGWFhnaqzETGBSO5Fry8cJ3uk0aHEqMSUlME1KHM5iBV0lGuKknyYGRQ4/1Nx0OBJ
 NNXSI/o4pAQEFtIylFwezlgvVOr79rUVUKUrq69N9cr1y7fiiOw/xHilTrUCD+6Oytqv
 2j4ClrLdDlM6HfoqfQeZC/MyUeOh/yN0PeNchSUU9qnq0KjlluRcDhBZnpSz4VZu2H7t
 mimDbGuPy21QFMLo52yL/OBLVyp645kV4Hh9I/JE+Ue6mQAArvslI07C6Nm+/KWlq9qj
 WmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YCeE2L0TGRZ8+dNyp7Q4Gn+JUeo73/cxEQroPrtcLoY=;
 b=m4Juehf52UdCymHRDiwo1fhjJZ2D8QQ6uxuoGF1dMLoHW4JjSGgRMhZR5sioZliwFp
 VG2sifiJ7z/Sq093+rrl7Qa9oJAKEpFIQqj0IGnJTqEowEw0cEgEPvbuXl56siAYXK35
 lcL7KyylRyrKjnr7lyY1HAeO7BIDBwJxUbWftaexOjQiqMCxOpR53Tvoan3W23Z1w10a
 q2W3kPfyGAXDt3bllZKyZWPKDArdAFu851+Xk3CA5H3crxj3ZOz+qLnY1GnpoOK5fPjt
 nC/re2L3hax/sCz+//ks6sAQo6Akp+2jDKvh4x6XM6zPOH9H/c22fGxGmAHdFmywbT+d
 PTVw==
X-Gm-Message-State: APjAAAX2NaK7IzvcUtChlqRsgSIC6zEnC9C0tTIq+lEjjD1eCtvyrcTO
 yq5MQ6PKHDIyOT7uPhI45zgZOg==
X-Google-Smtp-Source: APXvYqxYiQkc4bcBBBu9NLAQK8kvPCDw94DZHTp5bGM6fqmXr/FXhN4TK03Z+2AkxfiKFdOEJ7V94A==
X-Received: by 2002:adf:9144:: with SMTP id j62mr867018wrj.168.1576083939994; 
 Wed, 11 Dec 2019 09:05:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m10sm2977614wrx.19.2019.12.11.09.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:05:30 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E85C71FFA5;
 Wed, 11 Dec 2019 17:05:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 19/20] tests/tcg/aarch64: add SVE iotcl test
Date: Wed, 11 Dec 2019 17:05:19 +0000
Message-Id: <20191211170520.7747-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
---
 tests/tcg/aarch64/sve-ioctls.c    | 77 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  4 ++
 2 files changed, 81 insertions(+)
 create mode 100644 tests/tcg/aarch64/sve-ioctls.c

diff --git a/tests/tcg/aarch64/sve-ioctls.c b/tests/tcg/aarch64/sve-ioctls.c
new file mode 100644
index 00000000000..d7bb64d53f9
--- /dev/null
+++ b/tests/tcg/aarch64/sve-ioctls.c
@@ -0,0 +1,77 @@
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
+    unsigned int sve_feature = (get_cpu_reg(ID_AA64PFR0_EL1) >> 32) & 0xf;
+    /* Exit early if we don't support SVE at all */
+    if (sve_feature == 0x1) {
+        /* we also need to probe for the ioctl support */
+        if (getauxval(AT_HWCAP) & HWCAP_SVE) {
+            return do_sve_ioctl_test();
+        } else {
+            printf("SKIP: no HWCAP_SVE on this system\n");
+            return 0;
+        }
+    } else {
+        printf("SKIP: no SVE on this system\n");
+        return 0;
+    }
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 3f8783ada5c..209c79a1ddb 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -36,6 +36,10 @@ ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_SVE),)
 # System Registers Tests
 AARCH64_TESTS += sysregs
 sysregs: CFLAGS+=-march=armv8.1-a+sve
+
+# SVE ioctl test
+AARCH64_TESTS += sve-ioctls
+sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
 endif
 
 TESTS += $(AARCH64_TESTS)
-- 
2.20.1


