Received: from eggs.gnu.org ([2001:4830:134:3::10]:41978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks90-0003JV-H7
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dks8w-0003Tk-F7
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:25:58 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 24 Aug 2017 16:24:49 +0300
Message-Id: <a57dd6274e1b6dc9c28769fec4c7ea543be5c5e3.1503580370.git.berto@igalia.com>
In-Reply-To: <cover.1503580370.git.berto@igalia.com>
References: <cover.1503580370.git.berto@igalia.com>
In-Reply-To: <cover.1503580370.git.berto@igalia.com>
References: <cover.1503580370.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 7/7] throttle: Test the valid range of
 config values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/test-throttle.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 41c0dd2529..bf7a5a648a 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -378,6 +378,82 @@ static void test_is_valid(void)
     test_is_valid_for_value(1, true);
 }
 
+static void test_ranges(void)
+{
+    int i;
+
+    for (i = 0; i < BUCKETS_COUNT; i++) {
+        LeakyBucket *b = &cfg.buckets[i];
+        throttle_config_init(&cfg);
+
+        /* avg = 0 means throttling is disabled, but the config is valid */
+        b->avg = 0;
+        g_assert(throttle_is_valid(&cfg, NULL));
+        g_assert(!throttle_enabled(&cfg));
+
+        /* These are valid configurations (values <= THROTTLE_VALUE_MAX) */
+        b->avg = 1;
+        g_assert(throttle_is_valid(&cfg, NULL));
+
+        b->avg = THROTTLE_VALUE_MAX;
+        g_assert(throttle_is_valid(&cfg, NULL));
+
+        b->avg = THROTTLE_VALUE_MAX;
+        b->max = THROTTLE_VALUE_MAX;
+        g_assert(throttle_is_valid(&cfg, NULL));
+
+        /* Values over THROTTLE_VALUE_MAX are not allowed */
+        b->avg = THROTTLE_VALUE_MAX + 1;
+        g_assert(!throttle_is_valid(&cfg, NULL));
+
+        b->avg = THROTTLE_VALUE_MAX;
+        b->max = THROTTLE_VALUE_MAX + 1;
+        g_assert(!throttle_is_valid(&cfg, NULL));
+
+        /* burst_length must be between 1 and THROTTLE_VALUE_MAX */
+        b->avg = 1;
+        b->max = 1;
+        b->burst_length = 0;
+        g_assert(!throttle_is_valid(&cfg, NULL));
+
+        b->avg = 1;
+        b->max = 1;
+        b->burst_length = 1;
+        g_assert(throttle_is_valid(&cfg, NULL));
+
+        b->avg = 1;
+        b->max = 1;
+        b->burst_length = THROTTLE_VALUE_MAX;
+        g_assert(throttle_is_valid(&cfg, NULL));
+
+        b->avg = 1;
+        b->max = 1;
+        b->burst_length = THROTTLE_VALUE_MAX + 1;
+        g_assert(!throttle_is_valid(&cfg, NULL));
+
+        /* burst_length * max cannot exceed THROTTLE_VALUE_MAX */
+        b->avg = 1;
+        b->max = 2;
+        b->burst_length = THROTTLE_VALUE_MAX / 2;
+        g_assert(throttle_is_valid(&cfg, NULL));
+
+        b->avg = 1;
+        b->max = 3;
+        b->burst_length = THROTTLE_VALUE_MAX / 2;
+        g_assert(!throttle_is_valid(&cfg, NULL));
+
+        b->avg = 1;
+        b->max = THROTTLE_VALUE_MAX;
+        b->burst_length = 1;
+        g_assert(throttle_is_valid(&cfg, NULL));
+
+        b->avg = 1;
+        b->max = THROTTLE_VALUE_MAX;
+        b->burst_length = 2;
+        g_assert(!throttle_is_valid(&cfg, NULL));
+    }
+}
+
 static void test_max_is_missing_limit(void)
 {
     int i;
@@ -669,6 +745,7 @@ int main(int argc, char **argv)
     g_test_add_func("/throttle/config/enabled",     test_enabled);
     g_test_add_func("/throttle/config/conflicting", test_conflicting_config);
     g_test_add_func("/throttle/config/is_valid",    test_is_valid);
+    g_test_add_func("/throttle/config/ranges",      test_ranges);
     g_test_add_func("/throttle/config/max",         test_max_is_missing_limit);
     g_test_add_func("/throttle/config/iops_size",
                     test_iops_size_is_missing_limit);
-- 
2.11.0
