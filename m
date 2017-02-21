Received: from eggs.gnu.org ([2001:4830:134:3::10]:55169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpG-0007Qn-Cf
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpC-000051-RJ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgGpC-0008VA-Ff
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:14 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B138580465
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:14:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:14:08 +0100
Message-Id: <1487708048-2131-25-git-send-email-armbru@redhat.com>
In-Reply-To: <1487708048-2131-1-git-send-email-armbru@redhat.com>
References: <1487708048-2131-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 24/24] option: Fix checking of sizes for
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-qemu-opts.c | 21 +++++++++------------
 util/qemu-option.c     | 41 +++++++++++++----------------------------
 2 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 47f287f..dad419d 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -684,10 +684,9 @@ static void test_opts_parse_size(void)
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
@@ -705,19 +704,17 @@ static void test_opts_parse_size(void)
 
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
index 273d00d..419f252 100644
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
