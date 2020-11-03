Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DA1C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DCC2071A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nQVmqZ8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DCC2071A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlKs-0006r1-O0
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JK-gXwsKCgkq1trwwnvxnwpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--hskinnemoen.bounces.google.com>)
 id 1kZkuy-00089j-1P
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:15:24 -0500
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449]:45923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JK-gXwsKCgkq1trwwnvxnwpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--hskinnemoen.bounces.google.com>)
 id 1kZkus-0005oI-MY
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:15:23 -0500
Received: by mail-pf1-x449.google.com with SMTP id z125so11171785pfc.12
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 17:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=wh8or+ljt8at2k22dVmhE1DVFpTtQWKhA+UBKQ4cAts=;
 b=nQVmqZ8XyFRGjHxkqAqM2KV9yUisj+53aAzuzVrF8WUSTM4tbMQWdHYNV7CgccJf4C
 y56exMQjJV7td45J3c0m25xxCNACAyNuirn3+b0lBh25r1qnQaTdrDwazWl0jLDEAkw5
 UlH0Nwvtu3uYMexVx5Y15FxdMG0NOoaRwCDoCKKzY5VyxNGxVP3ZM5WozGajzL3VwEr6
 XVLkZkhrCcpAb9H+ByZNE0D2hRYrkTp+UcU+f++EwrdgEvHiSQ5isJyZrcuRJ82V9uAQ
 L9FvdIFokbu6nbKHG6PPPgKX5KFRyDpiv8i9oVsI5RxyZG5KsSQeEFI9VOArEESd3imy
 odJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=wh8or+ljt8at2k22dVmhE1DVFpTtQWKhA+UBKQ4cAts=;
 b=qSOROadmrA2xxBOvryewU7iN/5MMdD908f9TWwN8lxy5C+dcpAg0H8ycJdV5eK1ZDs
 Wpufpplsrp3WWKcWC5iLQlnltEKjJz0LDt/yO+8Z4lEmHX/Vq4QcCOxslSPoc6oipHTF
 NCAvM6QXH9rQG5W6B7hunvRMCAVvyyHGzsDIig5vmTiXg7fT1NgueiFQXRGw4nlVKF/u
 Kp1B/eq0JkXY6jLNjsWZcFPgE3/DXJmYLBo+Z4H6ii+Zz6QbI5oXoBnOH5QHCS6vj/BC
 CMVWy3Ng360rB6w/ysNg0dCbPuYHXhidnxkGeDp+aodqfHP7uySmAbN0Oac/OJ+W2VQ4
 qu8Q==
X-Gm-Message-State: AOAM531S7l7cotq5rK7YbMvIkog7YiB0aZbik1bLdegBxShmO/j5sMkc
 ZKfakPyy+jx/jn/TsUdR5UL7k35/nsquftYf4Q==
X-Google-Smtp-Source: ABdhPJwfFxHjf2wFERbw8WceoQn6LU6bpiReTVxyGaXL/3VVUwmRwqaX7X5r5IkEsxJuP7a+W3edfFD4pnvsKZHPzA==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by
 2002:a62:7cd4:0:b029:152:b3e8:c59f with
 SMTP id x203-20020a627cd40000b0290152b3e8c59fmr23027135pfc.2.1604366116071;
 Mon, 02 Nov 2020 17:15:16 -0800 (PST)
Date: Mon,  2 Nov 2020 17:14:57 -0800
In-Reply-To: <20201103011457.2959989-1-hskinnemoen@google.com>
Message-Id: <20201103011457.2959989-4-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20201103011457.2959989-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 3/3] tests/qtest/npcm7xx_rng-test: dump random data on failure
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3JK-gXwsKCgkq1trwwnvxnwpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--hskinnemoen.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

Dump the collected random data after a randomness test failure.

Note that you won't actually see this unless you add
g_test_set_nonfatal_assertions() back in.

Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 tests/qtest/npcm7xx_rng-test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/qtest/npcm7xx_rng-test.c b/tests/qtest/npcm7xx_rng-test.c
index d7e42cf062..09111d640c 100644
--- a/tests/qtest/npcm7xx_rng-test.c
+++ b/tests/qtest/npcm7xx_rng-test.c
@@ -20,6 +20,7 @@
 
 #include "libqtest-single.h"
 #include "qemu/bitops.h"
+#include "qemu-common.h"
 
 #define RNG_BASE_ADDR   0xf000b000
 
@@ -36,6 +37,13 @@
 /* Number of bits to collect for randomness tests. */
 #define TEST_INPUT_BITS  (128)
 
+static void dump_buf_if_failed(const uint8_t *buf, size_t size)
+{
+    if (g_test_failed()) {
+        qemu_hexdump(stderr, "", buf, size);
+    }
+}
+
 static void rng_writeb(unsigned int offset, uint8_t value)
 {
     writeb(RNG_BASE_ADDR + offset, value);
@@ -188,6 +196,7 @@ static void test_continuous_monobit(void)
     }
 
     g_assert_cmpfloat(calc_monobit_p(buf, sizeof(buf)), >, 0.01);
+    dump_buf_if_failed(buf, sizeof(buf));
 }
 
 /*
@@ -209,6 +218,7 @@ static void test_continuous_runs(void)
     }
 
     g_assert_cmpfloat(calc_runs_p(buf.l, sizeof(buf) * BITS_PER_BYTE), >, 0.01);
+    dump_buf_if_failed(buf.c, sizeof(buf));
 }
 
 /*
@@ -230,6 +240,7 @@ static void test_first_byte_monobit(void)
     }
 
     g_assert_cmpfloat(calc_monobit_p(buf, sizeof(buf)), >, 0.01);
+    dump_buf_if_failed(buf, sizeof(buf));
 }
 
 /*
@@ -254,6 +265,7 @@ static void test_first_byte_runs(void)
     }
 
     g_assert_cmpfloat(calc_runs_p(buf.l, sizeof(buf) * BITS_PER_BYTE), >, 0.01);
+    dump_buf_if_failed(buf.c, sizeof(buf));
 }
 
 int main(int argc, char **argv)
-- 
2.29.1.341.ge80a0c044ae-goog


