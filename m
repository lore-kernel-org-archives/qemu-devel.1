Received: from eggs.gnu.org ([2001:4830:134:3::10]:38841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJQ-0005r3-Qz
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJO-0003OZ-68
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJN-0003NN-Rw
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:18 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CC437FB67
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A245CACB8C
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:26:05 +0100
Message-Id: <1487067971-10443-19-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 18/24] tests/test-cutils: Use qemu_strtosz()
 more often
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use qemu_strtosz() instead of qemu_strtosz_mebi() where it doesn't
really make a difference.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-cutils.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index e28151b..ebef377 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1376,16 +1376,16 @@ static void test_qemu_strtosz_simple(void)
     int64_t res;
 
     str = "0";
-    res = qemu_strtosz_mebi(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 0);
     g_assert(endptr == str + 1);
 
     str = "12345M";
-    res = qemu_strtosz_mebi(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 12345 * M_BYTE);
     g_assert(endptr == str + 6);
 
-    res = qemu_strtosz_mebi(str, NULL);
+    res = qemu_strtosz(str, NULL);
     g_assert_cmpint(res, ==, 12345 * M_BYTE);
 
     /* Note: precision is 53 bits since we're parsing with strtod() */
@@ -1437,31 +1437,31 @@ static void test_qemu_strtosz_units(void)
     g_assert_cmpint(res, ==, M_BYTE);
     g_assert(endptr == none + 1);
 
-    res = qemu_strtosz_mebi(b, &endptr);
+    res = qemu_strtosz(b, &endptr);
     g_assert_cmpint(res, ==, 1);
     g_assert(endptr == b + 2);
 
-    res = qemu_strtosz_mebi(k, &endptr);
+    res = qemu_strtosz(k, &endptr);
     g_assert_cmpint(res, ==, K_BYTE);
     g_assert(endptr == k + 2);
 
-    res = qemu_strtosz_mebi(m, &endptr);
+    res = qemu_strtosz(m, &endptr);
     g_assert_cmpint(res, ==, M_BYTE);
     g_assert(endptr == m + 2);
 
-    res = qemu_strtosz_mebi(g, &endptr);
+    res = qemu_strtosz(g, &endptr);
     g_assert_cmpint(res, ==, G_BYTE);
     g_assert(endptr == g + 2);
 
-    res = qemu_strtosz_mebi(t, &endptr);
+    res = qemu_strtosz(t, &endptr);
     g_assert_cmpint(res, ==, T_BYTE);
     g_assert(endptr == t + 2);
 
-    res = qemu_strtosz_mebi(p, &endptr);
+    res = qemu_strtosz(p, &endptr);
     g_assert_cmpint(res, ==, P_BYTE);
     g_assert(endptr == p + 2);
 
-    res = qemu_strtosz_mebi(e, &endptr);
+    res = qemu_strtosz(e, &endptr);
     g_assert_cmpint(res, ==, E_BYTE);
     g_assert(endptr == e + 2);
 }
@@ -1472,7 +1472,7 @@ static void test_qemu_strtosz_float(void)
     char *endptr = NULL;
     int64_t res;
 
-    res = qemu_strtosz_mebi(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 12.345 * M_BYTE);
     g_assert(endptr == str + 7);
 }
@@ -1484,17 +1484,17 @@ static void test_qemu_strtosz_invalid(void)
     int64_t res;
 
     str = "";
-    res = qemu_strtosz_mebi(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -EINVAL);
     g_assert(endptr == str);
 
     str = " \t ";
-    res = qemu_strtosz_mebi(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -EINVAL);
     g_assert(endptr == str);
 
     str = "crap";
-    res = qemu_strtosz_mebi(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -EINVAL);
     g_assert(endptr == str);
 }
@@ -1511,7 +1511,7 @@ static void test_qemu_strtosz_trailing(void)
     g_assert(endptr == str + 3);
 
     str = "1kiB";
-    res = qemu_strtosz_mebi(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 1024);
     g_assert(endptr == str + 2);
 }
@@ -1523,7 +1523,7 @@ static void test_qemu_strtosz_erange(void)
     int64_t res;
 
     str = "-1";
-    res = qemu_strtosz_mebi(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
     g_assert(endptr == str + 2);
 
@@ -1543,7 +1543,7 @@ static void test_qemu_strtosz_erange(void)
     g_assert(endptr == str + 19);
 
     str = "10E";
-    res = qemu_strtosz_mebi(str, &endptr);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
     g_assert(endptr == str + 3);
 }
-- 
2.7.4
