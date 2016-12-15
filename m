Received: from eggs.gnu.org ([2001:4830:134:3::10]:42653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBy-0003I7-7s
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBv-0001Lu-6Y
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBu-0001LD-S1
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:35 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0haB8129121
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:33 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdkw90nu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:33 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:32 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:28 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-35-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 34/67] tests/test-qmp-input-strict: Cover
 missing struct members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

These tests would have caught the bug fixed by the previous commit.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1475594630-24758-1-git-send-email-armbru@redhat.com>
(cherry picked from commit bce3035a44c40bd3ec29d3162025fd350f2d8dbf)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/test-qmp-input-strict.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/test-qmp-input-strict.c b/tests/test-qmp-input-strict.c
index 814550a..d87f8b8 100644
--- a/tests/test-qmp-input-strict.c
+++ b/tests/test-qmp-input-strict.c
@@ -193,6 +193,50 @@ static void test_validate_fail_struct_nested(TestInputVisitorData *data,
     g_assert(!udp);
 }
 
+static void test_validate_fail_struct_missing(TestInputVisitorData *data,
+                                              const void *unused)
+{
+    Error *err = NULL;
+    Visitor *v;
+    QObject *any;
+    GenericAlternate *alt;
+    bool present;
+    int en;
+    int64_t i64;
+    uint32_t u32;
+    int8_t i8;
+    char *str;
+    double dbl;
+
+    v = validate_test_init(data, "{}");
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_start_struct(v, "struct", NULL, 0, &err);
+    error_free_or_abort(&err);
+    visit_start_list(v, "list", NULL, 0, &err);
+    error_free_or_abort(&err);
+    visit_start_alternate(v, "alternate", &alt, sizeof(*alt), false, &err);
+    error_free_or_abort(&err);
+    visit_optional(v, "optional", &present);
+    g_assert(!present);
+    visit_type_enum(v, "enum", &en, EnumOne_lookup, &err);
+    error_free_or_abort(&err);
+    visit_type_int(v, "i64", &i64, &err);
+    error_free_or_abort(&err);
+    visit_type_uint32(v, "u32", &u32, &err);
+    error_free_or_abort(&err);
+    visit_type_int8(v, "i8", &i8, &err);
+    error_free_or_abort(&err);
+    visit_type_str(v, "i8", &str, &err);
+    error_free_or_abort(&err);
+    visit_type_number(v, "dbl", &dbl, &err);
+    error_free_or_abort(&err);
+    visit_type_any(v, "any", &any, &err);
+    error_free_or_abort(&err);
+    visit_type_null(v, "null", &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+}
+
 static void test_validate_fail_list(TestInputVisitorData *data,
                                      const void *unused)
 {
@@ -316,6 +360,8 @@ int main(int argc, char **argv)
                       &testdata, test_validate_fail_struct);
     validate_test_add("/visitor/input-strict/fail/struct-nested",
                       &testdata, test_validate_fail_struct_nested);
+    validate_test_add("/visitor/input-strict/fail/struct-missing",
+                      &testdata, test_validate_fail_struct_missing);
     validate_test_add("/visitor/input-strict/fail/list",
                       &testdata, test_validate_fail_list);
     validate_test_add("/visitor/input-strict/fail/union-flat",
-- 
1.9.1
