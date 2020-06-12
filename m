Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E224C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B8620792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJooRcTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B8620792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjp87-0002zr-9h
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjoxQ-0000vA-C0
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:03:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33276)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjoxI-0006vF-6L
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:03:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so10830010wru.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xHHjjaudmjL3/NPzgw9p99IfJr3tJhoDfzqQ+U0Pj+w=;
 b=nJooRcToGPjCrsx3E/yLF2PF+F8TKxwOo17wJVXcKfqdZu9JDxgLr2+BjeVyGBDzS/
 gPGYojuGSNw2RmuTTuGWyh+AsN8kLoKg4Qq4rZI7BP9MsPW/rqrfFsnnu6C5lw4tlUlw
 ZWolRVp15LqvU8lErtoOhio0Xq61hXNYhfddWkuyQXzMD7/3Cv+1PCD+Z88Dl1aWCArC
 UrokSCFQJ73Qjv7rtCigit5oF0GGwWxlBd+KKi8PgptaA3nWwigo5rNQWRv5iaZoyhad
 LydnviyZa7pzfCDqBRow9JRhzozwDDRdgVwfSHNaGRL3n32cJLZh65VuhB4loSePfg+L
 deiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xHHjjaudmjL3/NPzgw9p99IfJr3tJhoDfzqQ+U0Pj+w=;
 b=aRKO0PnHMpstvGtI09yys7uVQiAmZGYUSzPvRzrUOfKZrFVCv8wlKgff/t8axxCJvl
 o4A3HP+M72Wlez/b9zzHnEYY5gDuZQtQBJU+lMgi/RZ1gADlUhKnWJD15+2PYdSYNGs8
 SsjSPaMhHQBZZXJ/PLWdhrLymdwa0Q9Yrg37Qe946Ko9arUcE6uKUI+F++P1qz65DHd2
 nOgb/0d7qsQSQDg9trdE6/Kcp4g0PQG4Cx1pEgic5uYk3PO/lDIvcChkNoLHfjU8SW6I
 rHFU5RKbRlWPsXkjDIX8+FFKKkELf6Ho9S29+XRiyq+5zFUCmtgCCcQxz5wAHMIKLiVH
 +X9g==
X-Gm-Message-State: AOAM533//9930f4/u09djZVP3mlRcB+4AQPEh3z+iaXQXbdRlUneLqAD
 EFrXWRDr3Ixd1FZtTpMCMZIs9Q==
X-Google-Smtp-Source: ABdhPJztNGjh5l4dH8BRMQ2N9NJ0jfOug4KdE3m7duc/NnBwJq6CAGFMUaGR3xfG/SFdegodfUZJRg==
X-Received: by 2002:a7b:c5d5:: with SMTP id n21mr364233wmk.106.1591988578082; 
 Fri, 12 Jun 2020 12:02:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d5sm11991420wrb.14.2020.06.12.12.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:02:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D3F9C1FF9A;
 Fri, 12 Jun 2020 20:02:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 11/18] thread: add tsan annotations to QemuSpin
Date: Fri, 12 Jun 2020 20:02:30 +0100
Message-Id: <20200612190237.30436-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612190237.30436-1-alex.bennee@linaro.org>
References: <20200612190237.30436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200609200738.445-9-robert.foley@linaro.org>
---
 include/qemu/thread.h | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index e50a0738897..43fc094b963 100644
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
2.20.1


