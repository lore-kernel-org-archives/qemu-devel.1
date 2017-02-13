Received: from eggs.gnu.org ([2001:4830:134:3::10]:39170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKmA-0003gX-T4
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKm7-0005yl-D2
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdKm7-0005yf-7L
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:55 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 13 Feb 2017 17:50:30 +0000
Message-Id: <20170213175033.7314-12-dgilbert@redhat.com>
In-Reply-To: <20170213175033.7314-1-dgilbert@redhat.com>
References: <20170213175033.7314-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 11/14] migration: Add
 VMSTATE_UNUSED_VARRAY_UINT32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, ashijeetacharya@gmail.com, amit@kernel.org, pbutsykin@virtuozzo.com, zhang.zhanghailiang@huawei.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

VMSTATE_UNUSED_VARRAY_UINT32 is used to skip a chunk of the stream
that's an n-element array;  note the array size and the dynamic value
read never get multiplied so there's no overflow risk.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170203160651.19917-2-dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/vmstate.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 39db47e..7339594 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -658,6 +658,17 @@ extern const VMStateInfo vmstate_info_qtailq;
     .flags        = VMS_BUFFER,                                      \
 }
 
+/* Discard size * field_num bytes, where field_num is a uint32 member */
+#define VMSTATE_UNUSED_VARRAY_UINT32(_state, _test, _version, _field_num, _size) {\
+    .name         = "unused",                                        \
+    .field_exists = (_test),                                         \
+    .num_offset   = vmstate_offset_value(_state, _field_num, uint32_t),\
+    .version_id   = (_version),                                      \
+    .size         = (_size),                                         \
+    .info         = &vmstate_info_unused_buffer,                     \
+    .flags        = VMS_VARRAY_UINT32 | VMS_BUFFER,                  \
+}
+
 /* _field_size should be a int32_t field in the _state struct giving the
  * size of the bitmap _field in bits.
  */
-- 
2.9.3
