Received: from eggs.gnu.org ([2001:4830:134:3::10]:38511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofs-0000Ew-C6
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofq-0004Xz-TW
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:44 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:39783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofq-0004Vp-Gl
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:42 -0500
Received: by mail-wr1-x433.google.com with SMTP id t27so5675190wra.6
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.39
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:12 +0000
Message-Id: <20181214144214.1260-21-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/22] tests/test-arm-mptimer: Don't leak string
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The test-arm-mptimer setup creates a lot of test names using
g_strdup_printf() and never frees them. This is entirely
harmless since it's one-shot test code, but it clutters
up the output from clang's LeakSanitizer. Refactor to
use a helper function so we can free the memory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181204132952.2601-5-peter.maydell@linaro.org
---
 tests/test-arm-mptimer.c | 153 ++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 84 deletions(-)

diff --git a/tests/test-arm-mptimer.c b/tests/test-arm-mptimer.c
index cb8f2df9141..156a39f50dd 100644
--- a/tests/test-arm-mptimer.c
+++ b/tests/test-arm-mptimer.c
@@ -991,10 +991,25 @@ static void test_timer_zero_load_nonscaled_periodic_to_prescaled_oneshot(void)
     g_assert_cmpuint(timer_get_and_clr_int_sts(), ==, 0);
 }
 
+/*
+ * Add a qtest test that comes in two versions: one with
+ * a timer scaler setting, and one with the timer nonscaled.
+ */
+static void add_scaler_test(const char *str, bool scale,
+                            void (*fn)(const void *))
+{
+    char *name;
+    int *scaler = scale ? &scaled : &nonscaled;
+
+    name = g_strdup_printf("%s=%d", str, *scaler);
+    qtest_add_data_func(name, scaler, fn);
+    g_free(name);
+}
+
 int main(int argc, char **argv)
 {
-    int *scaler = &nonscaled;
     int ret;
+    int scale;
 
     g_test_init(&argc, &argv, NULL);
 
@@ -1012,89 +1027,59 @@ int main(int argc, char **argv)
     qtest_add_func("mptimer/prescaler", test_timer_prescaler);
     qtest_add_func("mptimer/prescaler_on_the_fly", test_timer_prescaler_on_the_fly);
 
-tests_with_prescaler_arg:
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/oneshot scaler=%d", *scaler),
-                        scaler, test_timer_oneshot);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/pause scaler=%d", *scaler),
-                        scaler, test_timer_pause);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/reload scaler=%d", *scaler),
-                        scaler, test_timer_reload);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/periodic scaler=%d", *scaler),
-                        scaler, test_timer_periodic);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/oneshot_to_periodic scaler=%d", *scaler),
-                        scaler, test_timer_oneshot_to_periodic);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/periodic_to_oneshot scaler=%d", *scaler),
-                        scaler, test_timer_periodic_to_oneshot);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/set_oneshot_counter_to_0 scaler=%d", *scaler),
-                        scaler, test_timer_set_oneshot_counter_to_0);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/set_periodic_counter_to_0 scaler=%d", *scaler),
-                        scaler, test_timer_set_periodic_counter_to_0);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/noload_oneshot scaler=%d", *scaler),
-                        scaler, test_timer_noload_oneshot);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/noload_periodic scaler=%d", *scaler),
-                        scaler, test_timer_noload_periodic);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/zero_load_oneshot scaler=%d", *scaler),
-                        scaler, test_timer_zero_load_oneshot);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/zero_load_periodic scaler=%d", *scaler),
-                        scaler, test_timer_zero_load_periodic);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/zero_load_oneshot_to_nonzero scaler=%d", *scaler),
-                        scaler, test_timer_zero_load_oneshot_to_nonzero);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/zero_load_periodic_to_nonzero scaler=%d", *scaler),
-                        scaler, test_timer_zero_load_periodic_to_nonzero);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/nonzero_load_oneshot_to_zero scaler=%d", *scaler),
-                        scaler, test_timer_nonzero_load_oneshot_to_zero);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/nonzero_load_periodic_to_zero scaler=%d", *scaler),
-                        scaler, test_timer_nonzero_load_periodic_to_zero);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/set_periodic_counter_on_the_fly scaler=%d", *scaler),
-                        scaler, test_timer_set_periodic_counter_on_the_fly);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/enable_and_set_counter scaler=%d", *scaler),
-                        scaler, test_timer_enable_and_set_counter);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/set_counter_and_enable scaler=%d", *scaler),
-                        scaler, test_timer_set_counter_and_enable);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/oneshot_with_counter_0_on_start scaler=%d", *scaler),
-                        scaler, test_timer_oneshot_with_counter_0_on_start);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/periodic_with_counter_0_on_start scaler=%d", *scaler),
-                        scaler, test_timer_periodic_with_counter_0_on_start);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/periodic_counter scaler=%d", *scaler),
-                        scaler, test_periodic_counter);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/set_counter_periodic_with_zero_load scaler=%d", *scaler),
-                        scaler, test_timer_set_counter_periodic_with_zero_load);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/set_oneshot_load_to_0 scaler=%d", *scaler),
-                        scaler, test_timer_set_oneshot_load_to_0);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/set_periodic_load_to_0 scaler=%d", *scaler),
-                        scaler, test_timer_set_periodic_load_to_0);
-    qtest_add_data_func(
-        g_strdup_printf("mptimer/zero_load_mode_switch scaler=%d", *scaler),
-                        scaler, test_timer_zero_load_mode_switch);
-
-    if (scaler == &nonscaled) {
-        scaler = &scaled;
-        goto tests_with_prescaler_arg;
+    for (scale = 0; scale < 2; scale++) {
+        add_scaler_test("mptimer/oneshot scaler",
+                        scale, test_timer_oneshot);
+        add_scaler_test("mptimer/pause scaler",
+                        scale, test_timer_pause);
+        add_scaler_test("mptimer/reload scaler",
+                        scale, test_timer_reload);
+        add_scaler_test("mptimer/periodic scaler",
+                        scale, test_timer_periodic);
+        add_scaler_test("mptimer/oneshot_to_periodic scaler",
+                        scale, test_timer_oneshot_to_periodic);
+        add_scaler_test("mptimer/periodic_to_oneshot scaler",
+                        scale, test_timer_periodic_to_oneshot);
+        add_scaler_test("mptimer/set_oneshot_counter_to_0 scaler",
+                        scale, test_timer_set_oneshot_counter_to_0);
+        add_scaler_test("mptimer/set_periodic_counter_to_0 scaler",
+                        scale, test_timer_set_periodic_counter_to_0);
+        add_scaler_test("mptimer/noload_oneshot scaler",
+                        scale, test_timer_noload_oneshot);
+        add_scaler_test("mptimer/noload_periodic scaler",
+                        scale, test_timer_noload_periodic);
+        add_scaler_test("mptimer/zero_load_oneshot scaler",
+                        scale, test_timer_zero_load_oneshot);
+        add_scaler_test("mptimer/zero_load_periodic scaler",
+                        scale, test_timer_zero_load_periodic);
+        add_scaler_test("mptimer/zero_load_oneshot_to_nonzero scaler",
+                        scale, test_timer_zero_load_oneshot_to_nonzero);
+        add_scaler_test("mptimer/zero_load_periodic_to_nonzero scaler",
+                        scale, test_timer_zero_load_periodic_to_nonzero);
+        add_scaler_test("mptimer/nonzero_load_oneshot_to_zero scaler",
+                        scale, test_timer_nonzero_load_oneshot_to_zero);
+        add_scaler_test("mptimer/nonzero_load_periodic_to_zero scaler",
+                        scale, test_timer_nonzero_load_periodic_to_zero);
+        add_scaler_test("mptimer/set_periodic_counter_on_the_fly scaler",
+                        scale, test_timer_set_periodic_counter_on_the_fly);
+        add_scaler_test("mptimer/enable_and_set_counter scaler",
+                        scale, test_timer_enable_and_set_counter);
+        add_scaler_test("mptimer/set_counter_and_enable scaler",
+                        scale, test_timer_set_counter_and_enable);
+        add_scaler_test("mptimer/oneshot_with_counter_0_on_start scaler",
+                        scale, test_timer_oneshot_with_counter_0_on_start);
+        add_scaler_test("mptimer/periodic_with_counter_0_on_start scaler",
+                        scale, test_timer_periodic_with_counter_0_on_start);
+        add_scaler_test("mptimer/periodic_counter scaler",
+                        scale, test_periodic_counter);
+        add_scaler_test("mptimer/set_counter_periodic_with_zero_load scaler",
+                        scale, test_timer_set_counter_periodic_with_zero_load);
+        add_scaler_test("mptimer/set_oneshot_load_to_0 scaler",
+                        scale, test_timer_set_oneshot_load_to_0);
+        add_scaler_test("mptimer/set_periodic_load_to_0 scaler",
+                        scale, test_timer_set_periodic_load_to_0);
+        add_scaler_test("mptimer/zero_load_mode_switch scaler",
+                        scale, test_timer_zero_load_mode_switch);
     }
 
     qtest_start("-machine vexpress-a9");
-- 
2.19.2
