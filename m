Received: from eggs.gnu.org ([2001:4830:134:3::10]:32988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2a-0003uK-U3
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2V-0004sm-QW
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDA2V-0004qo-F7
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:11 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAAEBQMr125828
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:06 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e5dds8tx1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:06 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 07:12:05 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:11:43 -0500
In-Reply-To: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510323112-2207-5-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 04/13] tpm_tis: move buffers from localities
 into common location
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

One read buffer and one write buffer is sufficient for all localities.
The localities cannot all be active at the same time, and only the active
locality can use the r/w buffers. Inactive localities will require the
COMMAND_READY flag to be set on the STS register to move to the READY
state, which then enables access to using the buffer for writing of a
command, while all other localities are inactive.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index ddfcfc9..f6f5f17 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -64,16 +64,14 @@ typedef struct TPMLocality {
 
     uint16_t w_offset;
     uint16_t r_offset;
-    unsigned char w_buffer[TPM_TIS_BUFFER_MAX];
-    unsigned char r_buffer[TPM_TIS_BUFFER_MAX];
 } TPMLocality;
 
 typedef struct TPMState {
     ISADevice busdev;
     MemoryRegion mmio;
 
-    uint32_t offset;
-    uint8_t buf[TPM_TIS_BUFFER_MAX];
+    unsigned char w_buffer[TPM_TIS_BUFFER_MAX];
+    unsigned char r_buffer[TPM_TIS_BUFFER_MAX];
 
     uint8_t active_locty;
     uint8_t aborting_locty;
@@ -259,7 +257,7 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 {
     TPMLocality *locty_data = &s->loc[locty];
 
-    tpm_tis_show_buffer(s->loc[locty].w_buffer, s->be_buffer_size,
+    tpm_tis_show_buffer(s->w_buffer, s->be_buffer_size,
                         "tpm_tis: To TPM");
 
     /*
@@ -270,9 +268,9 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 
     s->cmd = (TPMBackendCmd) {
         .locty = locty,
-        .in = locty_data->w_buffer,
+        .in = s->w_buffer,
         .in_len = locty_data->w_offset,
-        .out = locty_data->r_buffer,
+        .out = s->r_buffer,
         .out_len = s->be_buffer_size,
     };
 
@@ -424,7 +422,7 @@ static void tpm_tis_request_completed(TPMIf *ti)
     s->loc[locty].r_offset = 0;
     s->loc[locty].w_offset = 0;
 
-    tpm_tis_show_buffer(s->loc[locty].r_buffer, s->be_buffer_size,
+    tpm_tis_show_buffer(s->r_buffer, s->be_buffer_size,
                         "tpm_tis: From TPM");
 
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
@@ -444,10 +442,10 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
     uint16_t len;
 
     if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
-        len = MIN(tpm_cmd_get_size(&s->loc[locty].r_buffer),
+        len = MIN(tpm_cmd_get_size(&s->r_buffer),
                   s->be_buffer_size);
 
-        ret = s->loc[locty].r_buffer[s->loc[locty].r_offset++];
+        ret = s->r_buffer[s->loc[locty].r_offset++];
         if (s->loc[locty].r_offset >= len) {
             /* got last byte */
             tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
@@ -493,12 +491,11 @@ static void tpm_tis_dump_state(void *opaque, hwaddr addr)
             "tpm_tis: result buffer : ",
             s->loc[locty].r_offset);
     for (idx = 0;
-         idx < MIN(tpm_cmd_get_size(&s->loc[locty].r_buffer),
-                   s->be_buffer_size);
+         idx < MIN(tpm_cmd_get_size(&s->r_buffer), s->be_buffer_size);
          idx++) {
         DPRINTF("%c%02x%s",
                 s->loc[locty].r_offset == idx ? '>' : ' ',
-                s->loc[locty].r_buffer[idx],
+                s->r_buffer[idx],
                 ((idx & 0xf) == 0xf) ? "\ntpm_tis:                 " : "");
     }
     DPRINTF("\n"
@@ -506,12 +503,11 @@ static void tpm_tis_dump_state(void *opaque, hwaddr addr)
             "tpm_tis: request buffer: ",
             s->loc[locty].w_offset);
     for (idx = 0;
-         idx < MIN(tpm_cmd_get_size(s->loc[locty].w_buffer),
-                   s->be_buffer_size);
+         idx < MIN(tpm_cmd_get_size(s->w_buffer), s->be_buffer_size);
          idx++) {
         DPRINTF("%c%02x%s",
                 s->loc[locty].w_offset == idx ? '>' : ' ',
-                s->loc[locty].w_buffer[idx],
+                s->w_buffer[idx],
                 ((idx & 0xf) == 0xf) ? "\ntpm_tis:                 " : "");
     }
     DPRINTF("\n");
@@ -573,7 +569,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
         if (s->active_locty == locty) {
             if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
                 val = TPM_TIS_BURST_COUNT(
-                       MIN(tpm_cmd_get_size(&s->loc[locty].r_buffer),
+                       MIN(tpm_cmd_get_size(&s->r_buffer),
                            s->be_buffer_size)
                        - s->loc[locty].r_offset) | s->loc[locty].sts;
             } else {
@@ -926,7 +922,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
 
             while ((s->loc[locty].sts & TPM_TIS_STS_EXPECT) && size > 0) {
                 if (s->loc[locty].w_offset < s->be_buffer_size) {
-                    s->loc[locty].w_buffer[s->loc[locty].w_offset++] =
+                    s->w_buffer[s->loc[locty].w_offset++] =
                         (uint8_t)val;
                     val >>= 8;
                     size--;
@@ -941,7 +937,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
                 /* we have a packet length - see if we have all of it */
                 bool need_irq = !(s->loc[locty].sts & TPM_TIS_STS_VALID);
 
-                len = tpm_cmd_get_size(&s->loc[locty].w_buffer);
+                len = tpm_cmd_get_size(&s->w_buffer);
                 if (len > s->loc[locty].w_offset) {
                     tpm_tis_sts_set(&s->loc[locty],
                                     TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
-- 
2.5.5
