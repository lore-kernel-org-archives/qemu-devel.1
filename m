Received: from eggs.gnu.org ([209.51.188.92]:40994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvW-00076e-Sf
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvW-0005YW-3t
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmKvV-0005Y5-SW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:54 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 23 Jan 2019 15:58:28 +0000
Message-Id: <20190123155830.8459-8-dgilbert@redhat.com>
In-Reply-To: <20190123155830.8459-1-dgilbert@redhat.com>
References: <20190123155830.8459-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/9] tests: add /vmstate/simple/array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, xiaoguangrong@tencent.com, marcandre.lureau@redhat.com, shirley17fei@gmail.com, lifei1214@126.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

A very simple test to show VMSTATE_*_ARRAY usage and result. It could
be systematically extended to other primitives, but I leave that as an
exercise for others :).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181114132130.27141-1-marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/test-vmstate.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index 0ab29a8216..fc8ce62471 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -284,6 +284,55 @@ static void test_simple_primitive(void)
     FIELD_EQUAL(i64_2);
 }
=20
+typedef struct TestSimpleArray {
+    uint16_t u16_1[3];
+} TestSimpleArray;
+
+/* Object instantiation, we are going to use it in more than one test */
+
+TestSimpleArray obj_simple_arr =3D {
+    .u16_1 =3D { 0x42, 0x43, 0x44 },
+};
+
+/* Description of the values.  If you add a primitive type
+   you are expected to add a test here */
+
+static const VMStateDescription vmstate_simple_arr =3D {
+    .name =3D "simple/array",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT16_ARRAY(u16_1, TestSimpleArray, 3),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+uint8_t wire_simple_arr[] =3D {
+    /* u16_1 */ 0x00, 0x42,
+    /* u16_1 */ 0x00, 0x43,
+    /* u16_1 */ 0x00, 0x44,
+    QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely=
 */
+};
+
+static void obj_simple_arr_copy(void *target, void *source)
+{
+    memcpy(target, source, sizeof(TestSimpleArray));
+}
+
+static void test_simple_array(void)
+{
+    TestSimpleArray obj, obj_clone;
+
+    memset(&obj, 0, sizeof(obj));
+    save_vmstate(&vmstate_simple_arr, &obj_simple_arr);
+
+    compare_vmstate(wire_simple_arr, sizeof(wire_simple_arr));
+
+    SUCCESS(load_vmstate(&vmstate_simple_arr, &obj, &obj_clone,
+                         obj_simple_arr_copy, 1, wire_simple_arr,
+                         sizeof(wire_simple_arr)));
+}
+
 typedef struct TestStruct {
     uint32_t a, b, c, e;
     uint64_t d, f;
@@ -863,6 +912,7 @@ int main(int argc, char **argv)
=20
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/vmstate/simple/primitive", test_simple_primitive);
+    g_test_add_func("/vmstate/simple/array", test_simple_array);
     g_test_add_func("/vmstate/versioned/load/v1", test_load_v1);
     g_test_add_func("/vmstate/versioned/load/v2", test_load_v2);
     g_test_add_func("/vmstate/field_exists/load/noskip", test_load_noski=
p);
--=20
2.20.1
