Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864A9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E1D206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axHGRNUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E1D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS47n-0000mB-PR
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kS46z-0008LF-2S
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:08:01 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:33871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kS46w-0007qF-4Z
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:08:00 -0400
Received: by mail-qt1-x842.google.com with SMTP id h12so12901692qtu.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 13:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6i0NScgWxuYRAmEw5Dp2uEcKLK/7VCmjil9HLRrvCqc=;
 b=axHGRNUcRl5LmqSUCaGstkBes2pmf45tBRyjVElv1sCdHf9r8lYs0HQQk10z7mLtPF
 RZhbaQHRQ3OzH7fe4SqduS93vsRdP8BnlzmLJIwh7cXrRRNyw21//4+sbQ+NzuEmWp7X
 TNG7stKGvNPjfyLZwg7o2dcOwrsebG1EOwkgy6aCGRzieUidxPzLMDqAkJ1RRw/Bgo51
 BQIqUJU/lwzNWKRROocAdHvYAHJe5berCD1Nhq8shRpE06F+vFj61tVHAiapMtb0u+Xw
 3FvRcI0Kq4fusX8E/hTQ2Ju8efCT73toLD4zmcO+K37Xy5jyIFQazdCVCSAmXMfpylz+
 pwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6i0NScgWxuYRAmEw5Dp2uEcKLK/7VCmjil9HLRrvCqc=;
 b=YlYEhi88HPEPQB/TfHzyqBslKpk4SDGETxujuDWC7NkMFfnby4R+8Eaksnvd6mYOBC
 Cfqp32aSfFIv57nEGLZPOewSqR+AKch2k3dCylXT5aHeSz7gLzScKqTaAg7ym9rMZMr2
 OZq8UuD0JT9Kg2oq3vdGDXyPkyiPQc68j8De/0GbTqWIGs5//1+fuoeYvk3NgmKfswaQ
 Y1d6ZoRG9UiY4R/ZL4TTp4M06P1BBa3hFqNjmfpTBe/bcWKcNSXU3X7Q/YbscN3syk7b
 ZVx1mnmNAY0tbNC3xKJW00PqwQPGYVCjqlRsPYBZPB8iqRqJLpZV5JMD6QgO3LJR/zE3
 Rv9Q==
X-Gm-Message-State: AOAM530j5s08flYl8jCKT4B6T5FjbSiGUXsDyrcrkj8aoVOEea4BamIp
 TT+I+lyZtn6Lsan8crA7yyvMzvK7wD4=
X-Google-Smtp-Source: ABdhPJxYVciNERydeeCQqQvQNkdYQ9e0kSc+LavTgvfZezC4swqdX9QbhsspxDFkVzzn2T4wkXg0Jg==
X-Received: by 2002:ac8:4792:: with SMTP id k18mr11497750qtq.296.1602533276852; 
 Mon, 12 Oct 2020 13:07:56 -0700 (PDT)
Received: from shine.lan ([2001:470:8:67e:9802:d83e:b724:7fdf])
 by smtp.gmail.com with ESMTPSA id d129sm13418350qkg.127.2020.10.12.13.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 13:07:55 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] accel: move qtest CpusAccel functions to a common location
Date: Mon, 12 Oct 2020 16:07:23 -0400
Message-Id: <20201012200725.64137-2-jandryuk@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012200725.64137-1-jandryuk@gmail.com>
References: <20201012200725.64137-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=jandryuk@gmail.com; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move and rename accel/qtest/qtest-cpu.* files to accel/dummy/ so they
can be re-used by Xen.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 .../qtest-cpus.c => dummy/dummy-cpus.c}       | 22 +++++--------------
 .../qtest-cpus.h => dummy/dummy-cpus.h}       | 10 ++++-----
 accel/dummy/meson.build                       |  6 +++++
 accel/meson.build                             |  1 +
 accel/qtest/meson.build                       |  1 -
 accel/qtest/qtest.c                           |  7 +++++-
 6 files changed, 23 insertions(+), 24 deletions(-)
 rename accel/{qtest/qtest-cpus.c => dummy/dummy-cpus.c} (76%)
 rename accel/{qtest/qtest-cpus.h => dummy/dummy-cpus.h} (59%)
 create mode 100644 accel/dummy/meson.build

diff --git a/accel/qtest/qtest-cpus.c b/accel/dummy/dummy-cpus.c
similarity index 76%
rename from accel/qtest/qtest-cpus.c
rename to accel/dummy/dummy-cpus.c
index 7c5399ed9d..efade99f03 100644
--- a/accel/qtest/qtest-cpus.c
+++ b/accel/dummy/dummy-cpus.c
@@ -1,5 +1,5 @@
 /*
- * QTest accelerator code
+ * Dummy cpu thread code
  *
  * Copyright IBM, Corp. 2011
  *
@@ -13,21 +13,14 @@
 
 #include "qemu/osdep.h"
 #include "qemu/rcu.h"
-#include "qapi/error.h"
-#include "qemu/module.h"
-#include "qemu/option.h"
-#include "qemu/config-file.h"
-#include "sysemu/accel.h"
-#include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
-#include "sysemu/cpu-timers.h"
 #include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
 
-#include "qtest-cpus.h"
+#include "dummy-cpus.h"
 
-static void *qtest_cpu_thread_fn(void *arg)
+static void *dummy_cpu_thread_fn(void *arg)
 {
 #ifdef _WIN32
     error_report("qtest is not supported under Windows");
@@ -72,7 +65,7 @@ static void *qtest_cpu_thread_fn(void *arg)
 #endif
 }
 
-static void qtest_start_vcpu_thread(CPUState *cpu)
+void dummy_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -81,11 +74,6 @@ static void qtest_start_vcpu_thread(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qtest_cpu_thread_fn, cpu,
+    qemu_thread_create(cpu->thread, thread_name, dummy_cpu_thread_fn, cpu,
                        QEMU_THREAD_JOINABLE);
 }
-
-const CpusAccel qtest_cpus = {
-    .create_vcpu_thread = qtest_start_vcpu_thread,
-    .get_virtual_clock = qtest_get_virtual_clock,
-};
diff --git a/accel/qtest/qtest-cpus.h b/accel/dummy/dummy-cpus.h
similarity index 59%
rename from accel/qtest/qtest-cpus.h
rename to accel/dummy/dummy-cpus.h
index 739519a472..a7a0469b17 100644
--- a/accel/qtest/qtest-cpus.h
+++ b/accel/dummy/dummy-cpus.h
@@ -7,11 +7,11 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef QTEST_CPUS_H
-#define QTEST_CPUS_H
+#ifndef DUMMY_CPUS_H
+#define DUMMY_CPUS_H
 
-#include "sysemu/cpus.h"
+#include "qemu/typedefs.h"
 
-extern const CpusAccel qtest_cpus;
+void dummy_start_vcpu_thread(CPUState *);
 
-#endif /* QTEST_CPUS_H */
+#endif /* DUMMY_CPUS_H */
diff --git a/accel/dummy/meson.build b/accel/dummy/meson.build
new file mode 100644
index 0000000000..5fbe27de90
--- /dev/null
+++ b/accel/dummy/meson.build
@@ -0,0 +1,6 @@
+dummy_ss = ss.source_set()
+dummy_ss.add(files(
+  'dummy-cpus.c',
+))
+
+specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: dummy_ss)
diff --git a/accel/meson.build b/accel/meson.build
index bb00d0fd13..d45a33fb8e 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,5 +1,6 @@
 softmmu_ss.add(files('accel.c'))
 
+subdir('dummy')
 subdir('qtest')
 subdir('kvm')
 subdir('tcg')
diff --git a/accel/qtest/meson.build b/accel/qtest/meson.build
index e477cb2ae2..a2f3276459 100644
--- a/accel/qtest/meson.build
+++ b/accel/qtest/meson.build
@@ -1,7 +1,6 @@
 qtest_ss = ss.source_set()
 qtest_ss.add(files(
   'qtest.c',
-  'qtest-cpus.c',
 ))
 
 specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: qtest_ss)
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 537e8b449c..ac54bc8f52 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -25,7 +25,12 @@
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
 
-#include "qtest-cpus.h"
+#include "accel/dummy/dummy-cpus.h"
+
+const CpusAccel qtest_cpus = {
+    .create_vcpu_thread = dummy_start_vcpu_thread,
+    .get_virtual_clock = qtest_get_virtual_clock,
+};
 
 static int qtest_init_accel(MachineState *ms)
 {
-- 
2.25.1


