Received: from eggs.gnu.org ([2001:4830:134:3::10]:38790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJP-0005qo-O5
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJM-0003MT-Gd
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJM-0003LU-6A
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:16 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D7FA85540
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1EAQFES003176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:26:16 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:25:57 +0100
Message-Id: <1487067971-10443-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 10/24] tests/test-cutils: Add missing
 qemu_strtosz()... endptr checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-cutils.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 47cc8a4..2dc6832 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1393,60 +1393,75 @@ static void test_qemu_strtosz_units(void)
     const char *t = "1T";
     const char *p = "1P";
     const char *e = "1E";
+    char *endptr = NULL;
     int64_t res;
 
     /* default is M */
-    res = qemu_strtosz(none, NULL);
+    res = qemu_strtosz(none, &endptr);
     g_assert_cmpint(res, ==, M_BYTE);
+    g_assert(endptr == none + 1);
 
-    res = qemu_strtosz(b, NULL);
+    res = qemu_strtosz(b, &endptr);
     g_assert_cmpint(res, ==, 1);
+    g_assert(endptr == b + 2);
 
-    res = qemu_strtosz(k, NULL);
+    res = qemu_strtosz(k, &endptr);
     g_assert_cmpint(res, ==, K_BYTE);
+    g_assert(endptr == k + 2);
 
-    res = qemu_strtosz(m, NULL);
+    res = qemu_strtosz(m, &endptr);
     g_assert_cmpint(res, ==, M_BYTE);
+    g_assert(endptr == m + 2);
 
-    res = qemu_strtosz(g, NULL);
+    res = qemu_strtosz(g, &endptr);
     g_assert_cmpint(res, ==, G_BYTE);
+    g_assert(endptr == g + 2);
 
-    res = qemu_strtosz(t, NULL);
+    res = qemu_strtosz(t, &endptr);
     g_assert_cmpint(res, ==, T_BYTE);
+    g_assert(endptr == t + 2);
 
-    res = qemu_strtosz(p, NULL);
+    res = qemu_strtosz(p, &endptr);
     g_assert_cmpint(res, ==, P_BYTE);
+    g_assert(endptr == p + 2);
 
-    res = qemu_strtosz(e, NULL);
+    res = qemu_strtosz(e, &endptr);
     g_assert_cmpint(res, ==, E_BYTE);
+    g_assert(endptr == e + 2);
 }
 
 static void test_qemu_strtosz_float(void)
 {
     const char *str = "12.345M";
+    char *endptr = NULL;
     int64_t res;
 
-    res = qemu_strtosz(str, NULL);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 12.345 * M_BYTE);
+    g_assert(endptr == str + 7);
 }
 
 static void test_qemu_strtosz_erange(void)
 {
     const char *str = "10E";
+    char *endptr = NULL;
     int64_t res;
 
-    res = qemu_strtosz(str, NULL);
+    res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
+    g_assert(endptr == str + 3);
 }
 
 static void test_qemu_strtosz_suffix_unit(void)
 {
     const char *str = "12345";
+    char *endptr = NULL;
     int64_t res;
 
-    res = qemu_strtosz_suffix_unit(str, NULL,
+    res = qemu_strtosz_suffix_unit(str, &endptr,
                                    QEMU_STRTOSZ_DEFSUFFIX_KB, 1000);
     g_assert_cmpint(res, ==, 12345000);
+    g_assert(endptr == str + 5);
 }
 
 int main(int argc, char **argv)
-- 
2.7.4
