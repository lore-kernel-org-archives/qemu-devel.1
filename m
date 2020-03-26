Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65E2C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A8A20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLimLxqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A8A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYLk-0000iy-QH
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJy-00061Z-Ie
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJx-0001Mn-EH
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:42 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:45602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYJx-0001MT-9o
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:41 -0400
Received: by mail-qk1-x743.google.com with SMTP id c145so8135332qke.12
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jjmk8HMVsaMAjw4OpmNeL2f8ls8xSfNsLsqnnyNmPuQ=;
 b=rLimLxqzAGiQnmDaz/CubO/0wZKhPAnzFUe5PvwwJRvz5PfYW33GroA8H403Azn/kk
 SYLK7FIg5UkDYHUOAIcaUwWvBtbbCC4sA7rhmL2vPsyelMPbAY5nwkIXxrE/0bLNR0SS
 v4IN4AY10MnYUePV3MqcA5qVG/HL3dP7P4GjrH9OGPjEbQYnP4SRrtv8r+o9ogJvrcsv
 yiIDnXOvbeiaLmG6xdcFCbttGrU1UADJBO+x59ZXbU3ftHfUi/7eqvtBifJF5o6Dz5np
 CvtLb8E6P7k0n9oZIqxvWidLRSPhAfgkX9Q4Rm8qOg5JekLGwpVfgCufqxFQMeTxTiaA
 rTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jjmk8HMVsaMAjw4OpmNeL2f8ls8xSfNsLsqnnyNmPuQ=;
 b=Z/+ekdm4m002U+il+qCD7iIvZUQtXGnVVGPvpX/T2aAUhpUulJGHAUmnXKEGLACLVR
 LULrJFk9znOTppUynIiHfn4/VTpMDS7z0FdMVysOhGVRPICk8ykpO46GgzB0ykSYcLsa
 gXHerN3pyCMxirWzDqLdL1cH6F7DAnDzd67aHYEIzTFQ031M0sKRBbDcPZsmSI5xt6Vn
 atN159akWfU0jI6HoNLtM0foEaB/g/4wz+mA8zg7cQ22kz9jSGDnwds5LXCejpHJkNe2
 mdHIJ+CrlkuJax87eRDzJTjcgWn7LFjHk8S3cQeWLbdLL7p4nBaceYLeW85zvi3LZGyz
 YrqA==
X-Gm-Message-State: ANhLgQ0E3q39a5FUqh/whb4aeYEXFK84qCsp8tOXsCzJORhbWcrL7/GX
 AsfMPgUf4/ZheyEm8ibvJJOxZAp+X22tPw==
X-Google-Smtp-Source: ADFU+vtklK73HVW65hfqKZJZiiiC2Uv9BxH/DO93MWUd2SIyfPu/mLIGf1ISoBqjLiPRYmdXLRwhDw==
X-Received: by 2002:a05:620a:120e:: with SMTP id
 u14mr9313433qkj.23.1585251460510; 
 Thu, 26 Mar 2020 12:37:40 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:39 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 06/74] cpu: introduce process_queued_cpu_work_locked
Date: Thu, 26 Mar 2020 15:30:48 -0400
Message-Id: <20200326193156.4322-7-robert.foley@linaro.org>
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

This completes the conversion to cpu_mutex_lock/unlock in the file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index bf5794cc17..f4a0f9ba3b 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -333,20 +333,19 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
     queue_work_on_cpu(cpu, wi);
 }
 
-void process_queued_cpu_work(CPUState *cpu)
+/* Called with the CPU's lock held */
+static void process_queued_cpu_work_locked(CPUState *cpu)
 {
     struct qemu_work_item *wi;
     bool has_bql = qemu_mutex_iothread_locked();
 
-    qemu_mutex_lock(&cpu->lock);
     if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
-        qemu_mutex_unlock(&cpu->lock);
         return;
     }
     while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
         wi = QSIMPLEQ_FIRST(&cpu->work_list);
         QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
-        qemu_mutex_unlock(&cpu->lock);
+        cpu_mutex_unlock(cpu);
         if (wi->exclusive) {
             /* Running work items outside the BQL avoids the following deadlock:
              * 1) start_exclusive() is called with the BQL taken while another
@@ -372,13 +371,19 @@ void process_queued_cpu_work(CPUState *cpu)
                 qemu_mutex_unlock_iothread();
             }
         }
-        qemu_mutex_lock(&cpu->lock);
+        cpu_mutex_lock(cpu);
         if (wi->free) {
             g_free(wi);
         } else {
             atomic_mb_set(&wi->done, true);
         }
     }
-    qemu_mutex_unlock(&cpu->lock);
     qemu_cond_broadcast(&cpu->cond);
 }
+
+void process_queued_cpu_work(CPUState *cpu)
+{
+    cpu_mutex_lock(cpu);
+    process_queued_cpu_work_locked(cpu);
+    cpu_mutex_unlock(cpu);
+}
-- 
2.17.1


