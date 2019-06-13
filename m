Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E287C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAA12173C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bz3uCyd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAA12173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39370 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOmz-00035g-H3
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58777)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOcx-0007tl-I3
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOcv-0003xm-B7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOcv-0003v1-39
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:45 -0400
Received: by mail-wr1-x443.google.com with SMTP id d18so20520750wrs.5
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jlXFJdoAtBcsrDt+RzPH/+cxhZKjIl45SfiQerQen7Q=;
 b=bz3uCyd+MZGkEPqrwRWvQ7NPvDO1qqBasx/hS1DLa4Oy3XxwuNOZdEhqgq8V9SugnN
 W0M9psU3QZNedPZ9B3Ga8Ytar4fQnNoHawResRMyfVvpabH/j5xOjp6nQYqIG0iTJfOc
 nd4Gy2v2EWWwbFpa3sLOX8d7ZCq0afwfwsmpjhkquTkm5a3lKXk3QDaipz0OkfTjaoLR
 m7YdkmKU8CacDmd2UskiqcB0MyDj54CYrWtb5T4fzgtafPMVU6Av7fA47mbZsDeUQWU+
 bZLTdwkoCytsxQiPJjeg1E61ryxozTh3hfmI9/51c3xu6l6z9JnwhmVopthku/sbEM30
 gX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jlXFJdoAtBcsrDt+RzPH/+cxhZKjIl45SfiQerQen7Q=;
 b=pNr93u7MXrBJVH+hJZDVtb9FbLrSptkneP6zQaDMGdMZnBLFkqbR1HXUaVumRpmmbn
 O3qJKPHQDUducNmM2lM52+yGqBjFDAqfSAU3KSZSn6J0u4rOUnN3XgNoZV0dwk/8aMxv
 1fVPxd8NPybObEUaJoJMBzW1DCL5y+Xv/PA+zC5ILX6LacarpuHOWEzBO0kiq05IYztu
 1cusYk+BR+IzbNscZlZPLKhLx0dDJ3Dz0UB/SLnTrn0Ee1PE03KOjqQvN61A5VaELLMn
 uz9Q+RUF0P4G6MG/lFkztQerN7TJz3RPg/WzPBkTPg5bRsA5s8s6fd5xjkBFM5tweGKw
 g9Ig==
X-Gm-Message-State: APjAAAUdlAsQJ2RReHfPLwQy9nxnpq9HMKSZqDXqimL9qrWCAfj78HEO
 Cb0/M7cvEuxMKgfbjhpPuVvjWtSuKtZ8LQ==
X-Google-Smtp-Source: APXvYqxrBmbowNYPdIRouAohRZmVDgaI6BmLOOHVza0yDTi6y+vfmwKVc3q6i1s5RrOM1Frj/qtqdg==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr2459600wrt.290.1560428082247; 
 Thu, 13 Jun 2019 05:14:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:13:51 +0100
Message-Id: <20190613121433.5246-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 06/48] target/arm: Fix output of PAuth Auth
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

The ARM pseudocode installs the error_code into the original
pointer, not the encrypted pointer.  The difference applies
within the 7 bits of pac data; the result should be the sign
extension of bit 55.

Add a testcase to that effect.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  2 +-
 target/arm/pauth_helper.c         |  4 +-
 tests/tcg/aarch64/pauth-2.c       | 61 +++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/aarch64/pauth-2.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 2bb914975be..31ba9cfcaa1 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -15,7 +15,7 @@ run-fcvt: fcvt
 	$(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
 	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
 
-AARCH64_TESTS += pauth-1
+AARCH64_TESTS += pauth-1 pauth-2
 run-pauth-%: QEMU += -cpu max
 
 TESTS:=$(AARCH64_TESTS)
diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 7f30ae7395e..d3194f20437 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -344,9 +344,9 @@ static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     if (unlikely(extract64(test, bot_bit, top_bit - bot_bit))) {
         int error_code = (keynumber << 1) | (keynumber ^ 1);
         if (param.tbi) {
-            return deposit64(ptr, 53, 2, error_code);
+            return deposit64(orig_ptr, 53, 2, error_code);
         } else {
-            return deposit64(ptr, 61, 2, error_code);
+            return deposit64(orig_ptr, 61, 2, error_code);
         }
     }
     return orig_ptr;
diff --git a/tests/tcg/aarch64/pauth-2.c b/tests/tcg/aarch64/pauth-2.c
new file mode 100644
index 00000000000..2fe030ba3da
--- /dev/null
+++ b/tests/tcg/aarch64/pauth-2.c
@@ -0,0 +1,61 @@
+#include <stdint.h>
+#include <assert.h>
+
+asm(".arch armv8.4-a");
+
+void do_test(uint64_t value)
+{
+    uint64_t salt1, salt2;
+    uint64_t encode, decode;
+
+    /*
+     * With TBI enabled and a 48-bit VA, there are 7 bits of auth,
+     * and so a 1/128 chance of encode = pac(value,key,salt) producing
+     * an auth for which leaves value unchanged.
+     * Iterate until we find a salt for which encode != value.
+     */
+    for (salt1 = 1; ; salt1++) {
+        asm volatile("pacda %0, %2" : "=r"(encode) : "0"(value), "r"(salt1));
+        if (encode != value) {
+            break;
+        }
+    }
+
+    /* A valid salt must produce a valid authorization.  */
+    asm volatile("autda %0, %2" : "=r"(decode) : "0"(encode), "r"(salt1));
+    assert(decode == value);
+
+    /*
+     * An invalid salt usually fails authorization, but again there
+     * is a chance of choosing another salt that works.
+     * Iterate until we find another salt which does fail.
+     */
+    for (salt2 = salt1 + 1; ; salt2++) {
+        asm volatile("autda %0, %2" : "=r"(decode) : "0"(encode), "r"(salt2));
+        if (decode != value) {
+            break;
+        }
+    }
+
+    /* The VA bits, bit 55, and the TBI bits, should be unchanged.  */
+    assert(((decode ^ value) & 0xff80ffffffffffffull) == 0);
+
+    /*
+     * Bits [54:53] are an error indicator based on the key used;
+     * the DA key above is keynumber 0, so error == 0b01.  Otherwise
+     * bit 55 of the original is sign-extended into the rest of the auth.
+     */
+    if ((value >> 55) & 1) {
+        assert(((decode >> 48) & 0xff) == 0b10111111);
+    } else {
+        assert(((decode >> 48) & 0xff) == 0b00100000);
+    }
+}
+
+int main()
+{
+    do_test(0);
+    do_test(-1);
+    do_test(0xda004acedeadbeefull);
+    return 0;
+}
-- 
2.20.1


