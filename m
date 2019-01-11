Received: from eggs.gnu.org ([209.51.188.92]:53544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghxx8-0005cJ-Bb
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghxx6-0005RF-Ch
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:38:30 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ghxx2-0005NX-N2
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:38:26 -0500
Received: by mail-wm1-x341.google.com with SMTP id f188so2582438wmf.5
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 06:38:24 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 11 Jan 2019 14:38:15 +0000
Message-Id: <20190111143815.26107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] tests: replace rem = sleep(time) with
 g_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, ehabkost@redhat.com, pbonzini@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Relying on sleep to always return having slept isn't safe as a signal
may have occurred. If signals are constantly incoming the program will
never reach it's termination condition. This is believed to be the
mechanism causing time outs for qht-test in Travis.

Instead we use a g_timer to determine if the duration of the test has
passed and sleep for a second at a time. This may bias benchmark
results for short runs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/atomic64-bench.c   | 11 ++++++++---
 tests/atomic_add-bench.c | 11 ++++++++---
 tests/qht-bench.c        | 11 ++++++++---
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/tests/atomic64-bench.c b/tests/atomic64-bench.c
index 71692560ed..f087ca5bc2 100644
--- a/tests/atomic64-bench.c
+++ b/tests/atomic64-bench.c
@@ -74,18 +74,23 @@ static void *thread_func(void *arg)
 
 static void run_test(void)
 {
-    unsigned int remaining;
+    GTimer *timer;
     unsigned int i;
 
     while (atomic_read(&n_ready_threads) != n_threads) {
         cpu_relax();
     }
+
+    timer = g_timer_new();
+
     atomic_set(&test_start, true);
     do {
-        remaining = sleep(duration);
-    } while (remaining);
+        sleep(1);
+    } while (g_timer_elapsed(timer, NULL) < duration);
     atomic_set(&test_stop, true);
 
+    g_timer_destroy(timer);
+
     for (i = 0; i < n_threads; i++) {
         qemu_thread_join(&threads[i]);
     }
diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
index 2f6c72f63a..5fdf901a71 100644
--- a/tests/atomic_add-bench.c
+++ b/tests/atomic_add-bench.c
@@ -76,18 +76,23 @@ static void *thread_func(void *arg)
 
 static void run_test(void)
 {
-    unsigned int remaining;
+    GTimer *timer;
     unsigned int i;
 
     while (atomic_read(&n_ready_threads) != n_threads) {
         cpu_relax();
     }
+
+    timer = g_timer_new();
+
     atomic_set(&test_start, true);
     do {
-        remaining = sleep(duration);
-    } while (remaining);
+        sleep(1);
+    } while (g_timer_elapsed(timer, NULL) < duration);
     atomic_set(&test_stop, true);
 
+    g_timer_destroy(timer);
+
     for (i = 0; i < n_threads; i++) {
         qemu_thread_join(&threads[i]);
     }
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index ab4e708180..7473fcb60a 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -398,18 +398,23 @@ static void pr_stats(void)
 
 static void run_test(void)
 {
-    unsigned int remaining;
+    GTimer *timer;
     int i;
 
     while (atomic_read(&n_ready_threads) != n_rw_threads + n_rz_threads) {
         cpu_relax();
     }
+
+    timer = g_timer_new();
+
     atomic_set(&test_start, true);
     do {
-        remaining = sleep(duration);
-    } while (remaining);
+        sleep(1);
+    } while (g_timer_elapsed(timer, NULL) < duration);
     atomic_set(&test_stop, true);
 
+    g_timer_destroy(timer);
+
     for (i = 0; i < n_rw_threads; i++) {
         qemu_thread_join(&rw_threads[i]);
     }
-- 
2.17.1
