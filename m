Received: from eggs.gnu.org ([2001:4830:134:3::10]:38728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJO-0005qd-GY
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJL-0003L7-Co
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJL-0003KV-3z
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:15 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3F128047B
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1EAQDoL003915
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:26:14 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:25:48 +0100
Message-Id: <1487067971-10443-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 01/24] tests/test-qemu-opts: Cover
 qemu_opts_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The new tests demonstrate a few bugs, all clearly marked.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qemu-opts.c | 294 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 292 insertions(+), 2 deletions(-)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index a505a3e..f4426bb 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/config-file.h"
@@ -29,6 +30,9 @@ static QemuOptsList opts_list_01 = {
         },{
             .name = "number1",
             .type = QEMU_OPT_NUMBER,
+        },{
+            .name = "number2",
+            .type = QEMU_OPT_NUMBER,
         },
         { /* end of list */ }
     },
@@ -42,14 +46,23 @@ static QemuOptsList opts_list_02 = {
             .name = "str1",
             .type = QEMU_OPT_STRING,
         },{
+            .name = "str2",
+            .type = QEMU_OPT_STRING,
+        },{
             .name = "bool1",
             .type = QEMU_OPT_BOOL,
         },{
-            .name = "str2",
-            .type = QEMU_OPT_STRING,
+            .name = "bool2",
+            .type = QEMU_OPT_BOOL,
         },{
             .name = "size1",
             .type = QEMU_OPT_SIZE,
+        },{
+            .name = "size2",
+            .type = QEMU_OPT_SIZE,
+        },{
+            .name = "size3",
+            .type = QEMU_OPT_SIZE,
         },
         { /* end of list */ }
     },
@@ -57,6 +70,7 @@ static QemuOptsList opts_list_02 = {
 
 static QemuOptsList opts_list_03 = {
     .name = "opts_list_03",
+    .implied_opt_name = "implied",
     .head = QTAILQ_HEAD_INITIALIZER(opts_list_03.head),
     .desc = {
         /* no elements => accept any params */
@@ -421,6 +435,278 @@ static void test_qemu_opts_set(void)
     g_assert(opts == NULL);
 }
 
+static int opts_count_iter(void *opaque, const char *name, const char *value,
+                           Error **errp)
+{
+    (*(size_t *)opaque)++;
+    return 0;
+}
+
+static size_t opts_count(QemuOpts *opts)
+{
+    size_t n = 0;
+
+    qemu_opt_foreach(opts, opts_count_iter, &n, NULL);
+    return n;
+}
+
+static void test_opts_parse(void)
+{
+    Error *err = NULL;
+    QemuOpts *opts;
+    char long_key[129];
+    char *params;
+
+    /* Nothing */
+    opts = qemu_opts_parse(&opts_list_03, "", false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 0);
+
+    /* Empty key */
+    opts = qemu_opts_parse(&opts_list_03, "=val", false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpstr(qemu_opt_get(opts, ""), ==, "val");
+
+    /* Long key */
+    memset(long_key, 'a', 127);
+    long_key[127] = 'z';
+    long_key[128] = 0;
+    params = g_strdup_printf("%s=v", long_key);
+    opts = qemu_opts_parse(&opts_list_03, params + 1, NULL, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpstr(qemu_opt_get(opts, long_key + 1), ==, "v");
+
+    /* Overlong key gets truncated */
+    opts = qemu_opts_parse(&opts_list_03, params, NULL, &error_abort);
+    g_assert(opts_count(opts) == 1);
+    long_key[127] = 0;
+    g_assert_cmpstr(qemu_opt_get(opts, long_key), ==, "v");
+    g_free(params);
+
+    /* Multiple keys, last one wins */
+    opts = qemu_opts_parse(&opts_list_03, "a=1,b=2,,x,a=3",
+                           false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 3);
+    g_assert_cmpstr(qemu_opt_get(opts, "a"), ==, "3");
+    g_assert_cmpstr(qemu_opt_get(opts, "b"), ==, "2,x");
+
+    /* Except when it doesn't */
+    opts = qemu_opts_parse(&opts_list_03, "id=foo,id=bar",
+                           false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 0);
+    g_assert_cmpstr(qemu_opts_id(opts), ==, "foo");
+
+    /* Implied value */
+    opts = qemu_opts_parse(&opts_list_03, "an,noaus,noaus=",
+                           false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 3);
+    g_assert_cmpstr(qemu_opt_get(opts, "an"), ==, "on");
+    g_assert_cmpstr(qemu_opt_get(opts, "aus"), ==, "off");
+    g_assert_cmpstr(qemu_opt_get(opts, "noaus"), ==, "");
+
+    /* Implied key */
+    opts = qemu_opts_parse(&opts_list_03, "an,noaus,noaus=", true,
+                           &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 3);
+    g_assert_cmpstr(qemu_opt_get(opts, "implied"), ==, "an");
+    g_assert_cmpstr(qemu_opt_get(opts, "aus"), ==, "off");
+    g_assert_cmpstr(qemu_opt_get(opts, "noaus"), ==, "");
+
+    /* Trailing comma is ignored */
+    opts = qemu_opts_parse(&opts_list_03, "x=y,", false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpstr(qemu_opt_get(opts, "x"), ==, "y");
+
+    /* Except when it isn't */
+    opts = qemu_opts_parse(&opts_list_03, ",", false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpstr(qemu_opt_get(opts, ""), ==, "on");
+
+    /* Duplicate ID */
+    opts = qemu_opts_parse(&opts_list_03, "x=y,id=foo", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+    /* TODO Cover .merge_lists = true */
+
+    /* Buggy ID recognition */
+    opts = qemu_opts_parse(&opts_list_03, "x=,,id=bar", false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpstr(qemu_opts_id(opts), ==, "bar"); /* BUG */
+    g_assert_cmpstr(qemu_opt_get(opts, "x"), ==, ",id=bar");
+
+    /* Anti-social ID */
+    opts = qemu_opts_parse(&opts_list_01, "id=666", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+
+    /* Unknown key */
+    opts = qemu_opts_parse(&opts_list_01, "nonexistent=", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+
+    qemu_opts_reset(&opts_list_01);
+    qemu_opts_reset(&opts_list_03);
+}
+
+static void test_opts_parse_bool(void)
+{
+    Error *err = NULL;
+    QemuOpts *opts;
+
+    opts = qemu_opts_parse(&opts_list_02, "bool1=on,bool2=off",
+                           false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 2);
+    g_assert(qemu_opt_get_bool(opts, "bool1", false));
+    g_assert(!qemu_opt_get_bool(opts, "bool2", true));
+
+    opts = qemu_opts_parse(&opts_list_02, "bool1=offer", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+
+    qemu_opts_reset(&opts_list_02);
+}
+
+static void test_opts_parse_number(void)
+{
+    Error *err = NULL;
+    QemuOpts *opts;
+
+    /* Lower limit zero */
+    opts = qemu_opts_parse(&opts_list_01, "number1=0", false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpuint(qemu_opt_get_number(opts, "number1", 1), ==, 0);
+
+    /* Upper limit 2^64-1 */
+    opts = qemu_opts_parse(&opts_list_01,
+                           "number1=18446744073709551615,number2=-1",
+                           false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 2);
+    g_assert_cmpuint(qemu_opt_get_number(opts, "number1", 1), ==, UINT64_MAX);
+    g_assert_cmpuint(qemu_opt_get_number(opts, "number2", 0), ==, UINT64_MAX);
+
+    /* Above upper limit */
+    opts = qemu_opts_parse(&opts_list_01, "number1=18446744073709551616",
+                           false, &error_abort);
+    /* BUG: should reject */
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpuint(qemu_opt_get_number(opts, "number1", 1), ==, UINT64_MAX);
+
+    /* Below lower limit */
+    opts = qemu_opts_parse(&opts_list_01, "number1=-18446744073709551616",
+                           false, &error_abort);
+    /* BUG: should reject */
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpuint(qemu_opt_get_number(opts, "number1", 1), ==, UINT64_MAX);
+
+    /* Hex and octal */
+    opts = qemu_opts_parse(&opts_list_01, "number1=0x2a,number2=052",
+                           false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 2);
+    g_assert_cmpuint(qemu_opt_get_number(opts, "number1", 1), ==, 42);
+    g_assert_cmpuint(qemu_opt_get_number(opts, "number2", 0), ==, 42);
+
+    /* Trailing crap */
+    opts = qemu_opts_parse(&opts_list_01, "number1=3.14", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+    opts = qemu_opts_parse(&opts_list_01, "number1=08", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+
+    qemu_opts_reset(&opts_list_01);
+}
+
+static void test_opts_parse_size(void)
+{
+    Error *err = NULL;
+    QemuOpts *opts;
+
+    /* Lower limit zero */
+    opts = qemu_opts_parse(&opts_list_02, "size1=0", false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 1), ==, 0);
+
+    /* Note: precision is 53 bits since we're parsing with strtod() */
+
+    /* Around limit of precision: 2^53-1, 2^53, 2^54 */
+    opts = qemu_opts_parse(&opts_list_02,
+                           "size1=9007199254740991,"
+                           "size2=9007199254740992,"
+                           "size3=9007199254740993",
+                           false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 3);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 1),
+                     ==, 0x1fffffffffffff);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size2", 1),
+                     ==, 0x20000000000000);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size3", 1),
+                     ==, 0x20000000000000);
+
+    /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) */
+    opts = qemu_opts_parse(&opts_list_02,
+                           "size1=9223372036854774784," /* 7ffffffffffffc00 */
+                           "size2=9223372036854775295", /* 7ffffffffffffdff */
+                           false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 2);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 1),
+                     ==, 0x7ffffffffffffc00);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size2", 1),
+                     ==, 0x7ffffffffffffc00);
+
+    /* Close to actual upper limit 0xfffffffffffff800 (53 msbs set) */
+    opts = qemu_opts_parse(&opts_list_02,
+                           "size1=18446744073709549568," /* fffffffffffff800 */
+                           "size2=18446744073709550591", /* fffffffffffffbff */
+                           false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 2);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 1),
+                     ==, 0xfffffffffffff800);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size2", 1),
+                     ==, 0xfffffffffffff800);
+
+    /* Above upper limit */
+    opts = qemu_opts_parse(&opts_list_02, "size1=-1", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+    opts = qemu_opts_parse(&opts_list_02,
+                           "size1=18446744073709550592", /* fffffffffffffc00 */
+                           false, &error_abort);
+    /* BUG: should reject */
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 1), ==, 0);
+
+    /* Suffixes */
+    opts = qemu_opts_parse(&opts_list_02, "size1=8b,size2=1.5k,size3=2M",
+                           false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 3);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 0), ==, 8);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size2", 0), ==, 1536);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size3", 0), ==, 2 * M_BYTE);
+    opts = qemu_opts_parse(&opts_list_02, "size1=0.1G,size2=16777215T",
+                           false, &error_abort);
+    g_assert_cmpuint(opts_count(opts), ==, 2);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 0), ==, G_BYTE / 10);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size2", 0),
+                     ==, 16777215 * T_BYTE);
+
+    /* Beyond limit with suffix */
+    opts = qemu_opts_parse(&opts_list_02, "size1=16777216T",
+                           false, &error_abort);
+    /* BUG: should reject */
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 1), ==, 0);
+
+    /* Trailing crap */
+    opts = qemu_opts_parse(&opts_list_02, "size1=16E", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
+    opts = qemu_opts_parse(&opts_list_02, "size1=16Gi", false, &error_abort);
+    /* BUG: should reject */
+    g_assert_cmpuint(opts_count(opts), ==, 1);
+    g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 1), ==, 16 * G_BYTE);
+
+    qemu_opts_reset(&opts_list_02);
+}
+
 int main(int argc, char *argv[])
 {
     register_opts();
@@ -435,6 +721,10 @@ int main(int argc, char *argv[])
     g_test_add_func("/qemu-opts/opt_unset", test_qemu_opt_unset);
     g_test_add_func("/qemu-opts/opts_reset", test_qemu_opts_reset);
     g_test_add_func("/qemu-opts/opts_set", test_qemu_opts_set);
+    g_test_add_func("/qemu-opts/opts_parse/general", test_opts_parse);
+    g_test_add_func("/qemu-opts/opts_parse/bool", test_opts_parse_bool);
+    g_test_add_func("/qemu-opts/opts_parse/number", test_opts_parse_number);
+    g_test_add_func("/qemu-opts/opts_parse/size", test_opts_parse_size);
     g_test_run();
     return 0;
 }
-- 
2.7.4
