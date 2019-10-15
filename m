Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72F6C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846BC2084B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TE/G92PH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846BC2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQ8a-0003q9-Dg
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKPn2-0008HK-JJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKPn1-0000Ic-BP
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:35:16 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKPn1-0000HW-5v
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:35:15 -0400
Received: by mail-pf1-x442.google.com with SMTP id h195so12826990pfe.5
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=m4O3Xy7tWLBs5UuOTJ5dzdaA6h4n+q00OCHjnj+1vK8=;
 b=TE/G92PHYDbz91JtzP8GE/LU/s06l3o0trtKUl5FKEffqZNPOpEurSJ4FBzjfTISD2
 /lVZYw4s7DqW8g51X+BQGYyef8qCiqeZQkP1oa2JYc4Z4RWEbVsh8IOILSWCt5WFAvRk
 1wZWvB3gjOBEqH9+qVTuKKK8GsPbhtS2fXeXMmiaT37Y8x1mIi+NvekCyxln1O2opmLk
 HXhwRP/Aya9Zv2VSKw2UTYCrNZgGuw/9/+0AqTpgvGdYAWvEv50/iZ+g9yXhbxiYWWOP
 zmvDOpPmx9E/dJR+hDtYU50QacP12Vze4l+2axHMBELlJueUPJJzv0bY4qhvcOUWlElp
 ZZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=m4O3Xy7tWLBs5UuOTJ5dzdaA6h4n+q00OCHjnj+1vK8=;
 b=nrV+rkcXJxmnFfclMBMoxED74+p/SlSEJ1h3qaA0cZpOxmUn1UMmQvAU9u4lrX3PCA
 ZRo9SrG8LAqW8vu6xkvGTHoF0GrlY99NjeTKuauyV27iJW2ml8eB7aM8afXsJ0I8jzRb
 yVCb/JTSDAtkhNDWGEOxQyVTpL0a2MEG1NjzIQenKuC9VSg/N8TljLlS2VTBFPahaFle
 pA65jjJPF18vLjavGomKVm/0xEswRTvXkwaz/DLclNQRh+djlCNZyJlJhgnA2Zb2QtHL
 npicUQhqh240MkU/YwAzYnILqB5mUqXcom9avna+MMGjISqhbU6YaskkID9X4k6G7nVA
 Gm7Q==
X-Gm-Message-State: APjAAAUcy+jWNq1vF+TCm1qjMBc8FPzD4BBvWg1aB0P4AGNBdiYFdWu/
 RQByQDTPSmWtMzfPLgw9KfnxX6AXYew=
X-Google-Smtp-Source: APXvYqz2uCiuKMXXRRK9lIVML/Zp5UEtKKiq15BJ9llu13JVcpuKlEOIcCdAjTN2tlcOa6Kmea+0Ow==
X-Received: by 2002:a17:90a:654b:: with SMTP id
 f11mr43562323pjs.49.1571157313791; 
 Tue, 15 Oct 2019 09:35:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m22sm22011593pgj.29.2019.10.15.09.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 09:35:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] tests/tcg/aarch64: Add mte smoke tests
Date: Tue, 15 Oct 2019 09:35:07 -0700
Message-Id: <20191015163507.12153-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015163507.12153-1-richard.henderson@linaro.org>
References: <20191015163507.12153-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: elver@google.com, icb@rice.edu, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/mte-1.c         | 27 +++++++++++++++++++++
 tests/tcg/aarch64/mte-2.c         | 39 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  5 ++++
 3 files changed, 71 insertions(+)
 create mode 100644 tests/tcg/aarch64/mte-1.c
 create mode 100644 tests/tcg/aarch64/mte-2.c

diff --git a/tests/tcg/aarch64/mte-1.c b/tests/tcg/aarch64/mte-1.c
new file mode 100644
index 0000000000..18bfb1120f
--- /dev/null
+++ b/tests/tcg/aarch64/mte-1.c
@@ -0,0 +1,27 @@
+/*
+ * Memory tagging, basic pass cases.
+ */
+
+#include <assert.h>
+
+asm(".arch armv8.5-a+memtag");
+
+int data[16 / sizeof(int)] __attribute__((aligned(16)));
+
+int main(int ac, char **av)
+{
+    int *p0 = data;
+    int *p1, *p2;
+    long c;
+
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1));
+    assert(p1 != p0);
+    asm("subp %0,%1,%2" : "=r"(c) : "r"(p0), "r"(p1));
+    assert(c == 0);
+
+    asm("stg %0, [%0]" : : "r"(p1));
+    asm("ldg %0, [%1]" : "=r"(p2) : "r"(p0), "0"(p0));
+    assert(p1 == p2);
+
+    return 0;
+}
diff --git a/tests/tcg/aarch64/mte-2.c b/tests/tcg/aarch64/mte-2.c
new file mode 100644
index 0000000000..2991b7df69
--- /dev/null
+++ b/tests/tcg/aarch64/mte-2.c
@@ -0,0 +1,39 @@
+/*
+ * Memory tagging, basic fail cases.
+ */
+
+#include <assert.h>
+#include <signal.h>
+#include <stdlib.h>
+
+asm(".arch armv8.5-a+memtag");
+
+int data[16 / sizeof(int)] __attribute__((aligned(16)));
+
+void pass(int sig)
+{
+    exit(0);
+}
+
+int main(int ac, char **av)
+{
+    int *p0 = data;
+    int *p1, *p2;
+    long excl = 1;
+
+    /* Create two differently tagged pointers.  */
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(excl));
+    asm("gmi %0,%1,%0" : "+r"(excl) : "r" (p1));
+    assert(excl != 1);
+    asm("irg %0,%1,%2" : "=r"(p2) : "r"(p0), "r"(excl));
+    assert(p1 != p2);
+
+    /* Store the tag from the first pointer.  */
+    asm("stg %0, [%0]" : : "r"(p1));
+
+    *p1 = 0;
+    signal(SIGSEGV, pass);
+    *p2 = 0;
+
+    assert(0);
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 0040b68dd0..0971c244b7 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -32,4 +32,9 @@ run-semihosting: semihosting
 # AARCH64_TESTS += bti-1
 bti-1: LDFLAGS += -nostdlib -Wl,-T,$(AARCH64_SRC)/bti.ld
 
+# We need binutils-2.32 to assemble this test case.
+# AARCH64_TESTS += mte-1 mte-2
+mte-%: CFLAGS += -O -g
+run-mte-%: QEMU += -cpu max,x-tagged-pages=on
+
 TESTS += $(AARCH64_TESTS)
-- 
2.17.1


