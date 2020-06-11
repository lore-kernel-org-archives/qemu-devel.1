Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B32C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A043D206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxXgORhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A043D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOZe-0003B7-SF
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjOSm-0001V3-2b
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37020)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjOSk-0003tg-7W
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:51 -0400
Received: by mail-wm1-x343.google.com with SMTP id y20so5318197wmi.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LzOz9VFkB26YxJcmiYuJHQzM0svMerx3Jk8uYHGUhAA=;
 b=bxXgORhgF3PAKSr6f2Suvgbh83N4Ltmk+CL66juf7Pf2QnpaWFOCiR8lMlh/FHIpzy
 Ne2EyqH/juWY8HQjj71zOPWNO4tY9sFhfv1c7Wh9pdUPdO6zBYW6HEjlXKyewN/gmIWG
 jh5iFmN6sn2nH8kfDbC78LNHEBn7eABo3mQh/QWbgBiWkK/PhgzzPFIcVDkhUziRQWJd
 YmixVsaFswIPEWcX0D+oxIYa6XXX/9Py/FRJ8kYlPP2cRJesWZmsgb7bq/pJGCEYBhBy
 Gm5kgK/wz7EHHZSOElz0Xs5OsRxLxrS5xJcJgwj2Zqx8kPBILLeIB1gpm2LL92Cwpld2
 sXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LzOz9VFkB26YxJcmiYuJHQzM0svMerx3Jk8uYHGUhAA=;
 b=TTv/hGzkUbENFj3DR2Ua1cND6j+zNrGHt9NUA3cFTcELbPBDm8z7MDZxShuNDXdyV9
 TyXLD0nGqhKgjHzGeM5NyARvD3gcLXnq0ABOdIOetiIlNRJ3dQxiWNPpKVl0nETaHDGN
 FSf+zHWcTUHCaCDQYuFMqDZxNAh2UMsXVdXa8oQMLrPbUaMYAnw/OWJSltJKv0UD9Y/1
 +qZJKrk0jIEh2cjHw24r7QZEuKdyKpHcDIX4XzneDoDLIP7Ck3yCqa2UTpJ6+cPtTZjP
 UVxbWedxNhBAPaFHCs4y54UTWuCPpVfI5s+8X+OWN8kWMxelO2AgYC2xgzM8/FyhLQks
 M3JA==
X-Gm-Message-State: AOAM530umDNzFhxof+PgVvDwgl6ELcPb8tBsNSmq6jG+36ybvDlvObFB
 CZeAtAwpUUQNqxJEWLwoTK5kXA==
X-Google-Smtp-Source: ABdhPJzZBwznH9HoRcX6IxGLE5YdbnR/892PtkaKXByK3akXiBUxC2OYrULGZaDFe3y354CTazpgQA==
X-Received: by 2002:a1c:7505:: with SMTP id o5mr8338912wmc.164.1591886742346; 
 Thu, 11 Jun 2020 07:45:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f9sm5116609wre.65.2020.06.11.07.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 07:45:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EAB581FF7E;
 Thu, 11 Jun 2020 15:45:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] logging: add a LOG_TCG_WARN for temp leaks
Date: Thu, 11 Jun 2020 15:45:30 +0100
Message-Id: <20200611144531.20142-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pretty much all calls to qemu_log are either wrapped in some other
enabling check or only enabled with debug defines. Add a specific flag
for TCG warnings and expand the documentation of the qemu_log
function.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/log-for-trace.h | 9 ++++++++-
 include/qemu/log.h           | 2 ++
 accel/tcg/translator.c       | 4 ++--
 util/log.c                   | 2 ++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
index 2f0a5b080ea..521d7936243 100644
--- a/include/qemu/log-for-trace.h
+++ b/include/qemu/log-for-trace.h
@@ -29,7 +29,14 @@ static inline bool qemu_loglevel_mask(int mask)
     return (qemu_loglevel & mask) != 0;
 }
 
-/* main logging function */
+/**
+ * qemu_log: main logging function
+ *
+ * Most users shouldn't be calling qemu_log unconditionally as it adds
+ * noise to logging output. Either use qemu_log_mask() or wrap
+ * successive log calls a qemu_loglevel_mask() check and
+ * qemu_log_lock/unlock(). The tracing infrastructure does similar wrapping.
+ */
 int GCC_FMT_ATTR(1, 2) qemu_log(const char *fmt, ...);
 
 #endif
diff --git a/include/qemu/log.h b/include/qemu/log.h
index f4724f73301..e1574ef7c14 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -64,6 +64,8 @@ static inline bool qemu_log_separate(void)
 #define CPU_LOG_PLUGIN     (1 << 18)
 /* LOG_STRACE is used for user-mode strace logging. */
 #define LOG_STRACE         (1 << 19)
+/* Additional TCG warnings */
+#define LOG_TCG_WARN       (1 << 20)
 
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 603d17ff831..44396ccd7ad 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -26,8 +26,8 @@
 void translator_loop_temp_check(DisasContextBase *db)
 {
     if (tcg_check_temp_count()) {
-        qemu_log("warning: TCG temporary leaks before "
-                 TARGET_FMT_lx "\n", db->pc_next);
+        qemu_log_mask(LOG_TCG_WARN, "warning: TCG temporary leaks before "
+                      TARGET_FMT_lx "\n", db->pc_next);
     }
 }
 
diff --git a/util/log.c b/util/log.c
index bdb3d712e88..fad25d9317f 100644
--- a/util/log.c
+++ b/util/log.c
@@ -334,6 +334,8 @@ const QEMULogItem qemu_log_items[] = {
 #endif
     { LOG_STRACE, "strace",
       "log every user-mode syscall, its input, and its result" },
+    { LOG_TCG_WARN, "tcg",
+      "log TCG warnings useful to developers." },
     { 0, NULL, NULL },
 };
 
-- 
2.20.1


