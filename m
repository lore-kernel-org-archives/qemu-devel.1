Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875A4C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3924A20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPPuOlNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3924A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYMt-0002mg-Bh
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK1-00067G-9d
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJz-0001OA-Cn
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:45 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:41667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYJz-0001Nu-7U
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:43 -0400
Received: by mail-qk1-x741.google.com with SMTP id q188so8161427qke.8
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8FJa6mBDpBCOXmQOSkwzK/quZgmaJvgZHIzCu9P5HcU=;
 b=KPPuOlNE3Uewn3fqFlxZdm6R32Cqn+Mw0p30jIoDMJw/785y4rK2LtHKy8t/KW/5b/
 KvwIeQtcxSCztbEl8xxeCW8jo77MfwZXuR6vdkMyAQFq5RdG9cOHiYAPtNyz45bAg/7Q
 z3kmgelomvziGYFD5LUWnTH7DkRix7zZ0LvHa9/7ewGG0hLsey+US3dkiJgbxM2S775D
 tyhoYIpWUmt43PjryNxSXF9PkSaRyj1hfzLlSL3m3nLyw3YE9RdWZTE+QJIx713L5eII
 QIkZL2NK2HiTThUrG5QOx0L7MlTVdL8fQS7QNKvKJibnxFXsJnRlhmSina0jpomYCgGk
 Pnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8FJa6mBDpBCOXmQOSkwzK/quZgmaJvgZHIzCu9P5HcU=;
 b=mIyUcMxXBXJQ8unVjynArVeUiw/ycjyfmg5Hfo9QSCTkh2wj/sVWGUHPj3tiGfB8ng
 EdYUqW/uWcZa64dw3oFEhWq6fFVPe5BuCPtAN+HXO/1xRDOO7jeJwUeX5D48tbFjH6AY
 Ajdy2NOKmEVYwRsLOe+QW3FX1MpRcQKCqbQDdTLi+Jz1VJPTZoQG+t8ewnLv4RYikLdQ
 qyuVngKD5tkwooLNFz5QzAIbMG+qHRgcjd3IwQcVW49jzb3939tzWpOgXAq/q6kSqF4k
 SrMSashJ1Cf2XABPzOFA1cUwqH8ygN56V3Y95FV4b0xaMFC7Nx1cX6YefGaz3vp0V3bp
 qYow==
X-Gm-Message-State: ANhLgQ16NhH4pgMVwFau1B6n+JY2QCJQPWjSUfKNfpN3sZjd8PxV2lo2
 iXQ4wDUR3yzJPgdYqkhEOJeq2DFiDbsUiQ==
X-Google-Smtp-Source: ADFU+vsw+zfTVCP7Nxs/t+uj+4xAKqnIBzfmGjqaeH5VNSFf/R+fgYtNMvk4qPwz+ppBt5PWhW5u7Q==
X-Received: by 2002:a37:410:: with SMTP id 16mr9847528qke.485.1585251461830;
 Thu, 26 Mar 2020 12:37:41 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:41 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 07/74] cpu: make per-CPU locks an alias of the BQL in TCG
 rr mode
Date: Thu, 26 Mar 2020 15:30:49 -0400
Message-Id: <20200326193156.4322-8-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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

Before we can switch from the BQL to per-CPU locks in
the CPU loop, we have to accommodate the fact that TCG
rr mode (i.e. !MTTCG) cannot work with separate per-vCPU
locks. That would lead to deadlock since we need a single
lock/condvar pair on which to wait for events that affect
any vCPU, e.g. in qemu_tcg_rr_wait_io_event.

At the same time, we are moving towards an interface where
the BQL and CPU locks are independent, and the only requirement
is that the locking order is respected, i.e. the BQL is
acquired first if both locks have to be held at the same time.

In this patch we make the BQL a recursive lock under the hood.
This allows us to (1) keep the BQL and CPU locks interfaces
separate, and (2) use a single lock for all vCPUs in TCG rr mode.

Note that the BQL's API (qemu_mutex_lock/unlock_iothread) remains
non-recursive.

Added cpu_mutex_destroy, and call from cpu_common_finalize,
to avoid destroying qemu_global_mutex, when cpu mutex is destroyed.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[RF: Fixed destroy issue, added cpu_mutex_destroy.]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c         |   2 +-
 cpus.c                | 101 ++++++++++++++++++++++++++++++++++++++----
 hw/core/cpu.c         |   5 ++-
 include/hw/core/cpu.h |   8 +++-
 stubs/cpu-lock.c      |  13 ++++--
 5 files changed, 113 insertions(+), 16 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index f4a0f9ba3b..9ca025149e 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -163,7 +163,7 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     while (!atomic_mb_read(&wi.done)) {
         CPUState *self_cpu = current_cpu;
 
-        qemu_cond_wait(&cpu->cond, &cpu->lock);
+        qemu_cond_wait(&cpu->cond, cpu->lock);
         current_cpu = self_cpu;
     }
     cpu_mutex_unlock(cpu);
diff --git a/cpus.c b/cpus.c
index ff8f37cf88..f27fb19b7c 100644
--- a/cpus.c
+++ b/cpus.c
@@ -91,6 +91,12 @@ static unsigned int throttle_percentage;
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
 
+static inline bool qemu_is_tcg_rr(void)
+{
+    /* in `make check-qtest', "use_icount && !tcg_enabled()" might be true */
+    return use_icount || (tcg_enabled() && !qemu_tcg_mttcg_enabled());
+}
+
 /* XXX: is this really the max number of CPUs? */
 #define CPU_LOCK_BITMAP_SIZE 2048
 
@@ -106,25 +112,75 @@ bool no_cpu_mutex_locked(void)
     return bitmap_empty(cpu_lock_bitmap, CPU_LOCK_BITMAP_SIZE);
 }
 
-void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
+static __thread bool iothread_locked;
+/*
+ * In TCG rr mode, we make the BQL a recursive mutex, so that we can use it for
+ * all vCPUs while keeping the interface as if the locks were per-CPU.
+ *
+ * The fact that the BQL is implemented recursively is invisible to BQL users;
+ * the mutex API we export (qemu_mutex_lock_iothread() etc.) is non-recursive.
+ *
+ * Locking order: the BQL is always acquired before CPU locks.
+ */
+static __thread int iothread_lock_count;
+
+static void rr_cpu_mutex_lock(void)
 {
-/* coverity gets confused by the indirect function call */
+    if (iothread_lock_count++ == 0) {
+        /*
+         * Circumvent qemu_mutex_lock_iothread()'s state keeping by
+         * acquiring the BQL directly.
+         */
+        qemu_mutex_lock(&qemu_global_mutex);
+    }
+}
+
+static void rr_cpu_mutex_unlock(void)
+{
+    g_assert(iothread_lock_count > 0);
+    if (--iothread_lock_count == 0) {
+        /*
+         * Circumvent qemu_mutex_unlock_iothread()'s state keeping by
+         * releasing the BQL directly.
+         */
+        qemu_mutex_unlock(&qemu_global_mutex);
+    }
+}
+
+static void do_cpu_mutex_lock(CPUState *cpu, const char *file, int line)
+{
+    /* coverity gets confused by the indirect function call */
 #ifdef __COVERITY__
-    qemu_mutex_lock_impl(&cpu->lock, file, line);
+    qemu_mutex_lock_impl(cpu->lock, file, line);
 #else
     QemuMutexLockFunc f = atomic_read(&qemu_mutex_lock_func);
 
+    f(cpu->lock, file, line);
+#endif
+}
+
+void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
+{
     g_assert(!cpu_mutex_locked(cpu));
     set_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
-    f(&cpu->lock, file, line);
-#endif
+
+    if (qemu_is_tcg_rr()) {
+        rr_cpu_mutex_lock();
+    } else {
+        do_cpu_mutex_lock(cpu, file, line);
+    }
 }
 
 void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
 {
     g_assert(cpu_mutex_locked(cpu));
-    qemu_mutex_unlock_impl(&cpu->lock, file, line);
     clear_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
+
+    if (qemu_is_tcg_rr()) {
+        rr_cpu_mutex_unlock();
+        return;
+    }
+    qemu_mutex_unlock_impl(cpu->lock, file, line);
 }
 
 bool cpu_mutex_locked(const CPUState *cpu)
@@ -132,6 +188,20 @@ bool cpu_mutex_locked(const CPUState *cpu)
     return test_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
 }
 
+void cpu_mutex_destroy(CPUState *cpu)
+{
+    /*
+     * In TCG RR, cpu->lock is the BQL under the hood. In all other modes,
+     * cpu->lock is a standalone per-CPU lock.
+     */
+    if (qemu_is_tcg_rr()) {
+        cpu->lock = NULL;
+    } else {
+        qemu_mutex_destroy(cpu->lock);
+        g_free(cpu->lock);
+    }
+}
+
 bool cpu_is_stopped(CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
@@ -1858,8 +1928,6 @@ bool qemu_in_vcpu_thread(void)
     return current_cpu && qemu_cpu_is_self(current_cpu);
 }
 
-static __thread bool iothread_locked = false;
-
 bool qemu_mutex_iothread_locked(void)
 {
     return iothread_locked;
@@ -1878,6 +1946,8 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line)
 
     g_assert(!qemu_mutex_iothread_locked());
     bql_lock(&qemu_global_mutex, file, line);
+    g_assert(iothread_lock_count == 0);
+    iothread_lock_count++;
     iothread_locked = true;
 }
 
@@ -1885,7 +1955,10 @@ void qemu_mutex_unlock_iothread(void)
 {
     g_assert(qemu_mutex_iothread_locked());
     iothread_locked = false;
-    qemu_mutex_unlock(&qemu_global_mutex);
+    g_assert(iothread_lock_count > 0);
+    if (--iothread_lock_count == 0) {
+        qemu_mutex_unlock(&qemu_global_mutex);
+    }
 }
 
 void qemu_cond_wait_iothread(QemuCond *cond)
@@ -2121,6 +2194,16 @@ void qemu_init_vcpu(CPUState *cpu)
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
+    /*
+     * In TCG RR, cpu->lock is the BQL under the hood. In all other modes,
+     * cpu->lock is a standalone per-CPU lock.
+     */
+    if (qemu_is_tcg_rr()) {
+        qemu_mutex_destroy(cpu->lock);
+        g_free(cpu->lock);
+        cpu->lock = &qemu_global_mutex;
+    }
+
     if (kvm_enabled()) {
         qemu_kvm_start_vcpu(cpu);
     } else if (hax_enabled()) {
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 6594323d77..d67bd58827 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -367,7 +367,8 @@ static void cpu_common_initfn(Object *obj)
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
 
-    qemu_mutex_init(&cpu->lock);
+    cpu->lock = g_new(QemuMutex, 1);
+    qemu_mutex_init(cpu->lock);
     qemu_cond_init(&cpu->cond);
     QSIMPLEQ_INIT(&cpu->work_list);
     QTAILQ_INIT(&cpu->breakpoints);
@@ -380,7 +381,7 @@ static void cpu_common_finalize(Object *obj)
 {
     CPUState *cpu = CPU(obj);
 
-    qemu_mutex_destroy(cpu->lock);
+    cpu_mutex_destroy(cpu);
 }
 
 static int64_t cpu_common_get_arch_id(CPUState *cpu)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 9c6a426c35..3f7727ec70 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -377,7 +377,7 @@ struct CPUState {
     uint64_t random_seed;
     sigjmp_buf jmp_env;
 
-    QemuMutex lock;
+    QemuMutex *lock;
     /* fields below protected by @lock */
     QemuCond cond;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
@@ -485,6 +485,12 @@ void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line);
  */
 bool cpu_mutex_locked(const CPUState *cpu);
 
+/**
+ * cpu_mutex_destroy - Handle how to destroy this CPU's mutex
+ * @cpu: the CPU whose mutex to destroy
+ */
+void cpu_mutex_destroy(CPUState *cpu);
+
 /**
  * no_cpu_mutex_locked - check whether any CPU mutex is held
  *
diff --git a/stubs/cpu-lock.c b/stubs/cpu-lock.c
index ca2ea8a9c2..31fc67c3af 100644
--- a/stubs/cpu-lock.c
+++ b/stubs/cpu-lock.c
@@ -5,16 +5,16 @@ void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
 {
 /* coverity gets confused by the indirect function call */
 #ifdef __COVERITY__
-    qemu_mutex_lock_impl(&cpu->lock, file, line);
+    qemu_mutex_lock_impl(cpu->lock, file, line);
 #else
     QemuMutexLockFunc f = atomic_read(&qemu_mutex_lock_func);
-    f(&cpu->lock, file, line);
+    f(cpu->lock, file, line);
 #endif
 }
 
 void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
 {
-    qemu_mutex_unlock_impl(&cpu->lock, file, line);
+    qemu_mutex_unlock_impl(cpu->lock, file, line);
 }
 
 bool cpu_mutex_locked(const CPUState *cpu)
@@ -26,3 +26,10 @@ bool no_cpu_mutex_locked(void)
 {
     return true;
 }
+
+void cpu_mutex_destroy(CPUState *cpu)
+{
+    qemu_mutex_destroy(cpu->lock);
+    g_free(cpu->lock);
+    cpu->lock = NULL;
+}
-- 
2.17.1


