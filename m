Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F1C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3845920735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrZYKwRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3845920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGft-0002h2-Cu
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUa-0005n0-2z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUY-0000ub-T6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:03 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:40305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGUY-0000q9-Lo
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:02 -0400
Received: by mail-wr1-x436.google.com with SMTP id f3so19944637wrw.7
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ycpjWhBk4Z3jSaQx3qTk+zNIZ4G3K3ciPCO6mbRvIck=;
 b=GrZYKwRkNggQoU4mAZZXM5HcZSS6CmTyiVIGmcjZmv6ydc+einah46k8tsuBP7jHPh
 YLisvKeBMipUnh6e4vzsHm/OavDbgjbIGVjcCau/G2AXMR7CTimnnI/uB6AzlUswGE+B
 LlMH7OIIGUUqX8eHKSzWl4OeYZODuobwFdtXEfgMOUvKfS67tlJZoxqHzt6sU2AwvY2F
 GJDIlMyOCbMiTd0I/fwx1xc8HKvFw8iOPKToW2/+adf11d/njsNd0xYvAYoyoIPa4ofW
 pBVC6ILRBBAp73M1BQ7u44ukztN4588wb+gqxn6eMk25xiQBKLPKE0uCz/sgK3VQwmfO
 rXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ycpjWhBk4Z3jSaQx3qTk+zNIZ4G3K3ciPCO6mbRvIck=;
 b=nrFOL7LXxaXYm9pJL8Y5XRGVO7um7OHjnYqwdMWR2ld0K4RH4fEzDIg5iQK/DPEsT5
 eRm+RnHD3evryuTU2Pal6WlCgFdEQWMTuj/tvO2mErF6+ZOqXq2NOMHbTTm08I6Kl/gP
 qY3bhLSl2HJK8fvetePnKcxGftbBQy+8E4bOQPYT80PUVzN0zYzpLAOkL13xMGrLaYwW
 YgtxLNCEHt/UDBgMZY4Y/yimNg6DpK1DWiBIgVChLQazr+m/iD7M50qZZTGjLl5ZFuWs
 PJx7EONCc38BRurXn7jeYh+siQzSD6BHm27hnTsY/4OwZUp8SRhWZPyf97x5bc2Ff9kV
 PRaw==
X-Gm-Message-State: ANhLgQ0aCs6197Po31zW37V7FXoqz0tDRhY5VHyEEnKxN5WWf4tWuoia
 /C/q359EJdx4+BYkt3pDWuNf8Q==
X-Google-Smtp-Source: ADFU+vsWt+MsX4jVSfyvKhZm30KBwx//vbU6xu9n7gRWcYHhzeye7+YI5t+CKleOr1B50NMD6vTYkg==
X-Received: by 2002:adf:e811:: with SMTP id o17mr187932wrm.422.1584467941533; 
 Tue, 17 Mar 2020 10:59:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z4sm5557961wrr.6.2020.03.17.10.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:58:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BDC241FFAE;
 Tue, 17 Mar 2020 17:50:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 24/28] tests/tcg/aarch64: add SVE iotcl test
Date: Tue, 17 Mar 2020 17:50:49 +0000
Message-Id: <20200317175053.5278-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a fairly bare-bones test of setting the various vector sizes
for SVE which will only fail if the PR_SVE_SET_VL can't reduce the
user-space vector length by powers of 2.

However we will also be able to use it in a future test which
exercises the GDB stub.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200316172155.971-25-alex.bennee@linaro.org>

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


