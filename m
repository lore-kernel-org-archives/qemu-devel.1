Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3EEC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37AED2098B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUe+jzOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AED2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhpV-000577-A9
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhoh-0003YQ-Cz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:31 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:34373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhof-00030F-KY
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:31 -0400
Received: by mail-pf1-x432.google.com with SMTP id g207so951805pfb.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Lqd5yDGxy4AV2MKebioMxfVu3v0WB2bLQ9Bs5O+/Sj8=;
 b=DUe+jzOipuO3qbkJZi5PpEjNTafWjEJydGkfMN/ae0wr7hw1ogXQFTvZ+CQ4HPV7TV
 ZxauIaJ4Rt9SYEOLdjAFELdwbcH2LbIuREHZXP/sEKNMpvVx05i5+8roJT2mkbhYYS8V
 HMA1/WZxmLvez+flRqlg9XSGRyz+UTIk/0o/Pf3zop1qjXQm5oZw8MDqJY9dRU1CdNY2
 S3U94NoGwFwlZD8j3Ec8IY5tfQvxbm9D9TV+nXqZ2IN/Xd4avP78GphfYgYD1685voXJ
 ql6rtRZw7t+Z9+iiG8tlyn3fQtqgOv0yzS+ktcuChw29c/sLLbrN3js1C0y5ENZ7YYrm
 9CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lqd5yDGxy4AV2MKebioMxfVu3v0WB2bLQ9Bs5O+/Sj8=;
 b=iub4wqsMlEMTrFY+rgctuV3CBoo9GGm9Iw5qj6Yu7MOeS1Bayb1Ugwx0nqkatOZaM2
 1m7SXNIVpcgJm/ZyPFi9lTUcV/dsYbtn6o5HbKARXDySCVrf91c0vvQMvgvc1Ow09byk
 iJ0zU9cvrqsce6xTloe+HVivGgIS4ojIA69QKF/NtMu9iNF/idHvUOatDvG/vPjaRiyt
 0QoAQJ3i/Ku05sLvkSO2xObrk298DR1Kve+RNpkMrGwUlXZj2wk4BdQvVvlN3pvLAkPJ
 9FzLZ3nRk9Y7TzrxC8wtj37jkJquD4SbN8kPd38+O3NBn7JVbROjjFhDy4yjS99Kc6oG
 ILvw==
X-Gm-Message-State: AOAM533MQiWYUU5xd4Ihhl67PSarR33cySjYoUBxrJ5m1Pfdy3toboEq
 /JLrET1+ErZiGGovuf7zDMbfnGXbxLZxIA==
X-Google-Smtp-Source: ABdhPJyzZ0WFAvuclPET/Yx5P0yA4ZgRSVRGdAQbbQhvahtnPJMxptQO+oYGPEJzCGdbRp/yaxO5Og==
X-Received: by 2002:a63:1c54:: with SMTP id c20mr1794583pgm.221.1598634327920; 
 Fri, 28 Aug 2020 10:05:27 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/16] crypto: Rename cipher include files to .c.inc
Date: Fri, 28 Aug 2020 10:05:09 -0700
Message-Id: <20200828170523.418603-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828170523.418603-1-richard.henderson@linaro.org>
References: <20200828170523.418603-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU standard procedure for included c files is to use *.c.inc.
E.g. there are a different set of checks that are applied.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher.c                                   | 6 +++---
 crypto/{cipher-builtin.c => cipher-builtin.c.inc} | 0
 crypto/{cipher-gcrypt.c => cipher-gcrypt.c.inc}   | 0
 crypto/{cipher-nettle.c => cipher-nettle.c.inc}   | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename crypto/{cipher-builtin.c => cipher-builtin.c.inc} (100%)
 rename crypto/{cipher-gcrypt.c => cipher-gcrypt.c.inc} (100%)
 rename crypto/{cipher-nettle.c => cipher-nettle.c.inc} (100%)

diff --git a/crypto/cipher.c b/crypto/cipher.c
index 2722dc7d87..005b5da4de 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -151,11 +151,11 @@ qcrypto_cipher_munge_des_rfb_key(const uint8_t *key,
 #endif /* CONFIG_GCRYPT || CONFIG_NETTLE */
 
 #ifdef CONFIG_GCRYPT
-#include "cipher-gcrypt.c"
+#include "cipher-gcrypt.c.inc"
 #elif defined CONFIG_NETTLE
-#include "cipher-nettle.c"
+#include "cipher-nettle.c.inc"
 #else
-#include "cipher-builtin.c"
+#include "cipher-builtin.c.inc"
 #endif
 
 QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c.inc
similarity index 100%
rename from crypto/cipher-builtin.c
rename to crypto/cipher-builtin.c.inc
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c.inc
similarity index 100%
rename from crypto/cipher-gcrypt.c
rename to crypto/cipher-gcrypt.c.inc
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c.inc
similarity index 100%
rename from crypto/cipher-nettle.c
rename to crypto/cipher-nettle.c.inc
-- 
2.25.1


