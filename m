Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC867C2D0E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F2E2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYMBLsJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F2E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYyh-0002i2-TV
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLU-0000cF-U7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLT-0002G0-KH
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:16 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:40108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLT-0002Fn-Fm
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:15 -0400
Received: by mail-qk1-x743.google.com with SMTP id l25so8190013qki.7
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rUhgLfadfGQvM7gNTBGDLFffVlG6lB5oP5ofMlz9KHY=;
 b=sYMBLsJCvqIwN/gi2ckGzc/7uirPnb4iR08PTPScNMf+Me1O7JDvnpr5Vip7LYYMh6
 G/2p7yrTjhuJdjlsRX3lAOp0/lvz0+IN5y7fQtoc0swhI8Y/LWYTCXO53vRzHZ4pNEGf
 vY3XbWmjZieAW7fv72o360FfOtcypF2n9vLzxFFqe+CouSzWJCwhZxlEl6h3ngPldFOW
 g5y1Un94Fh3LRmkqXP1zK/meOp6MH7UO2s5ZUC0Dw4LKlomGAkwxL2JltkYqOKK7wEq2
 89PVSk4QxIU+qRvjHBmus/U1brX+9vi4UrKTkhDSROqkoMWrhuyRkCVyhuFxkzTm5ICh
 T+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rUhgLfadfGQvM7gNTBGDLFffVlG6lB5oP5ofMlz9KHY=;
 b=DC3LsgnJcYEAu36PZ1h8j8Tl4kOECUxjBgFKxX9FaU2AqpWipqOhS8Bkw/CkNWSljj
 0lPjwkbfd5vGJV+QLQ1FUKm+lKC9JMRPG0LBQEfAvxKgbK/qPwMU0jfLsFCPrXVDtwII
 8bkvyXAAhiO1/AAQTyOOz53dyra2Dvny7s3LvR8eQRE10AB5WwlPuf771kt1D1H/cwAG
 qCVqQkAbBkwjgyDmVY+G9vfYrYc5z9i/gdttz/vlDD4AmRfijlYgjXPpvTvGk+i4zrGI
 nfr/RMjg5Qet9UzZirr+G/qFuB+DtVoVjI7Zt8wezxIzdBCZamIIV63fguCCE0hl9rCl
 SB3A==
X-Gm-Message-State: ANhLgQ1FKSqKSyL13XnRtLA6TgRdvxJ/JcBD+CdY0DROHTBraSIEzsLs
 T3NVdVd9kfMG6uORr+VGwiyKttY6iTYnPg==
X-Google-Smtp-Source: ADFU+vtr0Krx96ZywhDuDOB8FsVjdceqECd9/VaBUgM2IUECqso+6f+jcEXEJLahcqk5kwYktZx06w==
X-Received: by 2002:a37:a807:: with SMTP id r7mr10566025qke.5.1585251553681;
 Thu, 26 Mar 2020 12:39:13 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:39:13 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 72/74] cpus-common: release BQL earlier in run_on_cpu
Date: Thu, 26 Mar 2020 15:31:54 -0400
Message-Id: <20200326193156.4322-73-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

After completing the conversion to per-CPU locks, there is no need
to release the BQL after having called cpu_kick.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 9ca025149e..f5daf2d518 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -137,6 +137,11 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
         return;
     }
 
+    /* We are going to sleep on the CPU lock, so release the BQL */
+    if (has_bql) {
+        qemu_mutex_unlock_iothread();
+    }
+
     wi.func = func;
     wi.data = data;
     wi.done = false;
@@ -145,21 +150,6 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 
     cpu_mutex_lock(cpu);
     queue_work_on_cpu_locked(cpu, &wi);
-
-    /*
-     * We are going to sleep on the CPU lock, so release the BQL.
-     *
-     * During the transition to per-CPU locks, we release the BQL _after_
-     * having kicked the destination CPU (from queue_work_on_cpu_locked above).
-     * This makes sure that the enqueued work will be seen by the CPU
-     * after being woken up from the kick, since the CPU sleeps on the BQL.
-     * Once we complete the transition to per-CPU locks, we will release
-     * the BQL earlier in this function.
-     */
-    if (has_bql) {
-        qemu_mutex_unlock_iothread();
-    }
-
     while (!atomic_mb_read(&wi.done)) {
         CPUState *self_cpu = current_cpu;
 
-- 
2.17.1


