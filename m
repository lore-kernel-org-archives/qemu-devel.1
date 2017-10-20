Received: from eggs.gnu.org ([2001:4830:134:3::10]:59422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuP-0003Tv-EE
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuO-0003ui-1W
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:13 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:06 +0200
Message-Id: <20171020115418.2050-35-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 34/46] s390x/event-facility: variable-length
 event masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cornelia.huck@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

The architecture supports masks of variable length for sclp write
event mask. We currently only support 4 byte event masks, as that
is what Linux uses.

Let's extend this to the maximum mask length supported by the
architecture and return 0 to the guest for the mask bits we don't
support in core.

Initial patch by: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Message-Id: <1507729193-9747-1-git-send-email-jjherne@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/event-facility.c         | 35 +++++++++++++++++++++++++++++------
 include/hw/s390x/event-facility.h | 20 ++++++++++++++++----
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 34b2faf013..b0f71f4554 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -259,23 +259,46 @@ out:
     return;
 }
 
+/* copy up to dst_len bytes and fill the rest of dst with zeroes */
+static void copy_mask(uint8_t *dst, uint8_t *src, uint16_t dst_len,
+                      uint16_t src_len)
+{
+    int i;
+
+    for (i = 0; i < dst_len; i++) {
+        dst[i] = i < src_len ? src[i] : 0;
+    }
+}
+
 static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
 {
     WriteEventMask *we_mask = (WriteEventMask *) sccb;
+    uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
+    uint32_t tmp_mask;
 
-    /* Attention: We assume that Linux uses 4-byte masks, what it actually
-       does. Architecture allows for masks of variable size, though */
-    if (be16_to_cpu(we_mask->mask_length) != 4) {
+    if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX)) {
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_MASK_LENGTH);
         goto out;
     }
 
+    /*
+     * Note: We currently only support masks up to 4 byte length;
+     *       the remainder is filled up with zeroes. Linux uses
+     *       a 4 byte mask length.
+     */
+
     /* keep track of the guest's capability masks */
-    ef->receive_mask = be32_to_cpu(we_mask->cp_receive_mask);
+    copy_mask((uint8_t *)&tmp_mask, WEM_CP_RECEIVE_MASK(we_mask, mask_length),
+              sizeof(tmp_mask), mask_length);
+    ef->receive_mask = be32_to_cpu(tmp_mask);
 
     /* return the SCLP's capability masks to the guest */
-    we_mask->send_mask = cpu_to_be32(get_host_send_mask(ef));
-    we_mask->receive_mask = cpu_to_be32(get_host_receive_mask(ef));
+    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
+    copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
+              mask_length, sizeof(tmp_mask));
+    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
+    copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
+              mask_length, sizeof(tmp_mask));
 
     sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_COMPLETION);
 
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index def1bb0c03..5119b9b7f0 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -49,16 +49,28 @@
 #define TYPE_SCLP_CPU_HOTPLUG "sclp-cpu-hotplug"
 #define TYPE_SCLP_QUIESCE "sclpquiesce"
 
+#define SCLP_EVENT_MASK_LEN_MAX 1021
+
 typedef struct WriteEventMask {
     SCCBHeader h;
     uint16_t _reserved;
     uint16_t mask_length;
-    uint32_t cp_receive_mask;
-    uint32_t cp_send_mask;
-    uint32_t receive_mask;
-    uint32_t send_mask;
+    uint8_t masks[];
+/*
+ * Layout of the masks is
+ *  uint8_t cp_receive_mask[mask_length];
+ *  uint8_t cp_send_mask[mask_length];
+ *  uint8_t receive_mask[mask_length];
+ *  uint8_t send_mask[mask_length];
+ * where 1 <= mask_length <= SCLP_EVENT_MASK_LEN_MAX
+ */
 } QEMU_PACKED WriteEventMask;
 
+#define WEM_CP_RECEIVE_MASK(wem, mask_len) ((wem)->masks)
+#define WEM_CP_SEND_MASK(wem, mask_len) ((wem)->masks + (mask_len))
+#define WEM_RECEIVE_MASK(wem, mask_len) ((wem)->masks + 2 * (mask_len))
+#define WEM_SEND_MASK(wem, mask_len) ((wem)->masks + 3 * (mask_len))
+
 typedef struct EventBufferHeader {
     uint16_t length;
     uint8_t  type;
-- 
2.13.6
