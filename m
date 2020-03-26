Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484A5C2D0E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D80120714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmnjJcDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D80120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYMS-000239-5o
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJm-0005ed-DY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJl-0001Gp-5G
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:30 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYJl-0001Gd-1F
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:29 -0400
Received: by mail-qk1-x742.google.com with SMTP id c145so8134433qke.12
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2J4Nmd3k9E0GONt6majqdtko5Jz0lmYrhFciQ4irEcI=;
 b=cmnjJcDokVTArINkDHRw/wftn/f6oxWmGiX848zlcTpKfSfjUrM0PefCcRZtAlaWq9
 1xN7LTW+qiXNMVGeGu8jjrBlfUtZwphnHSAHekNlgTYhoUSrrYIIvCruCqvbc/MeYMSk
 dECzGA9iQnUKVBevF67Fbq/jm/TEkbDZ3ovGQmUF719kqPFiQZwHEC8vG/uiRHvyQGhh
 +zKqx0Y/wpaOCHD8tViosnkW3oE5RMWKSaPZyF1DWm0rlqrts856QrRw7ZPTofUSlzHR
 PQXR7bJ868LYy/LMVt8iiBtambg/JTq9zEDzdL0nxAXOJaYOQPU0pCf91iFknvausdAa
 pAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2J4Nmd3k9E0GONt6majqdtko5Jz0lmYrhFciQ4irEcI=;
 b=bYAplXVWBKVcpln53V852utJ2UxehdCxUO71HDOc1aMlNOZX4MylzsAGvPN1ItviMd
 tvDKUBeR82Pi4P88eyfihiLVa/V0tzH5tPm+Bf84iuw0+fHTpgLcFAdmPqtxOBuuDXf2
 w4lYzb5GCBAQsqCdz4u88TucIbXzL1ujfF862GSzLpJFk81hTuT6ajtHbSaA+Ym9WR6a
 QLz/nH3OFaOCj9gP7MAWiX649B8I/SVDfMD3AAQFMxBa3KMAA0Sue2RJ3hPxnM0WQkVm
 Jk4KH/RnhK5sgIrqEt/X7PK1WDeQCBPS3Yf0dOTmj/ywx1GZWWWLbzMzYd+ph/Hs70Kj
 Sxag==
X-Gm-Message-State: ANhLgQ3x6dvC9vSchcspRZP91mMTkdqyAodw/7gFs3dHXroFn14rMPVQ
 1qQrY4i3fpw+/A+J56ldC361nDSv5iFiWw==
X-Google-Smtp-Source: ADFU+vvM7WC2CPXP/SBxOB6fLNCP3SFb/gNJYRF0S7OmyRli6CW6/FFdxkWaRSVQKBBtajK9sAvkfQ==
X-Received: by 2002:a37:844:: with SMTP id 65mr9449566qki.15.1585251448086;
 Thu, 26 Mar 2020 12:37:28 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:27 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 02/74] cpu: rename cpu->work_mutex to cpu->lock
Date: Thu, 26 Mar 2020 15:30:44 -0400
Message-Id: <20200326193156.4322-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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

This lock will soon protect more fields of the struct. Give
it a more appropriate name.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c         | 14 +++++++-------
 cpus.c                |  4 ++--
 hw/core/cpu.c         |  4 ++--
 include/hw/core/cpu.h |  6 ++++--
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 3d659df464..f75cae23d9 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -107,10 +107,10 @@ struct qemu_work_item {
 
 static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
 {
-    qemu_mutex_lock(&cpu->work_mutex);
+    qemu_mutex_lock(&cpu->lock);
     QSIMPLEQ_INSERT_TAIL(&cpu->work_list, wi, node);
     wi->done = false;
-    qemu_mutex_unlock(&cpu->work_mutex);
+    qemu_mutex_unlock(&cpu->lock);
 
     qemu_cpu_kick(cpu);
 }
@@ -304,15 +304,15 @@ void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
 
-    qemu_mutex_lock(&cpu->work_mutex);
+    qemu_mutex_lock(&cpu->lock);
     if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
-        qemu_mutex_unlock(&cpu->work_mutex);
+        qemu_mutex_unlock(&cpu->lock);
         return;
     }
     while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
         wi = QSIMPLEQ_FIRST(&cpu->work_list);
         QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
-        qemu_mutex_unlock(&cpu->work_mutex);
+        qemu_mutex_unlock(&cpu->lock);
         if (wi->exclusive) {
             /* Running work items outside the BQL avoids the following deadlock:
              * 1) start_exclusive() is called with the BQL taken while another
@@ -328,13 +328,13 @@ void process_queued_cpu_work(CPUState *cpu)
         } else {
             wi->func(cpu, wi->data);
         }
-        qemu_mutex_lock(&cpu->work_mutex);
+        qemu_mutex_lock(&cpu->lock);
         if (wi->free) {
             g_free(wi);
         } else {
             atomic_mb_set(&wi->done, true);
         }
     }
-    qemu_mutex_unlock(&cpu->work_mutex);
+    qemu_mutex_unlock(&cpu->lock);
     qemu_cond_broadcast(&qemu_work_cond);
 }
diff --git a/cpus.c b/cpus.c
index 151abbc04c..71bd2f5d55 100644
--- a/cpus.c
+++ b/cpus.c
@@ -100,9 +100,9 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
 {
     bool ret;
 
-    qemu_mutex_lock(&cpu->work_mutex);
+    qemu_mutex_lock(&cpu->lock);
     ret = QSIMPLEQ_EMPTY(&cpu->work_list);
-    qemu_mutex_unlock(&cpu->work_mutex);
+    qemu_mutex_unlock(&cpu->lock);
     return ret;
 }
 
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 2fc6aa2159..bc0416829a 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -367,7 +367,7 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
 
-    qemu_mutex_init(&cpu->work_mutex);
+    qemu_mutex_init(&cpu->lock);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
@@ -379,7 +379,7 @@ static void cpu_common_finalize(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
-    qemu_mutex_destroy(&cpu->work_mutex);
+    qemu_mutex_destroy(cpu->lock);
 }
 
 static int64_t cpu_common_get_arch_id(CPUState *cpu)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 398b65159e..0b75fdb093 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -331,7 +331,8 @@ struct qemu_work_item;
  * @opaque: User data.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @kvm_fd: vCPU file descriptor for KVM.
- * @work_mutex: Lock to prevent multiple access to @work_list.
+ * @lock: Lock to prevent multiple access to per-CPU fields. Must be acquired
+ *        after the BQL.
  * @work_list: List of pending asynchronous work.
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
@@ -375,7 +376,8 @@ struct CPUState {
     uint64_t random_seed;
     sigjmp_buf jmp_env;
 
-    QemuMutex work_mutex;
+    QemuMutex lock;
+    /* fields below protected by @lock */
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     CPUAddressSpace *cpu_ases;
-- 
2.17.1


