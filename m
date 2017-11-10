Received: from eggs.gnu.org ([2001:4830:134:3::10]:33025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2d-0003vp-Nf
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2V-0004sh-Pu
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDA2V-0004qp-F9
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:11 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAAEA8JC120345
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:09 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e5dds8u0s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:08 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 07:12:07 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:11:44 -0500
In-Reply-To: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510323112-2207-6-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 05/13] tpm_tis: merge read and write buffer
 into single buffer
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

Since we can only be in read or write mode, we can merge the buffers
into a single buffer.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index f6f5f17..0b6dd7f 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -70,8 +70,7 @@ typedef struct TPMState {
     ISADevice busdev;
     MemoryRegion mmio;
 
-    unsigned char w_buffer[TPM_TIS_BUFFER_MAX];
-    unsigned char r_buffer[TPM_TIS_BUFFER_MAX];
+    unsigned char buffer[TPM_TIS_BUFFER_MAX];
 
     uint8_t active_locty;
     uint8_t aborting_locty;
@@ -257,7 +256,7 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 {
     TPMLocality *locty_data = &s->loc[locty];
 
-    tpm_tis_show_buffer(s->w_buffer, s->be_buffer_size,
+    tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
                         "tpm_tis: To TPM");
 
     /*
@@ -268,9 +267,9 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 
     s->cmd = (TPMBackendCmd) {
         .locty = locty,
-        .in = s->w_buffer,
+        .in = s->buffer,
         .in_len = locty_data->w_offset,
-        .out = s->r_buffer,
+        .out = s->buffer,
         .out_len = s->be_buffer_size,
     };
 
@@ -422,7 +421,7 @@ static void tpm_tis_request_completed(TPMIf *ti)
     s->loc[locty].r_offset = 0;
     s->loc[locty].w_offset = 0;
 
-    tpm_tis_show_buffer(s->r_buffer, s->be_buffer_size,
+    tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
                         "tpm_tis: From TPM");
 
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
@@ -442,10 +441,10 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
     uint16_t len;
 
     if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
-        len = MIN(tpm_cmd_get_size(&s->r_buffer),
+        len = MIN(tpm_cmd_get_size(&s->buffer),
                   s->be_buffer_size);
 
-        ret = s->r_buffer[s->loc[locty].r_offset++];
+        ret = s->buffer[s->loc[locty].r_offset++];
         if (s->loc[locty].r_offset >= len) {
             /* got last byte */
             tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
@@ -491,11 +490,11 @@ static void tpm_tis_dump_state(void *opaque, hwaddr addr)
             "tpm_tis: result buffer : ",
             s->loc[locty].r_offset);
     for (idx = 0;
-         idx < MIN(tpm_cmd_get_size(&s->r_buffer), s->be_buffer_size);
+         idx < MIN(tpm_cmd_get_size(&s->buffer), s->be_buffer_size);
          idx++) {
         DPRINTF("%c%02x%s",
                 s->loc[locty].r_offset == idx ? '>' : ' ',
-                s->r_buffer[idx],
+                s->buffer[idx],
                 ((idx & 0xf) == 0xf) ? "\ntpm_tis:                 " : "");
     }
     DPRINTF("\n"
@@ -503,11 +502,11 @@ static void tpm_tis_dump_state(void *opaque, hwaddr addr)
             "tpm_tis: request buffer: ",
             s->loc[locty].w_offset);
     for (idx = 0;
-         idx < MIN(tpm_cmd_get_size(s->w_buffer), s->be_buffer_size);
+         idx < MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
          idx++) {
         DPRINTF("%c%02x%s",
                 s->loc[locty].w_offset == idx ? '>' : ' ',
-                s->w_buffer[idx],
+                s->buffer[idx],
                 ((idx & 0xf) == 0xf) ? "\ntpm_tis:                 " : "");
     }
     DPRINTF("\n");
@@ -569,7 +568,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
         if (s->active_locty == locty) {
             if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
                 val = TPM_TIS_BURST_COUNT(
-                       MIN(tpm_cmd_get_size(&s->r_buffer),
+                       MIN(tpm_cmd_get_size(&s->buffer),
                            s->be_buffer_size)
                        - s->loc[locty].r_offset) | s->loc[locty].sts;
             } else {
@@ -922,7 +921,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
 
             while ((s->loc[locty].sts & TPM_TIS_STS_EXPECT) && size > 0) {
                 if (s->loc[locty].w_offset < s->be_buffer_size) {
-                    s->w_buffer[s->loc[locty].w_offset++] =
+                    s->buffer[s->loc[locty].w_offset++] =
                         (uint8_t)val;
                     val >>= 8;
                     size--;
@@ -937,7 +936,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
                 /* we have a packet length - see if we have all of it */
                 bool need_irq = !(s->loc[locty].sts & TPM_TIS_STS_VALID);
 
-                len = tpm_cmd_get_size(&s->w_buffer);
+                len = tpm_cmd_get_size(&s->buffer);
                 if (len > s->loc[locty].w_offset) {
                     tpm_tis_sts_set(&s->loc[locty],
                                     TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
-- 
2.5.5
