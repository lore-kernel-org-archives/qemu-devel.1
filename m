Received: from eggs.gnu.org ([2001:4830:134:3::10]:40526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuP-0005Yg-FD
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuO-00068y-3x
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:53 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  8 Mar 2018 19:04:21 +0100
Message-Id: <20180308180423.941-10-cohuck@redhat.com>
In-Reply-To: <20180308180423.941-1-cohuck@redhat.com>
References: <20180308180423.941-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 09/11] s390x/sclp: clean up sclp masks
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

Introduce an sccb_mask_t to be used for SCLP event masks instead of just
unsigned int or uint32_t. This will allow later to extend the mask with
more ease.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Message-Id: <1519407778-23095-3-git-send-email-imbrenda@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/char/sclpconsole-lm.c          |  4 ++--
 hw/char/sclpconsole.c             |  4 ++--
 hw/s390x/event-facility.c         | 20 ++++++++++----------
 hw/s390x/sclpcpu.c                |  4 ++--
 hw/s390x/sclpquiesce.c            |  4 ++--
 include/hw/s390x/event-facility.h | 22 +++++++++++++---------
 6 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 84efd8df73..dbc91a1e5b 100644
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
index e6ba0a46bd..1fa16e9055 100644
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
index feef6f788c..9c24bc6f7c 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -29,8 +29,8 @@ typedef struct SCLPEventsBus {
 struct SCLPEventFacility {
     SysBusDevice parent_obj;
     SCLPEventsBus sbus;
-    /* guest' receive mask */
-    unsigned int receive_mask;
+    /* guest's receive mask */
+    sccb_mask_t receive_mask;
     /*
      * when false, we keep the same broken, backwards compatible behaviour as
      * before, allowing only masks of size exactly 4; when true, we implement
@@ -61,9 +61,9 @@ static bool event_pending(SCLPEventFacility *ef)
     return false;
 }
 
-static unsigned int get_host_send_mask(SCLPEventFacility *ef)
+static sccb_mask_t get_host_send_mask(SCLPEventFacility *ef)
 {
-    unsigned int mask;
+    sccb_mask_t mask;
     BusChild *kid;
     SCLPEventClass *child;
 
@@ -77,9 +77,9 @@ static unsigned int get_host_send_mask(SCLPEventFacility *ef)
     return mask;
 }
 
-static unsigned int get_host_receive_mask(SCLPEventFacility *ef)
+static sccb_mask_t get_host_receive_mask(SCLPEventFacility *ef)
 {
-    unsigned int mask;
+    sccb_mask_t mask;
     BusChild *kid;
     SCLPEventClass *child;
 
@@ -189,7 +189,7 @@ out:
 }
 
 static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
-                                        unsigned int mask)
+                                        sccb_mask_t mask)
 {
     uint16_t rc;
     int slen;
@@ -242,8 +242,8 @@ static void copy_mask(uint8_t *dst, uint8_t *src, uint16_t dst_len,
 
 static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
 {
-    unsigned int sclp_active_selection_mask;
-    unsigned int sclp_cp_receive_mask;
+    sccb_mask_t sclp_active_selection_mask;
+    sccb_mask_t sclp_cp_receive_mask;
 
     ReadEventData *red = (ReadEventData *) sccb;
 
@@ -285,7 +285,7 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
 {
     WriteEventMask *we_mask = (WriteEventMask *) sccb;
     uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
-    uint32_t tmp_mask;
+    sccb_mask_t tmp_mask;
 
     if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX) ||
         ((mask_length != 4) && !ef->allow_all_mask_sizes)) {
diff --git a/hw/s390x/sclpcpu.c b/hw/s390x/sclpcpu.c
index 3ee890b392..50c021b9c2 100644
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
index 02416435a1..1c8f5c9393 100644
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
index b913f85edc..5698e5e96c 100644
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
+#define SCLP_EVMASK(T)  (1ULL << (sizeof(sccb_mask_t) * 8 - (T)))
+
+#define SCLP_EVENT_MASK_OP_CMD          SCLP_EVMASK(SCLP_EVENT_OPRTNS_COMMAND)
+#define SCLP_EVENT_MASK_MSG             SCLP_EVMASK(SCLP_EVENT_MESSAGE)
+#define SCLP_EVENT_MASK_CONFIG_MGT_DATA SCLP_EVMASK(SCLP_EVENT_CONFIG_MGT_DATA)
+#define SCLP_EVENT_MASK_PMSGCMD         SCLP_EVMASK(SCLP_EVENT_PMSGCMD)
+#define SCLP_EVENT_MASK_MSG_ASCII       SCLP_EVMASK(SCLP_EVENT_ASCII_CONSOLE_DATA)
+#define SCLP_EVENT_MASK_SIGNAL_QUIESCE  SCLP_EVMASK(SCLP_EVENT_SIGNAL_QUIESCE)
 
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
@@ -176,10 +180,10 @@ typedef struct SCLPEventClass {
     int (*init)(SCLPEvent *event);
 
     /* get SCLP's send mask */
-    unsigned int (*get_send_mask)(void);
+    sccb_mask_t (*get_send_mask)(void);
 
     /* get SCLP's receive mask */
-    unsigned int (*get_receive_mask)(void);
+    sccb_mask_t (*get_receive_mask)(void);
 
     int (*read_event_data)(SCLPEvent *event, EventBufferHeader *evt_buf_hdr,
                            int *slen);
-- 
2.13.6
