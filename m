Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FABC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 23:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0703920772
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 23:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fte7fUA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0703920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju2mW-0003iD-8k
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 19:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ju2lc-00027i-Q6
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 19:49:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44931
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ju2lY-0002ur-ME
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 19:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594424955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q42BDY967NfwgMkZvZMzYnSwg8UHqHjFKh4m0sMC/YQ=;
 b=fte7fUA3oPep370txJ0DPGDaU+yEmvIimdZqC7ERgtOO7IG4MRRMVRybIhMUZIrUtdOdKw
 ZilmopyBqsI7et+8xuYZl2efHGMoR2ewfYIy+qTQIAxAz8qoy4k/56j9n3jKHS4S/Orjs7
 7r0wfqwr1LqwCuvwr4Ao3f/wRIgB/bM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-m8zUwrJYNu6kNuw6nmhNNg-1; Fri, 10 Jul 2020 19:49:11 -0400
X-MC-Unique: m8zUwrJYNu6kNuw6nmhNNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC688108B;
 Fri, 10 Jul 2020 23:49:10 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B3C15C240;
 Fri, 10 Jul 2020 23:49:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 41/47] cpu-throttle: new module, extracted from cpus.c
Date: Fri, 10 Jul 2020 19:49:08 -0400
Message-Id: <20200710234909.21682-2-pbonzini@redhat.com>
In-Reply-To: <20200710234909.21682-1-pbonzini@redhat.com>
References: <20200710234909.21682-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 18:45:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

move the vcpu throttling functionality into its own module.

This functionality is not specific to any accelerator,
and it is used currently by migration to slow down guests to try to
have migrations converge, and by the cocoa MacOS UI to throttle speed.

cpu-throttle contains the controls to adjust and inspect throttle
settings, start (set) and stop vcpu throttling, and the throttling
function itself that is run periodically on vcpus to make them take a nap.

Execution of the throttling function on all vcpus is triggered by a timer,
registered at module initialization.

No functionality change.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20200629093504.3228-3-cfontana@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                   |   1 +
 include/hw/core/cpu.h         |  37 -----------
 include/qemu/main-loop.h      |   5 ++
 include/sysemu/cpu-throttle.h |  68 +++++++++++++++++++
 migration/migration.c         |   1 +
 migration/ram.c               |   1 +
 softmmu/Makefile.objs         |   1 +
 softmmu/cpu-throttle.c        | 122 ++++++++++++++++++++++++++++++++++
 softmmu/cpus.c                |  95 +++-----------------------
 ui/cocoa.m                    |   1 +
 10 files changed, 208 insertions(+), 124 deletions(-)
 create mode 100644 include/sysemu/cpu-throttle.h
 create mode 100644 softmmu/cpu-throttle.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 28f33123ec..361ae5c662 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2247,6 +2247,7 @@ F: util/qemu-timer.c
 F: softmmu/vl.c
 F: softmmu/main.c
 F: softmmu/cpus.c
+F: softmmu/cpu-throttle.c
 F: qapi/run-state.json
 
 Human Monitor (HMP)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b3f4b79318..5542577d2b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -822,43 +822,6 @@ bool cpu_exists(int64_t id);
  */
 CPUState *cpu_by_arch_id(int64_t id);
 
-/**
- * cpu_throttle_set:
- * @new_throttle_pct: Percent of sleep time. Valid range is 1 to 99.
- *
- * Throttles all vcpus by forcing them to sleep for the given percentage of
- * time. A throttle_percentage of 25 corresponds to a 75% duty cycle roughly.
- * (example: 10ms sleep for every 30ms awake).
- *
- * cpu_throttle_set can be called as needed to adjust new_throttle_pct.
- * Once the throttling starts, it will remain in effect until cpu_throttle_stop
- * is called.
- */
-void cpu_throttle_set(int new_throttle_pct);
-
-/**
- * cpu_throttle_stop:
- *
- * Stops the vcpu throttling started by cpu_throttle_set.
- */
-void cpu_throttle_stop(void);
-
-/**
- * cpu_throttle_active:
- *
- * Returns: %true if the vcpus are currently being throttled, %false otherwise.
- */
-bool cpu_throttle_active(void);
-
-/**
- * cpu_throttle_get_percentage:
- *
- * Returns the vcpu throttle percentage. See cpu_throttle_set for details.
- *
- * Returns: The throttle percentage in range 1 to 99.
- */
-int cpu_throttle_get_percentage(void);
-
 #ifndef CONFIG_USER_ONLY
 
 typedef void (*CPUInterruptHandler)(CPUState *, int);
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index a6d20b0719..8e98613656 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -303,6 +303,11 @@ void qemu_mutex_unlock_iothread(void);
  */
 void qemu_cond_wait_iothread(QemuCond *cond);
 
+/*
+ * qemu_cond_timedwait_iothread: like the previous, but with timeout
+ */
+void qemu_cond_timedwait_iothread(QemuCond *cond, int ms);
+
 /* internal interfaces */
 
 void qemu_fd_register(int fd);
diff --git a/include/sysemu/cpu-throttle.h b/include/sysemu/cpu-throttle.h
new file mode 100644
index 0000000000..d65bdef6d0
--- /dev/null
+++ b/include/sysemu/cpu-throttle.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright (c) 2012 SUSE LINUX Products GmbH
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see
+ * <http://www.gnu.org/licenses/gpl-2.0.html>
+ */
+
+#ifndef SYSEMU_CPU_THROTTLE_H
+#define SYSEMU_CPU_THROTTLE_H
+
+#include "qemu/timer.h"
+
+/**
+ * cpu_throttle_init:
+ *
+ * Initialize the CPU throttling API.
+ */
+void cpu_throttle_init(void);
+
+/**
+ * cpu_throttle_set:
+ * @new_throttle_pct: Percent of sleep time. Valid range is 1 to 99.
+ *
+ * Throttles all vcpus by forcing them to sleep for the given percentage of
+ * time. A throttle_percentage of 25 corresponds to a 75% duty cycle roughly.
+ * (example: 10ms sleep for every 30ms awake).
+ *
+ * cpu_throttle_set can be called as needed to adjust new_throttle_pct.
+ * Once the throttling starts, it will remain in effect until cpu_throttle_stop
+ * is called.
+ */
+void cpu_throttle_set(int new_throttle_pct);
+
+/**
+ * cpu_throttle_stop:
+ *
+ * Stops the vcpu throttling started by cpu_throttle_set.
+ */
+void cpu_throttle_stop(void);
+
+/**
+ * cpu_throttle_active:
+ *
+ * Returns: %true if the vcpus are currently being throttled, %false otherwise.
+ */
+bool cpu_throttle_active(void);
+
+/**
+ * cpu_throttle_get_percentage:
+ *
+ * Returns the vcpu throttle percentage. See cpu_throttle_set for details.
+ *
+ * Returns: The throttle percentage in range 1 to 99.
+ */
+int cpu_throttle_get_percentage(void);
+
+#endif /* SYSEMU_CPU_THROTTLE_H */
diff --git a/migration/migration.c b/migration/migration.c
index 92e44e021e..4e658c397e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -23,6 +23,7 @@
 #include "socket.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/cpu-throttle.h"
 #include "rdma.h"
 #include "ram.h"
 #include "migration/global_state.h"
diff --git a/migration/ram.c b/migration/ram.c
index 5554a7d2d8..76d4fee5d5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -52,6 +52,7 @@
 #include "migration/colo.h"
 #include "block.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/cpu-throttle.h"
 #include "savevm.h"
 #include "qemu/iov.h"
 #include "multifd.h"
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
index a4bd9f2f52..a414a74c50 100644
--- a/softmmu/Makefile.objs
+++ b/softmmu/Makefile.objs
@@ -2,6 +2,7 @@ softmmu-main-y = softmmu/main.o
 
 obj-y += arch_init.o
 obj-y += cpus.o
+obj-y += cpu-throttle.o
 obj-y += balloon.o
 obj-y += ioport.o
 obj-y += memory.o
diff --git a/softmmu/cpu-throttle.c b/softmmu/cpu-throttle.c
new file mode 100644
index 0000000000..4e6b2818ca
--- /dev/null
+++ b/softmmu/cpu-throttle.c
@@ -0,0 +1,122 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/thread.h"
+#include "hw/core/cpu.h"
+#include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
+#include "sysemu/cpu-throttle.h"
+
+/* vcpu throttling controls */
+static QEMUTimer *throttle_timer;
+static unsigned int throttle_percentage;
+
+#define CPU_THROTTLE_PCT_MIN 1
+#define CPU_THROTTLE_PCT_MAX 99
+#define CPU_THROTTLE_TIMESLICE_NS 10000000
+
+static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
+{
+    double pct;
+    double throttle_ratio;
+    int64_t sleeptime_ns, endtime_ns;
+
+    if (!cpu_throttle_get_percentage()) {
+        return;
+    }
+
+    pct = (double)cpu_throttle_get_percentage() / 100;
+    throttle_ratio = pct / (1 - pct);
+    /* Add 1ns to fix double's rounding error (like 0.9999999...) */
+    sleeptime_ns = (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS + 1);
+    endtime_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + sleeptime_ns;
+    while (sleeptime_ns > 0 && !cpu->stop) {
+        if (sleeptime_ns > SCALE_MS) {
+            qemu_cond_timedwait_iothread(cpu->halt_cond,
+                                         sleeptime_ns / SCALE_MS);
+        } else {
+            qemu_mutex_unlock_iothread();
+            g_usleep(sleeptime_ns / SCALE_US);
+            qemu_mutex_lock_iothread();
+        }
+        sleeptime_ns = endtime_ns - qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    }
+    atomic_set(&cpu->throttle_thread_scheduled, 0);
+}
+
+static void cpu_throttle_timer_tick(void *opaque)
+{
+    CPUState *cpu;
+    double pct;
+
+    /* Stop the timer if needed */
+    if (!cpu_throttle_get_percentage()) {
+        return;
+    }
+    CPU_FOREACH(cpu) {
+        if (!atomic_xchg(&cpu->throttle_thread_scheduled, 1)) {
+            async_run_on_cpu(cpu, cpu_throttle_thread,
+                             RUN_ON_CPU_NULL);
+        }
+    }
+
+    pct = (double)cpu_throttle_get_percentage() / 100;
+    timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
+                                   CPU_THROTTLE_TIMESLICE_NS / (1 - pct));
+}
+
+void cpu_throttle_set(int new_throttle_pct)
+{
+    /* Ensure throttle percentage is within valid range */
+    new_throttle_pct = MIN(new_throttle_pct, CPU_THROTTLE_PCT_MAX);
+    new_throttle_pct = MAX(new_throttle_pct, CPU_THROTTLE_PCT_MIN);
+
+    atomic_set(&throttle_percentage, new_throttle_pct);
+
+    timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
+                                       CPU_THROTTLE_TIMESLICE_NS);
+}
+
+void cpu_throttle_stop(void)
+{
+    atomic_set(&throttle_percentage, 0);
+}
+
+bool cpu_throttle_active(void)
+{
+    return (cpu_throttle_get_percentage() != 0);
+}
+
+int cpu_throttle_get_percentage(void)
+{
+    return atomic_read(&throttle_percentage);
+}
+
+void cpu_throttle_init(void)
+{
+    throttle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
+                                  cpu_throttle_timer_tick, NULL);
+}
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index d94456ed29..a802e899ab 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -61,6 +61,8 @@
 #include "hw/boards.h"
 #include "hw/hw.h"
 
+#include "sysemu/cpu-throttle.h"
+
 #ifdef CONFIG_LINUX
 
 #include <sys/prctl.h>
@@ -84,14 +86,6 @@ static QemuMutex qemu_global_mutex;
 int64_t max_delay;
 int64_t max_advance;
 
-/* vcpu throttling controls */
-static QEMUTimer *throttle_timer;
-static unsigned int throttle_percentage;
-
-#define CPU_THROTTLE_PCT_MIN 1
-#define CPU_THROTTLE_PCT_MAX 99
-#define CPU_THROTTLE_TIMESLICE_NS 10000000
-
 bool cpu_is_stopped(CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
@@ -738,90 +732,12 @@ static const VMStateDescription vmstate_timers = {
     }
 };
 
-static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
-{
-    double pct;
-    double throttle_ratio;
-    int64_t sleeptime_ns, endtime_ns;
-
-    if (!cpu_throttle_get_percentage()) {
-        return;
-    }
-
-    pct = (double)cpu_throttle_get_percentage()/100;
-    throttle_ratio = pct / (1 - pct);
-    /* Add 1ns to fix double's rounding error (like 0.9999999...) */
-    sleeptime_ns = (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS + 1);
-    endtime_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + sleeptime_ns;
-    while (sleeptime_ns > 0 && !cpu->stop) {
-        if (sleeptime_ns > SCALE_MS) {
-            qemu_cond_timedwait(cpu->halt_cond, &qemu_global_mutex,
-                                sleeptime_ns / SCALE_MS);
-        } else {
-            qemu_mutex_unlock_iothread();
-            g_usleep(sleeptime_ns / SCALE_US);
-            qemu_mutex_lock_iothread();
-        }
-        sleeptime_ns = endtime_ns - qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    }
-    atomic_set(&cpu->throttle_thread_scheduled, 0);
-}
-
-static void cpu_throttle_timer_tick(void *opaque)
-{
-    CPUState *cpu;
-    double pct;
-
-    /* Stop the timer if needed */
-    if (!cpu_throttle_get_percentage()) {
-        return;
-    }
-    CPU_FOREACH(cpu) {
-        if (!atomic_xchg(&cpu->throttle_thread_scheduled, 1)) {
-            async_run_on_cpu(cpu, cpu_throttle_thread,
-                             RUN_ON_CPU_NULL);
-        }
-    }
-
-    pct = (double)cpu_throttle_get_percentage()/100;
-    timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
-                                   CPU_THROTTLE_TIMESLICE_NS / (1-pct));
-}
-
-void cpu_throttle_set(int new_throttle_pct)
-{
-    /* Ensure throttle percentage is within valid range */
-    new_throttle_pct = MIN(new_throttle_pct, CPU_THROTTLE_PCT_MAX);
-    new_throttle_pct = MAX(new_throttle_pct, CPU_THROTTLE_PCT_MIN);
-
-    atomic_set(&throttle_percentage, new_throttle_pct);
-
-    timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
-                                       CPU_THROTTLE_TIMESLICE_NS);
-}
-
-void cpu_throttle_stop(void)
-{
-    atomic_set(&throttle_percentage, 0);
-}
-
-bool cpu_throttle_active(void)
-{
-    return (cpu_throttle_get_percentage() != 0);
-}
-
-int cpu_throttle_get_percentage(void)
-{
-    return atomic_read(&throttle_percentage);
-}
-
 void cpu_ticks_init(void)
 {
     seqlock_init(&timers_state.vm_clock_seqlock);
     qemu_spin_init(&timers_state.vm_clock_lock);
     vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
-    throttle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
-                                           cpu_throttle_timer_tick, NULL);
+    cpu_throttle_init();
 }
 
 void configure_icount(QemuOpts *opts, Error **errp)
@@ -1879,6 +1795,11 @@ void qemu_cond_wait_iothread(QemuCond *cond)
     qemu_cond_wait(cond, &qemu_global_mutex);
 }
 
+void qemu_cond_timedwait_iothread(QemuCond *cond, int ms)
+{
+    qemu_cond_timedwait(cond, &qemu_global_mutex, ms);
+}
+
 static bool all_vcpus_paused(void)
 {
     CPUState *cpu;
diff --git a/ui/cocoa.m b/ui/cocoa.m
index cb556e4e66..0910b4a716 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -32,6 +32,7 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
+#include "sysemu/cpu-throttle.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-misc.h"
-- 
2.26.2



