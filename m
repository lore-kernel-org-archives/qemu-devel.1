Received: from eggs.gnu.org ([2001:4830:134:3::10]:40502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuO-0005XJ-Fc
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuM-00067o-Cx
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:52 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  8 Mar 2018 19:04:20 +0100
Message-Id: <20180308180423.941-9-cohuck@redhat.com>
In-Reply-To: <20180308180423.941-1-cohuck@redhat.com>
References: <20180308180423.941-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 08/11] s390x/sclp: proper support of larger send
 and receive masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

Until 67915de9f0383ccf4a ("s390x/event-facility: variable-length event masks")
we only supported sclp event masks with a size of exactly 4 bytes, even
though the architecture allows the guests to set up sclp event masks
from 1 to 1021 bytes in length.
After that patch, the behaviour was almost compliant, but some issues
were still remaining, in particular regarding the handling of selective
reads and migration.

When setting the sclp event mask, a mask size is also specified. Until
now we only considered the size in order to decide which bits to save
in the internal state. On the other hand, when a guest performs a
selective read, it sends a mask, but it does not specify a size; the
implied size is the size of the last mask that has been set.

Specifying bits in the mask of selective read that are not available in
the internal mask should return an error, and bits past the end of the
mask should obviously be ignored. This can only be achieved by keeping
track of the lenght of the mask.

The mask length is thus now part of the internal state that needs to be
migrated.

This patch fixes the handling of selective reads, whose size will now
match the length of the event mask, as per architecture.

While the default behaviour is to be compliant with the architecture,
when using older machine models the old broken behaviour is selected
(allowing only masks of size exactly 4), in order to be able to migrate
toward older versions.

Fixes: 67915de9f0383ccf4a ("s390x/event-facility: variable-length event masks")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Message-Id: <1519407778-23095-2-git-send-email-imbrenda@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/event-facility.c  | 81 ++++++++++++++++++++++++++++++++++++++--------
 hw/s390x/s390-virtio-ccw.c |  8 ++++-
 2 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 79de3c738f..feef6f788c 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -31,6 +31,15 @@ struct SCLPEventFacility {
     SCLPEventsBus sbus;
     /* guest' receive mask */
     unsigned int receive_mask;
+    /*
+     * when false, we keep the same broken, backwards compatible behaviour as
+     * before, allowing only masks of size exactly 4; when true, we implement
+     * the architecture correctly, allowing all valid mask sizes. Needed for
+     * migration toward older versions.
+     */
+    bool allow_all_mask_sizes;
+    /* length of the receive mask */
+    uint16_t mask_length;
 };
 
 /* return true if any child has event pending set */
@@ -220,6 +229,17 @@ static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
     return rc;
 }
 
+/* copy up to src_len bytes and fill the rest of dst with zeroes */
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
 static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
 {
     unsigned int sclp_active_selection_mask;
@@ -240,7 +260,9 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
         sclp_active_selection_mask = sclp_cp_receive_mask;
         break;
     case SCLP_SELECTIVE_READ:
-        sclp_active_selection_mask = be32_to_cpu(red->mask);
+        copy_mask((uint8_t *)&sclp_active_selection_mask, (uint8_t *)&red->mask,
+                  sizeof(sclp_active_selection_mask), ef->mask_length);
+        sclp_active_selection_mask = be32_to_cpu(sclp_active_selection_mask);
         if (!sclp_cp_receive_mask ||
             (sclp_active_selection_mask & ~sclp_cp_receive_mask)) {
             sccb->h.response_code =
@@ -259,24 +281,14 @@ out:
     return;
 }
 
-/* copy up to dst_len bytes and fill the rest of dst with zeroes */
-static void copy_mask(uint8_t *dst, uint8_t *src, uint16_t dst_len,
-                      uint16_t src_len)
-{
-    int i;
-
-    for (i = 0; i < dst_len; i++) {
-        dst[i] = i < src_len ? src[i] : 0;
-    }
-}
-
 static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
 {
     WriteEventMask *we_mask = (WriteEventMask *) sccb;
     uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
     uint32_t tmp_mask;
 
-    if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX)) {
+    if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX) ||
+        ((mask_length != 4) && !ef->allow_all_mask_sizes)) {
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_MASK_LENGTH);
         goto out;
     }
@@ -301,6 +313,7 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
               mask_length, sizeof(tmp_mask));
 
     sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_COMPLETION);
+    ef->mask_length = mask_length;
 
 out:
     return;
@@ -356,6 +369,24 @@ static void command_handler(SCLPEventFacility *ef, SCCB *sccb, uint64_t code)
     }
 }
 
+static bool vmstate_event_facility_mask_length_needed(void *opaque)
+{
+    SCLPEventFacility *ef = opaque;
+
+    return ef->allow_all_mask_sizes;
+}
+
+static const VMStateDescription vmstate_event_facility_mask_length = {
+    .name = "vmstate-event-facility/mask_length",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = vmstate_event_facility_mask_length_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(mask_length, SCLPEventFacility),
+        VMSTATE_END_OF_LIST()
+     }
+};
+
 static const VMStateDescription vmstate_event_facility = {
     .name = "vmstate-event-facility",
     .version_id = 0,
@@ -363,15 +394,39 @@ static const VMStateDescription vmstate_event_facility = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(receive_mask, SCLPEventFacility),
         VMSTATE_END_OF_LIST()
+     },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_event_facility_mask_length,
+        NULL
      }
 };
 
+static void sclp_event_set_allow_all_mask_sizes(Object *obj, bool value,
+                                                       Error **errp)
+{
+    SCLPEventFacility *ef = (SCLPEventFacility *)obj;
+
+    ef->allow_all_mask_sizes = value;
+}
+
+static bool sclp_event_get_allow_all_mask_sizes(Object *obj, Error **e)
+{
+    SCLPEventFacility *ef = (SCLPEventFacility *)obj;
+
+    return ef->allow_all_mask_sizes;
+}
+
 static void init_event_facility(Object *obj)
 {
     SCLPEventFacility *event_facility = EVENT_FACILITY(obj);
     DeviceState *sdev = DEVICE(obj);
     Object *new;
 
+    event_facility->mask_length = 4;
+    event_facility->allow_all_mask_sizes = true;
+    object_property_add_bool(obj, "allow_all_mask_sizes",
+                             sclp_event_get_allow_all_mask_sizes,
+                             sclp_event_set_allow_all_mask_sizes, NULL);
     /* Spawn a new bus for SCLP events */
     qbus_create_inplace(&event_facility->sbus, sizeof(event_facility->sbus),
                         TYPE_SCLP_EVENTS_BUS, sdev, NULL);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f82270401b..864145a7c6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -27,6 +27,7 @@
 #include "s390-pci-bus.h"
 #include "hw/s390x/storage-keys.h"
 #include "hw/s390x/storage-attributes.h"
+#include "hw/s390x/event-facility.h"
 #include "hw/compat.h"
 #include "ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
@@ -668,7 +669,12 @@ bool css_migration_enabled(void)
     type_init(ccw_machine_register_##suffix)
 
 #define CCW_COMPAT_2_11 \
-        HW_COMPAT_2_11
+        HW_COMPAT_2_11 \
+        {\
+            .driver   = TYPE_SCLP_EVENT_FACILITY,\
+            .property = "allow_all_mask_sizes",\
+            .value    = "off",\
+        },
 
 #define CCW_COMPAT_2_10 \
         HW_COMPAT_2_10
-- 
2.13.6
