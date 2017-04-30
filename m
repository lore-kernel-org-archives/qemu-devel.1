Received: from eggs.gnu.org ([2001:4830:134:3::10]:60465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3c-00025d-Fk
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3b-0006g4-4p
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:12 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d4y3a-0006fT-Vw
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:11 -0400
Received: by mail-pf0-x244.google.com with SMTP id g23so25781712pfj.1
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 16:15:10 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  1 May 2017 08:14:22 +0900
Message-Id: <565b9678ec7335762a290afce68f7062bdaf0ce9.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
Subject: [Qemu-devel] [PULL 08/11] migration: Add VMSTATE_STRUCT_2DARRAY()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: QEMU Development <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

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
