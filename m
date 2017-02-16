Received: from eggs.gnu.org ([2001:4830:134:3::10]:43266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ceKv4-0000dc-MH
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ceKv1-0002ny-BZ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:12:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ceKv1-0002kv-1z
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:12:15 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1GC3i9l021256
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 07:12:14 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28n7cquh5m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 07:12:13 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 16 Feb 2017 12:12:10 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2017 13:11:39 +0100
In-Reply-To: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
References: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170216121140.9061-5-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/5] tests/test-vmstate.c: test array of ptr
 with null
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

Add test for VMSTATE_ARRAY_OF_POINTER_TO_STRUCT with an array
containing some null pointer.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/test-vmstate.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index d0dd390..b68a0b3 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -487,6 +487,8 @@ const VMStateDescription vmsd_tst = {
     }
 };
 
+/* test array migration */
+
 #define AR_SIZE 4
 
 typedef struct {
@@ -542,6 +544,52 @@ static void test_arr_ptr_str_no0_load(void)
     }
 }
 
+static void test_arr_ptr_str_0_save(void)
+{
+    TestStructTriv ar[AR_SIZE] = {{.i = 0}, {.i = 1}, {.i = 2}, {.i = 3} };
+    TestArrayOfPtrToStuct sample = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
+    uint8_t wire_sample[] = {
+        0x00, 0x00, 0x00, 0x00,
+        VMS_NULLPTR_MARKER,
+        0x00, 0x00, 0x00, 0x02,
+        0x00, 0x00, 0x00, 0x03,
+        QEMU_VM_EOF
+    };
+
+    save_vmstate(&vmsd_arps, &sample);
+    compare_vmstate(wire_sample, sizeof(wire_sample));
+}
+
+static void test_arr_ptr_str_0_load(void)
+{
+    TestStructTriv ar_gt[AR_SIZE] = {{.i = 0}, {.i = 0}, {.i = 2}, {.i = 3} };
+    TestStructTriv ar[AR_SIZE] = {};
+    TestArrayOfPtrToStuct obj = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
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
+    SUCCESS(load_vmstate_one(&vmsd_arps, &obj, 1,
+                          wire_sample, sizeof(wire_sample)));
+    for (idx = 0; idx < AR_SIZE; ++idx) {
+        /* compare the target array ar with the ground truth array ar_gt */
+        g_assert_cmpint(ar_gt[idx].i, ==, ar[idx].i);
+    }
+    for (idx = 0; idx < AR_SIZE; ++idx) {
+        if (idx == 1) {
+            g_assert_cmpint((uint64_t)(obj.ar[idx]), ==, 0);
+        } else {
+            g_assert_cmpint((uint64_t)(obj.ar[idx]), !=, 0);
+        }
+    }
+}
+
 /* test QTAILQ migration */
 typedef struct TestQtailqElement TestQtailqElement;
 
@@ -792,6 +840,9 @@ int main(int argc, char **argv)
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
2.8.4
