Received: from eggs.gnu.org ([2001:4830:134:3::10]:49842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cj2mD-0003xw-1I
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 06:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cj2mC-0007BG-13
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 06:50:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  1 Mar 2017 11:50:25 +0000
Message-Id: <20170301115026.22621-3-stefanha@redhat.com>
In-Reply-To: <20170301115026.22621-1-stefanha@redhat.com>
References: <20170301115026.22621-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/3] throttle: do not use invalid config in
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nini Gu <ngu@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

The (burst) max parameter cannot be smaller than the avg parameter.
There is a test case that uses avg = 56, max = 1 and gets away with it
because no input validation is performed by the test case.

This patch switches to valid test input parameters.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/test-throttle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 363b59a..8531809 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -205,8 +205,8 @@ static void test_config_functions(void)
     orig_cfg.buckets[THROTTLE_OPS_READ].avg  = 69;
     orig_cfg.buckets[THROTTLE_OPS_WRITE].avg = 23;
 
-    orig_cfg.buckets[THROTTLE_BPS_TOTAL].max = 0; /* should be corrected */
-    orig_cfg.buckets[THROTTLE_BPS_READ].max  = 1; /* should not be corrected */
+    orig_cfg.buckets[THROTTLE_BPS_TOTAL].max = 0;  /* should be corrected */
+    orig_cfg.buckets[THROTTLE_BPS_READ].max  = 56; /* should not be corrected */
     orig_cfg.buckets[THROTTLE_BPS_WRITE].max = 120;
 
     orig_cfg.buckets[THROTTLE_OPS_TOTAL].max = 150;
@@ -246,8 +246,8 @@ static void test_config_functions(void)
     g_assert(final_cfg.buckets[THROTTLE_OPS_READ].avg  == 69);
     g_assert(final_cfg.buckets[THROTTLE_OPS_WRITE].avg == 23);
 
-    g_assert(final_cfg.buckets[THROTTLE_BPS_TOTAL].max == 15.3);/* fixed */
-    g_assert(final_cfg.buckets[THROTTLE_BPS_READ].max  == 1);   /* not fixed */
+    g_assert(final_cfg.buckets[THROTTLE_BPS_TOTAL].max == 15.3); /* fixed */
+    g_assert(final_cfg.buckets[THROTTLE_BPS_READ].max  == 56);   /* not fixed */
     g_assert(final_cfg.buckets[THROTTLE_BPS_WRITE].max == 120);
 
     g_assert(final_cfg.buckets[THROTTLE_OPS_TOTAL].max == 150);
-- 
2.9.3
