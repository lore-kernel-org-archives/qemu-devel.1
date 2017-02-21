Received: from eggs.gnu.org ([2001:4830:134:3::10]:55023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpC-0007Pm-HG
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpA-0008Tx-S9
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgGpA-0008TR-MG
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:12 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7E5942BA0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:14:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:13:56 +0100
Message-Id: <1487708048-2131-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1487708048-2131-1-git-send-email-armbru@redhat.com>
References: <1487708048-2131-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/24] test-cutils: Cover qemu_strtosz()
 with trailing crap
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
 tests/test-cutils.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index dc8cd8d..1773f15 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1463,6 +1463,23 @@ static void test_qemu_strtosz_invalid(void)
     g_assert(endptr == str);
 }
 
+static void test_qemu_strtosz_trailing(void)
+{
+    const char *str;
+    char *endptr = NULL;
+    int64_t res;
+
+    str = "123xxx";
+    res = qemu_strtosz(str, &endptr);
+    g_assert_cmpint(res, ==, 123 * M_BYTE);
+    g_assert(endptr == str + 3);
+
+    str = "1kiB";
+    res = qemu_strtosz(str, &endptr);
+    g_assert_cmpint(res, ==, 1024);
+    g_assert(endptr == str + 2);
+}
+
 static void test_qemu_strtosz_erange(void)
 {
     const char *str = "10E";
@@ -1676,6 +1693,8 @@ int main(int argc, char **argv)
                     test_qemu_strtosz_float);
     g_test_add_func("/cutils/strtosz/invalid",
                     test_qemu_strtosz_invalid);
+    g_test_add_func("/cutils/strtosz/trailing",
+                    test_qemu_strtosz_trailing);
     g_test_add_func("/cutils/strtosz/erange",
                     test_qemu_strtosz_erange);
     g_test_add_func("/cutils/strtosz/suffix-unit",
-- 
2.7.4
