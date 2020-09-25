Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83AEC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3268920756
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lL+PE4Xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3268920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnNl-00054f-9G
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCw-0007rp-Si
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCu-0001RU-3c
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id x23so2927646wmi.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2gc/eAiM6fc/9xFq9v+gXHzceFFWcZXTxfGGQdY3TKo=;
 b=lL+PE4Xcu99+Yf301fWBDOYOKBRFX4BGFnZJ9UM7e6YQx7nI3w4CwXaBrlDtW24dA7
 9yH0LGCvLuy+6BePjaLK1Vg1wGGk81aoyFSpUs2ZOC/clFHjzRFJ5XlSSO7/i7x/vkjN
 g0roGJSrbKQve6pS7JsMrp+kDyc9YYHw+3/f04F6DOnoJ1nQpXYmGJDG/RvPf7xuxmx7
 ouVpX/eJImiwkjssNy4cVXCMVUjntSt3ydwH8eVazGioYkm5+7tClPR79hX3PJa1G9Od
 Mm7sOQrVgX+nxEgdIFkHH8pbG3IUlI2fURFwA6jXVZzmfqpo/yNQtoPA9PVNEdHPHoJs
 BbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2gc/eAiM6fc/9xFq9v+gXHzceFFWcZXTxfGGQdY3TKo=;
 b=LshQ5juMAg9NyBcvAzw9yzFSmq2/V0jMfbU5YNUHcolFJZR01niF3Kz1BSh5ixc1nG
 4eyFWvpbX9G70CyxlLv4R6VtnwIGMz5F8KCO7948gUUomUmg4GBscHKE6His/pymbEV3
 KvhqD8rAoedPk9gBu3b5UtzpxpQyQPykh16z8BNtHtCCJOycV7e/PLbe/S1vzwWerJ8u
 yIS1BPU3lWYoS105pg9qD3fo4hxyg2JyMZFqWxFt8ir5Z/yjsat3kiTtmErLQmWo22vw
 b1rtbN/uxKCJ1taHjelDreDv7LbRqJzxTTSQ1+hjlmyzuVVtE/w2PmMvWBihNV42iFNg
 z3lw==
X-Gm-Message-State: AOAM530TMNHFRgFENs7DMb/20lmht/UnBPUu/l1P2jKA2cZoDyzw/fxP
 CumPgkMLP+zqfY/rXrr8m71lhg==
X-Google-Smtp-Source: ABdhPJxeBSupo8i5C6YvM07AtjMhDiqQ1xpAwpiJVWc7s3N20uU84fMRZW1sEDeRezUSSYo0TsiUYQ==
X-Received: by 2002:a1c:ed19:: with SMTP id l25mr3025751wmh.49.1601038330538; 
 Fri, 25 Sep 2020 05:52:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l126sm2849103wmf.39.2020.09.25.05.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:52:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5E0241FF9B;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 12/19] tools/vhost-user-rpmb: import hmac_sha256 functions
Date: Fri, 25 Sep 2020 13:51:40 +0100
Message-Id: <20200925125147.26943-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jean-philippe@linaro.org, takahiro.akashi@linaro.org,
 virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to calculate HMAC-256SHA as part of the protocol. To avoid
making the daemon dependent on QEMU's internal crypto library we
import the functions here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/hmac_sha256.h |  87 ++++++++
 tools/vhost-user-rpmb/hmac_sha256.c | 331 ++++++++++++++++++++++++++++
 tools/vhost-user-rpmb/meson.build   |   3 +-
 3 files changed, 420 insertions(+), 1 deletion(-)
 create mode 100644 tools/vhost-user-rpmb/hmac_sha256.h
 create mode 100644 tools/vhost-user-rpmb/hmac_sha256.c

diff --git a/tools/vhost-user-rpmb/hmac_sha256.h b/tools/vhost-user-rpmb/hmac_sha256.h
new file mode 100644
index 000000000000..e67a5baedecd
--- /dev/null
+++ b/tools/vhost-user-rpmb/hmac_sha256.h
@@ -0,0 +1,87 @@
+/*
+ * HMAC-SHA-256 implementation
+ * Last update: 06/15/2005
+ * Issue date:  06/15/2005
+ *
+ * Copyright (C) 2005 Olivier Gay <olivier.gay@a3.epfl.ch>
+ * All rights reserved.
+ *
+ * Copyright (c) 2016, 2020, Linaro Limited
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the project nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef HMAC_SHA256_H
+#define HMAC_SHA256_H
+
+#define SHA256_DIGEST_SIZE ( 256 / 8)
+#define SHA256_BLOCK_SIZE  ( 512 / 8)
+
+#ifndef SHA2_TYPES
+#define SHA2_TYPES
+typedef unsigned char uint8;
+typedef unsigned int  uint32;
+typedef unsigned long long uint64;
+#endif
+
+typedef struct {
+    unsigned int tot_len;
+    unsigned int len;
+    unsigned char block[2 * SHA256_BLOCK_SIZE];
+    uint32 h[8];
+} sha256_ctx;
+
+void sha256_init(sha256_ctx * ctx);
+void sha256_update(sha256_ctx *ctx, const unsigned char *message,
+                   unsigned int len);
+void sha256_final(sha256_ctx *ctx, unsigned char *digest);
+void sha256(const unsigned char *message, unsigned int len,
+            unsigned char *digest);
+
+typedef struct {
+    sha256_ctx ctx_inside;
+    sha256_ctx ctx_outside;
+
+    /* for hmac_reinit */
+    sha256_ctx ctx_inside_reinit;
+    sha256_ctx ctx_outside_reinit;
+
+    unsigned char block_ipad[SHA256_BLOCK_SIZE];
+    unsigned char block_opad[SHA256_BLOCK_SIZE];
+} hmac_sha256_ctx;
+
+void hmac_sha256_init(hmac_sha256_ctx *ctx, const unsigned char *key,
+                      unsigned int key_size);
+void hmac_sha256_reinit(hmac_sha256_ctx *ctx);
+void hmac_sha256_update(hmac_sha256_ctx *ctx, const unsigned char *message,
+                        unsigned int message_len);
+void hmac_sha256_final(hmac_sha256_ctx *ctx, unsigned char *mac,
+                       unsigned int mac_size);
+void hmac_sha256(const unsigned char *key, unsigned int key_size,
+                 const unsigned char *message, unsigned int message_len,
+                 unsigned char *mac, unsigned mac_size);
+
+#endif /* !HMAC_SHA256_H */
diff --git a/tools/vhost-user-rpmb/hmac_sha256.c b/tools/vhost-user-rpmb/hmac_sha256.c
new file mode 100644
index 000000000000..f6640a46c616
--- /dev/null
+++ b/tools/vhost-user-rpmb/hmac_sha256.c
@@ -0,0 +1,331 @@
+/*
+ * HMAC-SHA-256 implementation
+ * Last update: 06/15/2005
+ * Issue date:  06/15/2005
+ *
+ * Copyright (C) 2005 Olivier Gay <olivier.gay@a3.epfl.ch>
+ * All rights reserved.
+ *
+ * Copyright (c) 2016, 2020 Linaro Limited
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the project nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#include <string.h>
+
+#include "hmac_sha256.h"
+
+/* SHA256 functions */
+
+#define SHFR(x, n)    (x >> n)
+#define ROTR(x, n)   ((x >> n) | (x << ((sizeof(x) << 3) - n)))
+#define ROTL(x, n)   ((x << n) | (x >> ((sizeof(x) << 3) - n)))
+#define CH(x, y, z)  ((x & y) ^ (~x & z))
+#define MAJ(x, y, z) ((x & y) ^ (x & z) ^ (y & z))
+
+#define SHA256_F1(x) (ROTR(x,  2) ^ ROTR(x, 13) ^ ROTR(x, 22))
+#define SHA256_F2(x) (ROTR(x,  6) ^ ROTR(x, 11) ^ ROTR(x, 25))
+#define SHA256_F3(x) (ROTR(x,  7) ^ ROTR(x, 18) ^ SHFR(x,  3))
+#define SHA256_F4(x) (ROTR(x, 17) ^ ROTR(x, 19) ^ SHFR(x, 10))
+
+#define UNPACK32(x, str)                      \
+{                                             \
+    *((str) + 3) = (uint8) ((x)      );       \
+    *((str) + 2) = (uint8) ((x) >>  8);       \
+    *((str) + 1) = (uint8) ((x) >> 16);       \
+    *((str) + 0) = (uint8) ((x) >> 24);       \
+}
+
+#define PACK32(str, x)                        \
+{                                             \
+    *(x) =   ((uint32) *((str) + 3)      )    \
+           | ((uint32) *((str) + 2) <<  8)    \
+           | ((uint32) *((str) + 1) << 16)    \
+           | ((uint32) *((str) + 0) << 24);   \
+}
+
+#define UNPACK64(x, str)                      \
+{                                             \
+    *((str) + 7) = (uint8) ((x)      );       \
+    *((str) + 6) = (uint8) ((x) >>  8);       \
+    *((str) + 5) = (uint8) ((x) >> 16);       \
+    *((str) + 4) = (uint8) ((x) >> 24);       \
+    *((str) + 3) = (uint8) ((x) >> 32);       \
+    *((str) + 2) = (uint8) ((x) >> 40);       \
+    *((str) + 1) = (uint8) ((x) >> 48);       \
+    *((str) + 0) = (uint8) ((x) >> 56);       \
+}
+
+#define PACK64(str, x)                        \
+{                                             \
+    *(x) =   ((uint64) *((str) + 7)      )    \
+           | ((uint64) *((str) + 6) <<  8)    \
+           | ((uint64) *((str) + 5) << 16)    \
+           | ((uint64) *((str) + 4) << 24)    \
+           | ((uint64) *((str) + 3) << 32)    \
+           | ((uint64) *((str) + 2) << 40)    \
+           | ((uint64) *((str) + 1) << 48)    \
+           | ((uint64) *((str) + 0) << 56);   \
+}
+
+#define SHA256_SCR(i)                         \
+{                                             \
+    w[i] =  SHA256_F4(w[i -  2]) + w[i -  7]  \
+          + SHA256_F3(w[i - 15]) + w[i - 16]; \
+}
+
+uint32 sha256_h0[8] =
+            {0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
+             0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19};
+
+uint32 sha256_k[64] =
+            {0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
+             0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
+             0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
+             0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
+             0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
+             0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
+             0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
+             0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
+             0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
+             0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
+             0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
+             0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
+             0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
+             0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
+             0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
+             0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};
+
+/* SHA-256 functions */
+
+static void sha256_transf(sha256_ctx *ctx, const unsigned char *message,
+                          unsigned int block_nb)
+{
+    uint32 w[64];
+    uint32 wv[8];
+    uint32 t1, t2;
+    const unsigned char *sub_block;
+    int i;
+    int j;
+
+    for (i = 0; i < (int) block_nb; i++) {
+        sub_block = message + (i << 6);
+
+        for (j = 0; j < 16; j++) {
+            PACK32(&sub_block[j << 2], &w[j]);
+        }
+
+        for (j = 16; j < 64; j++) {
+            SHA256_SCR(j);
+        }
+
+        for (j = 0; j < 8; j++) {
+            wv[j] = ctx->h[j];
+        }
+
+        for (j = 0; j < 64; j++) {
+            t1 = wv[7] + SHA256_F2(wv[4]) + CH(wv[4], wv[5], wv[6])
+                + sha256_k[j] + w[j];
+            t2 = SHA256_F1(wv[0]) + MAJ(wv[0], wv[1], wv[2]);
+            wv[7] = wv[6];
+            wv[6] = wv[5];
+            wv[5] = wv[4];
+            wv[4] = wv[3] + t1;
+            wv[3] = wv[2];
+            wv[2] = wv[1];
+            wv[1] = wv[0];
+            wv[0] = t1 + t2;
+        }
+
+        for (j = 0; j < 8; j++) {
+            ctx->h[j] += wv[j];
+        }
+    }
+}
+
+void sha256(const unsigned char *message, unsigned int len, unsigned char *digest)
+{
+    sha256_ctx ctx;
+
+    sha256_init(&ctx);
+    sha256_update(&ctx, message, len);
+    sha256_final(&ctx, digest);
+}
+
+void sha256_init(sha256_ctx *ctx)
+{
+    int i;
+    for (i = 0; i < 8; i++) {
+        ctx->h[i] = sha256_h0[i];
+    }
+
+    ctx->len = 0;
+    ctx->tot_len = 0;
+}
+
+void sha256_update(sha256_ctx *ctx, const unsigned char *message,
+                   unsigned int len)
+{
+    unsigned int block_nb;
+    unsigned int new_len, rem_len, tmp_len;
+    const unsigned char *shifted_message;
+
+    tmp_len = SHA256_BLOCK_SIZE - ctx->len;
+    rem_len = len < tmp_len ? len : tmp_len;
+
+    memcpy(&ctx->block[ctx->len], message, rem_len);
+
+    if (ctx->len + len < SHA256_BLOCK_SIZE) {
+        ctx->len += len;
+        return;
+    }
+
+    new_len = len - rem_len;
+    block_nb = new_len / SHA256_BLOCK_SIZE;
+
+    shifted_message = message + rem_len;
+
+    sha256_transf(ctx, ctx->block, 1);
+    sha256_transf(ctx, shifted_message, block_nb);
+
+    rem_len = new_len % SHA256_BLOCK_SIZE;
+
+    memcpy(ctx->block, &shifted_message[block_nb << 6],
+           rem_len);
+
+    ctx->len = rem_len;
+    ctx->tot_len += (block_nb + 1) << 6;
+}
+
+void sha256_final(sha256_ctx *ctx, unsigned char *digest)
+{
+    unsigned int block_nb;
+    unsigned int pm_len;
+    unsigned int len_b;
+    int i;
+
+    block_nb = (1 + ((SHA256_BLOCK_SIZE - 9)
+                     < (ctx->len % SHA256_BLOCK_SIZE)));
+
+    len_b = (ctx->tot_len + ctx->len) << 3;
+    pm_len = block_nb << 6;
+
+    memset(ctx->block + ctx->len, 0, pm_len - ctx->len);
+    ctx->block[ctx->len] = 0x80;
+    UNPACK32(len_b, ctx->block + pm_len - 4);
+
+    sha256_transf(ctx, ctx->block, block_nb);
+
+    for (i = 0 ; i < 8; i++) {
+        UNPACK32(ctx->h[i], &digest[i << 2]);
+    }
+}
+
+/* HMAC-SHA-256 functions */
+
+void hmac_sha256_init(hmac_sha256_ctx *ctx, const unsigned char *key,
+                      unsigned int key_size)
+{
+    unsigned int fill;
+    unsigned int num;
+
+    const unsigned char *key_used;
+    unsigned char key_temp[SHA256_DIGEST_SIZE];
+    int i;
+
+    if (key_size == SHA256_BLOCK_SIZE) {
+        key_used = key;
+        num = SHA256_BLOCK_SIZE;
+    } else {
+        if (key_size > SHA256_BLOCK_SIZE){
+            num = SHA256_DIGEST_SIZE;
+            sha256(key, key_size, key_temp);
+            key_used = key_temp;
+        } else { /* key_size > SHA256_BLOCK_SIZE */
+            key_used = key;
+            num = key_size;
+        }
+        fill = SHA256_BLOCK_SIZE - num;
+
+        memset(ctx->block_ipad + num, 0x36, fill);
+        memset(ctx->block_opad + num, 0x5c, fill);
+    }
+
+    for (i = 0; i < (int) num; i++) {
+        ctx->block_ipad[i] = key_used[i] ^ 0x36;
+        ctx->block_opad[i] = key_used[i] ^ 0x5c;
+    }
+
+    sha256_init(&ctx->ctx_inside);
+    sha256_update(&ctx->ctx_inside, ctx->block_ipad, SHA256_BLOCK_SIZE);
+
+    sha256_init(&ctx->ctx_outside);
+    sha256_update(&ctx->ctx_outside, ctx->block_opad,
+                  SHA256_BLOCK_SIZE);
+
+    /* for hmac_reinit */
+    memcpy(&ctx->ctx_inside_reinit, &ctx->ctx_inside,
+           sizeof(sha256_ctx));
+    memcpy(&ctx->ctx_outside_reinit, &ctx->ctx_outside,
+           sizeof(sha256_ctx));
+}
+
+void hmac_sha256_reinit(hmac_sha256_ctx *ctx)
+{
+    memcpy(&ctx->ctx_inside, &ctx->ctx_inside_reinit,
+           sizeof(sha256_ctx));
+    memcpy(&ctx->ctx_outside, &ctx->ctx_outside_reinit,
+           sizeof(sha256_ctx));
+}
+
+void hmac_sha256_update(hmac_sha256_ctx *ctx, const unsigned char *message,
+                        unsigned int message_len)
+{
+    sha256_update(&ctx->ctx_inside, message, message_len);
+}
+
+void hmac_sha256_final(hmac_sha256_ctx *ctx, unsigned char *mac,
+                       unsigned int mac_size)
+{
+    unsigned char digest_inside[SHA256_DIGEST_SIZE];
+    unsigned char mac_temp[SHA256_DIGEST_SIZE];
+
+    sha256_final(&ctx->ctx_inside, digest_inside);
+    sha256_update(&ctx->ctx_outside, digest_inside, SHA256_DIGEST_SIZE);
+    sha256_final(&ctx->ctx_outside, mac_temp);
+    memcpy(mac, mac_temp, mac_size);
+}
+
+void hmac_sha256(const unsigned char *key, unsigned int key_size,
+          const unsigned char *message, unsigned int message_len,
+          unsigned char *mac, unsigned mac_size)
+{
+    hmac_sha256_ctx ctx;
+
+    hmac_sha256_init(&ctx, key, key_size);
+    hmac_sha256_update(&ctx, message, message_len);
+    hmac_sha256_final(&ctx, mac, mac_size);
+}
diff --git a/tools/vhost-user-rpmb/meson.build b/tools/vhost-user-rpmb/meson.build
index cf80bedd99ac..f964837d151d 100644
--- a/tools/vhost-user-rpmb/meson.build
+++ b/tools/vhost-user-rpmb/meson.build
@@ -1,5 +1,6 @@
 executable('vhost-user-rpmb', files(
-  'main.c'),
+  'main.c',
+  'hmac_sha256.c'),
   dependencies: [qemuutil, glib, gio],
   link_with: [libvhost_user],
   install: true,
-- 
2.20.1


