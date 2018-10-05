Received: from eggs.gnu.org ([2001:4830:134:3::10]:56692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM6-0006XV-TG
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SLz-00065Z-Gn
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:29 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SLv-0005ze-MZ
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id 189-v6so2313543wmw.2
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:48:50 +0100
Message-Id: <20181005154910.3099-2-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH  01/21] util/log: allow -dfilter to stack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The original dfilter was patched to avoid a leak in the case of
multiple -dfilter ranges. There is no reason not to allow the user to
stack several dfilter options rather than push them all into one mega
line. We avoid the leak by simply only allocating the first time
around. As we are using a g_array it will automatically re-size as
needed.

The allocation is pushed to a helper as future patches will offer
additional ways to add to the dfilter.

We also add a helper qemu_reset_dfilter_ranges() so we can be explicit
in our unit tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/log.h   |  1 +
 tests/test-logging.c | 14 ++++++++++++++
 util/log.c           | 23 +++++++++++++++++------
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index b097a6cae1..8ed932ec24 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -116,6 +116,7 @@ void qemu_set_log(int log_flags);
 void qemu_log_needs_buffers(void);
 void qemu_set_log_filename(const char *filename, Error **errp);
 void qemu_set_dfilter_ranges(const char *ranges, Error **errp);
+void qemu_reset_dfilter_ranges(void);
 bool qemu_log_in_addr_range(uint64_t addr);
 int qemu_str_to_log_mask(const char *str);
 
diff --git a/tests/test-logging.c b/tests/test-logging.c
index a12585f70a..fbddd70ebc 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -43,6 +43,8 @@ static void test_parse_range(void)
     g_assert(qemu_log_in_addr_range(0x10ff));
     g_assert_false(qemu_log_in_addr_range(0x1100));
 
+    qemu_reset_dfilter_ranges();
+
     qemu_set_dfilter_ranges("0x1000-0x100", &error_abort);
 
     g_assert_false(qemu_log_in_addr_range(0x1001));
@@ -50,6 +52,8 @@ static void test_parse_range(void)
     g_assert(qemu_log_in_addr_range(0x0f01));
     g_assert_false(qemu_log_in_addr_range(0x0f00));
 
+    qemu_reset_dfilter_ranges();
+
     qemu_set_dfilter_ranges("0x1000..0x1100", &error_abort);
 
     g_assert_false(qemu_log_in_addr_range(0xfff));
@@ -57,26 +61,36 @@ static void test_parse_range(void)
     g_assert(qemu_log_in_addr_range(0x1100));
     g_assert_false(qemu_log_in_addr_range(0x1101));
 
+    qemu_reset_dfilter_ranges();
+
     qemu_set_dfilter_ranges("0x1000..0x1000", &error_abort);
 
     g_assert_false(qemu_log_in_addr_range(0xfff));
     g_assert(qemu_log_in_addr_range(0x1000));
     g_assert_false(qemu_log_in_addr_range(0x1001));
 
+    qemu_reset_dfilter_ranges();
+
     qemu_set_dfilter_ranges("0x1000+0x100,0x2100-0x100,0x3000..0x3100",
                             &error_abort);
     g_assert(qemu_log_in_addr_range(0x1050));
     g_assert(qemu_log_in_addr_range(0x2050));
     g_assert(qemu_log_in_addr_range(0x3050));
 
+    qemu_reset_dfilter_ranges();
+
     qemu_set_dfilter_ranges("0xffffffffffffffff-1", &error_abort);
     g_assert(qemu_log_in_addr_range(UINT64_MAX));
     g_assert_false(qemu_log_in_addr_range(UINT64_MAX - 1));
 
+    qemu_reset_dfilter_ranges();
+
     qemu_set_dfilter_ranges("0..0xffffffffffffffff", &err);
     g_assert(qemu_log_in_addr_range(0));
     g_assert(qemu_log_in_addr_range(UINT64_MAX));
  
+    qemu_reset_dfilter_ranges();
+
     qemu_set_dfilter_ranges("2..1", &err);
     error_free_or_abort(&err);
 
diff --git a/util/log.c b/util/log.c
index c0dbbd4700..c6c197cbb3 100644
--- a/util/log.c
+++ b/util/log.c
@@ -149,19 +149,30 @@ bool qemu_log_in_addr_range(uint64_t addr)
     }
 }
 
+static void maybe_allocate_dfilter(int size_hint)
+{
+    if (!debug_regions) {
+        debug_regions = g_array_sized_new(FALSE, FALSE,
+                                          sizeof(Range),
+                                          size_hint ? size_hint : 1);
+    }
+}
+
+/* This is only really used for testing, usually dfilter stacks */
+void qemu_reset_dfilter_ranges(void)
+{
+    GArray *old = debug_regions;
+    debug_regions = NULL;
+    g_array_free(old, TRUE);
+}
 
 void qemu_set_dfilter_ranges(const char *filter_spec, Error **errp)
 {
     gchar **ranges = g_strsplit(filter_spec, ",", 0);
     int i;
 
-    if (debug_regions) {
-        g_array_unref(debug_regions);
-        debug_regions = NULL;
-    }
+    maybe_allocate_dfilter(g_strv_length(ranges));
 
-    debug_regions = g_array_sized_new(FALSE, FALSE,
-                                      sizeof(Range), g_strv_length(ranges));
     for (i = 0; ranges[i]; i++) {
         const char *r = ranges[i];
         const char *range_op, *r2, *e;
-- 
2.17.1
