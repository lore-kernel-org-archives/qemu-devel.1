Received: from eggs.gnu.org ([2001:4830:134:3::10]:33052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2f-0003xA-1x
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2Y-0004z6-RC
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53620
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDA2Y-0004xk-JA
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:14 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAAE9rZ0076623
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:11 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e59kjkmrv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:11 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 07:12:10 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:11:46 -0500
In-Reply-To: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510323112-2207-8-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 07/13] tpm_tis: merge r/w_offset into
 rw_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Cc: amarnath.valluri@intel.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

We can now merge the r_offset and w_offset into a single rw_offset.
This is possible since when the offset is used for writing in
RECEPTION state then reads are ignore. Conversly, when the offset
is used for reading when in COMPLETION state, then writes are
ignored.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 60 ++++++++++++++++++++------------------------------------
 1 file changed, 21 insertions(+), 39 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index dfdddd3..7d7e2cd 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -68,8 +68,7 @@ typedef struct TPMState {
     MemoryRegion mmio;
 
     unsigned char buffer[TPM_TIS_BUFFER_MAX];
-    uint16_t w_offset;
-    uint16_t r_offset;
+    uint16_t rw_offset;
 
     uint8_t active_locty;
     uint8_t aborting_locty;
@@ -257,7 +256,7 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
                         "tpm_tis: To TPM");
 
     /*
-     * w_offset serves as length indicator for length of data;
+     * rw_offset serves as length indicator for length of data;
      * it's reset when the response comes back
      */
     s->loc[locty].state = TPM_TIS_STATE_EXECUTION;
@@ -265,7 +264,7 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
     s->cmd = (TPMBackendCmd) {
         .locty = locty,
         .in = s->buffer,
-        .in_len = s->w_offset,
+        .in_len = s->rw_offset,
         .out = s->buffer,
         .out_len = s->be_buffer_size,
     };
@@ -347,8 +346,7 @@ static void tpm_tis_new_active_locality(TPMState *s, uint8_t new_active_locty)
 /* abort -- this function switches the locality */
 static void tpm_tis_abort(TPMState *s, uint8_t locty)
 {
-    s->r_offset = 0;
-    s->w_offset = 0;
+    s->rw_offset = 0;
 
     DPRINTF("tpm_tis: tis_abort: new active locality is %d\n", s->next_locty);
 
@@ -415,8 +413,7 @@ static void tpm_tis_request_completed(TPMIf *ti)
     tpm_tis_sts_set(&s->loc[locty],
                     TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
     s->loc[locty].state = TPM_TIS_STATE_COMPLETION;
-    s->r_offset = 0;
-    s->w_offset = 0;
+    s->rw_offset = 0;
 
     tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
                         "tpm_tis: From TPM");
@@ -441,14 +438,14 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
         len = MIN(tpm_cmd_get_size(&s->buffer),
                   s->be_buffer_size);
 
-        ret = s->buffer[s->r_offset++];
-        if (s->r_offset >= len) {
+        ret = s->buffer[s->rw_offset++];
+        if (s->rw_offset >= len) {
             /* got last byte */
             tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
             tpm_tis_raise_irq(s, locty, TPM_TIS_INT_STS_VALID);
         }
         DPRINTF("tpm_tis: tpm_tis_data_read byte 0x%02x   [%d]\n",
-                ret, s->r_offset - 1);
+                ret, s->rw_offset - 1);
     }
 
     return ret;
@@ -483,26 +480,14 @@ static void tpm_tis_dump_state(void *opaque, hwaddr addr)
                 (int)tpm_tis_mmio_read(opaque, base + regs[idx], 4));
     }
 
-    DPRINTF("tpm_tis: read offset   : %d\n"
+    DPRINTF("tpm_tis: r/w offset    : %d\n"
             "tpm_tis: result buffer : ",
-            s->r_offset);
+            s->rw_offset);
     for (idx = 0;
          idx < MIN(tpm_cmd_get_size(&s->buffer), s->be_buffer_size);
          idx++) {
         DPRINTF("%c%02x%s",
-                s->r_offset == idx ? '>' : ' ',
-                s->buffer[idx],
-                ((idx & 0xf) == 0xf) ? "\ntpm_tis:                 " : "");
-    }
-    DPRINTF("\n"
-            "tpm_tis: write offset  : %d\n"
-            "tpm_tis: request buffer: ",
-            s->w_offset);
-    for (idx = 0;
-         idx < MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
-         idx++) {
-        DPRINTF("%c%02x%s",
-                s->w_offset == idx ? '>' : ' ',
+                s->rw_offset == idx ? '>' : ' ',
                 s->buffer[idx],
                 ((idx & 0xf) == 0xf) ? "\ntpm_tis:                 " : "");
     }
@@ -567,9 +552,9 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
                 val = TPM_TIS_BURST_COUNT(
                        MIN(tpm_cmd_get_size(&s->buffer),
                            s->be_buffer_size)
-                       - s->r_offset) | s->loc[locty].sts;
+                       - s->rw_offset) | s->loc[locty].sts;
             } else {
-                avail = s->be_buffer_size - s->w_offset;
+                avail = s->be_buffer_size - s->rw_offset;
                 /*
                  * byte-sized reads should not return 0x00 for 0x100
                  * available bytes.
@@ -833,8 +818,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
             switch (s->loc[locty].state) {
 
             case TPM_TIS_STATE_READY:
-                s->w_offset = 0;
-                s->r_offset = 0;
+                s->rw_offset = 0;
             break;
 
             case TPM_TIS_STATE_IDLE:
@@ -852,8 +836,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
             break;
 
             case TPM_TIS_STATE_COMPLETION:
-                s->w_offset = 0;
-                s->r_offset = 0;
+                s->rw_offset = 0;
                 /* shortcut to ready state with C/R set */
                 s->loc[locty].state = TPM_TIS_STATE_READY;
                 if (!(s->loc[locty].sts & TPM_TIS_STS_COMMAND_READY)) {
@@ -879,7 +862,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
         } else if (val == TPM_TIS_STS_RESPONSE_RETRY) {
             switch (s->loc[locty].state) {
             case TPM_TIS_STATE_COMPLETION:
-                s->r_offset = 0;
+                s->rw_offset = 0;
                 tpm_tis_sts_set(&s->loc[locty],
                                 TPM_TIS_STS_VALID|
                                 TPM_TIS_STS_DATA_AVAILABLE);
@@ -917,8 +900,8 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
             }
 
             while ((s->loc[locty].sts & TPM_TIS_STS_EXPECT) && size > 0) {
-                if (s->w_offset < s->be_buffer_size) {
-                    s->buffer[s->w_offset++] =
+                if (s->rw_offset < s->be_buffer_size) {
+                    s->buffer[s->rw_offset++] =
                         (uint8_t)val;
                     val >>= 8;
                     size--;
@@ -928,13 +911,13 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
             }
 
             /* check for complete packet */
-            if (s->w_offset > 5 &&
+            if (s->rw_offset > 5 &&
                 (s->loc[locty].sts & TPM_TIS_STS_EXPECT)) {
                 /* we have a packet length - see if we have all of it */
                 bool need_irq = !(s->loc[locty].sts & TPM_TIS_STS_VALID);
 
                 len = tpm_cmd_get_size(&s->buffer);
-                if (len > s->w_offset) {
+                if (len > s->rw_offset) {
                     tpm_tis_sts_set(&s->loc[locty],
                                     TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
                 } else {
@@ -1019,8 +1002,7 @@ static void tpm_tis_reset(DeviceState *dev)
         s->loc[c].ints = 0;
         s->loc[c].state = TPM_TIS_STATE_IDLE;
 
-        s->w_offset = 0;
-        s->r_offset = 0;
+        s->rw_offset = 0;
     }
 
     tpm_tis_do_startup_tpm(s, s->be_buffer_size);
-- 
2.5.5
