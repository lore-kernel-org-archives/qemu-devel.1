Received: from eggs.gnu.org ([2001:4830:134:3::10]:39020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJX-0005y2-Pf
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJU-0003Sm-IF
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:27 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:26:08 +0100
Message-Id: <1487067971-10443-22-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 21/24] util/cutils: Let qemu_strtosz*()
 optionally reject trailing crap
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

Change the qemu_strtosz() & friends to return -EINVAL when @endptr is
null and the conversion doesn't consume the string completely.
Matches how qemu_strtol() & friends work.

Only test_qemu_strtosz_simple() passes a null @endptr.  No functional
change there, because its conversion consumes the string.

Simplify callers that use @endptr only to fail when it doesn't point
to '\0' to pass a null @endptr instead.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
Cc: Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
Cc: Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
Cc: qemu-block@nongnu.org (open list:Block layer core)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp.c               |  6 ++----
 hw/misc/ivshmem.c   |  6 ++----
 qapi/opts-visitor.c |  5 ++---
 qemu-img.c          |  7 +------
 qemu-io-cmds.c      |  7 +------
 target/i386/cpu.c   |  5 ++---
 tests/test-cutils.c |  6 ++++++
 util/cutils.c       | 14 +++++++++-----
 8 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/hmp.c b/hmp.c
index 6d0d05b..0eb5b6d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1340,7 +1340,6 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     const char *valuestr = qdict_get_str(qdict, "value");
     int64_t valuebw = 0;
     long valueint = 0;
-    char *endp;
     Error *err = NULL;
     bool use_int_value = false;
     int i;
@@ -1379,9 +1378,8 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 break;
             case MIGRATION_PARAMETER_MAX_BANDWIDTH:
                 p.has_max_bandwidth = true;
-                valuebw = qemu_strtosz_mebi(valuestr, &endp);
-                if (valuebw < 0 || (size_t)valuebw != valuebw
-                    || *endp != '\0') {
+                valuebw = qemu_strtosz_mebi(valuestr, NULL);
+                if (valuebw < 0 || (size_t)valuebw != valuebw) {
                     error_setg(&err, "Invalid size %s", valuestr);
                     goto cleanup;
                 }
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 382dd8b..f00cd75 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1267,10 +1267,8 @@ static void ivshmem_realize(PCIDevice *dev, Error **errp)
     if (s->sizearg == NULL) {
         s->legacy_size = 4 << 20; /* 4 MB default */
     } else {
-        char *end;
-        int64_t size = qemu_strtosz_mebi(s->sizearg, &end);
-        if (size < 0 || (size_t)size != size || *end != '\0'
-            || !is_power_of_2(size)) {
+        int64_t size = qemu_strtosz_mebi(s->sizearg, NULL);
+        if (size < 0 || (size_t)size != size || !is_power_of_2(size)) {
             error_setg(errp, "Invalid size %s", s->sizearg);
             return;
         }
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 360d337..911a0ee 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -482,15 +482,14 @@ opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
     OptsVisitor *ov = to_ov(v);
     const QemuOpt *opt;
     int64_t val;
-    char *endptr;
 
     opt = lookup_scalar(ov, name, errp);
     if (!opt) {
         return;
     }
 
-    val = qemu_strtosz(opt->str ? opt->str : "", &endptr);
-    if (val < 0 || *endptr) {
+    val = qemu_strtosz(opt->str ? opt->str : "", NULL);
+    if (val < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
                    "a size value representible as a non-negative int64");
         return;
diff --git a/qemu-img.c b/qemu-img.c
index 2a47966..adcb511 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -370,14 +370,9 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
 
 static int64_t cvtnum(const char *s)
 {
-    char *end;
     int64_t ret;
 
-    ret = qemu_strtosz(s, &end);
-    if (*end != '\0') {
-        /* Detritus at the end of the string */
-        return -EINVAL;
-    }
+    ret = qemu_strtosz(s, NULL);
     return ret;
 }
 
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 6b7a89c..417a4e0 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -137,14 +137,9 @@ static char **breakline(char *input, int *count)
 
 static int64_t cvtnum(const char *s)
 {
-    char *end;
     int64_t ret;
 
-    ret = qemu_strtosz(s, &end);
-    if (*end != '\0') {
-        /* Detritus at the end of the string */
-        return -EINVAL;
-    }
+    ret = qemu_strtosz(s, NULL);
     return ret;
 }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3a8d72d..5cb0b4b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2034,10 +2034,9 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
         /* Special case: */
         if (!strcmp(name, "tsc-freq")) {
             int64_t tsc_freq;
-            char *err;
 
-            tsc_freq = qemu_strtosz_metric(val, &err);
-            if (tsc_freq < 0 || *err) {
+            tsc_freq = qemu_strtosz_metric(val, NULL);
+            if (tsc_freq < 0) {
                 error_setg(errp, "bad numerical value %s", val);
                 return;
             }
diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 585912b..07095e3 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1510,10 +1510,16 @@ static void test_qemu_strtosz_trailing(void)
     g_assert_cmpint(res, ==, 123 * M_BYTE);
     g_assert(endptr == str + 3);
 
+    res = qemu_strtosz(str, NULL);
+    g_assert_cmpint(res, ==, -EINVAL);
+
     str = "1kiB";
     res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 1024);
     g_assert(endptr == str + 2);
+
+    res = qemu_strtosz(str, NULL);
+    g_assert_cmpint(res, ==, -EINVAL);
 }
 
 static void test_qemu_strtosz_erange(void)
diff --git a/util/cutils.c b/util/cutils.c
index 4a290ea..5c1bfe5 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -208,7 +208,7 @@ static int64_t suffix_mul(char suffix, int64_t unit)
 static int64_t do_strtosz(const char *nptr, char **end,
                           const char default_suffix, int64_t unit)
 {
-    int64_t retval = -EINVAL;
+    int64_t retval;
     char *endptr;
     unsigned char c;
     int mul_required = 0;
@@ -217,7 +217,8 @@ static int64_t do_strtosz(const char *nptr, char **end,
     errno = 0;
     val = strtod(nptr, &endptr);
     if (isnan(val) || endptr == nptr || errno != 0) {
-        goto fail;
+        retval = -EINVAL;
+        goto out;
     }
     fraction = modf(val, &integral);
     if (fraction != 0) {
@@ -232,17 +233,20 @@ static int64_t do_strtosz(const char *nptr, char **end,
         assert(mul >= 0);
     }
     if (mul == 1 && mul_required) {
-        goto fail;
+        retval = -EINVAL;
+        goto out;
     }
     if ((val * mul >= INT64_MAX) || val < 0) {
         retval = -ERANGE;
-        goto fail;
+        goto out;
     }
     retval = val * mul;
 
-fail:
+out:
     if (end) {
         *end = endptr;
+    } else if (*endptr) {
+        retval = -EINVAL;
     }
 
     return retval;
-- 
2.7.4
