Received: from eggs.gnu.org ([2001:4830:134:3::10]:38813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJQ-0005qr-2x
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJM-0003Me-It
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJM-0003LW-8x
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:16 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70D97C04B950
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1EAQFuc001976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:26:16 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:26:00 +0100
Message-Id: <1487067971-10443-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 13/24] tests/test-cutils: Cover qemu_strtosz()
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
---
 tests/test-cutils.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index ec65d27..af52ac5 100644
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
