Received: from eggs.gnu.org ([2001:4830:134:3::10]:39746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgzSs-0001xv-FU
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgzSp-0000nt-BO
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgzSp-0000mX-2s
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:07 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28E467E9D5
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 19:54:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1NJs5Q1029929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:54:06 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Feb 2017 20:53:47 +0100
Message-Id: <1487879642-16139-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1487879642-16139-1-git-send-email-armbru@redhat.com>
References: <1487879642-16139-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 09/24] option: Fix to reject invalid and
 overflowing numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

parse_option_number() fails to check for these errors after
strtoull().  Has always been broken.  Fix that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1487708048-2131-10-git-send-email-armbru@redhat.com>
---
 tests/test-qemu-opts.c | 19 ++++++++-----------
 util/qemu-option.c     | 11 ++++++++---
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 310485b..8b92f7b 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -603,17 +603,15 @@ static void test_opts_parse_number(void)
 
     /* Above upper limit */
     opts = qemu_opts_parse(&opts_list_01, "number1=18446744073709551616",
-                           false, &error_abort);
-    /* BUG: should reject */
-    g_assert_cmpuint(opts_count(opts), ==, 1);
-    g_assert_cmpuint(qemu_opt_get_number(opts, "number1", 1), ==, UINT64_MAX);
+                           false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
 
     /* Below lower limit */
     opts = qemu_opts_parse(&opts_list_01, "number1=-18446744073709551616",
-                           false, &error_abort);
-    /* BUG: should reject */
-    g_assert_cmpuint(opts_count(opts), ==, 1);
-    g_assert_cmpuint(qemu_opt_get_number(opts, "number1", 1), ==, UINT64_MAX);
+                           false, &err);
+    error_free_or_abort(&err);
+    g_assert(!opts);
 
     /* Hex and octal */
     opts = qemu_opts_parse(&opts_list_01, "number1=0x2a,number2=052",
@@ -624,9 +622,8 @@ static void test_opts_parse_number(void)
 
     /* Invalid */
     opts = qemu_opts_parse(&opts_list_01, "number1=", false, &err);
-    /* BUG: should reject */
-    g_assert_cmpuint(opts_count(opts), ==, 1);
-    g_assert_cmpuint(qemu_opt_get_number(opts, "number1", 1), ==, 0);
+    error_free_or_abort(&err);
+    g_assert(!opts);
     opts = qemu_opts_parse(&opts_list_01, "number1=eins", false, &err);
     error_free_or_abort(&err);
     g_assert(!opts);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 9708668..273d00d 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -141,11 +141,16 @@ static void parse_option_bool(const char *name, const char *value, bool *ret,
 static void parse_option_number(const char *name, const char *value,
                                 uint64_t *ret, Error **errp)
 {
-    char *postfix;
     uint64_t number;
+    int err;
 
-    number = strtoull(value, &postfix, 0);
-    if (*postfix != '\0') {
+    err = qemu_strtou64(value, NULL, 0, &number);
+    if (err == -ERANGE) {
+        error_setg(errp, "Value '%s' is too large for parameter '%s'",
+                   value, name);
+        return;
+    }
+    if (err) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name, "a number");
         return;
     }
-- 
2.7.4
