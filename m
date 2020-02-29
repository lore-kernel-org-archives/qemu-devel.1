Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2264DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36292469D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJgvO2M9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36292469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7s7p-0000fN-3n
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 21:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6l-0007A3-4K
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6k-0003I9-2B
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:44:03 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:41219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7s6j-0003GO-S9
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:44:02 -0500
Received: by mail-pg1-x536.google.com with SMTP id b1so2454210pgm.8
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 18:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VlxVvw9Nxub+F/a7czDjW6LNfb9GxIjz3UCnfFm+v5Q=;
 b=wJgvO2M9voJAm3Ydd5wUA9lnxPBEBL1Q2ejMnIk70UHL1CL5a5zMFW5TNkOW8igFS+
 ky+ScSqWxtaLN2NYww8rAlA6zMTljABd/rDUvYP2FbFu7UnoBRiKLsBVw24TuRKWv8xL
 mK9g4iojiFoi9yEdK1uh0ZZZHDeR7Pbr4nok94JV7bLDEYeAnLd3s+vPwokZF6zCJ3gP
 Kp4ITdaw6j0guFoq9ZfiNiwblSYuuOsSayw3Ao1jtL34QgaIAr3Ce40ODpE8wQdBLGC2
 rCzl2a3V0Br7KHdAtQ9vlUPIiYTCn5NJwJg6oUdDXV+g9VCqvD6iDtCmhL4Y0X/BxJDa
 4yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VlxVvw9Nxub+F/a7czDjW6LNfb9GxIjz3UCnfFm+v5Q=;
 b=nkKx6E/ZQRiRkZdia85eP9cAjHw7mTNdgmN+hSHp5ednXRF4e1kBB7p4G+GcpYu7IL
 ztnsCt3t4j9//MoF3iRL6uyKJxUcejxmBGfEgaILabHhQGbfbIyrRKciZjSHG4uHzk3p
 DGxkMbbfWjWQB2tYm10O91VvI4Xn1+xyWcC6Af6HwOzizp8QiqxudRvQ2PbPQfMPC8Vf
 5x8a6Bl1ZPiRYE3LGsleBxo/e4GTIA7mtloNSwu0+P3q4jd83kiK9A31lEglsAXCSXKG
 /2GkVwCzgb0vcqNyWBh97nDbnPedyN6yWEM1C+87eSp7Y17fAFegBhlNWAFaVddlPLpe
 A0hA==
X-Gm-Message-State: APjAAAX9CfXYlI4TJAeezIG5AsW6iFFRPkxfiAdyw1cWh5UCntsWYiuk
 b3omWC4L4sEfsrsLdl5F14lTk9g+SkM=
X-Google-Smtp-Source: APXvYqyIdmEi+uWeXPTuAwabJYNuamrmjnlK2whuuk2R6G29sylVc586dgw+oGpqNXeclMDtMqCEFQ==
X-Received: by 2002:a63:5522:: with SMTP id j34mr6715600pgb.97.1582944240355; 
 Fri, 28 Feb 2020 18:44:00 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id k9sm3649321pjo.19.2020.02.28.18.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 18:43:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] accel/tcg: increase default code gen buffer size for 64 bit
Date: Fri, 28 Feb 2020 18:43:47 -0800
Message-Id: <20200229024347.22826-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229024347.22826-1-richard.henderson@linaro.org>
References: <20200229024347.22826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::536
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

While 32mb is certainly usable a full system boot ends up flushing the
codegen buffer nearly 100 times. Increase the default on 64 bit hosts
to take advantage of all that spare memory. After this change I can
boot my tests system without any TB flushes.

As we usually run more CONFIG_USER binaries at a time in typical usage
we aren't quite as profligate for user-mode code generation usage. We
also bring the static code gen defies to the same place to keep all
the reasoning in the comments together.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-Id: <20200228192415.19867-5-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 4ce5d1b393..78914154bf 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -892,15 +892,6 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
     }
 }
 
-#if defined(CONFIG_USER_ONLY) && TCG_TARGET_REG_BITS == 32
-/*
- * For user mode on smaller 32 bit systems we may run into trouble
- * allocating big chunks of data in the right place. On these systems
- * we utilise a static code generation buffer directly in the binary.
- */
-#define USE_STATIC_CODE_GEN_BUFFER
-#endif
-
 /* Minimum size of the code gen buffer.  This number is randomly chosen,
    but not so small that we can't have a fair number of TB's live.  */
 #define MIN_CODE_GEN_BUFFER_SIZE     (1 * MiB)
@@ -929,7 +920,33 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
 # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 #endif
 
+#if TCG_TARGET_REG_BITS == 32
 #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
+#ifdef CONFIG_USER_ONLY
+/*
+ * For user mode on smaller 32 bit systems we may run into trouble
+ * allocating big chunks of data in the right place. On these systems
+ * we utilise a static code generation buffer directly in the binary.
+ */
+#define USE_STATIC_CODE_GEN_BUFFER
+#endif
+#else /* TCG_TARGET_REG_BITS == 64 */
+#ifdef CONFIG_USER_ONLY
+/*
+ * As user-mode emulation typically means running multiple instances
+ * of the translator don't go too nuts with our default code gen
+ * buffer lest we make things too hard for the OS.
+ */
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (128 * MiB)
+#else
+/*
+ * We expect most system emulation to run one or two guests per host.
+ * Users running large scale system emulation may want to tweak their
+ * runtime setup via the tb-size control on the command line.
+ */
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)
+#endif
+#endif
 
 #define DEFAULT_CODE_GEN_BUFFER_SIZE \
   (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
-- 
2.20.1


