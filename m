Received: from eggs.gnu.org ([2001:4830:134:3::10]:37270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eoCum-0007rT-7m
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eoCuf-0002Ui-St
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:45:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44748
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1eoCuf-0002UQ-MZ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:45:13 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1KIioZu044016
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:45:13 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g8qv6bct8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:45:08 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Tue, 20 Feb 2018 18:45:06 -0000
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Tue, 20 Feb 2018 19:45:00 +0100
In-Reply-To: <1519152302-19079-1-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1519152302-19079-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Message-Id: <1519152302-19079-2-git-send-email-imbrenda@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/3] s390x/sclp: proper support of larger
 send and receive masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm390-list@tuxmaker.boeblingen.de.ibm.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com

The architecture allows the guests to ask for masks up to 1021 bytes in
length. Part was fixed in 67915de9f0383ccf4ab8c42dd02aa18dcd79b411
("s390x/event-facility: variable-length event masks"), but some issues
were still remaining, in particular regarding the handling of selective
reads.

This patch fixes the handling of selective reads, whose size will now
match the length of the event mask, as per architecture.

The default behaviour is to be compliant with the architecture, but when
using older machine models the old behaviour is selected, in order to
be able to migrate toward older versions.

Fixes: 67915de9f0383ccf4a ("s390x/event-facility: variable-length event masks")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
 hw/s390x/event-facility.c  | 90 +++++++++++++++++++++++++++++++++++++++-------
 hw/s390x/s390-virtio-ccw.c |  8 ++++-
 2 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 155a694..2414614 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -31,6 +31,14 @@ struct SCLPEventFacility {
     SCLPEventsBus sbus;
     /* guest' receive mask */
     unsigned int receive_mask;
+    /*
+     * when false, we keep the same broken, backwards compatible behaviour as
+     * before; when true, we implement the architecture correctly. Needed for
+     * migration toward older versions.
+     */
+    bool allow_all_mask_sizes;
+    /* length of the receive mask */
+    uint16_t mask_length;
 };
 
 /* return true if any child has event pending set */
@@ -220,6 +228,17 @@ static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
     return rc;
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
 static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
 {
     unsigned int sclp_active_selection_mask;
@@ -240,7 +259,9 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
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
@@ -259,24 +280,14 @@ out:
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
@@ -301,6 +312,7 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
               mask_length, sizeof(tmp_mask));
 
     sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_COMPLETION);
+    ef->mask_length = mask_length;
 
 out:
     return;
@@ -356,6 +368,34 @@ static void command_handler(SCLPEventFacility *ef, SCCB *sccb, uint64_t code)
     }
 }
 
+static bool vmstate_event_facility_mask_length_needed(void *opaque)
+{
+    SCLPEventFacility *ef = opaque;
+
+    return ef->allow_all_mask_sizes;
+}
+
+static int vmstate_event_facility_mask_length_pre_load(void *opaque)
+{
+    SCLPEventFacility *ef = opaque;
+
+    ef->allow_all_mask_sizes = false;
+    return 0;
+}
+
+static const VMStateDescription vmstate_event_facility_mask_length = {
+    .name = "vmstate-event-facility/mask_length",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = vmstate_event_facility_mask_length_needed,
+    .pre_load = vmstate_event_facility_mask_length_pre_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(allow_all_mask_sizes, SCLPEventFacility),
+        VMSTATE_UINT16(mask_length, SCLPEventFacility),
+        VMSTATE_END_OF_LIST()
+     }
+};
+
 static const VMStateDescription vmstate_event_facility = {
     .name = "vmstate-event-facility",
     .version_id = 0,
@@ -363,15 +403,39 @@ static const VMStateDescription vmstate_event_facility = {
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
index 8b3053f..e9309fd 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -29,6 +29,7 @@
 #include "s390-pci-bus.h"
 #include "hw/s390x/storage-keys.h"
 #include "hw/s390x/storage-attributes.h"
+#include "hw/s390x/event-facility.h"
 #include "hw/compat.h"
 #include "ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
@@ -671,7 +672,12 @@ bool css_migration_enabled(void)
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
2.7.4
