Received: from eggs.gnu.org ([2001:4830:134:3::10]:52716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIGh-0005YR-R3
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIGf-0004K0-QK
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNIGf-0004Jg-JN
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:13 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 15 Nov 2018 15:04:54 +0100
Message-Id: <20181115140501.7872-3-david@redhat.com>
In-Reply-To: <20181115140501.7872-1-david@redhat.com>
References: <20181115140501.7872-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/9] cutils: use qemu_strtod_finite() in
 do_strtosz()
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

Let's use the new function. In order to do so, we have to convert all
users of qemu_strtosz*() to pass a "const char **end" ptr.

We will now also reject "inf" properly.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qemu/cutils.h |  6 +++---
 monitor.c             |  2 +-
 tests/test-cutils.c   | 14 +++++++-------
 util/cutils.c         | 14 ++++++--------
 4 files changed, 17 insertions(+), 19 deletions(-)

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
index d85c3e0f6d..e21dcbf12b 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1950,7 +1950,7 @@ static void test_qemu_strtou64_full_max(void)
 static void test_qemu_strtosz_simple(void)
 {
     const char *str;
-    char *endptr = NULL;
+    const char *endptr = NULL;
     int err;
     uint64_t res = 0xbaadf00d;
 
@@ -2017,7 +2017,7 @@ static void test_qemu_strtosz_units(void)
     const char *p = "1P";
     const char *e = "1E";
     int err;
-    char *endptr = NULL;
+    const char *endptr = NULL;
     uint64_t res = 0xbaadf00d;
 
     /* default is M */
@@ -2066,7 +2066,7 @@ static void test_qemu_strtosz_float(void)
 {
     const char *str = "12.345M";
     int err;
-    char *endptr = NULL;
+    const char *endptr = NULL;
     uint64_t res = 0xbaadf00d;
 
     err = qemu_strtosz(str, &endptr, &res);
@@ -2078,7 +2078,7 @@ static void test_qemu_strtosz_float(void)
 static void test_qemu_strtosz_invalid(void)
 {
     const char *str;
-    char *endptr = NULL;
+    const char *endptr = NULL;
     int err;
     uint64_t res = 0xbaadf00d;
 
@@ -2101,7 +2101,7 @@ static void test_qemu_strtosz_invalid(void)
 static void test_qemu_strtosz_trailing(void)
 {
     const char *str;
-    char *endptr = NULL;
+    const char *endptr = NULL;
     int err;
     uint64_t res = 0xbaadf00d;
 
@@ -2126,7 +2126,7 @@ static void test_qemu_strtosz_trailing(void)
 static void test_qemu_strtosz_erange(void)
 {
     const char *str;
-    char *endptr = NULL;
+    const char *endptr = NULL;
     int err;
     uint64_t res = 0xbaadf00d;
 
@@ -2160,7 +2160,7 @@ static void test_qemu_strtosz_metric(void)
 {
     const char *str = "12345k";
     int err;
-    char *endptr = NULL;
+    const char *endptr = NULL;
     uint64_t res = 0xbaadf00d;
 
     err = qemu_strtosz_metric(str, &endptr, &res);
diff --git a/util/cutils.c b/util/cutils.c
index 7868a683e8..dd61fb4558 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -206,19 +206,17 @@ static int64_t suffix_mul(char suffix, int64_t unit)
  * in *end, if not NULL. Return -ERANGE on overflow, Return -EINVAL on
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
+    if (qemu_strtod_finite(nptr, &endptr, &val)) {
         retval = -EINVAL;
         goto out;
     }
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
