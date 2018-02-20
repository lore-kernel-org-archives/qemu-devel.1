Received: from eggs.gnu.org ([2001:4830:134:3::10]:40078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eoD4a-0007vi-E4
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eoD4W-0001iE-Bf
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:55:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1eoD4V-0001gL-Tb
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:55:24 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1KIseaI059149
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:55:22 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g8rmmsu51-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:55:21 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Tue, 20 Feb 2018 18:45:08 -0000
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Tue, 20 Feb 2018 19:45:01 +0100
In-Reply-To: <1519152302-19079-1-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1519152302-19079-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Message-Id: <1519152302-19079-3-git-send-email-imbrenda@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 2/3] s390x/sclp: clean up sclp masks
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

Clean up SCLP masks: introduce an sccb_mask_t to be used for SCLP event
masks instead of just unsigned int or uint32_t. This will allow later
to extend the mask with more ease.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
 hw/char/sclpconsole-lm.c          |  4 ++--
 hw/char/sclpconsole.c             |  4 ++--
 hw/s390x/event-facility.c         | 18 +++++++++---------
 hw/s390x/sclpcpu.c                |  4 ++--
 hw/s390x/sclpquiesce.c            |  4 ++--
 include/hw/s390x/event-facility.h | 22 +++++++++++++---------
 6 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index c500bda..cc4d70a 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -102,12 +102,12 @@ static bool can_handle_event(uint8_t type)
     return type == SCLP_EVENT_MESSAGE || type == SCLP_EVENT_PMSGCMD;
 }
 
-static unsigned int send_mask(void)
+static sccb_mask_t send_mask(void)
 {
     return SCLP_EVENT_MASK_OP_CMD | SCLP_EVENT_MASK_PMSGCMD;
 }
 
-static unsigned int receive_mask(void)
+static sccb_mask_t receive_mask(void)
 {
     return SCLP_EVENT_MASK_MSG | SCLP_EVENT_MASK_PMSGCMD;
 }
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index d0265df..ec9db13 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -83,12 +83,12 @@ static bool can_handle_event(uint8_t type)
     return type == SCLP_EVENT_ASCII_CONSOLE_DATA;
 }
 
-static unsigned int send_mask(void)
+static sccb_mask_t send_mask(void)
 {
     return SCLP_EVENT_MASK_MSG_ASCII;
 }
 
-static unsigned int receive_mask(void)
+static sccb_mask_t receive_mask(void)
 {
     return SCLP_EVENT_MASK_MSG_ASCII;
 }
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 2414614..f6f28fd 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -30,7 +30,7 @@ struct SCLPEventFacility {
     SysBusDevice parent_obj;
     SCLPEventsBus sbus;
     /* guest' receive mask */
-    unsigned int receive_mask;
+    sccb_mask_t receive_mask;
     /*
      * when false, we keep the same broken, backwards compatible behaviour as
      * before; when true, we implement the architecture correctly. Needed for
@@ -60,9 +60,9 @@ static bool event_pending(SCLPEventFacility *ef)
     return false;
 }
 
-static unsigned int get_host_send_mask(SCLPEventFacility *ef)
+static sccb_mask_t get_host_send_mask(SCLPEventFacility *ef)
 {
-    unsigned int mask;
+    sccb_mask_t mask;
     BusChild *kid;
     SCLPEventClass *child;
 
@@ -76,9 +76,9 @@ static unsigned int get_host_send_mask(SCLPEventFacility *ef)
     return mask;
 }
 
-static unsigned int get_host_receive_mask(SCLPEventFacility *ef)
+static sccb_mask_t get_host_receive_mask(SCLPEventFacility *ef)
 {
-    unsigned int mask;
+    sccb_mask_t mask;
     BusChild *kid;
     SCLPEventClass *child;
 
@@ -188,7 +188,7 @@ out:
 }
 
 static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
-                                        unsigned int mask)
+                                        sccb_mask_t mask)
 {
     uint16_t rc;
     int slen;
@@ -241,8 +241,8 @@ static void copy_mask(uint8_t *dst, uint8_t *src, uint16_t dst_len,
 
 static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
 {
-    unsigned int sclp_active_selection_mask;
-    unsigned int sclp_cp_receive_mask;
+    sccb_mask_t sclp_active_selection_mask = 0;
+    sccb_mask_t sclp_cp_receive_mask;
 
     ReadEventData *red = (ReadEventData *) sccb;
 
@@ -284,7 +284,7 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
 {
     WriteEventMask *we_mask = (WriteEventMask *) sccb;
     uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
-    uint32_t tmp_mask;
+    sccb_mask_t tmp_mask = 0;
 
     if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX) ||
         ((mask_length != 4) && !ef->allow_all_mask_sizes)) {
diff --git a/hw/s390x/sclpcpu.c b/hw/s390x/sclpcpu.c
index 3ee890b..50c021b 100644
--- a/hw/s390x/sclpcpu.c
+++ b/hw/s390x/sclpcpu.c
@@ -37,12 +37,12 @@ void raise_irq_cpu_hotplug(void)
     sclp_service_interrupt(0);
 }
 
-static unsigned int send_mask(void)
+static sccb_mask_t send_mask(void)
 {
     return SCLP_EVENT_MASK_CONFIG_MGT_DATA;
 }
 
-static unsigned int receive_mask(void)
+static sccb_mask_t receive_mask(void)
 {
     return 0;
 }
diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index 0241643..1c8f5c9 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -28,12 +28,12 @@ static bool can_handle_event(uint8_t type)
     return type == SCLP_EVENT_SIGNAL_QUIESCE;
 }
 
-static unsigned int send_mask(void)
+static sccb_mask_t send_mask(void)
 {
     return SCLP_EVENT_MASK_SIGNAL_QUIESCE;
 }
 
-static unsigned int receive_mask(void)
+static sccb_mask_t receive_mask(void)
 {
     return 0;
 }
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index 5119b9b..0a8b47a 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -28,12 +28,14 @@
 #define SCLP_EVENT_SIGNAL_QUIESCE               0x1d
 
 /* SCLP event masks */
-#define SCLP_EVENT_MASK_SIGNAL_QUIESCE          0x00000008
-#define SCLP_EVENT_MASK_MSG_ASCII               0x00000040
-#define SCLP_EVENT_MASK_CONFIG_MGT_DATA         0x10000000
-#define SCLP_EVENT_MASK_OP_CMD                  0x80000000
-#define SCLP_EVENT_MASK_MSG                     0x40000000
-#define SCLP_EVENT_MASK_PMSGCMD                 0x00800000
+#define SCLPEVMSK(T)  (1ULL << (sizeof(sccb_mask_t) * 8 - (T)))
+
+#define SCLP_EVENT_MASK_OP_CMD          SCLPEVMSK(SCLP_EVENT_OPRTNS_COMMAND)
+#define SCLP_EVENT_MASK_MSG             SCLPEVMSK(SCLP_EVENT_MESSAGE)
+#define SCLP_EVENT_MASK_CONFIG_MGT_DATA SCLPEVMSK(SCLP_EVENT_CONFIG_MGT_DATA)
+#define SCLP_EVENT_MASK_PMSGCMD         SCLPEVMSK(SCLP_EVENT_PMSGCMD)
+#define SCLP_EVENT_MASK_MSG_ASCII       SCLPEVMSK(SCLP_EVENT_ASCII_CONSOLE_DATA)
+#define SCLP_EVENT_MASK_SIGNAL_QUIESCE  SCLPEVMSK(SCLP_EVENT_SIGNAL_QUIESCE)
 
 #define SCLP_UNCONDITIONAL_READ                 0x00
 #define SCLP_SELECTIVE_READ                     0x01
@@ -71,6 +73,8 @@ typedef struct WriteEventMask {
 #define WEM_RECEIVE_MASK(wem, mask_len) ((wem)->masks + 2 * (mask_len))
 #define WEM_SEND_MASK(wem, mask_len) ((wem)->masks + 3 * (mask_len))
 
+typedef uint32_t sccb_mask_t;
+
 typedef struct EventBufferHeader {
     uint16_t length;
     uint8_t  type;
@@ -160,7 +164,7 @@ typedef struct WriteEventData {
 typedef struct ReadEventData {
     SCCBHeader h;
     union {
-        uint32_t mask;
+        sccb_mask_t mask;
         EventBufferHeader ebh;
     };
 } QEMU_PACKED ReadEventData;
@@ -177,10 +181,10 @@ typedef struct SCLPEventClass {
     int (*exit)(SCLPEvent *event);
 
     /* get SCLP's send mask */
-    unsigned int (*get_send_mask)(void);
+    sccb_mask_t (*get_send_mask)(void);
 
     /* get SCLP's receive mask */
-    unsigned int (*get_receive_mask)(void);
+    sccb_mask_t (*get_receive_mask)(void);
 
     int (*read_event_data)(SCLPEvent *event, EventBufferHeader *evt_buf_hdr,
                            int *slen);
-- 
2.7.4
