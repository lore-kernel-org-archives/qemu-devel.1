Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB4FC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8229C2469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WjVnA+sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8229C2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7lGh-0005Ho-MX
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 14:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j7lFE-0003WS-4G
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j7lFD-0005xz-1d
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:20 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j7lFC-0005wy-Qh
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:18 -0500
Received: by mail-wm1-x336.google.com with SMTP id p9so4443812wmc.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 11:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MUKeYtgIb4UZ9vwvUtDtiSAihx2HzY0rjwybRRhbUFA=;
 b=WjVnA+sdeDD/dAjucmn9POJ7exza6O0tTnNUXa3sBOiMPZIdnWGPu1kG2Jeu3eTfRf
 xmpDPDFiZehF+P9i4+qAPYlazCLRCfJ7Cxq7jPH8Sd5eqP9VTXxEH0nYfZgLKMy8FANj
 ofA+z6GmaoWaPd7+V+ZyE+hAKIlvit2z3ojC/JvJ/CMEytAS+DagOQAI1g+xgkYmU6tb
 wgo19A5+fQBnLiZK/1E79Jli6hDHvu0Dqwjsi321cwxhK0ae9AOgTVq/r75aGH8T5L0Q
 DIAU2kHbUsjAO1/aBhDLHaOyAl8hcdQNV2ergB923KuKtZVG5LIptROdkqJVIBSUi2sd
 fy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MUKeYtgIb4UZ9vwvUtDtiSAihx2HzY0rjwybRRhbUFA=;
 b=KVVmCRlG5wS0rPK39dEf1ngu3qqQCn1tCWDNwghzQccb3pMxMEb9BJcnFNUXfsbCQs
 59vjad1erFyUk+gOHh8MgW5AA0pC033NQzsCTkZm5ozK5pLMrV19RJNOhH/XoTNI999q
 +RNvzxtsE3Z9tcK12MAIUQGT310TWPcwOf/eT9mp8YRv2rrH/jsRZ8k6lLWKFjdUjv0J
 fglwIgCGBciq2sK3wQlepqVcBoYgm4Q+D6knKThZy4+Hd6nRm0XTxg6tL+nH02v5jDKI
 hNzb08QGqiXX9Ka3rWckPf5ix0W3a7/A3ANtuXWwsoOxmuxf2hoqooqVy/yM2X7eZJtg
 oxjA==
X-Gm-Message-State: APjAAAX5G4PLePrR6Bq4My1SHgvhwtXosvQ7D5kPTrosWDfT3eBuStsN
 QJIjufKZAHR55atZpAOnxRdHmKQV8Kg=
X-Google-Smtp-Source: APXvYqy1SlszhI88Y7gjUPHtf96KQnRCJzuaPdiYVuNszs2TiTp7G7sjkar1e4T2l4WBnxT1eowqBA==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr5848704wmi.45.1582917857376;
 Fri, 28 Feb 2020 11:24:17 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n2sm14331577wro.96.2020.02.28.11.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 11:24:16 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F3871FF8C;
 Fri, 28 Feb 2020 19:24:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] accel/tcg: use units.h for defining code gen buffer
 sizes
Date: Fri, 28 Feb 2020 19:24:12 +0000
Message-Id: <20200228192415.19867-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228192415.19867-1-alex.bennee@linaro.org>
References: <20200228192415.19867-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's easier to read.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


