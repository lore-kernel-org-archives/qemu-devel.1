Received: from eggs.gnu.org ([2001:4830:134:3::10]:56060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d2QCF-0000cy-99
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d2QCC-0000Y4-SR
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:41:35 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:34182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d2QCC-0000Xw-Nv
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:41:32 -0400
Received: by mail-it0-x241.google.com with SMTP id c26so4021211itd.1
	for <qemu-devel@nongnu.org>; Sun, 23 Apr 2017 15:41:32 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon, 24 Apr 2017 07:40:55 +0900
Message-Id: <565b9678ec7335762a290afce68f7062bdaf0ce9.1492986468.git.shorne@gmail.com>
In-Reply-To: <cover.1492986468.git.shorne@gmail.com>
References: <cover.1492986468.git.shorne@gmail.com>
In-Reply-To: <cover.1492986468.git.shorne@gmail.com>
References: <cover.1492986468.git.shorne@gmail.com>
Subject: [Qemu-devel] [PATCH v2 7/9] migration: Add VMSTATE_STRUCT_2DARRAY()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Openrisc <openrisc@lists.librecores.org>, "Tim \\'mithro\\' Ansell" <mithro@mithis.com>, Stafford Horne <shorne@gmail.com>

For openrisc we implement tlb state as a 2d array of tlb entry structs.
This is added to allow easy storing of state of 2d arrays.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 include/migration/vmstate.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f2dbf84..9b7dcdc 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -499,6 +499,17 @@ extern const VMStateInfo vmstate_info_qtailq;
     .offset       = vmstate_offset_array(_state, _field, _type, _num),\
 }
 
+#define VMSTATE_STRUCT_2DARRAY_TEST(_field, _state, _n1, _n2, _test, _version, _vmsd, _type) { \
+    .name         = (stringify(_field)),                                    \
+    .num          = (_n1) * (_n2),                                          \
+    .field_exists = (_test),                                                \
+    .version_id   = (_version),                                             \
+    .vmsd         = &(_vmsd),                                               \
+    .size         = sizeof(_type),                                          \
+    .flags        = VMS_STRUCT|VMS_ARRAY,                                   \
+    .offset       = vmstate_offset_2darray(_state, _field, _type, _n1, _n2),\
+}
+
 #define VMSTATE_STRUCT_VARRAY_UINT8(_field, _state, _field_num, _version, _vmsd, _type) { \
     .name       = (stringify(_field)),                               \
     .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
@@ -746,6 +757,10 @@ extern const VMStateInfo vmstate_info_qtailq;
     VMSTATE_STRUCT_ARRAY_TEST(_field, _state, _num, NULL, _version,   \
             _vmsd, _type)
 
+#define VMSTATE_STRUCT_2DARRAY(_field, _state, _n1, _n2, _version, _vmsd, _type) \
+    VMSTATE_STRUCT_2DARRAY_TEST(_field, _state, _n1, _n2, NULL, _version,   \
+            _vmsd, _type)
+
 #define VMSTATE_BUFFER_UNSAFE_INFO(_field, _state, _version, _info, _size) \
     VMSTATE_BUFFER_UNSAFE_INFO_TEST(_field, _state, NULL, _version, _info, \
             _size)
-- 
2.9.3
