Received: from eggs.gnu.org ([2001:4830:134:3::10]:55115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpF-0007QC-8i
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpB-0008UZ-3g
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgGpA-0008Te-Sk
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:13 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B41C4DD49
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:14:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:13:57 +0100
Message-Id: <1487708048-2131-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1487708048-2131-1-git-send-email-armbru@redhat.com>
References: <1487708048-2131-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/24] test-cutils: Cover qemu_strtosz()
 around range limits
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-cutils.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 1773f15..df6c330 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1371,16 +1371,52 @@ static void test_qemu_strtou64_full_max(void)
 
 static void test_qemu_strtosz_simple(void)
 {
-    const char *str = "12345M";
+    const char *str;
     char *endptr = NULL;
     int64_t res;
 
+    str = "0";
+    res = qemu_strtosz(str, &endptr);
+    g_assert_cmpint(res, ==, 0);
+    g_assert(endptr == str + 1);
+
+    str = "12345M";
     res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, 12345 * M_BYTE);
     g_assert(endptr == str + 6);
 
     res = qemu_strtosz(str, NULL);
     g_assert_cmpint(res, ==, 12345 * M_BYTE);
+
+    /* Note: precision is 53 bits since we're parsing with strtod() */
+
+    str = "9007199254740991"; /* 2^53-1 */
+    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    g_assert_cmpint(res, ==, 0x1fffffffffffff);
+    g_assert(endptr == str + 16);
+
+    str = "9007199254740992"; /* 2^53 */
+    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    g_assert_cmpint(res, ==, 0x20000000000000);
+    g_assert(endptr == str + 16);
+
+    str = "9007199254740993"; /* 2^53+1 */
+    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    g_assert_cmpint(res, ==, 0x20000000000000); /* rounded to 53 bits */
+    g_assert(endptr == str + 16);
+
+    str = "9223372036854774784"; /* 0x7ffffffffffffc00 (53 msbs set) */
+    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    g_assert_cmpint(res, ==, 0x7ffffffffffffc00);
+    g_assert(endptr == str + 19);
+
+    str = "9223372036854775295"; /* 0x7ffffffffffffdff */
+    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    g_assert_cmpint(res, ==, 0x7ffffffffffffc00); /* rounded to 53 bits */
+    g_assert(endptr == str + 19);
+
+    /* 0x7ffffffffffffe00..0x7fffffffffffffff get rounded to
+     * 0x8000000000000000, thus -ERANGE; see test_qemu_strtosz_erange() */
 }
 
 static void test_qemu_strtosz_units(void)
@@ -1482,10 +1518,31 @@ static void test_qemu_strtosz_trailing(void)
 
 static void test_qemu_strtosz_erange(void)
 {
-    const char *str = "10E";
+    const char *str;
     char *endptr = NULL;
     int64_t res;
 
+    str = "-1";
+    res = qemu_strtosz(str, &endptr);
+    g_assert_cmpint(res, ==, -ERANGE);
+    g_assert(endptr == str + 2);
+
+    str = "9223372036854775296"; /* 0x7ffffffffffffe00 */
+    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    g_assert_cmpint(res, ==, -ERANGE);
+    g_assert(endptr == str + 19);
+
+    str = "9223372036854775807"; /* 2^63-1 */
+    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    g_assert_cmpint(res, ==, -ERANGE);
+    g_assert(endptr == str + 19);
+
+    str = "9223372036854775808"; /* 2^63 */
+    res = qemu_strtosz_suffix(str, &endptr, QEMU_STRTOSZ_DEFSUFFIX_B);
+    g_assert_cmpint(res, ==, -ERANGE);
+    g_assert(endptr == str + 19);
+
+    str = "10E";
     res = qemu_strtosz(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
     g_assert(endptr == str + 3);
-- 
2.7.4
