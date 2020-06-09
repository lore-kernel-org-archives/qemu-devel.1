Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58656C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AB52072F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcTY0w/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AB52072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikaU-00016V-E2
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZF-0007i6-IR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:53 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZE-0005bK-0h
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:53 -0400
Received: by mail-pg1-x544.google.com with SMTP id e9so10754541pgo.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AYdOaJYxtk+d/I+Jwq+9vEcr8Iz8aXatF1CrO9YlEDI=;
 b=DcTY0w/8OD14Sm++yyBa4igV00n4r6Ty47GW1i8jTGsc6pxoB73b5ogmJIqP62WPlX
 jOswX7x96FJQ3RT9v4Uotev16p7W7o7x5ChM8w3NRx6bsb/clhNq14gu6gvPfynVfrk7
 c8fExNHJ7jG2UCOo1N8nnd4DdXvGUSxjd2BdJwO/bCxCtE/aLNnOvFJR+YIfSOWHNpRZ
 EqLfiV484sWiFhGk255xasHZfsRdnY9WLuIsDhjClZOUaTZR6OVPbHxzHYx/8LAMmm4o
 9rOCnpwx0fIW7ShgaG7tJHgj5QGszvtrSHynx2w9gypcDdlrG9ogVc5YJNFVpKaGCqOV
 HYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AYdOaJYxtk+d/I+Jwq+9vEcr8Iz8aXatF1CrO9YlEDI=;
 b=N2o4byZrb+2L7IStiUnBFNGc/Tpk13BNSrM5lpG5etdXCfgltksCvLBtn9zERm+o9I
 IVI9nUoIrMBzakmgGeF2amcTjNZMj/8hZeIj2lfUcdYxuR6oMNcX/HvxNHFj3IY+Gdva
 dhlxM6D3A/mIA9YAciljw6Dhhurl2NAEa0dYctsVpyi/AMAfic2OZgNYTQ4ZulCaqQjl
 h4ZbXdR9zI3ExkBcVy2UoATCzmNWgwzSkhvHL5SBSHwxqxJpcdcBAlLeHtmDYlDjhC9I
 GfqXdWoIJGTLruD3lAXdoII7GCFwVhH6qGY4EJVAtajCtPNbPok7e3IB3LHhr32R7W/9
 pmug==
X-Gm-Message-State: AOAM531Y37Nt9KGvteanA9FdPOhpsR4Bb5hj5jBpXLpajMlYjC6zTYiw
 aTWntLHPGRUq342c2hxkmRsfDfpFN5rZwQ==
X-Google-Smtp-Source: ABdhPJxYN8fCgGZTuZeG9zOJd6vnrZel5fYLloFdSflWGVX8GEPe3bFjl5mYHqz3lPgq8W7cU/sQxQ==
X-Received: by 2002:a63:9258:: with SMTP id s24mr25931521pgn.362.1591733390238; 
 Tue, 09 Jun 2020 13:09:50 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1d09:cef2:3b1f:abce])
 by smtp.gmail.com with ESMTPSA id n19sm10523374pfu.194.2020.06.09.13.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:09:49 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/13] thread: add tsan annotations to QemuSpin
Date: Tue,  9 Jun 2020 16:07:33 -0400
Message-Id: <20200609200738.445-9-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609200738.445-1-robert.foley@linaro.org>
References: <20200609200738.445-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/thread.h | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index e50a073889..43fc094b96 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -206,6 +206,10 @@ void qemu_thread_atexit_add(struct Notifier *notifier);
  */
 void qemu_thread_atexit_remove(struct Notifier *notifier);
 
+#ifdef CONFIG_TSAN
+#include <sanitizer/tsan_interface.h>
+#endif
+
 struct QemuSpin {
     int value;
 };
@@ -213,23 +217,46 @@ struct QemuSpin {
 static inline void qemu_spin_init(QemuSpin *spin)
 {
     __sync_lock_release(&spin->value);
+#ifdef CONFIG_TSAN
+    __tsan_mutex_create(spin, __tsan_mutex_not_static);
+#endif
 }
 
-static inline void qemu_spin_destroy(QemuSpin *spin)
-{ }
+/* const parameter because the only purpose here is the TSAN annotation */
+static inline void qemu_spin_destroy(const QemuSpin *spin)
+{
+#ifdef CONFIG_TSAN
+    __tsan_mutex_destroy((void *)spin, __tsan_mutex_not_static);
+#endif
+}
 
 static inline void qemu_spin_lock(QemuSpin *spin)
 {
+#ifdef CONFIG_TSAN
+    __tsan_mutex_pre_lock(spin, 0);
+#endif
     while (unlikely(__sync_lock_test_and_set(&spin->value, true))) {
         while (atomic_read(&spin->value)) {
             cpu_relax();
         }
     }
+#ifdef CONFIG_TSAN
+    __tsan_mutex_post_lock(spin, 0, 0);
+#endif
 }
 
 static inline bool qemu_spin_trylock(QemuSpin *spin)
 {
-    return __sync_lock_test_and_set(&spin->value, true);
+#ifdef CONFIG_TSAN
+    __tsan_mutex_pre_lock(spin, __tsan_mutex_try_lock);
+#endif
+    bool busy = __sync_lock_test_and_set(&spin->value, true);
+#ifdef CONFIG_TSAN
+    unsigned flags = __tsan_mutex_try_lock;
+    flags |= busy ? __tsan_mutex_try_lock_failed : 0;
+    __tsan_mutex_post_lock(spin, flags, 0);
+#endif
+    return busy;
 }
 
 static inline bool qemu_spin_locked(QemuSpin *spin)
@@ -239,7 +266,13 @@ static inline bool qemu_spin_locked(QemuSpin *spin)
 
 static inline void qemu_spin_unlock(QemuSpin *spin)
 {
+#ifdef CONFIG_TSAN
+    __tsan_mutex_pre_unlock(spin, 0);
+#endif
     __sync_lock_release(&spin->value);
+#ifdef CONFIG_TSAN
+    __tsan_mutex_post_unlock(spin, 0);
+#endif
 }
 
 struct QemuLockCnt {
-- 
2.17.1


