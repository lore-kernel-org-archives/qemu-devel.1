Received: from eggs.gnu.org ([2001:4830:134:3::10]:39960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5d-00082Z-48
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5a-0000EW-GE
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih5a-0000EG-7h
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:10 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:34 +0000
Message-Id: <20170228124056.5074-6-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 05/27] tests/test-vmstate.c: test array of ptr
 with null
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

Add test for VMSTATE_ARRAY_OF_POINTER_TO_STRUCT with an array
containing some null pointer.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170222160119.52771-5-pasic@linux.vnet.ibm.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
   Fixed type case in assert to uintptr_t rather than uint64_t
---
 tests/test-vmstate.c | 74 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 17 deletions(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index 39f338a..2e20756 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -476,6 +476,8 @@ const VMStateDescription vmsd_tst = {
     }
 };
 
+/* test array migration */
+
 #define AR_SIZE 4
 
 typedef struct {
@@ -492,20 +494,22 @@ const VMStateDescription vmsd_arps = {
         VMSTATE_END_OF_LIST()
     }
 };
+
+static uint8_t wire_arr_ptr_no0[] = {
+    0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x01,
+    0x00, 0x00, 0x00, 0x02,
+    0x00, 0x00, 0x00, 0x03,
+    QEMU_VM_EOF
+};
+
 static void test_arr_ptr_str_no0_save(void)
 {
     TestStructTriv ar[AR_SIZE] = {{.i = 0}, {.i = 1}, {.i = 2}, {.i = 3} };
     TestArrayOfPtrToStuct sample = {.ar = {&ar[0], &ar[1], &ar[2], &ar[3]} };
-    uint8_t wire_sample[] = {
-        0x00, 0x00, 0x00, 0x00,
-        0x00, 0x00, 0x00, 0x01,
-        0x00, 0x00, 0x00, 0x02,
-        0x00, 0x00, 0x00, 0x03,
-        QEMU_VM_EOF
-    };
 
     save_vmstate(&vmsd_arps, &sample);
-    compare_vmstate(wire_sample, sizeof(wire_sample));
+    compare_vmstate(wire_arr_ptr_no0, sizeof(wire_arr_ptr_no0));
 }
 
 static void test_arr_ptr_str_no0_load(void)
@@ -514,21 +518,54 @@ static void test_arr_ptr_str_no0_load(void)
     TestStructTriv ar[AR_SIZE] = {};
     TestArrayOfPtrToStuct obj = {.ar = {&ar[0], &ar[1], &ar[2], &ar[3]} };
     int idx;
-    uint8_t wire_sample[] = {
-        0x00, 0x00, 0x00, 0x00,
-        0x00, 0x00, 0x00, 0x01,
-        0x00, 0x00, 0x00, 0x02,
-        0x00, 0x00, 0x00, 0x03,
-        QEMU_VM_EOF
-    };
 
-    save_buffer(wire_sample, sizeof(wire_sample));
+    save_buffer(wire_arr_ptr_no0, sizeof(wire_arr_ptr_no0));
+    SUCCESS(load_vmstate_one(&vmsd_arps, &obj, 1,
+                          wire_arr_ptr_no0, sizeof(wire_arr_ptr_no0)));
+    for (idx = 0; idx < AR_SIZE; ++idx) {
+        /* compare the target array ar with the ground truth array ar_gt */
+        g_assert_cmpint(ar_gt[idx].i, ==, ar[idx].i);
+    }
+}
+
+static uint8_t wire_arr_ptr_0[] = {
+    0x00, 0x00, 0x00, 0x00,
+    VMS_NULLPTR_MARKER,
+    0x00, 0x00, 0x00, 0x02,
+    0x00, 0x00, 0x00, 0x03,
+    QEMU_VM_EOF
+};
+
+static void test_arr_ptr_str_0_save(void)
+{
+    TestStructTriv ar[AR_SIZE] = {{.i = 0}, {.i = 1}, {.i = 2}, {.i = 3} };
+    TestArrayOfPtrToStuct sample = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
+
+    save_vmstate(&vmsd_arps, &sample);
+    compare_vmstate(wire_arr_ptr_0, sizeof(wire_arr_ptr_0));
+}
+
+static void test_arr_ptr_str_0_load(void)
+{
+    TestStructTriv ar_gt[AR_SIZE] = {{.i = 0}, {.i = 0}, {.i = 2}, {.i = 3} };
+    TestStructTriv ar[AR_SIZE] = {};
+    TestArrayOfPtrToStuct obj = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
+    int idx;
+
+    save_buffer(wire_arr_ptr_0, sizeof(wire_arr_ptr_0));
     SUCCESS(load_vmstate_one(&vmsd_arps, &obj, 1,
-                          wire_sample, sizeof(wire_sample)));
+                          wire_arr_ptr_0, sizeof(wire_arr_ptr_0)));
     for (idx = 0; idx < AR_SIZE; ++idx) {
         /* compare the target array ar with the ground truth array ar_gt */
         g_assert_cmpint(ar_gt[idx].i, ==, ar[idx].i);
     }
+    for (idx = 0; idx < AR_SIZE; ++idx) {
+        if (idx == 1) {
+            g_assert_cmpint((uintptr_t)(obj.ar[idx]), ==, 0);
+        } else {
+            g_assert_cmpint((uintptr_t)(obj.ar[idx]), !=, 0);
+        }
+    }
 }
 
 /* test QTAILQ migration */
@@ -781,6 +818,9 @@ int main(int argc, char **argv)
                     test_arr_ptr_str_no0_save);
     g_test_add_func("/vmstate/array/ptr/str/no0/load",
                     test_arr_ptr_str_no0_load);
+    g_test_add_func("/vmstate/array/ptr/str/0/save", test_arr_ptr_str_0_save);
+    g_test_add_func("/vmstate/array/ptr/str/0/load",
+                    test_arr_ptr_str_0_load);
     g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
     g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
     g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
-- 
2.9.3
