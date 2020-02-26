Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A89C4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B461424650
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRWIeo+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B461424650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j719U-0008UQ-Tu
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j718d-00076v-Fz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j718b-000642-Me
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:27 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j718b-000637-GQ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:25 -0500
Received: by mail-wr1-x441.google.com with SMTP id u6so4331237wrt.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BW1rVVuvHSIHaMM8u2a8l8PWRGvK4vmAgMmHgrFc8bQ=;
 b=NRWIeo+TbwqyFHiuPlZeJfbjbxrZkRBenWPlixbEeIHkcZkhUjJOFOYs1KRoDIs1Cc
 Hr9SN7GFX/7lWvt5hq54iru7ozw0Q5eejip0/yJhULvtM+Q2Ib0LesSOnQ2TUXYDBPU0
 4hFdevSeqtsXzulLw0a8IPGGGZix2HTUgVlOTiJ7V57S6iuVhTiJ+UenIOYLTOhRPaqa
 GUqqUWQJ4GRXQGijmul/6L9dB+hrbyohw5JkdA/MrlJr/O1ZqXA3ob9zzNqOPYnK5RIq
 2quzMNw7AzaptbgvYjB8K1tj0nI9h9RfCv0ieXbzvdgHUuNfCOePTm6wyCdB7fvOgmwr
 VTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BW1rVVuvHSIHaMM8u2a8l8PWRGvK4vmAgMmHgrFc8bQ=;
 b=hTooTRIYgwY72ahDXbDZdpMvzdqEzWuQg5WpUe+J3hZZ7VqBjVgL6qKA543UHyNE4Q
 /uOf26dX5P6LORTHb1n8ORqlk9fQTy3oKBu/ipm/C4eI94TR+Uv8JDwQfo93+lYMAmRj
 nWwb1XHVk/d4T6nH2Ts873dcbWD4nMOOxX3k6cHTdpSsGmPh5ElzkIK7kYJ9GXvYQ/io
 vJ3e06eluEMGnUobIAGjbJYdePZNIH3N3U01YhYTtBKvV7VcgRciOo1AwDAeW2fzC5H+
 bNyUFd0XOhwzg79EaUvEzgqvSZW0O3W3PSfx2poY98wvkL+XnBZe8Wb2gYkE7Z8kdLtz
 Gacg==
X-Gm-Message-State: APjAAAX9RBhDksUI8xfSNdxMx5JJ9mqnFnoF3XxjsvCEzX5RtZOwSKcw
 GB0c7Nzr0rJsFeW26Kb0CttkGYk7aAM=
X-Google-Smtp-Source: APXvYqwcSteicOJ0uFqauIDpb/K6QH2cZeUNx7e7lFnmFTo488gfslFyzgQlaJqM2WDZ3PpfqnKJXw==
X-Received: by 2002:adf:f606:: with SMTP id t6mr6780858wrp.304.1582740624387; 
 Wed, 26 Feb 2020 10:10:24 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p26sm3725420wmc.24.2020.02.26.10.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 10:10:21 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E8FF51FF8C;
 Wed, 26 Feb 2020 18:10:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/4] accel/tcg: use units.h for defining code gen buffer
 sizes
Date: Wed, 26 Feb 2020 18:10:17 +0000
Message-Id: <20200226181020.19592-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226181020.19592-1-alex.bennee@linaro.org>
References: <20200226181020.19592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's easier to read.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/translate-all.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a08ab11f657..238b0e575bf 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu-common.h"
 
 #define NO_CPU_IO_DEFS
@@ -901,33 +902,33 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
 
 /* Minimum size of the code gen buffer.  This number is randomly chosen,
    but not so small that we can't have a fair number of TB's live.  */
-#define MIN_CODE_GEN_BUFFER_SIZE     (1024u * 1024)
+#define MIN_CODE_GEN_BUFFER_SIZE     (1 * MiB)
 
 /* Maximum size of the code gen buffer we'd like to use.  Unless otherwise
    indicated, this is constrained by the range of direct branches on the
    host cpu, as used by the TCG implementation of goto_tb.  */
 #if defined(__x86_64__)
-# define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
+# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
 #elif defined(__sparc__)
-# define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
+# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
 #elif defined(__powerpc64__)
-# define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
+# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
 #elif defined(__powerpc__)
-# define MAX_CODE_GEN_BUFFER_SIZE  (32u * 1024 * 1024)
+# define MAX_CODE_GEN_BUFFER_SIZE  (32 * MiB)
 #elif defined(__aarch64__)
-# define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
+# define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
 #elif defined(__s390x__)
   /* We have a +- 4GB range on the branches; leave some slop.  */
-# define MAX_CODE_GEN_BUFFER_SIZE  (3ul * 1024 * 1024 * 1024)
+# define MAX_CODE_GEN_BUFFER_SIZE  (3 * GiB)
 #elif defined(__mips__)
   /* We have a 256MB branch region, but leave room to make sure the
      main executable is also within that region.  */
-# define MAX_CODE_GEN_BUFFER_SIZE  (128ul * 1024 * 1024)
+# define MAX_CODE_GEN_BUFFER_SIZE  (128 * MiB)
 #else
 # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 #endif
 
-#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32u * 1024 * 1024)
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
 
 #define DEFAULT_CODE_GEN_BUFFER_SIZE \
   (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
-- 
2.20.1


