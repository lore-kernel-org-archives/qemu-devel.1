Received: from eggs.gnu.org ([2001:4830:134:3::10]:43274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ceKv6-0000kb-N7
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ceKv0-0002mS-OS
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:12:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40860
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ceKv0-0002kh-IS
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:12:14 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1GC3a4e030407
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 07:12:14 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28n6ua4k4s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 07:12:13 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 16 Feb 2017 12:12:12 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2017 13:11:40 +0100
In-Reply-To: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
References: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170216121140.9061-6-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 5/5] tests/test-vmstate.c: test array of ptr to
 primitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

Let's have a test for ptr arrays to some primitive type with some
not-null and null ptrs intermixed.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

---

Mainly for the sake of completeness and also to demonstrate that it works
since in the previous version I wrongly stated it does not. If guys think
we do not need this, I'm happy with just dropping it.
---
 tests/test-vmstate.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index b68a0b3..82ab743 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -590,6 +590,64 @@ static void test_arr_ptr_str_0_load(void)
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
+    uint8_t wire_sample[] = {
+        0x00, 0x00, 0x00, 0x00,
+        VMS_NULLPTR_MARKER,
+        0x00, 0x00, 0x00, 0x02,
+        0x00, 0x00, 0x00, 0x03,
+        QEMU_VM_EOF
+    };
+
+    save_vmstate(&vmsd_arpp, &sample);
+    compare_vmstate(wire_sample, sizeof(wire_sample));
+}
+
+static void test_arr_ptr_prim_0_load(void)
+{
+    int32_t ar_gt[AR_SIZE] = {0, 1, 2, 3};
+    int32_t ar[AR_SIZE] = {3 , 42, 1, 0};
+    TestArrayOfPtrToInt obj = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
+    int idx;
+    uint8_t wire_sample[] = {
+        0x00, 0x00, 0x00, 0x00,
+        VMS_NULLPTR_MARKER,
+        0x00, 0x00, 0x00, 0x02,
+        0x00, 0x00, 0x00, 0x03,
+        QEMU_VM_EOF
+    };
+
+    save_buffer(wire_sample, sizeof(wire_sample));
+    SUCCESS(load_vmstate_one(&vmsd_arpp, &obj, 1,
+                          wire_sample, sizeof(wire_sample)));
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
 
@@ -843,6 +901,10 @@ int main(int argc, char **argv)
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
2.8.4
