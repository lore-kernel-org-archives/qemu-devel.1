Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1125DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 01:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BB7206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 01:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4F4T8Cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BB7206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjYpi-0006nk-3a
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 21:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3a97iXgMKCrAZapWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--jkz.bounces.google.com>)
 id 1jjYm4-00016r-GZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 21:46:28 -0400
Received: from mail-qv1-xf49.google.com ([2607:f8b0:4864:20::f49]:42163)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3a97iXgMKCrAZapWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--jkz.bounces.google.com>)
 id 1jjYm2-0001VU-IX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 21:46:28 -0400
Received: by mail-qv1-xf49.google.com with SMTP id w3so5845285qvl.9
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 18:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=E4ik8F3C9Ws3lL4kBNltyKwjw/0cR5DBXCIJAWDvMCQ=;
 b=E4F4T8Cy2xR0y1KX38vZfba81i0X7CyiecxwNKCR4zh3nzXXfJOPYU+LILn2ZbZUl9
 CoXIa7VhRxMG7us19Tor3Uo0NfRN2k3Z9WQxmTwX8YYeVWUWlYIkBK/kfymfu6lMeEM3
 FVtw1Fw+zTOAVEdyFcBQD3G8//0HtX+CgbdcJnyy5DUeT4/F/klNqnugQkyZ5FPxNluq
 JI4N8oF1gzaj4JwzmT5jpTlcq2alhXRmHe9e3ZguBdnfuO0CIZfpZfotU50IKkeQFjaX
 d1ezF/6vl4J0aJhQixCZoVN8yYGqWHRmeHFTx18ZSWWfVWur/fl4MrL7MzBWqCv8elmS
 zV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=E4ik8F3C9Ws3lL4kBNltyKwjw/0cR5DBXCIJAWDvMCQ=;
 b=anvUR0OvuS9fnr6evYEh/S5gGF2RAuQ1aK2Bp8Vqic9SHOQ8oQvEY3Z9DnlBeg+iwN
 N/EAfdKe/3R38eHptiZmg5cRXl/nq7QXnRx4r1jdtMmmel65ulX9BhCv6dqJocNEMxv4
 yTmJ5Rk4VMbGQyBI19fCsHQa0ZuQi58W6fDGT2Gluub7BBRgznFXbqJGA23boKFxA5Oc
 Y3rPGAwkB9v4ix5Hr0tLglvxM7sFj9ppJx0ZPsHJqRdPZe5Rkbi0kDFX/qEWwGNOx/8t
 EygFDSOCRe07FOkREEQjme9fMZohCgNgKxRHkKmgOB2ZanZqAaRhjou2Rh4wvf7ZVjpo
 4hLw==
X-Gm-Message-State: AOAM530TtSTHLl8N2AKG7stjARcwrZ32XTyKU0SLxBg/YmHaPlTbODsC
 oVuFN8LOQSN++kDuJEkfvirzFaHmlCOtVWytQaGt3Vxja5uxXhJNeinB8I0a8ytcWLAUNw6d1em
 Ls08DEdqzpbOna91in9E3XkKu3lg7hd7RlnLF+XuGfUyhyAijTrMN
X-Google-Smtp-Source: ABdhPJxKQFGXJRYnQx9WtxygmdRTedVUH/CHhykVMpalGOxw5Yw7Z/23BDIgD/FwQoGpQVGc4+womNk=
X-Received: by 2002:a05:6214:11f0:: with SMTP id
 e16mr10306827qvu.37.1591926379175; 
 Thu, 11 Jun 2020 18:46:19 -0700 (PDT)
Date: Thu, 11 Jun 2020 18:46:06 -0700
In-Reply-To: <20200612014606.147691-1-jkz@google.com>
Message-Id: <20200612014606.147691-6-jkz@google.com>
Mime-Version: 1.0
References: <20200612014606.147691-1-jkz@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 5/5] linux-user: Add PDEATHSIG test for clone process
 hierarchy.
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f49;
 envelope-from=3a97iXgMKCrAZapWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--jkz.bounces.google.com;
 helo=mail-qv1-xf49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Certain process-level linux features like subreapers, and PDEATHSIG,
depend on the guest's process hierarchy being emulated correctly on the
host. This change adds a test that makes sure PDEATHSIG works for a
guest process created with `clone`.

Signed-off-by: Josh Kunz <jkz@google.com>
---
 tests/tcg/multiarch/Makefile.target |   3 +
 tests/tcg/multiarch/linux-test.c    | 160 ++++++++++++++++++++++++++--
 2 files changed, 153 insertions(+), 10 deletions(-)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index cb49cc9ccb..d937b4c59b 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -60,3 +60,6 @@ endif
 
 # Update TESTS
 TESTS += $(MULTIARCH_TESTS)
+
+# linux-test.c depends on -pthread.
+LDFLAGS += -pthread
diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index a7723556c2..1824a5a0c2 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -20,16 +20,19 @@
 #include <stdarg.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <string.h>
 #include <sys/types.h>
+#include <syscall.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <errno.h>
 #include <utime.h>
 #include <time.h>
+#include <sys/prctl.h>
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/uio.h>
@@ -41,6 +44,7 @@
 #include <setjmp.h>
 #include <sys/shm.h>
 #include <assert.h>
+#include <pthread.h>
 
 #define STACK_SIZE 16384
 
@@ -368,14 +372,12 @@ static void test_pipe(void)
     chk_error(close(fds[1]));
 }
 
-static int thread1_res;
-static int thread2_res;
-
 static int thread1_func(void *arg)
 {
+    int *res = (int *) arg;
     int i;
     for(i=0;i<5;i++) {
-        thread1_res++;
+        (*res)++;
         usleep(10 * 1000);
     }
     return 0;
@@ -383,9 +385,10 @@ static int thread1_func(void *arg)
 
 static int thread2_func(void *arg)
 {
+    int *res = (int *) arg;
     int i;
     for(i=0;i<6;i++) {
-        thread2_res++;
+        (*res)++;
         usleep(10 * 1000);
     }
     return 0;
@@ -405,25 +408,27 @@ static void test_clone(void)
     uint8_t *stack1, *stack2;
     pid_t pid1, pid2;
 
+    int t1 = 0, t2 = 0;
+
     stack1 = malloc(STACK_SIZE);
     pid1 = chk_error(clone(thread1_func, stack1 + STACK_SIZE,
                            CLONE_VM | SIGCHLD,
-                            "hello1"));
+                            &t1));
 
     stack2 = malloc(STACK_SIZE);
     pid2 = chk_error(clone(thread2_func, stack2 + STACK_SIZE,
                            CLONE_VM | CLONE_FS | CLONE_FILES |
                            CLONE_SIGHAND | CLONE_SYSVSEM | SIGCHLD,
-                           "hello2"));
+                           &t2));
 
     wait_for_child(pid1);
     free(stack1);
     wait_for_child(pid2);
     free(stack2);
 
-    if (thread1_res != 5 ||
-        thread2_res != 6)
+    if (t1 != 5 || t2 != 6) {
         error("clone");
+    }
 }
 
 /***********************************/
@@ -562,6 +567,7 @@ static void test_clone_signal_count(void)
      * SIGCHLD.
      */
     chk_error(waitpid(pid, &status, __WCLONE));
+    free(child_stack);
 
     chk_error(sigaction(SIGRTMIN, &prev, NULL));
 
@@ -571,6 +577,139 @@ static void test_clone_signal_count(void)
     }
 }
 
+struct test_clone_pdeathsig_info {
+    uint8_t *child_stack;
+    pthread_mutex_t notify_test_mutex;
+    pthread_cond_t notify_test_cond;
+    pthread_mutex_t notify_parent_mutex;
+    pthread_cond_t notify_parent_cond;
+    bool signal_received;
+};
+
+static int test_clone_pdeathsig_child(void *arg)
+{
+    struct test_clone_pdeathsig_info *info =
+        (struct test_clone_pdeathsig_info *) arg;
+    sigset_t wait_on, block_all;
+    siginfo_t sinfo;
+    struct timespec timeout;
+    int ret;
+
+    /* Block all signals, so SIGUSR1 will be pending when we wait on it. */
+    sigfillset(&block_all);
+    chk_error(sigprocmask(SIG_BLOCK, &block_all, NULL));
+
+    chk_error(prctl(PR_SET_PDEATHSIG, SIGUSR1));
+
+    pthread_mutex_lock(&info->notify_parent_mutex);
+    pthread_cond_broadcast(&info->notify_parent_cond);
+    pthread_mutex_unlock(&info->notify_parent_mutex);
+
+    sigemptyset(&wait_on);
+    sigaddset(&wait_on, SIGUSR1);
+    timeout.tv_sec = 0;
+    timeout.tv_nsec = 300 * 1000 * 1000;  /* 300ms */
+
+    ret = sigtimedwait(&wait_on, &sinfo, &timeout);
+
+    if (ret < 0 && errno != EAGAIN) {
+        error("%m (ret=%d, errno=%d/%s)", ret, errno, strerror(errno));
+    }
+    if (ret == SIGUSR1) {
+        info->signal_received = true;
+    }
+    pthread_mutex_lock(&info->notify_test_mutex);
+    pthread_cond_broadcast(&info->notify_test_cond);
+    pthread_mutex_unlock(&info->notify_test_mutex);
+    _exit(0);
+}
+
+static int test_clone_pdeathsig_parent(void *arg)
+{
+    struct test_clone_pdeathsig_info *info =
+        (struct test_clone_pdeathsig_info *) arg;
+
+    pthread_mutex_lock(&info->notify_parent_mutex);
+
+    chk_error(clone(
+        test_clone_pdeathsig_child,
+        info->child_stack + STACK_SIZE,
+        CLONE_VM,
+        info
+    ));
+
+    /* No need to reap the child, it will get reaped by init. */
+
+    /* Wait for the child to signal that they have set up PDEATHSIG. */
+    pthread_cond_wait(&info->notify_parent_cond, &info->notify_parent_mutex);
+    pthread_mutex_unlock(&info->notify_parent_mutex);  /* avoid UB on destroy */
+
+    _exit(0);
+}
+
+/*
+ * This checks that cloned children have the correct parent/child
+ * relationship using PDEATHSIG. PDEATHSIG is based on kernel task hierarchy,
+ * rather than "process" hierarchy, so it should be pretty sensitive to
+ * breakages. PDEATHSIG is also a widely used feature, so it's important
+ * it's correct.
+ *
+ * This test works by spawning a child process (parent) which then spawns it's
+ * own child (the child). The child registers a PDEATHSIG handler, and then
+ * notifies the parent which exits. The child then waits for the PDEATHSIG
+ * signal it regsitered. The child reports whether or not the signal is
+ * received within a small time window, and then notifies the test runner
+ * (this function) that the test is finished.
+ */
+static void test_clone_pdeathsig(void)
+{
+    uint8_t *parent_stack;
+    struct test_clone_pdeathsig_info info;
+    pid_t pid;
+    int status;
+
+    memset(&info, 0, sizeof(info));
+
+    /*
+     * Setup condition variables, so we can be notified once the final child
+     * observes the PDEATHSIG signal from it's parent exiting. When the parent
+     * exits, the child will be orphaned, so we can't use `wait*` to wait for
+     * it to finish.
+     */
+    chk_error(pthread_mutex_init(&info.notify_test_mutex, NULL));
+    chk_error(pthread_cond_init(&info.notify_test_cond, NULL));
+    chk_error(pthread_mutex_init(&info.notify_parent_mutex, NULL));
+    chk_error(pthread_cond_init(&info.notify_parent_cond, NULL));
+
+    parent_stack = malloc(STACK_SIZE);
+    info.child_stack = malloc(STACK_SIZE);
+
+    pthread_mutex_lock(&info.notify_test_mutex);
+
+    pid = chk_error(clone(
+        test_clone_pdeathsig_parent,
+        parent_stack + STACK_SIZE,
+        CLONE_VM,
+        &info
+    ));
+
+    pthread_cond_wait(&info.notify_test_cond, &info.notify_test_mutex);
+    pthread_mutex_unlock(&info.notify_test_mutex);
+    chk_error(waitpid(pid, &status, __WCLONE));  /* reap the parent */
+
+    free(parent_stack);
+    free(info.child_stack);
+
+    pthread_cond_destroy(&info.notify_parent_cond);
+    pthread_mutex_destroy(&info.notify_parent_mutex);
+    pthread_cond_destroy(&info.notify_test_cond);
+    pthread_mutex_destroy(&info.notify_test_mutex);
+
+    if (!info.signal_received) {
+        error("child did not receive PDEATHSIG on parent death");
+    }
+}
+
 int main(int argc, char **argv)
 {
     test_file();
@@ -580,8 +719,9 @@ int main(int argc, char **argv)
     test_socket();
     test_clone();
     test_clone_signal_count();
-
+    test_clone_pdeathsig();
     test_signal();
     test_shm();
+
     return 0;
 }
-- 
2.27.0.290.gba653c62da-goog


