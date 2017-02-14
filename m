Received: from eggs.gnu.org ([2001:4830:134:3::10]:38838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJQ-0005r2-Q5
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJO-0003OS-4T
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJN-0003NT-Rz
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:18 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AEBE61D30
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1EAQGvV024054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:26:17 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:26:11 +0100
Message-Id: <1487067971-10443-25-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 24/24] QemuOpts: Fix checking of sizes for
 overflow and trailing crap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

parse_option_size()'s checking for overflow and trailing crap is
wrong.  Has always been that way.  qemu_strtosz() gets it right, so
use that.

This adds support for size suffixes 'P', 'E', and ignores case for all
suffixes, not just 'k'.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qemu-opts.c | 21 +++++++++------------
 util/qemu-option.c     | 41 +++++++++++++----------------------------
 2 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 6a9d3c5..b9d5b7e 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -667,10 +667,9 @@ static void test_opts_parse_size(void)
     g_assert(!opts);
     opts = qemu_opts_parse(&opts_list_02,
                            "size1=18446744073709550592", /* fffffffffffffc00 */
-                           false, &error_abort);
-    /* BUG: should reject */
-    g_assert_cmpuint(opts_count(opts), ==, 1);
-    g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 1), ==, 0);
+                           false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
 
     /* Suffixes */
     opts = qemu_opts_parse(&opts_list_02, "size1=8b,size2=1.5k,size3=2M",
@@ -688,19 +687,17 @@ static void test_opts_parse_size(void)
 
     /* Beyond limit with suffix */
     opts = qemu_opts_parse(&opts_list_02, "size1=16777216T",
-                           false, &error_abort);
-    /* BUG: should reject */
-    g_assert_cmpuint(opts_count(opts), ==, 1);
-    g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 1), ==, 0);
+                           false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
 
     /* Trailing crap */
     opts = qemu_opts_parse(&opts_list_02, "size1=16E", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
-    opts = qemu_opts_parse(&opts_list_02, "size1=16Gi", false, &error_abort);
-    /* BUG: should reject */
-    g_assert_cmpuint(opts_count(opts), ==, 1);
-    g_assert_cmpuint(qemu_opt_get_size(opts, "size1", 1), ==, 16 * G_BYTE);
+    opts = qemu_opts_parse(&opts_list_02, "size1=16Gi", false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
 
     qemu_opts_reset(&opts_list_02);
 }
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 5d82327..c11ce93 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -174,39 +174,24 @@ static const QemuOptDesc *find_desc_by_name(const QemuOptDesc *desc,
 void parse_option_size(const char *name, const char *value,
                        uint64_t *ret, Error **errp)
 {
-    char *postfix;
-    double sizef;
+    uint64_t size;
+    int err;
 
-    sizef = strtod(value, &postfix);
-    if (sizef < 0 || sizef > UINT64_MAX) {
+    err = qemu_strtosz(value, NULL, &size);
+    if (err == -ERANGE) {
+        error_setg(errp, "Value '%s' is too large for parameter '%s'",
+                   value, name);
+        return;
+    }
+    if (err) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
                    "a non-negative number below 2^64");
+        error_append_hint(errp, "Optional suffix k, M, G, T, P or E means"
+                          " kilo-, mega-, giga-, tera-, peta-\n"
+                          "and exabytes, respectively.\n");
         return;
     }
-    switch (*postfix) {
-    case 'T':
-        sizef *= 1024;
-        /* fall through */
-    case 'G':
-        sizef *= 1024;
-        /* fall through */
-    case 'M':
-        sizef *= 1024;
-        /* fall through */
-    case 'K':
-    case 'k':
-        sizef *= 1024;
-        /* fall through */
-    case 'b':
-    case '\0':
-        *ret = (uint64_t) sizef;
-        break;
-    default:
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name, "a size");
-        error_append_hint(errp, "You may use k, M, G or T suffixes for "
-                          "kilobytes, megabytes, gigabytes and terabytes.\n");
-        return;
-    }
+    *ret = size;
 }
 
 bool has_help_option(const char *param)
-- 
2.7.4
