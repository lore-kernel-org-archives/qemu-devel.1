Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3FDC55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F65223AC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adU1+k15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F65223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzQU-0004HX-GH
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzOr-0002Rq-JS
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzOn-0006bY-T5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=TGGBqiGB6r8dKyjh5nHD5mqpIoJiTqKb6xBSBz5qwVQ=;
 b=adU1+k15TD42zyv0SxTzGCZ5DSTuv4KPkKTa6SgwqeyvfFbBiXFyj0EaEWqYkbp2oSGuJq
 fYDKemT5mZ6XcanlwErNvqnjA/vgWNqFgWusFE5QdEmvdsqL+K2WvUXl0Z1tM78JmaiIRE
 lO86VgveMbIRE7wXuK0LRLseFGUS8+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-cjBst0nUOPyE8xXlSVs-pg-1; Mon, 26 Oct 2020 06:06:42 -0400
X-MC-Unique: cjBst0nUOPyE8xXlSVs-pg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA04380B714;
 Mon, 26 Oct 2020 10:06:41 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADAA88B846;
 Mon, 26 Oct 2020 10:06:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/31] accel: move qtest CpusAccel functions to a common
 location
Date: Mon, 26 Oct 2020 11:06:05 +0100
Message-Id: <20201026100632.212530-5-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Andryuk <jandryuk@gmail.com>

Move and rename accel/qtest/qtest-cpus.c files to accel/dummy-cpus.c so
it can be re-used by Xen.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Message-Id: <20201013140511.5681-3-jandryuk@gmail.com>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 accel/{qtest/qtest-cpus.c => dummy-cpus.c} | 22 ++++------------------
 accel/meson.build                          |  7 +++++++
 accel/qtest/meson.build                    |  1 -
 accel/qtest/qtest-cpus.h                   | 17 -----------------
 accel/qtest/qtest.c                        |  5 ++++-
 include/sysemu/cpus.h                      |  3 +++
 6 files changed, 18 insertions(+), 37 deletions(-)
 rename accel/{qtest/qtest-cpus.c => dummy-cpus.c} (75%)
 delete mode 100644 accel/qtest/qtest-cpus.h

diff --git a/accel/qtest/qtest-cpus.c b/accel/dummy-cpus.c
similarity index 75%
rename from accel/qtest/qtest-cpus.c
rename to accel/dummy-cpus.c
index db094201c1..10429fdfb2 100644
--- a/accel/qtest/qtest-cpus.c
+++ b/accel/dummy-cpus.c
@@ -1,5 +1,5 @@
 /*
- * QTest accelerator code
+ * Dummy cpu thread code
  *
  * Copyright IBM, Corp. 2011
  *
@@ -13,21 +13,12 @@
 
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
-
-static void *qtest_cpu_thread_fn(void *arg)
+static void *dummy_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
     sigset_t waitset;
@@ -67,7 +58,7 @@ static void *qtest_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void qtest_start_vcpu_thread(CPUState *cpu)
+void dummy_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -76,11 +67,6 @@ static void qtest_start_vcpu_thread(CPUState *cpu)
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
diff --git a/accel/meson.build b/accel/meson.build
index bb00d0fd13..9a417396bd 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -5,3 +5,10 @@ subdir('kvm')
 subdir('tcg')
 subdir('xen')
 subdir('stubs')
+
+dummy_ss = ss.source_set()
+dummy_ss.add(files(
+  'dummy-cpus.c',
+))
+
+specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: dummy_ss)
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
diff --git a/accel/qtest/qtest-cpus.h b/accel/qtest/qtest-cpus.h
deleted file mode 100644
index 739519a472..0000000000
--- a/accel/qtest/qtest-cpus.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Accelerator CPUS Interface
- *
- * Copyright 2020 SUSE LLC
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef QTEST_CPUS_H
-#define QTEST_CPUS_H
-
-#include "sysemu/cpus.h"
-
-extern const CpusAccel qtest_cpus;
-
-#endif /* QTEST_CPUS_H */
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 537e8b449c..b282cea5cf 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -25,7 +25,10 @@
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
 
-#include "qtest-cpus.h"
+const CpusAccel qtest_cpus = {
+    .create_vcpu_thread = dummy_start_vcpu_thread,
+    .get_virtual_clock = qtest_get_virtual_clock,
+};
 
 static int qtest_init_accel(MachineState *ms)
 {
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 231685955d..e8156728c6 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -25,6 +25,9 @@ typedef struct CpusAccel {
 /* register accel-specific cpus interface implementation */
 void cpus_register_accel(const CpusAccel *i);
 
+/* Create a dummy vcpu for CpusAccel->create_vcpu_thread */
+void dummy_start_vcpu_thread(CPUState *);
+
 /* interface available for cpus accelerator threads */
 
 /* For temporary buffers for forming a name */
-- 
2.18.2


