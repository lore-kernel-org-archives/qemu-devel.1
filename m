Received: from eggs.gnu.org ([2001:4830:134:3::10]:60626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eoteJ-0004b6-At
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eoteG-0004uG-4d
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:23:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32832
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1eoteF-0004tZ-Uk
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:23:08 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1MGIkgj003981
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 11:23:07 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g9wexk3ka-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 11:23:07 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Thu, 22 Feb 2018 16:23:05 -0000
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 17:22:59 +0100
In-Reply-To: <1519316579-7162-1-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1519316579-7162-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Message-Id: <1519316579-7162-4-git-send-email-imbrenda@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/3] s390x/sclp: extend SCLP event masks to
 64 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

Extend the SCLP event masks to 64 bits.

Notice that using any of the new bits results in a state that cannot be
migrated to an older version.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
 hw/s390x/event-facility.c         | 43 +++++++++++++++++++++++++++++++++------
 include/hw/s390x/event-facility.h |  2 +-
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 94fe948..f9e8898 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -30,7 +30,10 @@ struct SCLPEventFacility {
     SysBusDevice parent_obj;
     SCLPEventsBus sbus;
     /* guest's receive mask */
-    sccb_mask_t receive_mask;
+    union {
+        uint32_t receive_mask_compat32;
+        sccb_mask_t receive_mask;
+    };
     /*
      * when false, we keep the same broken, backwards compatible behaviour as
      * before, allowing only masks of size exactly 4; when true, we implement
@@ -262,7 +265,7 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
     case SCLP_SELECTIVE_READ:
         copy_mask((uint8_t *)&sclp_active_selection_mask, (uint8_t *)&red->mask,
                   sizeof(sclp_active_selection_mask), ef->mask_length);
-        sclp_active_selection_mask = be32_to_cpu(sclp_active_selection_mask);
+        sclp_active_selection_mask = be64_to_cpu(sclp_active_selection_mask);
         if (!sclp_cp_receive_mask ||
             (sclp_active_selection_mask & ~sclp_cp_receive_mask)) {
             sccb->h.response_code =
@@ -302,13 +305,13 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
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
 
@@ -369,6 +372,21 @@ static void command_handler(SCLPEventFacility *ef, SCCB *sccb, uint64_t code)
     }
 }
 
+static bool vmstate_event_facility_mask64_needed(void *opaque)
+{
+    SCLPEventFacility *ef = opaque;
+
+    return (ef->receive_mask & 0xFFFFFFFF) != 0;
+}
+
+static int vmstate_event_facility_mask64_pre_load(void *opaque)
+{
+    SCLPEventFacility *ef = opaque;
+
+    ef->receive_mask &= ~0xFFFFFFFFULL;
+    return 0;
+}
+
 static bool vmstate_event_facility_mask_length_needed(void *opaque)
 {
     SCLPEventFacility *ef = opaque;
@@ -384,6 +402,18 @@ static int vmstate_event_facility_mask_length_pre_load(void *opaque)
     return 0;
 }
 
+static const VMStateDescription vmstate_event_facility_mask64 = {
+    .name = "vmstate-event-facility/mask64",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = vmstate_event_facility_mask64_needed,
+    .pre_load = vmstate_event_facility_mask64_pre_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(receive_mask, SCLPEventFacility),
+        VMSTATE_END_OF_LIST()
+     }
+};
+
 static const VMStateDescription vmstate_event_facility_mask_length = {
     .name = "vmstate-event-facility/mask_length",
     .version_id = 0,
@@ -402,10 +432,11 @@ static const VMStateDescription vmstate_event_facility = {
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(receive_mask, SCLPEventFacility),
+        VMSTATE_UINT32(receive_mask_compat32, SCLPEventFacility),
         VMSTATE_END_OF_LIST()
      },
     .subsections = (const VMStateDescription * []) {
+        &vmstate_event_facility_mask64,
         &vmstate_event_facility_mask_length,
         NULL
      }
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index 0e2b761..06ba4ea 100644
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
2.7.4
