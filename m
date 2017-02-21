Received: from eggs.gnu.org ([2001:4830:134:3::10]:55191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpG-0007RX-Ul
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpC-00004q-Ph
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgGpC-0008V9-F1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:14 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B166080476
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:14:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:14:00 +0100
Message-Id: <1487708048-2131-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1487708048-2131-1-git-send-email-armbru@redhat.com>
References: <1487708048-2131-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/24] util/cutils: New qemu_strtosz()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Most callers of qemu_strtosz_suffix() pass QEMU_STRTOSZ_DEFSUFFIX_B.
Capture the pattern in new qemu_strtosz().

Inline qemu_strtosz_suffix() into its only remaining caller.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/cutils.h | 17 +----------------
 qapi/opts-visitor.c   |  3 +--
 qemu-img.c            | 18 ++++++++----------
 qemu-io-cmds.c        |  2 +-
 tests/test-cutils.c   | 16 ++++++++--------
 util/cutils.c         | 15 +++++++++++----
 6 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index a08b1b0..3fdbb6b 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -139,22 +139,7 @@ int parse_uint(const char *s, unsigned long long *value, char **endptr,
                int base);
 int parse_uint_full(const char *s, unsigned long long *value, int base);
 
-/*
- * qemu_strtosz() suffixes used to specify the default treatment of an
- * argument passed to qemu_strtosz() without an explicit suffix.
- * These should be defined using upper case characters in the range
- * A-Z, as qemu_strtosz() will use qemu_toupper() on the given argument
- * prior to comparison.
- */
-#define QEMU_STRTOSZ_DEFSUFFIX_EB 'E'
-#define QEMU_STRTOSZ_DEFSUFFIX_PB 'P'
-#define QEMU_STRTOSZ_DEFSUFFIX_TB 'T'
-#define QEMU_STRTOSZ_DEFSUFFIX_GB 'G'
-#define QEMU_STRTOSZ_DEFSUFFIX_MB 'M'
-#define QEMU_STRTOSZ_DEFSUFFIX_KB 'K'
-#define QEMU_STRTOSZ_DEFSUFFIX_B 'B'
-int64_t qemu_strtosz_suffix(const char *nptr, char **end,
-                            const char default_suffix);
+int64_t qemu_strtosz(const char *nptr, char **end);
 int64_t qemu_strtosz_MiB(const char *nptr, char **end);
 int64_t qemu_strtosz_metric(const char *nptr, char **end);
 
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 1048bbc..360d337 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -489,8 +489,7 @@ opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
         return;
     }
 
-    val = qemu_strtosz_suffix(opt->str ? opt->str : "", &endptr,
-                         QEMU_STRTOSZ_DEFSUFFIX_B);
+    val = qemu_strtosz(opt->str ? opt->str : "", &endptr);
     if (val < 0 || *endptr) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
                    "a size value representible as a non-negative int64");
diff --git a/qemu-img.c b/qemu-img.c
index cff22e3..f1c641c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -462,8 +462,7 @@ static int img_create(int argc, char **argv)
     if (optind < argc) {
         int64_t sval;
         char *end;
-        sval = qemu_strtosz_suffix(argv[optind++], &end,
-                                   QEMU_STRTOSZ_DEFSUFFIX_B);
+        sval = qemu_strtosz(argv[optind++], &end);
         if (sval < 0 || *end) {
             if (sval == -ERANGE) {
                 error_report("Image size must be less than 8 EiB!");
@@ -1865,7 +1864,7 @@ static int img_convert(int argc, char **argv)
         {
             int64_t sval;
             char *end;
-            sval = qemu_strtosz_suffix(optarg, &end, QEMU_STRTOSZ_DEFSUFFIX_B);
+            sval = qemu_strtosz(optarg, &end);
             if (sval < 0 || *end) {
                 error_report("Invalid minimum zero buffer size for sparse output specified");
                 ret = -1;
@@ -3653,8 +3652,7 @@ static int img_bench(int argc, char **argv)
         {
             char *end;
             errno = 0;
-            offset = qemu_strtosz_suffix(optarg, &end,
-                                         QEMU_STRTOSZ_DEFSUFFIX_B);
+            offset = qemu_strtosz(optarg, &end);
             if (offset < 0|| *end) {
                 error_report("Invalid offset specified");
                 return 1;
@@ -3670,7 +3668,7 @@ static int img_bench(int argc, char **argv)
             int64_t sval;
             char *end;
 
-            sval = qemu_strtosz_suffix(optarg, &end, QEMU_STRTOSZ_DEFSUFFIX_B);
+            sval = qemu_strtosz(optarg, &end);
             if (sval < 0 || sval > INT_MAX || *end) {
                 error_report("Invalid buffer size specified");
                 return 1;
@@ -3684,7 +3682,7 @@ static int img_bench(int argc, char **argv)
             int64_t sval;
             char *end;
 
-            sval = qemu_strtosz_suffix(optarg, &end, QEMU_STRTOSZ_DEFSUFFIX_B);
+            sval = qemu_strtosz(optarg, &end);
             if (sval < 0 || sval > INT_MAX || *end) {
                 error_report("Invalid step size specified");
                 return 1;
@@ -3847,7 +3845,7 @@ static int img_dd_bs(const char *arg,
     char *end;
     int64_t res;
 
-    res = qemu_strtosz_suffix(arg, &end, QEMU_STRTOSZ_DEFSUFFIX_B);
+    res = qemu_strtosz(arg, &end);
 
     if (res <= 0 || res > INT_MAX || *end) {
         error_report("invalid number: '%s'", arg);
@@ -3864,7 +3862,7 @@ static int img_dd_count(const char *arg,
 {
     char *end;
 
-    dd->count = qemu_strtosz_suffix(arg, &end, QEMU_STRTOSZ_DEFSUFFIX_B);
+    dd->count = qemu_strtosz(arg, &end);
 
     if (dd->count < 0 || *end) {
         error_report("invalid number: '%s'", arg);
@@ -3898,7 +3896,7 @@ static int img_dd_skip(const char *arg,
 {
     char *end;
 
-    in->offset = qemu_strtosz_suffix(arg, &end, QEMU_STRTOSZ_DEFSUFFIX_B);
+    in->offset = qemu_strtosz(arg, &end);
 
     if (in->offset < 0 || *end) {
         error_report("invalid number: '%s'", arg);
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index e415b03..0166cfa 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -140,7 +140,7 @@ static int64_t cvtnum(const char *s)
     char *end;
     int64_t ret;
 
-    ret = qemu_strtosz_suffix(s, &end, QEMU_STRTOSZ_DEFSUFFIX_B);
+    ret = qemu_strtosz(s, &end);
     if (*end != '\0') {
         /* Detritus at the end of the string */
         return -EINVAL;
diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 9bbfb8f..9eae067 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1391,27 +1391,27 @@ static void test_qemu_strtosz_simple(void)
     /* Note: precision is 53 bits since we're parsing with strtod() */
 
     str = "9007199254740991"; /* 2^53-1 */
-    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 0x1fffffffffffff);
     g_assert(endptr == str + 16);
 
     str = "9007199254740992"; /* 2^53 */
-    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 0x20000000000000);
     g_assert(endptr == str + 16);
 
     str = "9007199254740993"; /* 2^53+1 */
-    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 0x20000000000000); /* rounded to 53 bits */
     g_assert(endptr == str + 16);
 
     str = "9223372036854774784"; /* 0x7ffffffffffffc00 (53 msbs set) */
-    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 0x7ffffffffffffc00);
     g_assert(endptr == str + 19);
 
     str = "9223372036854775295"; /* 0x7ffffffffffffdff */
-    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 0x7ffffffffffffc00); /* rounded to 53 bits */
     g_assert(endptr == str + 19);
 
@@ -1528,17 +1528,17 @@ static void test_qemu_strtosz_erange(void)
     g_assert(endptr == str + 2);
 
     str = "9223372036854775296"; /* 0x7ffffffffffffe00 */
-    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
     g_assert(endptr == str + 19);
 
     str = "9223372036854775807"; /* 2^63-1 */
-    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
     g_assert(endptr == str + 19);
 
     str = "9223372036854775808"; /* 2^63 */
-    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
     g_assert(endptr == str + 19);
 
diff --git a/util/cutils.c b/util/cutils.c
index 9693add..97ec130 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -178,6 +178,14 @@ int fcntl_setfl(int fd, int flag)
 }
 #endif
 
+#define QEMU_STRTOSZ_DEFSUFFIX_EB 'E'
+#define QEMU_STRTOSZ_DEFSUFFIX_PB 'P'
+#define QEMU_STRTOSZ_DEFSUFFIX_TB 'T'
+#define QEMU_STRTOSZ_DEFSUFFIX_GB 'G'
+#define QEMU_STRTOSZ_DEFSUFFIX_MB 'M'
+#define QEMU_STRTOSZ_DEFSUFFIX_KB 'K'
+#define QEMU_STRTOSZ_DEFSUFFIX_B 'B'
+
 static int64_t suffix_mul(char suffix, int64_t unit)
 {
     switch (qemu_toupper(suffix)) {
@@ -248,15 +256,14 @@ fail:
     return retval;
 }
 
-int64_t qemu_strtosz_suffix(const char *nptr, char **end,
-                            const char default_suffix)
+int64_t qemu_strtosz(const char *nptr, char **end)
 {
-    return do_strtosz(nptr, end, default_suffix, 1024);
+    return do_strtosz(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_B, 1024);
 }
 
 int64_t qemu_strtosz_MiB(const char *nptr, char **end)
 {
-    return qemu_strtosz_suffix(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_MB);
+    return do_strtosz(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_MB, 1024);
 }
 
 int64_t qemu_strtosz_metric(const char *nptr, char **end)
-- 
2.7.4
