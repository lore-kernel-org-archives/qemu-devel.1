Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B849C4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B3121D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBVn+11j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B3121D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rQf-00077p-7F
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rO6-0003Xa-2O
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rO4-0005fz-Oa
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:45:45 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:38557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rO4-0005dJ-Aq
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:45:44 -0500
Received: by mail-wm1-x336.google.com with SMTP id a9so1862962wmj.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4olBGu/IQFOKY78lHg02hbFiHdwwHtqSc/rf9v7sw/0=;
 b=LBVn+11jSt/rgqati9jKTTkr+6S6qLVA4H5fnfVOnjokVuQZPXWAhTLO4oRm/mGfUB
 F9BNoEuzPV8qa26U6/sarOUpz2MOo9QljYkU6aGKhUrBOXSV/m+bmmK8oIyP9Z3wshdG
 Jf3Z5mOChQ6VHsRvGREYGNnXTpHaWdRl1UG/g5QIIHJ0daPtYwojuuR++55ccfQveDiI
 1pJwGyx+ntpNhkRM0fjwBy4uTTgT30iasv4smU6UVuZojmKfMeaVSOYxXhN4LIhOKdjV
 jYx+liz3bQyU4w1svUNY2QHhH7+YQFcdV8QoSJKQFwZ4UYo/SWRgoBeiWCB+aQli48O6
 q+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4olBGu/IQFOKY78lHg02hbFiHdwwHtqSc/rf9v7sw/0=;
 b=r9R1mwNSHz+xgVdY1tfFs4x8EHJqtWlMYhunQof0dNU4NfgLOH6cDJJ9yebr2LvODC
 c3ja5s3JIE8nCGAqIAQKmk+J9qsnwgcf5rdZdyE08B22cFmtZ5hd/vxH54VkkKIVmXHJ
 c3yjDXIr/c5NTKfegX0ZEIcXZDhUzWZCHZrIO8PnqymiiSC9Dt9CsxONip5aBNAVP/wu
 gFzIiiJBSXsCHDW4bu8Pc75rc2UQyvkWYkfwsGb8al+y5lGMAYTgzlyvivNpCPDcQJ4+
 QtTgSva8CsAgwHebmMW0SYi8SOtDXOXIkNF+umwcC1fuGWjnkg1mu7CJW0gFu3rtKJ+z
 yh8A==
X-Gm-Message-State: APjAAAUIeDRNDJywJ6MJ7o+ekBQzqPeEGwHWyWI8iKViFv5bBVS+uAq7
 iW39CHt7pfW9qc3EoHD/CE6bcA==
X-Google-Smtp-Source: APXvYqzsBiOTFMqVaBFBeJyN8XdkU8Fj1PwwPds0hw5RBZuCpfFVM9/Z5Q8fAidZTPGE0nwdgq3IpQ==
X-Received: by 2002:a7b:c3cd:: with SMTP id t13mr3824115wmj.88.1582703142994; 
 Tue, 25 Feb 2020 23:45:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b21sm1797732wmd.37.2020.02.25.23.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:45:40 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E6B5C1FFAA;
 Wed, 26 Feb 2020 07:39:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 19/19] tests/tcg: take into account expected clashes pauth-4
Date: Wed, 26 Feb 2020 07:39:29 +0000
Message-Id: <20200226073929.28237-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
References: <20200226073929.28237-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pointer authentication isn't perfect so measure the percentage of
failed checks. As we want to vary the pointer we work through a bunch
of different addresses.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200225124710.14152-20-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/pauth-4.c b/tests/tcg/aarch64/pauth-4.c
index 1040e92aec3..24a639e36ca 100644
--- a/tests/tcg/aarch64/pauth-4.c
+++ b/tests/tcg/aarch64/pauth-4.c
@@ -1,25 +1,45 @@
 #include <stdint.h>
 #include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#define TESTS 1000
 
 int main()
 {
-  uintptr_t x, y;
+    int i, count = 0;
+    float perc;
+    void *base = malloc(TESTS);
+
+    for (i = 0; i < TESTS; i++) {
+        uintptr_t in, x, y;
+
+        in = i + (uintptr_t) base;
+
+        asm("mov %0, %[in]\n\t"
+            "pacia %0, sp\n\t"        /* sigill if pauth not supported */
+            "eor %0, %0, #4\n\t"      /* corrupt single bit */
+            "mov %1, %0\n\t"
+            "autia %1, sp\n\t"        /* validate corrupted pointer */
+            "xpaci %0\n\t"            /* strip pac from corrupted pointer */
+            : /* out */ "=r"(x), "=r"(y)
+            : /* in */ [in] "r" (in)
+            : /* clobbers */);
 
-  asm("mov %0, lr\n\t"
-      "pacia %0, sp\n\t"        /* sigill if pauth not supported */
-      "eor %0, %0, #4\n\t"      /* corrupt single bit */
-      "mov %1, %0\n\t"
-      "autia %1, sp\n\t"        /* validate corrupted pointer */
-      "xpaci %0\n\t"            /* strip pac from corrupted pointer */
-      : "=r"(x), "=r"(y));
+        /*
+         * Once stripped, the corrupted pointer is of the form 0x0000...wxyz.
+         * We expect the autia to indicate failure, producing a pointer of the
+         * form 0x000e....wxyz.  Use xpaci and != for the test, rather than
+         * extracting explicit bits from the top, because the location of the
+         * error code "e" depends on the configuration of virtual memory.
+         */
+        if (x != y) {
+            count++;
+        }
 
-  /*
-   * Once stripped, the corrupted pointer is of the form 0x0000...wxyz.
-   * We expect the autia to indicate failure, producing a pointer of the
-   * form 0x000e....wxyz.  Use xpaci and != for the test, rather than
-   * extracting explicit bits from the top, because the location of the
-   * error code "e" depends on the configuration of virtual memory.
-   */
-  assert(x != y);
-  return 0;
+    }
+    perc = (float) count / (float) TESTS;
+    printf("Checks Passed: %0.2f%%", perc * 100.0);
+    assert(perc > 0.95);
+    return 0;
 }
-- 
2.20.1


