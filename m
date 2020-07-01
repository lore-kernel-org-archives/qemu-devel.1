Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F1DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9707520720
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdOj8hFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9707520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqgxE-0003ZO-QL
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 13:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqgwV-0002yQ-CS
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:54:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32841
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqgwS-0007Cq-Sa
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593626079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kF+8m07BX3QpxKMxa4T6CTC41Noz2xPVueqJb6b5lc8=;
 b=VdOj8hFdLEg8K7PaDpZqaaDM3jIABvC4kpTQQJFWvzsYetKQHFOGyvLUsSg/Z35cfCUhHm
 Q1U9rIxAxFJ9nFHWWT1+cJ1hlZPRKWh1oB318lqcRFuJv8cAq/Bn3XRL5DCSdd1l/7h1ww
 zM4BYkG1V0J5ogu1p6IaREx71PH+4kA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-3xRh3jY-P4Oxd2IN1KtR-w-1; Wed, 01 Jul 2020 13:54:36 -0400
X-MC-Unique: 3xRh3jY-P4Oxd2IN1KtR-w-1
Received: by mail-ed1-f69.google.com with SMTP id v8so15442445edj.4
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 10:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kF+8m07BX3QpxKMxa4T6CTC41Noz2xPVueqJb6b5lc8=;
 b=Ls2tkV2lYFeMg/KcdSlIrBqdKdZc7VdmCTywvo4Kcp8wUYt5ZAb1B6ns8z+SLK1Lvy
 inkNwHvQaMcC0dMCxwDXAP6fZ0LsG5nyAfKFcdAuIa8+m/b5UXw4BwEXQE6/53hqoxCT
 9EA2d7wWlizpyHVppke1tLbpnqeEBc1Z1DkoWsXyMgoEs4N2FofRNdfvoF9hoNgL19lX
 BIus9aHW2OZVhb4OzAQRXDCU0HPhZR+9lUnfYoW6/Y8w5c4Sq3gGt3f1z8K+Tvo4Q2bS
 JZ9vOEiovU7ihHKQ3kDZEZl3D/u/AWtjlwEQtVzcGKjWAzCdNVG732izOQpPQ6YpW1iz
 yOOQ==
X-Gm-Message-State: AOAM532SjtJ3UWosRh7qqzcEmP5cLxFZSXeufgAM2oD2De7Kk7Vd9n8K
 FXV7g47KYTF8ec+ph9ZRv5r4Nwufg2m6//nqJl79w3l211UBrvqb/1+2qrz0jg6hcB/HbvTryBR
 Q+VOrVv1XrAF4U8k=
X-Received: by 2002:a05:6402:706:: with SMTP id
 w6mr29640641edx.326.1593626074722; 
 Wed, 01 Jul 2020 10:54:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7kNoL+04TjzjHwf06iCYJfm7RLqllZCfZ+F9wUzLpVmvoghZvkgj5DCbRWgxG9PBN7nd6eA==
X-Received: by 2002:a05:6402:706:: with SMTP id
 w6mr29640623edx.326.1593626074520; 
 Wed, 01 Jul 2020 10:54:34 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id s7sm6494753edr.57.2020.07.01.10.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 10:54:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] cpus: Move CPU code from exec.c to cpus.c
Date: Wed,  1 Jul 2020 19:54:32 +0200
Message-Id: <20200701175432.18892-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code was introduced with SMP support in commit 6a00d60127,
later commit 296af7c952 moved CPU parts to cpus.c but forgot this
code. Move now and simplify ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 cpus.c | 18 ++++++++++++++++++
 exec.c | 22 ----------------------
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/cpus.c b/cpus.c
index 41d1c5099f..472686cbbc 100644
--- a/cpus.c
+++ b/cpus.c
@@ -92,6 +92,11 @@ static unsigned int throttle_percentage;
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
 
+CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
+
+/* current CPU in the current thread. It is only valid inside cpu_exec() */
+__thread CPUState *current_cpu;
+
 bool cpu_is_stopped(CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
@@ -134,6 +139,19 @@ static bool all_cpu_threads_idle(void)
     return true;
 }
 
+CPUState *qemu_get_cpu(int index)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (cpu->cpu_index == index) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
 /***********************************************************/
 /* guest cycle counter */
 
diff --git a/exec.c b/exec.c
index 21926dc9c7..997b7db15f 100644
--- a/exec.c
+++ b/exec.c
@@ -98,12 +98,6 @@ AddressSpace address_space_memory;
 static MemoryRegion io_mem_unassigned;
 #endif
 
-CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
-
-/* current CPU in the current thread. It is only valid inside
-   cpu_exec() */
-__thread CPUState *current_cpu;
-
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
 
@@ -832,22 +826,6 @@ const VMStateDescription vmstate_cpu_common = {
     }
 };
 
-#endif
-
-CPUState *qemu_get_cpu(int index)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        if (cpu->cpu_index == index) {
-            return cpu;
-        }
-    }
-
-    return NULL;
-}
-
-#if !defined(CONFIG_USER_ONLY)
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr)
 {
-- 
2.21.3


