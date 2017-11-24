Received: from eggs.gnu.org ([2001:4830:134:3::10]:32987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eIF1j-0003Ow-34
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eIF1f-0002Hb-Vp
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:32:23 -0500
Received: from mail-he1eur01on0113.outbound.protection.outlook.com
	([104.47.0.113]:47053
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eIF1f-0002H9-8E
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:32:19 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 24 Nov 2017 17:32:06 +0300
Message-Id: <20171124143206.28833-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] util: add is_equal to UUID API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>

It's going to be useful, in particular, in VMBus code massively using
uuids aka GUIDs.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 include/qemu/uuid.h |  2 ++
 tests/test-uuid.c   | 24 ++++++++++++++++++++++++
 util/uuid.c         |  7 ++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index afe4840296..09489ce5c5 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -48,6 +48,8 @@ void qemu_uuid_generate(QemuUUID *out);
 
 int qemu_uuid_is_null(const QemuUUID *uu);
 
+int qemu_uuid_is_equal(const QemuUUID *lhv, const QemuUUID *rhv);
+
 void qemu_uuid_unparse(const QemuUUID *uuid, char *out);
 
 char *qemu_uuid_unparse_strdup(const QemuUUID *uuid);
diff --git a/tests/test-uuid.c b/tests/test-uuid.c
index d3a2791fd4..c6c8148117 100644
--- a/tests/test-uuid.c
+++ b/tests/test-uuid.c
@@ -116,6 +116,29 @@ static void test_uuid_is_null(void)
     g_assert_false(qemu_uuid_is_null(&uuid_not_null_2));
 }
 
+static void test_uuid_is_equal(void)
+{
+    int i;
+    QemuUUID uuid;
+    QemuUUID uuid_null = { };
+    QemuUUID uuid_not_null = { { {
+        0x58, 0x6e, 0xce, 0x27, 0x7f, 0x09, 0x41, 0xe0,
+        0x9e, 0x74, 0xe9, 0x01, 0x31, 0x7e, 0x9d, 0x42
+    } } };
+    QemuUUID uuid_null_2 = uuid_null;
+    QemuUUID uuid_not_null_2 = uuid_not_null;
+
+    g_assert(qemu_uuid_is_equal(&uuid_null, &uuid_null_2));
+    g_assert(qemu_uuid_is_equal(&uuid_not_null, &uuid_not_null_2));
+    g_assert_false(qemu_uuid_is_equal(&uuid_null, &uuid_not_null));
+
+    for (i = 0; i < 100; ++i) {
+        qemu_uuid_generate(&uuid);
+        g_assert_false(qemu_uuid_is_equal(&uuid_null, &uuid));
+        g_assert_false(qemu_uuid_is_equal(&uuid_not_null, &uuid));
+    }
+}
+
 static void test_uuid_parse(void)
 {
     int i, r;
@@ -170,6 +193,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/uuid/generate", test_uuid_generate);
     g_test_add_func("/uuid/is_null", test_uuid_is_null);
+    g_test_add_func("/uuid/is_equal", test_uuid_is_equal);
     g_test_add_func("/uuid/parse", test_uuid_parse);
     g_test_add_func("/uuid/unparse", test_uuid_unparse);
     g_test_add_func("/uuid/unparse_strdup", test_uuid_unparse_strdup);
diff --git a/util/uuid.c b/util/uuid.c
index dd6b5fdf05..ebf06c049a 100644
--- a/util/uuid.c
+++ b/util/uuid.c
@@ -41,7 +41,12 @@ void qemu_uuid_generate(QemuUUID *uuid)
 int qemu_uuid_is_null(const QemuUUID *uu)
 {
     static QemuUUID null_uuid;
-    return memcmp(uu, &null_uuid, sizeof(QemuUUID)) == 0;
+    return qemu_uuid_is_equal(uu, &null_uuid);
+}
+
+int qemu_uuid_is_equal(const QemuUUID *lhv, const QemuUUID *rhv)
+{
+    return memcmp(lhv, rhv, sizeof(QemuUUID)) == 0;
 }
 
 void qemu_uuid_unparse(const QemuUUID *uuid, char *out)
-- 
2.14.3
