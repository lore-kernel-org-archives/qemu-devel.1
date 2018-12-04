Received: from eggs.gnu.org ([2001:4830:134:3::10]:58129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gUAmA-0007lr-NI
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gUAm6-00012S-Ux
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:30:10 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  4 Dec 2018 13:29:51 +0000
Message-Id: <20181204132952.2601-5-peter.maydell@linaro.org>
In-Reply-To: <20181204132952.2601-1-peter.maydell@linaro.org>
References: <20181204132952.2601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/5] tests/test-arm-mptimer: Don't leak string
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The test-arm-mptimer setup creates a lot of test names using
g_strdup_printf() and never frees them. This is entirely
harmless since it's one-shot test code, but it clutters
up the output from clang's LeakSanitizer. Refactor to
use a helper function so we can free the memory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
