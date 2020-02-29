Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93BAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6528246A8
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9WwVTAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6528246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7sAB-0004Eb-Pd
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 21:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6i-00076w-Dr
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6h-0003BY-BY
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:44:00 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:35872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7s6h-00038c-4y
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:59 -0500
Received: by mail-pl1-x630.google.com with SMTP id a6so1963337plm.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 18:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yoR4lHIMH0qpeMnLjOHbbbErJmJaq6BNdKSX4fGfFYE=;
 b=u9WwVTAYzRYg3KP4fU5p87GW67pe0yNzYMuOPrhid+PwGKRQnT/i+nEfA1U79/ddSp
 L8eu4ixwWumA20LPF7uWJ2A225oKetz4cRdxff7HtEOy0OjliXE5CS8bLOKOQBpOJpCZ
 ifZ8V4lRn/xPJDkgHXWVMnkdesAIztNUQt/czPfH2lJexZe/sq9nA1e6HHWKNc8j+W11
 0azNHWJ/7IBoJx0Jaf8dH37X2oEfYaaTOLLRuplhja8EaEXzYOXwuNKyoLZIAaom7GrA
 vGgIWFRmrAdJXr0DOOz6q6CVDdGEjPq4c0LBfNt4XwOTpVUkpXbanN1xmFt1m2KGXnbb
 /tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yoR4lHIMH0qpeMnLjOHbbbErJmJaq6BNdKSX4fGfFYE=;
 b=crnmamHFTzQiKU1Wyj42TaOte4YibVRdPFwPpfMGPd8HvMiiSjIw/o+PTooFS2QbO7
 dFsi5tK9to6OYMp6uLyC9MPEEk8CDSWPO2RnP0vpmcTYcs0/kwLIQD36snXQqLNn+Tpy
 AmCtoppFbc0u3a/+gy+iCvD9NlO+zm27wRPCQiEKUwmlqEBxVNW3i/pnp/y3xt167G1j
 xmjmZXe46Yx7S206S4ZdDG0qNmuKdnIBTJ6YvamfkZtzOfFOMZtZHYfXK3Y2FaMby8rQ
 qITXjKZ8H3eMzx7f6ur478ubGeoYFuZ/URoD2fIMq6XecAwPSmTp0uRQ5EOjeBy0Mkbb
 RX0Q==
X-Gm-Message-State: APjAAAWo2BeJRswPYQdmEk6tLfg5GLuaVFjBW77iHhFaWTa/EZxduw3C
 TKkpfIc6h6Dc7Vodq9IcSjDDEPxNrek=
X-Google-Smtp-Source: APXvYqw09I/s86W6TGDp3ADpS+xkOCrpnlhBnr8CB3kiWkFU3YUy8ImY1Ejg22fqmNATTO0RxxPilA==
X-Received: by 2002:a17:90a:6545:: with SMTP id
 f5mr8094175pjs.42.1582944236626; 
 Fri, 28 Feb 2020 18:43:56 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id k9sm3649321pjo.19.2020.02.28.18.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 18:43:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] accel/tcg: use units.h for defining code gen buffer sizes
Date: Fri, 28 Feb 2020 18:43:44 -0800
Message-Id: <20200229024347.22826-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229024347.22826-1-richard.henderson@linaro.org>
References: <20200229024347.22826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::630
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

It's easier to read.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200228192415.19867-2-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a08ab11f65..238b0e575b 100644
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


