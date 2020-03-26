Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68642C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB1B206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3oFF8mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB1B206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYje-0003s9-Ak
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLV-0000dv-He
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLU-0002GD-00
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:17 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:33140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLT-0002G4-Px
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:15 -0400
Received: by mail-qt1-x843.google.com with SMTP id c14so6577103qtp.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DxV2LkVkxZ0JK8RLYAmvvmQ/YQu2Mo+p3eePMYpr0Kw=;
 b=j3oFF8mFjFA7gqqrPh920l4L7Ce/Hwxlw5fBhVU1CWgL6cUza8FLHE/QcvX0uCekIZ
 udC/ttEAQNvrS3AIpeq8j5ZJBHBjThN/9rj5kRtwwMjaDbS16/jWKYMirnmKUN6+cluT
 MM/njKTrbH49VYyOb95P2g/4QwzIuEGgJ+ulTO/aDfJz8FFZJAQJfcTA72lDDeGmZGJR
 3PAbOMwlUdi2KM2ytURkzwMml2eyL/T6fJrTECTz4EU5YXG4+gJVRPr/OAZ4Y/Zw9SwI
 3jxkgNpTSVh+Ek0tTcZHA9iyocSGsRvJxJtSRE5Obs8ntoAa0JyOuNSmff9daaoVgAPY
 pVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DxV2LkVkxZ0JK8RLYAmvvmQ/YQu2Mo+p3eePMYpr0Kw=;
 b=D5F0yl28wqf7EAVWmb15Fxq2ptl5Qrk47EwAI68yZQN+DwvUXHjEwt2o810PDeNger
 Qy/vFV2ypBKlpGHPDQ1ohkRGs404fHAJKlIHiZmR80ZWQV7GWdI7i+uloFEELmmAz96h
 x2zCMMtJtDLT3ooUfnoH6vC/y1e2++YG0SY29KmweR2s0h9Hl0WCuQJmNHldGG36ooUd
 kQyks7Bv/h6KaGhEgwnn/jiXuUujFIL7CicBwKBaq8LD7heKDBHfxja8+SN3DtiFB+pv
 49lLP3R6djYCmkJ5E6ZdYe+72vXFBW/Ng5nuG7Av2A8nmWvBKHi9mMOFgPAVZrZwSYLq
 TSRg==
X-Gm-Message-State: ANhLgQ0CWf83sur5vu2jaWMQBZyPtkcZwhkdhx0fqGUoh+yq7yuWF6jz
 7tlc0KTr2YFKM1vkf88/EMZukLdCBSt3hg==
X-Google-Smtp-Source: ADFU+vt4CfxRFRH89zGcnsDHySE0mXplwXpxW9TfvGb5diYvehxjI0VcPAH0AOn5+Cq60BsBxC6yVw==
X-Received: by 2002:ac8:17f9:: with SMTP id r54mr10216067qtk.285.1585251554968; 
 Thu, 26 Mar 2020 12:39:14 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:39:14 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 73/74] cpu: add async_run_on_cpu_no_bql
Date: Thu, 26 Mar 2020 15:31:55 -0400
Message-Id: <20200326193156.4322-74-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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

Some async jobs do not need the BQL.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c         | 39 ++++++++++++++++++++++++++++++++++-----
 include/hw/core/cpu.h | 14 ++++++++++++++
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index f5daf2d518..efefe5e603 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -101,6 +101,7 @@ struct qemu_work_item {
     run_on_cpu_func func;
     run_on_cpu_data data;
     bool free, exclusive, done;
+    bool bql;
 };
 
 /* Called with the CPU's lock held */
@@ -147,6 +148,7 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     wi.done = false;
     wi.free = false;
     wi.exclusive = false;
+    wi.bql = true;
 
     cpu_mutex_lock(cpu);
     queue_work_on_cpu_locked(cpu, &wi);
@@ -171,6 +173,21 @@ void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     wi->func = func;
     wi->data = data;
     wi->free = true;
+    wi->bql = true;
+
+    queue_work_on_cpu(cpu, wi);
+}
+
+void async_run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
+                             run_on_cpu_data data)
+{
+    struct qemu_work_item *wi;
+
+    wi = g_malloc0(sizeof(struct qemu_work_item));
+    wi->func = func;
+    wi->data = data;
+    wi->free = true;
+    /* wi->bql initialized to false */
 
     queue_work_on_cpu(cpu, wi);
 }
@@ -319,6 +336,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
     wi->data = data;
     wi->free = true;
     wi->exclusive = true;
+    /* wi->bql initialized to false */
 
     queue_work_on_cpu(cpu, wi);
 }
@@ -343,6 +361,7 @@ static void process_queued_cpu_work_locked(CPUState *cpu)
              * BQL, so it goes to sleep; start_exclusive() is sleeping too, so
              * neither CPU can proceed.
              */
+            g_assert(!wi->bql);
             if (has_bql) {
                 qemu_mutex_unlock_iothread();
             }
@@ -353,12 +372,22 @@ static void process_queued_cpu_work_locked(CPUState *cpu)
                 qemu_mutex_lock_iothread();
             }
         } else {
-            if (has_bql) {
-                wi->func(cpu, wi->data);
+            if (wi->bql) {
+                if (has_bql) {
+                    wi->func(cpu, wi->data);
+                } else {
+                    qemu_mutex_lock_iothread();
+                    wi->func(cpu, wi->data);
+                    qemu_mutex_unlock_iothread();
+                }
             } else {
-                qemu_mutex_lock_iothread();
-                wi->func(cpu, wi->data);
-                qemu_mutex_unlock_iothread();
+                if (has_bql) {
+                    qemu_mutex_unlock_iothread();
+                    wi->func(cpu, wi->data);
+                    qemu_mutex_lock_iothread();
+                } else {
+                    wi->func(cpu, wi->data);
+                }
             }
         }
         cpu_mutex_lock(cpu);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 8f70249f45..91e35bf940 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -889,9 +889,23 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
  * @data: Data to pass to the function.
  *
  * Schedules the function @func for execution on the vCPU @cpu asynchronously.
+ * See also: async_run_on_cpu_no_bql()
  */
 void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
 
+/**
+ * async_run_on_cpu_no_bql:
+ * @cpu: The vCPU to run on.
+ * @func: The function to be executed.
+ * @data: Data to pass to the function.
+ *
+ * Schedules the function @func for execution on the vCPU @cpu asynchronously.
+ * This function is run outside the BQL.
+ * See also: async_run_on_cpu()
+ */
+void async_run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
+                             run_on_cpu_data data);
+
 /**
  * async_safe_run_on_cpu:
  * @cpu: The vCPU to run on.
-- 
2.17.1


