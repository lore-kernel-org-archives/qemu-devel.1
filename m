Received: from eggs.gnu.org ([2001:4830:134:3::10]:55026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpC-0007Po-IC
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGp9-0008Sz-CF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgGp9-0008Sa-3R
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:11 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B16C3B721
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:14:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:13:48 +0100
Message-Id: <1487708048-2131-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1487708048-2131-1-git-send-email-armbru@redhat.com>
References: <1487708048-2131-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/24] test-cutils: Clean up qemu_strtoul()
 result checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use unsigned comparisons to check the result of qemu_strtoul() and
strtoull().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-cutils.c | 60 ++++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 71681dc..749aaa9 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -523,7 +523,7 @@ static void test_qemu_strtoul_correct(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 12345);
+    g_assert_cmpuint(res, ==, 12345);
     g_assert(endptr == str + 5);
 }
 
@@ -593,7 +593,7 @@ static void test_qemu_strtoul_trailing(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert(endptr == str + 3);
 }
 
@@ -608,7 +608,7 @@ static void test_qemu_strtoul_octal(void)
     err = qemu_strtoul(str, &endptr, 8, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0123);
+    g_assert_cmpuint(res, ==, 0123);
     g_assert(endptr == str + strlen(str));
 
     res = 999;
@@ -616,7 +616,7 @@ static void test_qemu_strtoul_octal(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0123);
+    g_assert_cmpuint(res, ==, 0123);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -631,7 +631,7 @@ static void test_qemu_strtoul_decimal(void)
     err = qemu_strtoul(str, &endptr, 10, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert(endptr == str + strlen(str));
 
     str = "123";
@@ -640,7 +640,7 @@ static void test_qemu_strtoul_decimal(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -655,7 +655,7 @@ static void test_qemu_strtoul_hex(void)
     err = qemu_strtoul(str, &endptr, 16, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0x123);
+    g_assert_cmphex(res, ==, 0x123);
     g_assert(endptr == str + strlen(str));
 
     str = "0x123";
@@ -664,7 +664,7 @@ static void test_qemu_strtoul_hex(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0x123);
+    g_assert_cmphex(res, ==, 0x123);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -679,7 +679,7 @@ static void test_qemu_strtoul_max(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, ULONG_MAX);
+    g_assert_cmphex(res, ==, ULONG_MAX);
     g_assert(endptr == str + strlen(str));
     g_free(str);
 }
@@ -695,7 +695,7 @@ static void test_qemu_strtoul_overflow(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, ULONG_MAX);
+    g_assert_cmphex(res, ==, ULONG_MAX);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -710,7 +710,7 @@ static void test_qemu_strtoul_underflow(void)
     err  = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, -1ul);
+    g_assert_cmpuint(res, ==, -1ul);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -725,7 +725,7 @@ static void test_qemu_strtoul_negative(void)
     err = qemu_strtoul(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, -321ul);
+    g_assert_cmpuint(res, ==, -321ul);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -738,7 +738,7 @@ static void test_qemu_strtoul_full_correct(void)
     err = qemu_strtoul(str, NULL, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
 }
 
 static void test_qemu_strtoul_full_null(void)
@@ -769,7 +769,7 @@ static void test_qemu_strtoul_full_negative(void)
 
     err = qemu_strtoul(str, NULL, 0, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, -321ul);
+    g_assert_cmpuint(res, ==, -321ul);
 }
 
 static void test_qemu_strtoul_full_trailing(void)
@@ -792,7 +792,7 @@ static void test_qemu_strtoul_full_max(void)
     err = qemu_strtoul(str, NULL, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, ULONG_MAX);
+    g_assert_cmphex(res, ==, ULONG_MAX);
     g_free(str);
 }
 
@@ -1094,7 +1094,7 @@ static void test_qemu_strtoull_correct(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 12345);
+    g_assert_cmpuint(res, ==, 12345);
     g_assert(endptr == str + 5);
 }
 
@@ -1164,7 +1164,7 @@ static void test_qemu_strtoull_trailing(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert(endptr == str + 3);
 }
 
@@ -1179,7 +1179,7 @@ static void test_qemu_strtoull_octal(void)
     err = qemu_strtoull(str, &endptr, 8, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0123);
+    g_assert_cmpuint(res, ==, 0123);
     g_assert(endptr == str + strlen(str));
 
     endptr = &f;
@@ -1187,7 +1187,7 @@ static void test_qemu_strtoull_octal(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0123);
+    g_assert_cmpuint(res, ==, 0123);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -1202,7 +1202,7 @@ static void test_qemu_strtoull_decimal(void)
     err = qemu_strtoull(str, &endptr, 10, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert(endptr == str + strlen(str));
 
     str = "123";
@@ -1211,7 +1211,7 @@ static void test_qemu_strtoull_decimal(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -1226,7 +1226,7 @@ static void test_qemu_strtoull_hex(void)
     err = qemu_strtoull(str, &endptr, 16, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0x123);
+    g_assert_cmphex(res, ==, 0x123);
     g_assert(endptr == str + strlen(str));
 
     str = "0x123";
@@ -1235,7 +1235,7 @@ static void test_qemu_strtoull_hex(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0x123);
+    g_assert_cmphex(res, ==, 0x123);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -1250,7 +1250,7 @@ static void test_qemu_strtoull_max(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, ULLONG_MAX);
+    g_assert_cmphex(res, ==, ULLONG_MAX);
     g_assert(endptr == str + strlen(str));
     g_free(str);
 }
@@ -1266,7 +1266,7 @@ static void test_qemu_strtoull_overflow(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, ULLONG_MAX);
+    g_assert_cmphex(res, ==, ULLONG_MAX);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -1281,7 +1281,7 @@ static void test_qemu_strtoull_underflow(void)
     err  = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, -1);
+    g_assert_cmphex(res, ==, -1ull);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -1296,7 +1296,7 @@ static void test_qemu_strtoull_negative(void)
     err = qemu_strtoull(str, &endptr, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, -321);
+    g_assert_cmpuint(res, ==, -321ull);
     g_assert(endptr == str + strlen(str));
 }
 
@@ -1309,7 +1309,7 @@ static void test_qemu_strtoull_full_correct(void)
     err = qemu_strtoull(str, NULL, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 18446744073709551614LLU);
+    g_assert_cmpuint(res, ==, 18446744073709551614ull);
 }
 
 static void test_qemu_strtoull_full_null(void)
@@ -1342,7 +1342,7 @@ static void test_qemu_strtoull_full_negative(void)
     err = qemu_strtoull(str, NULL, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 18446744073709551295LLU);
+    g_assert_cmpuint(res, ==, -321ull);
 }
 
 static void test_qemu_strtoull_full_trailing(void)
@@ -1365,7 +1365,7 @@ static void test_qemu_strtoull_full_max(void)
     err = qemu_strtoull(str, NULL, 0, &res);
 
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, ULLONG_MAX);
+    g_assert_cmphex(res, ==, ULLONG_MAX);
     g_free(str);
 }
 
-- 
2.7.4
