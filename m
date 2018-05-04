Received: from eggs.gnu.org ([2001:4830:134:3::10]:33968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV5u-0004Ic-Tc
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV5s-00073T-S9
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:30 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 May 2018 09:25:01 +0200
Message-Id: <20180504072514.8450-3-cohuck@redhat.com>
In-Reply-To: <20180504072514.8450-1-cohuck@redhat.com>
References: <20180504072514.8450-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/15] s390x/sclp: extend SCLP event masks to 64
 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

Extend the SCLP event masks to 64 bits.

Notice that using any of the new bits results in a state that cannot be
migrated to an older version.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Message-Id: <1520507069-22179-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/event-facility.c         | 50 ++++++++++++++++++++++++++++++++-------
 include/hw/s390x/event-facility.h |  2 +-
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 9c24bc6f7c..0dea6cccae 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -26,11 +26,23 @@ typedef struct SCLPEventsBus {
     BusState qbus;
 } SCLPEventsBus;
 
+/* we need to save 32 bit chunks for compatibility */
+#ifdef HOST_WORDS_BIGENDIAN
+#define RECV_MASK_LOWER 1
+#define RECV_MASK_UPPER 0
+#else /* little endian host */
+#define RECV_MASK_LOWER 0
+#define RECV_MASK_UPPER 1
+#endif
+
 struct SCLPEventFacility {
     SysBusDevice parent_obj;
     SCLPEventsBus sbus;
     /* guest's receive mask */
-    sccb_mask_t receive_mask;
+    union {
+        uint32_t receive_mask_pieces[2];
+        sccb_mask_t receive_mask;
+    };
     /*
      * when false, we keep the same broken, backwards compatible behaviour as
      * before, allowing only masks of size exactly 4; when true, we implement
@@ -262,7 +274,7 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
     case SCLP_SELECTIVE_READ:
         copy_mask((uint8_t *)&sclp_active_selection_mask, (uint8_t *)&red->mask,
                   sizeof(sclp_active_selection_mask), ef->mask_length);
-        sclp_active_selection_mask = be32_to_cpu(sclp_active_selection_mask);
+        sclp_active_selection_mask = be64_to_cpu(sclp_active_selection_mask);
         if (!sclp_cp_receive_mask ||
             (sclp_active_selection_mask & ~sclp_cp_receive_mask)) {
             sccb->h.response_code =
@@ -294,21 +306,22 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
     }
 
     /*
-     * Note: We currently only support masks up to 4 byte length;
-     *       the remainder is filled up with zeroes. Linux uses
-     *       a 4 byte mask length.
+     * Note: We currently only support masks up to 8 byte length;
+     *       the remainder is filled up with zeroes. Older Linux
+     *       kernels use a 4 byte mask length, newer ones can use both
+     *       8 or 4 depending on what is available on the host.
      */
 
     /* keep track of the guest's capability masks */
     copy_mask((uint8_t *)&tmp_mask, WEM_CP_RECEIVE_MASK(we_mask, mask_length),
               sizeof(tmp_mask), mask_length);
-    ef->receive_mask = be32_to_cpu(tmp_mask);
+    ef->receive_mask = be64_to_cpu(tmp_mask);
 
     /* return the SCLP's capability masks to the guest */
-    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
+    tmp_mask = cpu_to_be64(get_host_receive_mask(ef));
     copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
               mask_length, sizeof(tmp_mask));
-    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
+    tmp_mask = cpu_to_be64(get_host_send_mask(ef));
     copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
               mask_length, sizeof(tmp_mask));
 
@@ -369,6 +382,13 @@ static void command_handler(SCLPEventFacility *ef, SCCB *sccb, uint64_t code)
     }
 }
 
+static bool vmstate_event_facility_mask64_needed(void *opaque)
+{
+    SCLPEventFacility *ef = opaque;
+
+    return (ef->receive_mask & 0xFFFFFFFF) != 0;
+}
+
 static bool vmstate_event_facility_mask_length_needed(void *opaque)
 {
     SCLPEventFacility *ef = opaque;
@@ -376,6 +396,17 @@ static bool vmstate_event_facility_mask_length_needed(void *opaque)
     return ef->allow_all_mask_sizes;
 }
 
+static const VMStateDescription vmstate_event_facility_mask64 = {
+    .name = "vmstate-event-facility/mask64",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = vmstate_event_facility_mask64_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(receive_mask_pieces[RECV_MASK_LOWER], SCLPEventFacility),
+        VMSTATE_END_OF_LIST()
+     }
+};
+
 static const VMStateDescription vmstate_event_facility_mask_length = {
     .name = "vmstate-event-facility/mask_length",
     .version_id = 0,
@@ -392,10 +423,11 @@ static const VMStateDescription vmstate_event_facility = {
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(receive_mask, SCLPEventFacility),
+        VMSTATE_UINT32(receive_mask_pieces[RECV_MASK_UPPER], SCLPEventFacility),
         VMSTATE_END_OF_LIST()
      },
     .subsections = (const VMStateDescription * []) {
+        &vmstate_event_facility_mask64,
         &vmstate_event_facility_mask_length,
         NULL
      }
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index 5698e5e96c..8b39a80bb9 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -73,7 +73,7 @@ typedef struct WriteEventMask {
 #define WEM_RECEIVE_MASK(wem, mask_len) ((wem)->masks + 2 * (mask_len))
 #define WEM_SEND_MASK(wem, mask_len) ((wem)->masks + 3 * (mask_len))
 
-typedef uint32_t sccb_mask_t;
+typedef uint64_t sccb_mask_t;
 
 typedef struct EventBufferHeader {
     uint16_t length;
-- 
2.14.3
