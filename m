Received: from eggs.gnu.org ([209.51.188.92]:35473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kF-0006K0-UD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kF-0005PK-3Q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:43 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:43460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3kE-0005O9-Qu
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:42 -0500
Received: by mail-wr1-x42f.google.com with SMTP id r10so23213786wrs.10
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:01:42 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:28 +0000
Message-Id: <20190114150129.1013-21-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/21] tests: use g_usleep instead of rem =
 sleep(time)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Relying on sleep to always return having slept isn't safe as a signal
may have occurred. If signals are constantly incoming the program will
never reach its termination condition. This is believed to be the
mechanism causing time outs for qht-test in Travis.

The glib g_usleep() deals with all of this for us so lets use it instead.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

diff --git a/tests/atomic64-bench.c b/tests/atomic64-bench.c
index 71692560ed..121a8c14f4 100644
--- a/tests/atomic64-bench.c
+++ b/tests/atomic64-bench.c
@@ -74,16 +74,14 @@ static void *thread_func(void *arg)
 
 static void run_test(void)
 {
-    unsigned int remaining;
     unsigned int i;
 
     while (atomic_read(&n_ready_threads) != n_threads) {
         cpu_relax();
     }
+
     atomic_set(&test_start, true);
-    do {
-        remaining = sleep(duration);
-    } while (remaining);
+    g_usleep(duration * G_USEC_PER_SEC);
     atomic_set(&test_stop, true);
 
     for (i = 0; i < n_threads; i++) {
diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
index 2f6c72f63a..5666f6bbff 100644
--- a/tests/atomic_add-bench.c
+++ b/tests/atomic_add-bench.c
@@ -76,16 +76,14 @@ static void *thread_func(void *arg)
 
 static void run_test(void)
 {
-    unsigned int remaining;
     unsigned int i;
 
     while (atomic_read(&n_ready_threads) != n_threads) {
         cpu_relax();
     }
+
     atomic_set(&test_start, true);
-    do {
-        remaining = sleep(duration);
-    } while (remaining);
+    g_usleep(duration * G_USEC_PER_SEC);
     atomic_set(&test_stop, true);
 
     for (i = 0; i < n_threads; i++) {
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index ab4e708180..e3b512f26f 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -398,16 +398,14 @@ static void pr_stats(void)
 
 static void run_test(void)
 {
-    unsigned int remaining;
     int i;
 
     while (atomic_read(&n_ready_threads) != n_rw_threads + n_rz_threads) {
         cpu_relax();
     }
+
     atomic_set(&test_start, true);
-    do {
-        remaining = sleep(duration);
-    } while (remaining);
+    g_usleep(duration * G_USEC_PER_SEC);
     atomic_set(&test_stop, true);
 
     for (i = 0; i < n_rw_threads; i++) {
-- 
2.17.1
