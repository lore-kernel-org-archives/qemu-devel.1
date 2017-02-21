Received: from eggs.gnu.org ([2001:4830:134:3::10]:55156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpG-0007Qa-4P
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpC-0008WM-OX
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgGpC-0008V8-FN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:14 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B109C81127
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:14:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:14:02 +0100
Message-Id: <1487708048-2131-19-git-send-email-armbru@redhat.com>
In-Reply-To: <1487708048-2131-1-git-send-email-armbru@redhat.com>
References: <1487708048-2131-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 18/24] test-cutils: Use qemu_strtosz() more
 often
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use qemu_strtosz() instead of qemu_strtosz_MiB() where it doesn't
really make a difference.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-cutils.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 9eae067..d492d1e 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1376,16 +1376,16 @@ static void test_qemu_strtosz_simple(void)
     int64_t res;
 
     str = "0";
-    res = qemu_strtosz_MiB(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 0);
     g_assert(endptr == str + 1);
 
     str = "12345M";
-    res = qemu_strtosz_MiB(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 12345 * M_BYTE);
     g_assert(endptr == str + 6);
 
-    res = qemu_strtosz_MiB(str, NULL);
+    res = qemu_strtosz(str, NULL);
     g_assert_cmpint(res, ==, 12345 * M_BYTE);
 
     /* Note: precision is 53 bits since we're parsing with strtod() */
@@ -1437,31 +1437,31 @@ static void test_qemu_strtosz_units(void)
     g_assert_cmpint(res, ==, M_BYTE);
     g_assert(endptr == none + 1);
 
-    res = qemu_strtosz_MiB(b, &endptr);
+    res = qemu_strtosz(b, &endptr);
     g_assert_cmpint(res, ==, 1);
     g_assert(endptr == b + 2);
 
-    res = qemu_strtosz_MiB(k, &endptr);
+    res = qemu_strtosz(k, &endptr);
     g_assert_cmpint(res, ==, K_BYTE);
     g_assert(endptr == k + 2);
 
-    res = qemu_strtosz_MiB(m, &endptr);
+    res = qemu_strtosz(m, &endptr);
     g_assert_cmpint(res, ==, M_BYTE);
     g_assert(endptr == m + 2);
 
-    res = qemu_strtosz_MiB(g, &endptr);
+    res = qemu_strtosz(g, &endptr);
     g_assert_cmpint(res, ==, G_BYTE);
     g_assert(endptr == g + 2);
 
-    res = qemu_strtosz_MiB(t, &endptr);
+    res = qemu_strtosz(t, &endptr);
     g_assert_cmpint(res, ==, T_BYTE);
     g_assert(endptr == t + 2);
 
-    res = qemu_strtosz_MiB(p, &endptr);
+    res = qemu_strtosz(p, &endptr);
     g_assert_cmpint(res, ==, P_BYTE);
     g_assert(endptr == p + 2);
 
-    res = qemu_strtosz_MiB(e, &endptr);
+    res = qemu_strtosz(e, &endptr);
     g_assert_cmpint(res, ==, E_BYTE);
     g_assert(endptr == e + 2);
 }
@@ -1472,7 +1472,7 @@ static void test_qemu_strtosz_float(void)
     char *endptr = NULL;
     int64_t res;
 
-    res = qemu_strtosz_MiB(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 12.345 * M_BYTE);
     g_assert(endptr == str + 7);
 }
@@ -1484,17 +1484,17 @@ static void test_qemu_strtosz_invalid(void)
     int64_t res;
 
     str = "";
-    res = qemu_strtosz_MiB(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -EINVAL);
     g_assert(endptr == str);
 
     str = " \t ";
-    res = qemu_strtosz_MiB(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -EINVAL);
     g_assert(endptr == str);
 
     str = "crap";
-    res = qemu_strtosz_MiB(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -EINVAL);
     g_assert(endptr == str);
 }
@@ -1511,7 +1511,7 @@ static void test_qemu_strtosz_trailing(void)
     g_assert(endptr == str + 3);
 
     str = "1kiB";
-    res = qemu_strtosz_MiB(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 1024);
     g_assert(endptr == str + 2);
 }
@@ -1523,7 +1523,7 @@ static void test_qemu_strtosz_erange(void)
     int64_t res;
 
     str = "-1";
-    res = qemu_strtosz_MiB(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
     g_assert(endptr == str + 2);
 
@@ -1543,7 +1543,7 @@ static void test_qemu_strtosz_erange(void)
     g_assert(endptr == str + 19);
 
     str = "10E";
-    res = qemu_strtosz_MiB(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
     g_assert(endptr == str + 3);
 }
-- 
2.7.4
