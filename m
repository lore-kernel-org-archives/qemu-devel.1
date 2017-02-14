Received: from eggs.gnu.org ([2001:4830:134:3::10]:39058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJa-00061E-60
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJX-0003UZ-Um
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:30 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:26:09 +0100
Message-Id: <1487067971-10443-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 22/24] util/cutils: Return qemu_strtosz*()
 error and value separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

This makes qemu_strtosz(), qemu_strtosz_mebi() and
qemu_strtosz_metric() similar to qemu_strtoi64(), except negative
values are rejected.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
Cc: Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
Cc: Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
Cc: qemu-block@nongnu.org (open list:Block layer core)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp.c                 |   6 +--
 hw/misc/ivshmem.c     |   7 ++-
 include/qemu/cutils.h |   6 +--
 monitor.c             |   5 ++-
 qapi/opts-visitor.c   |   5 ++-
 qemu-img.c            |  10 +++--
 qemu-io-cmds.c        |  10 +++--
 target/i386/cpu.c     |   5 ++-
 tests/test-cutils.c   | 120 ++++++++++++++++++++++++++++++--------------------
 util/cutils.c         |  22 ++++-----
 10 files changed, 119 insertions(+), 77 deletions(-)

diff --git a/hmp.c b/hmp.c
index 0eb5b6d..9846fa4 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1342,7 +1342,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     long valueint = 0;
     Error *err = NULL;
     bool use_int_value = false;
-    int i;
+    int i, ret;
 
     for (i = 0; i < MIGRATION_PARAMETER__MAX; i++) {
         if (strcmp(param, MigrationParameter_lookup[i]) == 0) {
@@ -1378,8 +1378,8 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 break;
             case MIGRATION_PARAMETER_MAX_BANDWIDTH:
                 p.has_max_bandwidth = true;
-                valuebw = qemu_strtosz_mebi(valuestr, NULL);
-                if (valuebw < 0 || (size_t)valuebw != valuebw) {
+                ret = qemu_strtosz_mebi(valuestr, NULL, &valuebw);
+                if (ret < 0 || (size_t)valuebw != valuebw) {
                     error_setg(&err, "Invalid size %s", valuestr);
                     goto cleanup;
                 }
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index f00cd75..3dc04f4 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1267,8 +1267,11 @@ static void ivshmem_realize(PCIDevice *dev, Error **errp)
     if (s->sizearg == NULL) {
         s->legacy_size = 4 << 20; /* 4 MB default */
     } else {
-        int64_t size = qemu_strtosz_mebi(s->sizearg, NULL);
-        if (size < 0 || (size_t)size != size || !is_power_of_2(size)) {
+        int ret;
+        int64_t size;
+
+        ret = qemu_strtosz_mebi(s->sizearg, NULL, &size);
+        if (ret < 0 || (size_t)size != size || !is_power_of_2(size)) {
             error_setg(errp, "Invalid size %s", s->sizearg);
             return;
         }
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 4184851..c91649b 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -139,9 +139,9 @@ int parse_uint(const char *s, unsigned long long *value, char **endptr,
                int base);
 int parse_uint_full(const char *s, unsigned long long *value, int base);
 
-int64_t qemu_strtosz(const char *nptr, char **end);
-int64_t qemu_strtosz_mebi(const char *nptr, char **end);
-int64_t qemu_strtosz_metric(const char *nptr, char **end);
+int qemu_strtosz(const char *nptr, char **end, int64_t *result);
+int qemu_strtosz_mebi(const char *nptr, char **end, int64_t *result);
+int qemu_strtosz_metric(const char *nptr, char **end, int64_t *result);
 
 #define K_BYTE     (1ULL << 10)
 #define M_BYTE     (1ULL << 20)
diff --git a/monitor.c b/monitor.c
index 1f8c031..85b1b61 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2773,6 +2773,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
             break;
         case 'o':
             {
+                int ret;
                 int64_t val;
                 char *end;
 
@@ -2785,8 +2786,8 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                         break;
                     }
                 }
-                val = qemu_strtosz_mebi(p, &end);
-                if (val < 0) {
+                ret = qemu_strtosz_mebi(p, &end, &val);
+                if (ret < 0) {
                     monitor_printf(mon, "invalid size\n");
                     goto fail;
                 }
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 911a0ee..aac2e09 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -482,14 +482,15 @@ opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
     OptsVisitor *ov = to_ov(v);
     const QemuOpt *opt;
     int64_t val;
+    int err;
 
     opt = lookup_scalar(ov, name, errp);
     if (!opt) {
         return;
     }
 
-    val = qemu_strtosz(opt->str ? opt->str : "", NULL);
-    if (val < 0) {
+    err = qemu_strtosz(opt->str ? opt->str : "", NULL, &val);
+    if (err < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
                    "a size value representible as a non-negative int64");
         return;
diff --git a/qemu-img.c b/qemu-img.c
index adcb511..89ced5a 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -370,10 +370,14 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
 
 static int64_t cvtnum(const char *s)
 {
-    int64_t ret;
+    int err;
+    int64_t value;
 
-    ret = qemu_strtosz(s, NULL);
-    return ret;
+    err = qemu_strtosz(s, NULL, &value);
+    if (err < 0) {
+        return err;
+    }
+    return value;
 }
 
 static int img_create(int argc, char **argv)
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 417a4e0..d9f3e93 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -137,10 +137,14 @@ static char **breakline(char *input, int *count)
 
 static int64_t cvtnum(const char *s)
 {
-    int64_t ret;
+    int err;
+    int64_t value;
 
-    ret = qemu_strtosz(s, NULL);
-    return ret;
+    err = qemu_strtosz(s, NULL, &value);
+    if (err < 0) {
+        return err;
+    }
+    return value;
 }
 
 static void print_cvtnum_err(int64_t rc, const char *arg)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5cb0b4b..5f85410 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2033,10 +2033,11 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
 
         /* Special case: */
         if (!strcmp(name, "tsc-freq")) {
+            int ret;
             int64_t tsc_freq;
 
-            tsc_freq = qemu_strtosz_metric(val, NULL);
-            if (tsc_freq < 0) {
+            ret = qemu_strtosz_metric(val, NULL, &tsc_freq);
+            if (ret < 0) {
                 error_setg(errp, "bad numerical value %s", val);
                 return;
             }
diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 07095e3..9c2eed3 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1373,45 +1373,54 @@ static void test_qemu_strtosz_simple(void)
 {
     const char *str;
     char *endptr = NULL;
-    int64_t res;
+    int err;
+    int64_t res = 0xbaadf00d;
 
     str = "0";
-    res = qemu_strtosz(str, &endptr);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0);
     g_assert(endptr == str + 1);
 
     str = "12345";
-    res = qemu_strtosz(str, &endptr);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 12345);
     g_assert(endptr == str + 5);
 
-    res = qemu_strtosz(str, NULL);
+    err = qemu_strtosz(str, NULL, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 12345);
 
     /* Note: precision is 53 bits since we're parsing with strtod() */
 
     str = "9007199254740991"; /* 2^53-1 */
-    res = qemu_strtosz(str, &endptr);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x1fffffffffffff);
     g_assert(endptr == str + 16);
 
     str = "9007199254740992"; /* 2^53 */
-    res = qemu_strtosz(str, &endptr);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x20000000000000);
     g_assert(endptr == str + 16);
 
     str = "9007199254740993"; /* 2^53+1 */
-    res = qemu_strtosz(str, &endptr);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x20000000000000); /* rounded to 53 bits */
     g_assert(endptr == str + 16);
 
     str = "9223372036854774784"; /* 0x7ffffffffffffc00 (53 msbs set) */
-    res = qemu_strtosz(str, &endptr);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x7ffffffffffffc00);
     g_assert(endptr == str + 19);
 
     str = "9223372036854775295"; /* 0x7ffffffffffffdff */
-    res = qemu_strtosz(str, &endptr);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x7ffffffffffffc00); /* rounded to 53 bits */
     g_assert(endptr == str + 19);
 
@@ -1429,39 +1438,48 @@ static void test_qemu_strtosz_units(void)
     const char *t = "1T";
     const char *p = "1P";
     const char *e = "1E";
+    int err;
     char *endptr = NULL;
-    int64_t res;
+    int64_t res = 0xbaadf00d;
 
     /* default is M */
-    res = qemu_strtosz_mebi(none, &endptr);
+    err = qemu_strtosz_mebi(none, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, M_BYTE);
     g_assert(endptr == none + 1);
 
-    res = qemu_strtosz(b, &endptr);
+    err = qemu_strtosz(b, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 1);
     g_assert(endptr == b + 2);
 
-    res = qemu_strtosz(k, &endptr);
+    err = qemu_strtosz(k, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, K_BYTE);
     g_assert(endptr == k + 2);
 
-    res = qemu_strtosz(m, &endptr);
+    err = qemu_strtosz(m, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, M_BYTE);
     g_assert(endptr == m + 2);
 
-    res = qemu_strtosz(g, &endptr);
+    err = qemu_strtosz(g, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, G_BYTE);
     g_assert(endptr == g + 2);
 
-    res = qemu_strtosz(t, &endptr);
+    err = qemu_strtosz(t, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, T_BYTE);
     g_assert(endptr == t + 2);
 
-    res = qemu_strtosz(p, &endptr);
+    err = qemu_strtosz(p, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, P_BYTE);
     g_assert(endptr == p + 2);
 
-    res = qemu_strtosz(e, &endptr);
+    err = qemu_strtosz(e, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, E_BYTE);
     g_assert(endptr == e + 2);
 }
@@ -1469,10 +1487,12 @@ static void test_qemu_strtosz_units(void)
 static void test_qemu_strtosz_float(void)
 {
     const char *str = "12.345M";
+    int err;
     char *endptr = NULL;
-    int64_t res;
+    int64_t res = 0xbaadf00d;
 
-    res = qemu_strtosz(str, &endptr);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 12.345 * M_BYTE);
     g_assert(endptr == str + 7);
 }
@@ -1481,21 +1501,22 @@ static void test_qemu_strtosz_invalid(void)
 {
     const char *str;
     char *endptr = NULL;
-    int64_t res;
+    int err;
+    int64_t res = 0xbaadf00d;
 
     str = "";
-    res = qemu_strtosz(str, &endptr);
-    g_assert_cmpint(res, ==, -EINVAL);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
     g_assert(endptr == str);
 
     str = " \t ";
-    res = qemu_strtosz(str, &endptr);
-    g_assert_cmpint(res, ==, -EINVAL);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
     g_assert(endptr == str);
 
     str = "crap";
-    res = qemu_strtosz(str, &endptr);
-    g_assert_cmpint(res, ==, -EINVAL);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
     g_assert(endptr == str);
 }
 
@@ -1503,64 +1524,69 @@ static void test_qemu_strtosz_trailing(void)
 {
     const char *str;
     char *endptr = NULL;
-    int64_t res;
+    int err;
+    int64_t res = 0xbaadf00d;
 
     str = "123xxx";
-    res = qemu_strtosz_mebi(str, &endptr);
+    err = qemu_strtosz_mebi(str, &endptr, &res);
     g_assert_cmpint(res, ==, 123 * M_BYTE);
     g_assert(endptr == str + 3);
 
-    res = qemu_strtosz(str, NULL);
-    g_assert_cmpint(res, ==, -EINVAL);
+    err = qemu_strtosz(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
 
     str = "1kiB";
-    res = qemu_strtosz(str, &endptr);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 1024);
     g_assert(endptr == str + 2);
 
-    res = qemu_strtosz(str, NULL);
-    g_assert_cmpint(res, ==, -EINVAL);
+    err = qemu_strtosz(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
 }
 
 static void test_qemu_strtosz_erange(void)
 {
     const char *str;
     char *endptr = NULL;
-    int64_t res;
+    int err;
+    int64_t res = 0xbaadf00d;
 
     str = "-1";
-    res = qemu_strtosz(str, &endptr);
-    g_assert_cmpint(res, ==, -ERANGE);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
     g_assert(endptr == str + 2);
 
     str = "9223372036854775296"; /* 0x7ffffffffffffe00 */
-    res = qemu_strtosz(str, &endptr);
-    g_assert_cmpint(res, ==, -ERANGE);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
     g_assert(endptr == str + 19);
 
     str = "9223372036854775807"; /* 2^63-1 */
-    res = qemu_strtosz(str, &endptr);
-    g_assert_cmpint(res, ==, -ERANGE);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
     g_assert(endptr == str + 19);
 
     str = "9223372036854775808"; /* 2^63 */
-    res = qemu_strtosz(str, &endptr);
-    g_assert_cmpint(res, ==, -ERANGE);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
     g_assert(endptr == str + 19);
 
     str = "10E";
-    res = qemu_strtosz(str, &endptr);
-    g_assert_cmpint(res, ==, -ERANGE);
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
     g_assert(endptr == str + 3);
 }
 
 static void test_qemu_strtosz_metric(void)
 {
     const char *str = "12345k";
+    int err;
     char *endptr = NULL;
-    int64_t res;
+    int64_t res = 0xbaadf00d;
 
-    res = qemu_strtosz_metric(str, &endptr);
+    err = qemu_strtosz_metric(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 12345000);
     g_assert(endptr == str + 6);
 }
diff --git a/util/cutils.c b/util/cutils.c
index 5c1bfe5..08effe6 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -205,10 +205,11 @@ static int64_t suffix_mul(char suffix, int64_t unit)
  * in *end, if not NULL. Return -ERANGE on overflow, Return -EINVAL on
  * other error.
  */
-static int64_t do_strtosz(const char *nptr, char **end,
-                          const char default_suffix, int64_t unit)
+static int do_strtosz(const char *nptr, char **end,
+                      const char default_suffix, int64_t unit,
+                      int64_t *result)
 {
-    int64_t retval;
+    int retval;
     char *endptr;
     unsigned char c;
     int mul_required = 0;
@@ -240,7 +241,8 @@ static int64_t do_strtosz(const char *nptr, char **end,
         retval = -ERANGE;
         goto out;
     }
-    retval = val * mul;
+    *result = val * mul;
+    retval = 0;
 
 out:
     if (end) {
@@ -252,19 +254,19 @@ out:
     return retval;
 }
 
-int64_t qemu_strtosz(const char *nptr, char **end)
+int qemu_strtosz(const char *nptr, char **end, int64_t *result)
 {
-    return do_strtosz(nptr, end, 'B', 1024);
+    return do_strtosz(nptr, end, 'B', 1024, result);
 }
 
-int64_t qemu_strtosz_mebi(const char *nptr, char **end)
+int qemu_strtosz_mebi(const char *nptr, char **end, int64_t *result)
 {
-    return do_strtosz(nptr, end, 'M', 1024);
+    return do_strtosz(nptr, end, 'M', 1024, result);
 }
 
-int64_t qemu_strtosz_metric(const char *nptr, char **end)
+int qemu_strtosz_metric(const char *nptr, char **end, int64_t *result)
 {
-    return do_strtosz(nptr, end, 'B', 1000);
+    return do_strtosz(nptr, end, 'B', 1000, result);
 }
 
 /**
-- 
2.7.4
