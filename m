Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CEBC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDA720674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxCt8s5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDA720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuk7-0006Ft-Jn
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtXg-0003cL-GJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtXd-0001zN-Ju
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtXa-0001vS-AJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:39 -0400
Received: by mail-wm1-x344.google.com with SMTP id n8so18592653wmc.4
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=06upHfcJvurHEqRqXZxgM7CdWpLdWAWn6DtNQywwJZ8=;
 b=rxCt8s5OoOLvHRbo/k7sI7lrYMCY235QQ56t3odLROKNvVD40SD87Iv25oeI0Yvvav
 yOxQV/hgROD8DxYEOUS3nt0HenrKKQxE2cU0mU0xi4IjyXkQhs9l32Rbcp4sndPdD9az
 M5+Cq4Nq47g9GL51vJUuJrbz3DLclu9OLysvOYQUm4mD4j/NQ9V+aND5up8OhLrX8grh
 ia3JKvkeuZzyWdGNiQQs2ZTV2JKe/jvJnVCh7OcgN76gNuiK6lyJp95PSUgKNK2f0YTo
 CFKOCSOnz+nOfoiG1gqwbp6wYopaa7wwr9MDEVXrfmVKzs0dhcKAr1VZwl5Cs4qYEnsr
 Tjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=06upHfcJvurHEqRqXZxgM7CdWpLdWAWn6DtNQywwJZ8=;
 b=hCXT9Ayvyw/S6KW/ECsEmKUpWgUeLQjoipWBW+T94wj/B5xi0S9nqrazfE+az3TRh1
 Vf9EMHLGMQ5ojBogdOMzutg8oJ6dmB+HRH4S2sBN7ymk+DmyYNWVUzgijuCo4IRsqPC2
 fNyy8UIIvhUxWSEZeosJAK7DSRJUVrq+kN6fIAOUrGv+0i1OPUhGFMnV9HI2Oe+7kF1t
 9KgWvUTz5+Srk0yKz/9t7PWzygybdyD0sb7mFWGE1ZCcn/oNEK5MWpqlGyCFJqJjiWEt
 HfskwXx6uhH0e0Ozp990tDSg+L2tA8u48VdDc73rid3IuFETtG3UsODua27BtwdGReKO
 1KsA==
X-Gm-Message-State: ANhLgQ0Iz8s1fcCWPorfjtJEFalCNjPNivhsLnUjNoTQcd8AI6pchUc6
 nBpfU5btHHfEn3pGwqj+SkJfvA==
X-Google-Smtp-Source: ADFU+vuBA3uteprROJQ5kvIqO2S/z5P3CI22HY9shQgGF7TReHRRy49ZzIPQn2TgzCfnRIBPJ2v7eA==
X-Received: by 2002:a05:600c:214f:: with SMTP id
 v15mr201958wml.110.1584379716962; 
 Mon, 16 Mar 2020 10:28:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l12sm770079wrt.73.2020.03.16.10.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:28:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 978F41FFAF;
 Mon, 16 Mar 2020 17:21:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 24/28] tests/tcg/aarch64: add SVE iotcl test
Date: Mon, 16 Mar 2020 17:21:51 +0000
Message-Id: <20200316172155.971-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
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


