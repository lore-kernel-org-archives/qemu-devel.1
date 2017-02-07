Received: from eggs.gnu.org ([2001:4830:134:3::10]:60531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6CB-0007cG-4s
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6C9-0007qi-MD
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6C9-0007q7-DS
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:33 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8366EC049D59
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:52:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:51:48 +0400
Message-Id: <20170207135211.15870-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/28] tests: fix ptimer leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Spotted by ASAN.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/ptimer.h       |   1 +
 hw/core/ptimer.c          |   8 +++
 tests/ptimer-test-stubs.c |   5 ++
 tests/ptimer-test.c       | 122 ++++++++++++++++++++++++++++------------=
------
 4 files changed, 89 insertions(+), 47 deletions(-)

diff --git a/include/hw/ptimer.h b/include/hw/ptimer.h
index 48cccbdb51..eafc3f0a86 100644
--- a/include/hw/ptimer.h
+++ b/include/hw/ptimer.h
@@ -60,6 +60,7 @@ typedef struct ptimer_state ptimer_state;
 typedef void (*ptimer_cb)(void *opaque);
=20
 ptimer_state *ptimer_init(QEMUBH *bh, uint8_t policy_mask);
+void ptimer_free(ptimer_state *s);
 void ptimer_set_period(ptimer_state *s, int64_t period);
 void ptimer_set_freq(ptimer_state *s, uint32_t freq);
 uint64_t ptimer_get_limit(ptimer_state *s);
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 3af82afe78..59ccb00550 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -12,6 +12,7 @@
 #include "qemu/host-utils.h"
 #include "sysemu/replay.h"
 #include "sysemu/qtest.h"
+#include "block/aio.h"
=20
 #define DELTA_ADJUST     1
 #define DELTA_NO_ADJUST -1
@@ -353,3 +354,10 @@ ptimer_state *ptimer_init(QEMUBH *bh, uint8_t policy=
_mask)
     s->policy_mask =3D policy_mask;
     return s;
 }
+
+void ptimer_free(ptimer_state *s)
+{
+    qemu_bh_delete(s->bh);
+    timer_free(s->timer);
+    g_free(s);
+}
diff --git a/tests/ptimer-test-stubs.c b/tests/ptimer-test-stubs.c
index 21d4ebb0fe..8a1b0a336c 100644
--- a/tests/ptimer-test-stubs.c
+++ b/tests/ptimer-test-stubs.c
@@ -108,6 +108,11 @@ QEMUBH *qemu_bh_new(QEMUBHFunc *cb, void *opaque)
     return bh;
 }
=20
+void qemu_bh_delete(QEMUBH *bh)
+{
+    g_free(bh);
+}
+
 void replay_bh_schedule_event(QEMUBH *bh)
 {
     bh->cb(bh->opaque);
diff --git a/tests/ptimer-test.c b/tests/ptimer-test.c
index b36a476483..5d1a2a8188 100644
--- a/tests/ptimer-test.c
+++ b/tests/ptimer-test.c
@@ -73,6 +73,7 @@ static void check_set_count(gconstpointer arg)
     ptimer_set_count(ptimer, 1000);
     g_assert_cmpuint(ptimer_get_count(ptimer), =3D=3D, 1000);
     g_assert_false(triggered);
+    ptimer_free(ptimer);
 }
=20
 static void check_set_limit(gconstpointer arg)
@@ -92,6 +93,7 @@ static void check_set_limit(gconstpointer arg)
     g_assert_cmpuint(ptimer_get_count(ptimer), =3D=3D, 2000);
     g_assert_cmpuint(ptimer_get_limit(ptimer), =3D=3D, 2000);
     g_assert_false(triggered);
+    ptimer_free(ptimer);
 }
=20
 static void check_oneshot(gconstpointer arg)
@@ -194,6 +196,7 @@ static void check_oneshot(gconstpointer arg)
=20
     g_assert_cmpuint(ptimer_get_count(ptimer), =3D=3D, 0);
     g_assert_false(triggered);
+    ptimer_free(ptimer);
 }
=20
 static void check_periodic(gconstpointer arg)
@@ -360,6 +363,7 @@ static void check_periodic(gconstpointer arg)
     g_assert_cmpuint(ptimer_get_count(ptimer), =3D=3D,
                     (no_round_down ? 8 : 7) + (wrap_policy ? 1 : 0));
     g_assert_false(triggered);
+    ptimer_free(ptimer);
 }
=20
 static void check_on_the_fly_mode_change(gconstpointer arg)
@@ -406,6 +410,7 @@ static void check_on_the_fly_mode_change(gconstpointe=
r arg)
=20
     g_assert_cmpuint(ptimer_get_count(ptimer), =3D=3D, 0);
     g_assert_true(triggered);
+    ptimer_free(ptimer);
 }
=20
 static void check_on_the_fly_period_change(gconstpointer arg)
@@ -438,6 +443,7 @@ static void check_on_the_fly_period_change(gconstpoin=
ter arg)
=20
     g_assert_cmpuint(ptimer_get_count(ptimer), =3D=3D, 0);
     g_assert_true(triggered);
+    ptimer_free(ptimer);
 }
=20
 static void check_on_the_fly_freq_change(gconstpointer arg)
@@ -470,6 +476,7 @@ static void check_on_the_fly_freq_change(gconstpointe=
r arg)
=20
     g_assert_cmpuint(ptimer_get_count(ptimer), =3D=3D, 0);
     g_assert_true(triggered);
+    ptimer_free(ptimer);
 }
=20
 static void check_run_with_period_0(gconstpointer arg)
@@ -487,6 +494,7 @@ static void check_run_with_period_0(gconstpointer arg=
)
=20
     g_assert_cmpuint(ptimer_get_count(ptimer), =3D=3D, 99);
     g_assert_false(triggered);
+    ptimer_free(ptimer);
 }
=20
 static void check_run_with_delta_0(gconstpointer arg)
@@ -591,6 +599,7 @@ static void check_run_with_delta_0(gconstpointer arg)
     g_assert_true(triggered);
=20
     ptimer_stop(ptimer);
+    ptimer_free(ptimer);
 }
=20
 static void check_periodic_with_load_0(gconstpointer arg)
@@ -649,6 +658,7 @@ static void check_periodic_with_load_0(gconstpointer =
arg)
     }
=20
     ptimer_stop(ptimer);
+    ptimer_free(ptimer);
 }
=20
 static void check_oneshot_with_load_0(gconstpointer arg)
@@ -682,14 +692,14 @@ static void check_oneshot_with_load_0(gconstpointer=
 arg)
     } else {
         g_assert_false(triggered);
     }
+
+    ptimer_free(ptimer);
 }
=20
 static void add_ptimer_tests(uint8_t policy)
 {
-    uint8_t *ppolicy =3D g_malloc(1);
-    char *policy_name =3D g_malloc0(256);
-
-    *ppolicy =3D policy;
+    char policy_name[256] =3D "";
+    char *tmp;
=20
     if (policy =3D=3D PTIMER_POLICY_DEFAULT) {
         g_sprintf(policy_name, "default");
@@ -715,49 +725,67 @@ static void add_ptimer_tests(uint8_t policy)
         g_strlcat(policy_name, "no_counter_rounddown,", 256);
     }
=20
-    g_test_add_data_func(
-        g_strdup_printf("/ptimer/set_count policy=3D%s", policy_name),
-        ppolicy, check_set_count);
-
-    g_test_add_data_func(
-        g_strdup_printf("/ptimer/set_limit policy=3D%s", policy_name),
-        ppolicy, check_set_limit);
-
-    g_test_add_data_func(
-        g_strdup_printf("/ptimer/oneshot policy=3D%s", policy_name),
-        ppolicy, check_oneshot);
-
-    g_test_add_data_func(
-        g_strdup_printf("/ptimer/periodic policy=3D%s", policy_name),
-        ppolicy, check_periodic);
-
-    g_test_add_data_func(
-        g_strdup_printf("/ptimer/on_the_fly_mode_change policy=3D%s", po=
licy_name),
-        ppolicy, check_on_the_fly_mode_change);
-
-    g_test_add_data_func(
-        g_strdup_printf("/ptimer/on_the_fly_period_change policy=3D%s", =
policy_name),
-        ppolicy, check_on_the_fly_period_change);
-
-    g_test_add_data_func(
-        g_strdup_printf("/ptimer/on_the_fly_freq_change policy=3D%s", po=
licy_name),
-        ppolicy, check_on_the_fly_freq_change);
-
-    g_test_add_data_func(
-        g_strdup_printf("/ptimer/run_with_period_0 policy=3D%s", policy_=
name),
-        ppolicy, check_run_with_period_0);
-
-    g_test_add_data_func(
-        g_strdup_printf("/ptimer/run_with_delta_0 policy=3D%s", policy_n=
ame),
-        ppolicy, check_run_with_delta_0);
-
-    g_test_add_data_func(
-        g_strdup_printf("/ptimer/periodic_with_load_0 policy=3D%s", poli=
cy_name),
-        ppolicy, check_periodic_with_load_0);
-
-    g_test_add_data_func(
-        g_strdup_printf("/ptimer/oneshot_with_load_0 policy=3D%s", polic=
y_name),
-        ppolicy, check_oneshot_with_load_0);
+    g_test_add_data_func_full(
+        tmp =3D g_strdup_printf("/ptimer/set_count policy=3D%s", policy_=
name),
+        g_memdup(&policy, 1), check_set_count, g_free);
+    g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp =3D g_strdup_printf("/ptimer/set_limit policy=3D%s", policy_=
name),
+        g_memdup(&policy, 1), check_set_limit, g_free);
+    g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp =3D g_strdup_printf("/ptimer/oneshot policy=3D%s", policy_na=
me),
+        g_memdup(&policy, 1), check_oneshot, g_free);
+    g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp =3D g_strdup_printf("/ptimer/periodic policy=3D%s", policy_n=
ame),
+        g_memdup(&policy, 1), check_periodic, g_free);
+    g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp =3D g_strdup_printf("/ptimer/on_the_fly_mode_change policy=3D=
%s",
+                              policy_name),
+        g_memdup(&policy, 1), check_on_the_fly_mode_change, g_free);
+    g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp =3D g_strdup_printf("/ptimer/on_the_fly_period_change policy=
=3D%s",
+                              policy_name),
+        g_memdup(&policy, 1), check_on_the_fly_period_change, g_free);
+    g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp =3D g_strdup_printf("/ptimer/on_the_fly_freq_change policy=3D=
%s",
+                              policy_name),
+        g_memdup(&policy, 1), check_on_the_fly_freq_change, g_free);
+    g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp =3D g_strdup_printf("/ptimer/run_with_period_0 policy=3D%s",
+                              policy_name),
+        g_memdup(&policy, 1), check_run_with_period_0, g_free);
+    g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp =3D g_strdup_printf("/ptimer/run_with_delta_0 policy=3D%s",
+                              policy_name),
+        g_memdup(&policy, 1), check_run_with_delta_0, g_free);
+    g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp =3D g_strdup_printf("/ptimer/periodic_with_load_0 policy=3D%=
s",
+                              policy_name),
+        g_memdup(&policy, 1), check_periodic_with_load_0, g_free);
+    g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp =3D g_strdup_printf("/ptimer/oneshot_with_load_0 policy=3D%s=
",
+                              policy_name),
+        g_memdup(&policy, 1), check_oneshot_with_load_0, g_free);
+    g_free(tmp);
 }
=20
 static void add_all_ptimer_policies_comb_tests(void)
--=20
2.11.0.295.gd7dffce1c.dirty
