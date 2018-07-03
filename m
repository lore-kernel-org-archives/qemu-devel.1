Received: from eggs.gnu.org ([2001:4830:134:3::10]:33510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1faP2k-0008Ax-77
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1faP2i-0005Xz-SA
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:24:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  3 Jul 2018 18:10:41 +0100
Message-Id: <20180703171044.9503-2-peter.maydell@linaro.org>
In-Reply-To: <20180703171044.9503-1-peter.maydell@linaro.org>
References: <20180703171044.9503-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 1/4] ptimer: Add
 TRIGGER_ONLY_ON_DECREMENT policy option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Guenter Roeck <linux@roeck-us.net>

The CMSDK timer behaviour is that an interrupt is triggered when the
counter counts down from 1 to 0; however one is not triggered if the
counter is manually set to 0 by a guest write to the counter register.
Currently ptimer can't handle this; add a policy option to allow
a ptimer user to request this behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ptimer.h |  9 +++++++++
 hw/core/ptimer.c    | 22 +++++++++++++++++++++-
 tests/ptimer-test.c | 25 +++++++++++++++++++------
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/include/hw/ptimer.h b/include/hw/ptimer.h
index fc4ef5cc1d2..0731d9aef19 100644
--- a/include/hw/ptimer.h
+++ b/include/hw/ptimer.h
@@ -69,6 +69,15 @@
  * not the one less.  */
 #define PTIMER_POLICY_NO_COUNTER_ROUND_DOWN (1 << 4)
 
+/*
+ * Starting to run with a zero counter, or setting the counter to "0" via
+ * ptimer_set_count() or ptimer_set_limit() will not trigger the timer
+ * (though it will cause a reload). Only a counter decrement to "0"
+ * will cause a trigger. Not compatible with NO_IMMEDIATE_TRIGGER;
+ * ptimer_init() will assert() that you don't set both.
+ */
+#define PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT (1 << 5)
+
 /* ptimer.c */
 typedef struct ptimer_state ptimer_state;
 typedef void (*ptimer_cb)(void *opaque);
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 7221c68a984..170fd34d8b5 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -45,8 +45,20 @@ static void ptimer_reload(ptimer_state *s, int delta_adjust)
     uint32_t period_frac = s->period_frac;
     uint64_t period = s->period;
     uint64_t delta = s->delta;
+    bool suppress_trigger = false;
 
-    if (delta == 0 && !(s->policy_mask & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER)) {
+    /*
+     * Note that if delta_adjust is 0 then we must be here because of
+     * a count register write or timer start, not because of timer expiry.
+     * In that case the policy might require us to suppress the timer trigger
+     * that we would otherwise generate for a zero delta.
+     */
+    if (delta_adjust == 0 &&
+        (s->policy_mask & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT)) {
+        suppress_trigger = true;
+    }
+    if (delta == 0 && !(s->policy_mask & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER)
+        && !suppress_trigger) {
         ptimer_trigger(s);
     }
 
@@ -353,6 +365,14 @@ ptimer_state *ptimer_init(QEMUBH *bh, uint8_t policy_mask)
     s->bh = bh;
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ptimer_tick, s);
     s->policy_mask = policy_mask;
+
+    /*
+     * These two policies are incompatible -- trigger-on-decrement implies
+     * a timer trigger when the count becomes 0, but no-immediate-trigger
+     * implies a trigger when the count stops being 0.
+     */
+    assert(!((policy_mask & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT) &&
+             (policy_mask & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER)));
     return s;
 }
 
diff --git a/tests/ptimer-test.c b/tests/ptimer-test.c
index 41488896f76..b30aad07372 100644
--- a/tests/ptimer-test.c
+++ b/tests/ptimer-test.c
@@ -208,6 +208,7 @@ static void check_periodic(gconstpointer arg)
     bool no_immediate_trigger = (*policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
     bool no_immediate_reload = (*policy & PTIMER_POLICY_NO_IMMEDIATE_RELOAD);
     bool no_round_down = (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+    bool trig_only_on_dec = (*policy & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT);
 
     triggered = false;
 
@@ -311,7 +312,7 @@ static void check_periodic(gconstpointer arg)
     g_assert_cmpuint(ptimer_get_count(ptimer), ==,
                      no_immediate_reload ? 0 : 10);
 
-    if (no_immediate_trigger) {
+    if (no_immediate_trigger || trig_only_on_dec) {
         g_assert_false(triggered);
     } else {
         g_assert_true(triggered);
@@ -506,6 +507,7 @@ static void check_run_with_delta_0(gconstpointer arg)
     bool no_immediate_trigger = (*policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
     bool no_immediate_reload = (*policy & PTIMER_POLICY_NO_IMMEDIATE_RELOAD);
     bool no_round_down = (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+    bool trig_only_on_dec = (*policy & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT);
 
     triggered = false;
 
@@ -515,7 +517,7 @@ static void check_run_with_delta_0(gconstpointer arg)
     g_assert_cmpuint(ptimer_get_count(ptimer), ==,
                      no_immediate_reload ? 0 : 99);
 
-    if (no_immediate_trigger) {
+    if (no_immediate_trigger || trig_only_on_dec) {
         g_assert_false(triggered);
     } else {
         g_assert_true(triggered);
@@ -563,7 +565,7 @@ static void check_run_with_delta_0(gconstpointer arg)
     g_assert_cmpuint(ptimer_get_count(ptimer), ==,
                      no_immediate_reload ? 0 : 99);
 
-    if (no_immediate_trigger) {
+    if (no_immediate_trigger || trig_only_on_dec) {
         g_assert_false(triggered);
     } else {
         g_assert_true(triggered);
@@ -609,6 +611,7 @@ static void check_periodic_with_load_0(gconstpointer arg)
     ptimer_state *ptimer = ptimer_init(bh, *policy);
     bool continuous_trigger = (*policy & PTIMER_POLICY_CONTINUOUS_TRIGGER);
     bool no_immediate_trigger = (*policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
+    bool trig_only_on_dec = (*policy & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT);
 
     triggered = false;
 
@@ -617,7 +620,7 @@ static void check_periodic_with_load_0(gconstpointer arg)
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 0);
 
-    if (no_immediate_trigger) {
+    if (no_immediate_trigger || trig_only_on_dec) {
         g_assert_false(triggered);
     } else {
         g_assert_true(triggered);
@@ -667,6 +670,7 @@ static void check_oneshot_with_load_0(gconstpointer arg)
     QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
     ptimer_state *ptimer = ptimer_init(bh, *policy);
     bool no_immediate_trigger = (*policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
+    bool trig_only_on_dec = (*policy & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT);
 
     triggered = false;
 
@@ -675,7 +679,7 @@ static void check_oneshot_with_load_0(gconstpointer arg)
 
     g_assert_cmpuint(ptimer_get_count(ptimer), ==, 0);
 
-    if (no_immediate_trigger) {
+    if (no_immediate_trigger || trig_only_on_dec) {
         g_assert_false(triggered);
     } else {
         g_assert_true(triggered);
@@ -725,6 +729,10 @@ static void add_ptimer_tests(uint8_t policy)
         g_strlcat(policy_name, "no_counter_rounddown,", 256);
     }
 
+    if (policy & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT) {
+        g_strlcat(policy_name, "trigger_only_on_decrement,", 256);
+    }
+
     g_test_add_data_func_full(
         tmp = g_strdup_printf("/ptimer/set_count policy=%s", policy_name),
         g_memdup(&policy, 1), check_set_count, g_free);
@@ -790,10 +798,15 @@ static void add_ptimer_tests(uint8_t policy)
 
 static void add_all_ptimer_policies_comb_tests(void)
 {
-    int last_policy = PTIMER_POLICY_NO_COUNTER_ROUND_DOWN;
+    int last_policy = PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT;
     int policy = PTIMER_POLICY_DEFAULT;
 
     for (; policy < (last_policy << 1); policy++) {
+        if ((policy & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT) &&
+            (policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER)) {
+            /* Incompatible policy flag settings -- don't try to test them */
+            continue;
+        }
         add_ptimer_tests(policy);
     }
 }
-- 
2.17.1
