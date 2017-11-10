Received: from eggs.gnu.org ([2001:4830:134:3::10]:33067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2f-0003xl-R6
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2V-0004sr-Ql
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDA2V-0004qm-FB
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:11 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAAEBAeE125023
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:06 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e5dds8twr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:05 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 07:12:05 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:11:42 -0500
In-Reply-To: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510323112-2207-4-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 03/13] tpm_tis: remove TPMSizeBuffer usage
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

Remove usage of TPMSizeBuffer. The size of the buffers is limited now
by s->be_buffer_size, which is the size of the buffer the TIS has
negotiated with the backend.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 68 ++++++++++++++++++++++++--------------------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 90c6df2..ddfcfc9 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -64,8 +64,8 @@ typedef struct TPMLocality {
 
     uint16_t w_offset;
     uint16_t r_offset;
-    TPMSizedBuffer w_buffer;
-    TPMSizedBuffer r_buffer;
+    unsigned char w_buffer[TPM_TIS_BUFFER_MAX];
+    unsigned char r_buffer[TPM_TIS_BUFFER_MAX];
 } TPMLocality;
 
 typedef struct TPMState {
@@ -215,23 +215,19 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
     return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0x7);
 }
 
-static uint32_t tpm_tis_get_size_from_buffer(const TPMSizedBuffer *sb)
-{
-    return tpm_cmd_get_size(sb->buffer);
-}
-
-static void tpm_tis_show_buffer(const TPMSizedBuffer *sb, const char *string)
+static void tpm_tis_show_buffer(const unsigned char *buffer,
+                                size_t buffer_size, const char *string)
 {
 #ifdef DEBUG_TIS
     uint32_t len, i;
 
-    len = tpm_tis_get_size_from_buffer(sb);
+    len = MIN(tpm_cmd_get_size(buffer), buffer_size);
     DPRINTF("tpm_tis: %s length = %d\n", string, len);
     for (i = 0; i < len; i++) {
         if (i && !(i % 16)) {
             DPRINTF("\n");
         }
-        DPRINTF("%.2X ", sb->buffer[i]);
+        DPRINTF("%.2X ", buffer[i]);
     }
     DPRINTF("\n");
 #endif
@@ -263,7 +259,8 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 {
     TPMLocality *locty_data = &s->loc[locty];
 
-    tpm_tis_show_buffer(&s->loc[locty].w_buffer, "tpm_tis: To TPM");
+    tpm_tis_show_buffer(s->loc[locty].w_buffer, s->be_buffer_size,
+                        "tpm_tis: To TPM");
 
     /*
      * w_offset serves as length indicator for length of data;
@@ -273,10 +270,10 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 
     s->cmd = (TPMBackendCmd) {
         .locty = locty,
-        .in = locty_data->w_buffer.buffer,
+        .in = locty_data->w_buffer,
         .in_len = locty_data->w_offset,
-        .out = locty_data->r_buffer.buffer,
-        .out_len = locty_data->r_buffer.size
+        .out = locty_data->r_buffer,
+        .out_len = s->be_buffer_size,
     };
 
     tpm_backend_deliver_request(s->be_driver, &s->cmd);
@@ -427,7 +424,8 @@ static void tpm_tis_request_completed(TPMIf *ti)
     s->loc[locty].r_offset = 0;
     s->loc[locty].w_offset = 0;
 
-    tpm_tis_show_buffer(&s->loc[locty].r_buffer, "tpm_tis: From TPM");
+    tpm_tis_show_buffer(s->loc[locty].r_buffer, s->be_buffer_size,
+                        "tpm_tis: From TPM");
 
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
         tpm_tis_abort(s, locty);
@@ -446,9 +444,10 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
     uint16_t len;
 
     if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
-        len = tpm_tis_get_size_from_buffer(&s->loc[locty].r_buffer);
+        len = MIN(tpm_cmd_get_size(&s->loc[locty].r_buffer),
+                  s->be_buffer_size);
 
-        ret = s->loc[locty].r_buffer.buffer[s->loc[locty].r_offset++];
+        ret = s->loc[locty].r_buffer[s->loc[locty].r_offset++];
         if (s->loc[locty].r_offset >= len) {
             /* got last byte */
             tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
@@ -494,11 +493,12 @@ static void tpm_tis_dump_state(void *opaque, hwaddr addr)
             "tpm_tis: result buffer : ",
             s->loc[locty].r_offset);
     for (idx = 0;
-         idx < tpm_tis_get_size_from_buffer(&s->loc[locty].r_buffer);
+         idx < MIN(tpm_cmd_get_size(&s->loc[locty].r_buffer),
+                   s->be_buffer_size);
          idx++) {
         DPRINTF("%c%02x%s",
                 s->loc[locty].r_offset == idx ? '>' : ' ',
-                s->loc[locty].r_buffer.buffer[idx],
+                s->loc[locty].r_buffer[idx],
                 ((idx & 0xf) == 0xf) ? "\ntpm_tis:                 " : "");
     }
     DPRINTF("\n"
@@ -506,11 +506,12 @@ static void tpm_tis_dump_state(void *opaque, hwaddr addr)
             "tpm_tis: request buffer: ",
             s->loc[locty].w_offset);
     for (idx = 0;
-         idx < tpm_tis_get_size_from_buffer(&s->loc[locty].w_buffer);
+         idx < MIN(tpm_cmd_get_size(s->loc[locty].w_buffer),
+                   s->be_buffer_size);
          idx++) {
         DPRINTF("%c%02x%s",
                 s->loc[locty].w_offset == idx ? '>' : ' ',
-                s->loc[locty].w_buffer.buffer[idx],
+                s->loc[locty].w_buffer[idx],
                 ((idx & 0xf) == 0xf) ? "\ntpm_tis:                 " : "");
     }
     DPRINTF("\n");
@@ -572,11 +573,11 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
         if (s->active_locty == locty) {
             if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
                 val = TPM_TIS_BURST_COUNT(
-                       tpm_tis_get_size_from_buffer(&s->loc[locty].r_buffer)
+                       MIN(tpm_cmd_get_size(&s->loc[locty].r_buffer),
+                           s->be_buffer_size)
                        - s->loc[locty].r_offset) | s->loc[locty].sts;
             } else {
-                avail = s->loc[locty].w_buffer.size
-                        - s->loc[locty].w_offset;
+                avail = s->be_buffer_size - s->loc[locty].w_offset;
                 /*
                  * byte-sized reads should not return 0x00 for 0x100
                  * available bytes.
@@ -924,9 +925,9 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
             }
 
             while ((s->loc[locty].sts & TPM_TIS_STS_EXPECT) && size > 0) {
-                if (s->loc[locty].w_offset < s->loc[locty].w_buffer.size) {
-                    s->loc[locty].w_buffer.
-                        buffer[s->loc[locty].w_offset++] = (uint8_t)val;
+                if (s->loc[locty].w_offset < s->be_buffer_size) {
+                    s->loc[locty].w_buffer[s->loc[locty].w_offset++] =
+                        (uint8_t)val;
                     val >>= 8;
                     size--;
                 } else {
@@ -940,7 +941,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
                 /* we have a packet length - see if we have all of it */
                 bool need_irq = !(s->loc[locty].sts & TPM_TIS_STS_VALID);
 
-                len = tpm_tis_get_size_from_buffer(&s->loc[locty].w_buffer);
+                len = tpm_cmd_get_size(&s->loc[locty].w_buffer);
                 if (len > s->loc[locty].w_offset) {
                     tpm_tis_sts_set(&s->loc[locty],
                                     TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
@@ -979,15 +980,6 @@ static int tpm_tis_do_startup_tpm(TPMState *s, size_t buffersize)
     return tpm_backend_startup_tpm(s->be_driver, buffersize);
 }
 
-static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb,
-                                   size_t wanted_size)
-{
-    if (sb->size != wanted_size) {
-        sb->buffer = g_realloc(sb->buffer, wanted_size);
-        sb->size = wanted_size;
-    }
-}
-
 /*
  * Get the TPMVersion of the backend device being used
  */
@@ -1036,9 +1028,7 @@ static void tpm_tis_reset(DeviceState *dev)
         s->loc[c].state = TPM_TIS_STATE_IDLE;
 
         s->loc[c].w_offset = 0;
-        tpm_tis_realloc_buffer(&s->loc[c].w_buffer, s->be_buffer_size);
         s->loc[c].r_offset = 0;
-        tpm_tis_realloc_buffer(&s->loc[c].r_buffer, s->be_buffer_size);
     }
 
     tpm_tis_do_startup_tpm(s, s->be_buffer_size);
-- 
2.5.5
