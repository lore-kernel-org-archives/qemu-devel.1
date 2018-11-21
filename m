Received: from eggs.gnu.org ([2001:4830:134:3::10]:51635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gPVc7-0007QG-3S
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gPVc6-0006aB-4t
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gPVc5-0006ZW-Ty
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:30 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 21 Nov 2018 17:44:14 +0100
Message-Id: <20181121164421.20780-3-david@redhat.com>
In-Reply-To: <20181121164421.20780-1-david@redhat.com>
References: <20181121164421.20780-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-4.0 2/9] cutils: Fix qemu_strtosz() &
 friends to reject non-finite sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>

qemu_strtosz() & friends reject NaNs, but happily accept infinities.
They shouldn't. Fix that.

The fix makes use of qemu_strtod_finite(). To avoid ugly casts,
change the @end parameter of qemu_strtosz() & friends from char **
to const char **.

Also, add two test cases, testing that "inf" and "NaN" are properly
rejected. While at it, also fixup the function documentation.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qemu/cutils.h |  6 +++---
 monitor.c             |  2 +-
 tests/test-cutils.c   | 24 +++++++++++++++++-------
 util/cutils.c         | 18 ++++++++----------
 4 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 756b41c193..d2dad3057c 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -153,9 +153,9 @@ int parse_uint(const char *s, unsigned long long *value, char **endptr,
                int base);
 int parse_uint_full(const char *s, unsigned long long *value, int base);
 
-int qemu_strtosz(const char *nptr, char **end, uint64_t *result);
-int qemu_strtosz_MiB(const char *nptr, char **end, uint64_t *result);
-int qemu_strtosz_metric(const char *nptr, char **end, uint64_t *result);
+int qemu_strtosz(const char *nptr, const char **end, uint64_t *result);
+int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *result);
+int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
 
 /* used to print char* safely */
 #define STR_OR_NULL(str) ((str) ? (str) : "null")
diff --git a/monitor.c b/monitor.c
index d39390c2f2..ee9893c785 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3231,7 +3231,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
             {
                 int ret;
                 uint64_t val;
-                char *end;
+                const char *end;
 
                 while (qemu_isspace(*p)) {
                     p++;
diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index d85c3e0f6d..1aa8351520 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1950,7 +1950,7 @@ static void test_qemu_strtou64_full_max(void)
 static void test_qemu_strtosz_simple(void)
 {
     const char *str;
-    char *endptr = NULL;
+    const char *endptr;
     int err;
     uint64_t res = 0xbaadf00d;
 
@@ -2017,7 +2017,7 @@ static void test_qemu_strtosz_units(void)
     const char *p = "1P";
     const char *e = "1E";
     int err;
-    char *endptr = NULL;
+    const char *endptr;
     uint64_t res = 0xbaadf00d;
 
     /* default is M */
@@ -2066,7 +2066,7 @@ static void test_qemu_strtosz_float(void)
 {
     const char *str = "12.345M";
     int err;
-    char *endptr = NULL;
+    const char *endptr;
     uint64_t res = 0xbaadf00d;
 
     err = qemu_strtosz(str, &endptr, &res);
@@ -2078,7 +2078,7 @@ static void test_qemu_strtosz_float(void)
 static void test_qemu_strtosz_invalid(void)
 {
     const char *str;
-    char *endptr = NULL;
+    const char *endptr;
     int err;
     uint64_t res = 0xbaadf00d;
 
@@ -2096,12 +2096,22 @@ static void test_qemu_strtosz_invalid(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert(endptr == str);
+
+    str = "inf";
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+
+    str = "NaN";
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }
 
 static void test_qemu_strtosz_trailing(void)
 {
     const char *str;
-    char *endptr = NULL;
+    const char *endptr;
     int err;
     uint64_t res = 0xbaadf00d;
 
@@ -2126,7 +2136,7 @@ static void test_qemu_strtosz_trailing(void)
 static void test_qemu_strtosz_erange(void)
 {
     const char *str;
-    char *endptr = NULL;
+    const char *endptr;
     int err;
     uint64_t res = 0xbaadf00d;
 
@@ -2160,7 +2170,7 @@ static void test_qemu_strtosz_metric(void)
 {
     const char *str = "12345k";
     int err;
-    char *endptr = NULL;
+    const char *endptr;
     uint64_t res = 0xbaadf00d;
 
     err = qemu_strtosz_metric(str, &endptr, &res);
diff --git a/util/cutils.c b/util/cutils.c
index 173407d2fd..91930d1bbe 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -203,23 +203,21 @@ static int64_t suffix_mul(char suffix, int64_t unit)
 /*
  * Convert string to bytes, allowing either B/b for bytes, K/k for KB,
  * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned
- * in *end, if not NULL. Return -ERANGE on overflow, Return -EINVAL on
+ * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
  * other error.
  */
-static int do_strtosz(const char *nptr, char **end,
+static int do_strtosz(const char *nptr, const char **end,
                       const char default_suffix, int64_t unit,
                       uint64_t *result)
 {
     int retval;
-    char *endptr;
+    const char *endptr;
     unsigned char c;
     int mul_required = 0;
     double val, mul, integral, fraction;
 
-    errno = 0;
-    val = strtod(nptr, &endptr);
-    if (isnan(val) || endptr == nptr || errno != 0) {
-        retval = -EINVAL;
+    retval = qemu_strtod_finite(nptr, &endptr, &val);
+    if (retval) {
         goto out;
     }
     fraction = modf(val, &integral);
@@ -259,17 +257,17 @@ out:
     return retval;
 }
 
-int qemu_strtosz(const char *nptr, char **end, uint64_t *result)
+int qemu_strtosz(const char *nptr, const char **end, uint64_t *result)
 {
     return do_strtosz(nptr, end, 'B', 1024, result);
 }
 
-int qemu_strtosz_MiB(const char *nptr, char **end, uint64_t *result)
+int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *result)
 {
     return do_strtosz(nptr, end, 'M', 1024, result);
 }
 
-int qemu_strtosz_metric(const char *nptr, char **end, uint64_t *result)
+int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result)
 {
     return do_strtosz(nptr, end, 'B', 1000, result);
 }
-- 
2.17.2
