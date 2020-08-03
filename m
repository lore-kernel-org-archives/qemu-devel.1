Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC67C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E392222C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbC4wh87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E392222C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2gJt-00004s-0s
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDw-0001X8-5i
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:52088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDu-0003aG-D6
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:15 -0400
Received: by mail-wm1-x331.google.com with SMTP id p14so617122wmg.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+x86j1nJrSJr/whqOt2lTLFOKpP51a1MJPUQH0taM0Q=;
 b=hbC4wh87oMNGJ5bjEWJdWrbeq4uYGls/z5u3D9cunMcNwQW2sJrOlVD/cNixowzqeY
 ZzD5rfYAr8GgIcjeBK6ZUH0sFp0+1IDiF3tkmiJEoAor7JW/KgDK6dqueQflKZmFDgzw
 GddAqhnx07FwwZqh6UqEMLg9yzRZMeuUmz0nRqj/hf5KDLj5gittGSox9CVxnuVm5IPX
 tjRVBeCOH5CM9Ny0t5iFi/gUi7Kc9QRpuwcw2wMm0xV0vW3Z6tHQ5eUXQj6FM9/IdlFg
 Gh5LG7axxX3Tj8rlWAugskBQjZArAzo4fD7q2ir2xo4wxQuRb0qxDM49NrVrrKZX6ESp
 HDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+x86j1nJrSJr/whqOt2lTLFOKpP51a1MJPUQH0taM0Q=;
 b=XKW24OIDuCyj4UVZ0H5IqwL3205VLSTlhUpfx57rhOwzA+2cocB/cz+HZDjRCJuwyL
 QLGPjXmtl3Xzv0KZL4Ccg/vurRCJlHPMFH+VJX7BXQ1E+mdyaZpbbbqk/xq0esQcFvBV
 Bbc8YTvmdOu6zTyTdvQ0cVvaORqThyuoq/QHDhcWxiw1EJEKtnHEV9cKo5yVxQT+b7uh
 N4M8G6qX8Xf9T7bMNtDAaMCdBD2sIwYrOC4ZzNs0YU5rD2Wl+1XOXQBiCK+nMtEt6YNT
 qDGXFhakbmlfm20fHzNgFNyb5aX/ztAiV+gZDgDYTIyCQNJQ+RALWLUnEFOhmbb/3dnS
 L2Jw==
X-Gm-Message-State: AOAM531y7X1ctH1DF3X5omkJjcxPMnquapi7MT4Kl5GVyRrLbkRb6/TN
 UNfOvZRxR2q1S6SLWRclxc2WbIUDYvzw5A==
X-Google-Smtp-Source: ABdhPJzGwkzdF0bb/NhbEUduUbrviOZ4KXBxNOY78UNrroaYp87PSzvJbaypocN5D6cY3iO+GqmV1w==
X-Received: by 2002:a1c:a7d1:: with SMTP id q200mr604191wme.131.1596483251719; 
 Mon, 03 Aug 2020 12:34:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r206sm985565wma.6.2020.08.03.12.34.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 12:34:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] target/arm: Fix AddPAC error indication
Date: Mon,  3 Aug 2020 20:33:56 +0100
Message-Id: <20200803193359.12936-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803193359.12936-1-peter.maydell@linaro.org>
References: <20200803193359.12936-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Richard Henderson <richard.henderson@linaro.org>

The definition of top_bit used in this function is one higher
than that used in the Arm ARM psuedo-code, which put the error
indication at top_bit - 1 at the wrong place, which meant that
it wasn't visible to Auth.

Fixing the definition of top_bit requires more changes, because
its most common use is for the count of bits in top_bit:bot_bit,
which would then need to be computed as top_bit - bot_bit + 1.

For now, prefer the minimal fix to the error indication alone.

Fixes: 63ff0ca94cb
Reported-by: Derrick McKee <derrick.mckee@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200728195706.11087-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: added comment about the divergence from the pseudocode]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/pauth_helper.c         |  6 +++++-
 tests/tcg/aarch64/pauth-5.c       | 33 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 3 files changed, 39 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/pauth-5.c

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index b909630317e..6dbab037683 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -300,7 +300,11 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
      */
     test = sextract64(ptr, bot_bit, top_bit - bot_bit);
     if (test != 0 && test != -1) {
-        pac ^= MAKE_64BIT_MASK(top_bit - 1, 1);
+        /*
+         * Note that our top_bit is one greater than the pseudocode's
+         * version, hence "- 2" here.
+         */
+        pac ^= MAKE_64BIT_MASK(top_bit - 2, 1);
     }
 
     /*
diff --git a/tests/tcg/aarch64/pauth-5.c b/tests/tcg/aarch64/pauth-5.c
new file mode 100644
index 00000000000..67c257918b9
--- /dev/null
+++ b/tests/tcg/aarch64/pauth-5.c
@@ -0,0 +1,33 @@
+#include <assert.h>
+
+static int x;
+
+int main()
+{
+    int *p0 = &x, *p1, *p2, *p3;
+    unsigned long salt = 0;
+
+    /*
+     * With TBI enabled and a 48-bit VA, there are 7 bits of auth, and so
+     * a 1/128 chance of auth = pac(ptr,key,salt) producing zero.
+     * Find a salt that creates auth != 0.
+     */
+    do {
+        salt++;
+        asm("pacda %0, %1" : "=r"(p1) : "r"(salt), "0"(p0));
+    } while (p0 == p1);
+
+    /*
+     * This pac must fail, because the input pointer bears an encryption,
+     * and so is not properly extended within bits [55:47].  This will
+     * toggle bit 54 in the output...
+     */
+    asm("pacda %0, %1" : "=r"(p2) : "r"(salt), "0"(p1));
+
+    /* ... so that the aut must fail, setting bit 53 in the output ... */
+    asm("autda %0, %1" : "=r"(p3) : "r"(salt), "0"(p2));
+
+    /* ... which means this equality must not hold. */
+    assert(p3 != p0);
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index b617f2ac7e0..e7249915e7e 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -19,7 +19,7 @@ run-fcvt: fcvt
 
 # Pauth Tests
 ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_3),)
-AARCH64_TESTS += pauth-1 pauth-2 pauth-4
+AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
 pauth-%: CFLAGS += -march=armv8.3-a
 run-pauth-%: QEMU_OPTS += -cpu max
 run-plugin-pauth-%: QEMU_OPTS += -cpu max
-- 
2.20.1


