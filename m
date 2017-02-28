Received: from eggs.gnu.org ([2001:4830:134:3::10]:39963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5d-000831-Eg
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5c-0000Ey-G5
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih5c-0000Eh-7p
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:12 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:35 +0000
Message-Id: <20170228124056.5074-7-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 06/27] tests/test-vmstate.c: test array of ptr
 to primitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, danielhb@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, ashijeetacharya@gmail.com

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Let's have a test for ptr arrays to some primitive type with some
not-null and null ptrs intermixed.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Message-Id: <20170222160119.52771-6-pasic@linux.vnet.ibm.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/test-vmstate.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index 2e20756..f694a89 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -568,6 +568,50 @@ static void test_arr_ptr_str_0_load(void)
     }
 }
 
+typedef struct TestArrayOfPtrToInt {
+    int32_t *ar[AR_SIZE];
+} TestArrayOfPtrToInt;
+
+const VMStateDescription vmsd_arpp = {
+    .name = "test/arps",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_ARRAY_OF_POINTER(ar, TestArrayOfPtrToInt,
+                AR_SIZE, 0, vmstate_info_int32, int32_t*),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void test_arr_ptr_prim_0_save(void)
+{
+    int32_t ar[AR_SIZE] = {0 , 1, 2, 3};
+    TestArrayOfPtrToInt  sample = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
+
+    save_vmstate(&vmsd_arpp, &sample);
+    compare_vmstate(wire_arr_ptr_0, sizeof(wire_arr_ptr_0));
+}
+
+static void test_arr_ptr_prim_0_load(void)
+{
+    int32_t ar_gt[AR_SIZE] = {0, 1, 2, 3};
+    int32_t ar[AR_SIZE] = {3 , 42, 1, 0};
+    TestArrayOfPtrToInt obj = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
+    int idx;
+
+    save_buffer(wire_arr_ptr_0, sizeof(wire_arr_ptr_0));
+    SUCCESS(load_vmstate_one(&vmsd_arpp, &obj, 1,
+                          wire_arr_ptr_0, sizeof(wire_arr_ptr_0)));
+    for (idx = 0; idx < AR_SIZE; ++idx) {
+        /* compare the target array ar with the ground truth array ar_gt */
+        if (idx == 1) {
+            g_assert_cmpint(42, ==, ar[idx]);
+        } else {
+            g_assert_cmpint(ar_gt[idx], ==, ar[idx]);
+        }
+    }
+}
+
 /* test QTAILQ migration */
 typedef struct TestQtailqElement TestQtailqElement;
 
@@ -821,6 +865,10 @@ int main(int argc, char **argv)
     g_test_add_func("/vmstate/array/ptr/str/0/save", test_arr_ptr_str_0_save);
     g_test_add_func("/vmstate/array/ptr/str/0/load",
                     test_arr_ptr_str_0_load);
+    g_test_add_func("/vmstate/array/ptr/prim/0/save",
+                    test_arr_ptr_prim_0_save);
+    g_test_add_func("/vmstate/array/ptr/prim/0/load",
+                    test_arr_ptr_prim_0_load);
     g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
     g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
     g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
-- 
2.9.3
