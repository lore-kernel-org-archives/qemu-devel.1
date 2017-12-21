Received: from eggs.gnu.org ([2001:4830:134:3::10]:50668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRq2O-0006nN-H6
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRq2N-0001uK-Hn
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:52:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eRq2N-0001tk-Az
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:52:43 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 21 Dec 2017 09:52:34 +0800
Message-Id: <20171221015234.9912-3-famz@redhat.com>
In-Reply-To: <20171221015234.9912-1-famz@redhat.com>
References: <20171221015234.9912-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] util: add is_equal to UUID API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Roman Kagan <rkagan@virtuozzo.com>

It's going to be useful, in particular, in VMBus code massively using
uuids aka GUIDs.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20171127124355.26015-1-rkagan@virtuozzo.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/qemu/uuid.h | 2 ++
 tests/test-uuid.c   | 8 +++++++-
 util/uuid.c         | 7 ++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

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
index d3a2791fd4..22b4b0727d 100644
--- a/tests/test-uuid.c
+++ b/tests/test-uuid.c
@@ -93,12 +93,18 @@ static inline bool uuid_is_valid(QemuUUID *uuid)
 
 static void test_uuid_generate(void)
 {
+    QemuUUID uuid_not_null = { { {
+        0x58, 0x6e, 0xce, 0x27, 0x7f, 0x09, 0x41, 0xe0,
+        0x9e, 0x74, 0xe9, 0x01, 0x31, 0x7e, 0x9d, 0x42
+    } } };
     QemuUUID uuid;
     int i;
 
     for (i = 0; i < 100; ++i) {
         qemu_uuid_generate(&uuid);
         g_assert(uuid_is_valid(&uuid));
+        g_assert_false(qemu_uuid_is_null(&uuid));
+        g_assert_false(qemu_uuid_is_equal(&uuid_not_null, &uuid));
     }
 }
 
@@ -168,8 +174,8 @@ static void test_uuid_unparse_strdup(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
-    g_test_add_func("/uuid/generate", test_uuid_generate);
     g_test_add_func("/uuid/is_null", test_uuid_is_null);
+    g_test_add_func("/uuid/generate", test_uuid_generate);
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
