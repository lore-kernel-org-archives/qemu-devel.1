Received: from eggs.gnu.org ([2001:4830:134:3::10]:55022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpC-0007Pl-Gq
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpA-0008Tr-P1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgGpA-0008TO-J9
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:12 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8E54811A7
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:14:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:13:55 +0100
Message-Id: <1487708048-2131-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1487708048-2131-1-git-send-email-armbru@redhat.com>
References: <1487708048-2131-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/24] test-cutils: Cover qemu_strtosz()
 invalid input
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
 tests/test-cutils.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index a3eb182..dc8cd8d 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1441,6 +1441,28 @@ static void test_qemu_strtosz_float(void)
     g_assert(endptr == str + 7);
 }
 
+static void test_qemu_strtosz_invalid(void)
+{
+    const char *str;
+    char *endptr = NULL;
+    int64_t res;
+
+    str = "";
+    res = qemu_strtosz(str, &endptr);
+    g_assert_cmpint(res, ==, -EINVAL);
+    g_assert(endptr == str);
+
+    str = " \t ";
+    res = qemu_strtosz(str, &endptr);
+    g_assert_cmpint(res, ==, -EINVAL);
+    g_assert(endptr == str);
+
+    str = "crap";
+    res = qemu_strtosz(str, &endptr);
+    g_assert_cmpint(res, ==, -EINVAL);
+    g_assert(endptr == str);
+}
+
 static void test_qemu_strtosz_erange(void)
 {
     const char *str = "10E";
@@ -1652,6 +1674,8 @@ int main(int argc, char **argv)
                     test_qemu_strtosz_units);
     g_test_add_func("/cutils/strtosz/float",
                     test_qemu_strtosz_float);
+    g_test_add_func("/cutils/strtosz/invalid",
+                    test_qemu_strtosz_invalid);
     g_test_add_func("/cutils/strtosz/erange",
                     test_qemu_strtosz_erange);
     g_test_add_func("/cutils/strtosz/suffix-unit",
-- 
2.7.4
