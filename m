Received: from eggs.gnu.org ([2001:4830:134:3::10]:41857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZgO3-0007RB-7M
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZgO2-0007SM-0C
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:06:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZgO1-0007SD-Nv
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:06:57 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEC9A83F40
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 16:06:57 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  3 Feb 2017 16:06:50 +0000
Message-Id: <20170203160651.19917-4-dgilbert@redhat.com>
In-Reply-To: <20170203160651.19917-1-dgilbert@redhat.com>
References: <20170203160651.19917-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] tests/migration: Add test for
 VMSTATE_WITH_TMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a test for VMSTATE_WITH_TMP to tests/test-vmstate.c

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/test-vmstate.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index 9d87faf..d0dd390 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -90,7 +90,7 @@ static void save_buffer(const uint8_t *buf, size_t buf_size)
     qemu_fclose(fsave);
 }
 
-static void compare_vmstate(uint8_t *wire, size_t size)
+static void compare_vmstate(const uint8_t *wire, size_t size)
 {
     QEMUFile *f = open_test_file(false);
     uint8_t result[size];
@@ -113,7 +113,7 @@ static void compare_vmstate(uint8_t *wire, size_t size)
 }
 
 static int load_vmstate_one(const VMStateDescription *desc, void *obj,
-                            int version, uint8_t *wire, size_t size)
+                            int version, const uint8_t *wire, size_t size)
 {
     QEMUFile *f;
     int ret;
@@ -137,7 +137,7 @@ static int load_vmstate_one(const VMStateDescription *desc, void *obj,
 static int load_vmstate(const VMStateDescription *desc,
                         void *obj, void *obj_clone,
                         void (*obj_copy)(void *, void*),
-                        int version, uint8_t *wire, size_t size)
+                        int version, const uint8_t *wire, size_t size)
 {
     /* We test with zero size */
     obj_copy(obj_clone, obj);
@@ -289,7 +289,6 @@ static void test_simple_primitive(void)
     FIELD_EQUAL(i64_1);
     FIELD_EQUAL(i64_2);
 }
-#undef FIELD_EQUAL
 
 typedef struct TestStruct {
     uint32_t a, b, c, e;
@@ -474,7 +473,6 @@ static void test_load_skip(void)
     qemu_fclose(loading);
 }
 
-
 typedef struct {
     int32_t i;
 } TestStructTriv;
@@ -688,6 +686,94 @@ static void test_load_q(void)
     qemu_fclose(fload);
 }
 
+typedef struct TmpTestStruct {
+    TestStruct *parent;
+    int64_t diff;
+} TmpTestStruct;
+
+static void tmp_child_pre_save(void *opaque)
+{
+    struct TmpTestStruct *tts = opaque;
+
+    tts->diff = tts->parent->b - tts->parent->a;
+}
+
+static int tmp_child_post_load(void *opaque, int version_id)
+{
+    struct TmpTestStruct *tts = opaque;
+
+    tts->parent->b = tts->parent->a + tts->diff;
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_tmp_back_to_parent = {
+    .name = "test/tmp_child_parent",
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(f, TestStruct),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_tmp_child = {
+    .name = "test/tmp_child",
+    .pre_save = tmp_child_pre_save,
+    .post_load = tmp_child_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT64(diff, TmpTestStruct),
+        VMSTATE_STRUCT_POINTER(parent, TmpTestStruct,
+                               vmstate_tmp_back_to_parent, TestStruct),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_with_tmp = {
+    .name = "test/with_tmp",
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(a, TestStruct),
+        VMSTATE_UINT64(d, TestStruct),
+        VMSTATE_WITH_TMP(TestStruct, TmpTestStruct, vmstate_tmp_child),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void obj_tmp_copy(void *target, void *source)
+{
+    memcpy(target, source, sizeof(TestStruct));
+}
+
+static void test_tmp_struct(void)
+{
+    TestStruct obj, obj_clone;
+
+    uint8_t const wire_with_tmp[] = {
+        /* u32 a */ 0x00, 0x00, 0x00, 0x02,
+        /* u64 d */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+        /* diff  */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02,
+        /* u64 f */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08,
+        QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely */
+    };
+
+    memset(&obj, 0, sizeof(obj));
+    obj.a = 2;
+    obj.b = 4;
+    obj.d = 1;
+    obj.f = 8;
+    save_vmstate(&vmstate_with_tmp, &obj);
+
+    compare_vmstate(wire_with_tmp, sizeof(wire_with_tmp));
+
+    memset(&obj, 0, sizeof(obj));
+    SUCCESS(load_vmstate(&vmstate_with_tmp, &obj, &obj_clone,
+                         obj_tmp_copy, 1, wire_with_tmp,
+                         sizeof(wire_with_tmp)));
+    g_assert_cmpint(obj.a, ==, 2); /* From top level vmsd */
+    g_assert_cmpint(obj.b, ==, 4); /* from the post_load */
+    g_assert_cmpint(obj.d, ==, 1); /* From top level vmsd */
+    g_assert_cmpint(obj.f, ==, 8); /* From the child->parent */
+}
+
 int main(int argc, char **argv)
 {
     temp_fd = mkstemp(temp_file);
@@ -708,7 +794,7 @@ int main(int argc, char **argv)
                     test_arr_ptr_str_no0_load);
     g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
     g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
-
+    g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
     g_test_run();
 
     close(temp_fd);
-- 
2.9.3
