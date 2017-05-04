Received: from eggs.gnu.org ([2001:4830:134:3::10]:56865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d651x-0001WX-Bs
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d651w-00061e-Ms
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:05 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d651w-00061G-Gy
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:04 -0400
Received: by mail-pf0-x242.google.com with SMTP id d1so720583pfe.1
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 17:54:04 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Thu,  4 May 2017 09:53:23 +0900
Message-Id: <b75c958d888f3c973bae6c6471edacf53fb27182.1493858877.git.shorne@gmail.com>
In-Reply-To: <cover.1493858877.git.shorne@gmail.com>
References: <cover.1493858877.git.shorne@gmail.com>
In-Reply-To: <cover.1493858877.git.shorne@gmail.com>
References: <cover.1493858877.git.shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 08/11] migration: Add VMSTATE_STRUCT_2DARRAY()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stafford Horne <shorne@gmail.com>

For openrisc we implement tlb state as a 2d array of tlb entry structs.
This is added to allow easy storing of state of 2d arrays.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 include/migration/vmstate.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f2dbf84..4834e55 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -499,6 +499,19 @@ extern const VMStateInfo vmstate_info_qtailq;
     .offset       = vmstate_offset_array(_state, _field, _type, _num),\
 }
 
+#define VMSTATE_STRUCT_2DARRAY_TEST(_field, _state, _n1, _n2, _test, \
+                                    _version, _vmsd, _type) {        \
+    .name         = (stringify(_field)),                             \
+    .num          = (_n1) * (_n2),                                   \
+    .field_exists = (_test),                                         \
+    .version_id   = (_version),                                      \
+    .vmsd         = &(_vmsd),                                        \
+    .size         = sizeof(_type),                                   \
+    .flags        = VMS_STRUCT | VMS_ARRAY,                          \
+    .offset       = vmstate_offset_2darray(_state, _field, _type,    \
+                                           _n1, _n2),                \
+}
+
 #define VMSTATE_STRUCT_VARRAY_UINT8(_field, _state, _field_num, _version, _vmsd, _type) { \
     .name       = (stringify(_field)),                               \
     .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
@@ -746,6 +759,11 @@ extern const VMStateInfo vmstate_info_qtailq;
     VMSTATE_STRUCT_ARRAY_TEST(_field, _state, _num, NULL, _version,   \
             _vmsd, _type)
 
+#define VMSTATE_STRUCT_2DARRAY(_field, _state, _n1, _n2, _version,    \
+            _vmsd, _type)                                             \
+    VMSTATE_STRUCT_2DARRAY_TEST(_field, _state, _n1, _n2, NULL,       \
+            _version, _vmsd, _type)
+
 #define VMSTATE_BUFFER_UNSAFE_INFO(_field, _state, _version, _info, _size) \
     VMSTATE_BUFFER_UNSAFE_INFO_TEST(_field, _state, NULL, _version, _info, \
             _size)
-- 
2.9.3
