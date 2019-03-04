Received: from eggs.gnu.org ([209.51.188.92]:37815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1h0pow-0003xV-MA
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1h0pov-0005nZ-3O
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:48:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41626
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1h0pou-0005cQ-Qa
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:48:01 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x24Fir0Q121075
	for <qemu-devel@nongnu.org>; Mon, 4 Mar 2019 10:47:47 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r15f8mkqk-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:47:47 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 4 Mar 2019 15:47:46 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon,  4 Mar 2019 10:47:39 -0500
In-Reply-To: <20190304154739.758486-1-stefanb@linux.vnet.ibm.com>
References: <20190304154739.758486-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20190304154739.758486-3-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 2/2] tpm_tis: convert tpm_tis_show_buffer()
 to use trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Liam Merwick <liam.merwick@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>

From: Liam Merwick <liam.merwick@oracle.com>

cppcheck reports:

[hw/tpm/tpm_tis.c:113]: (warning) %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'

Rather than just converting the format specifier to use '%u", the
tpm_tis_show_buffer() function is converted to use trace points and
the two debug callers use the trace event infrastructure so that it's
available in production cases also and not just when DEBUG_TIS is enabled.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis.c    | 31 +++++++++++++++++++------------
 hw/tpm/trace-events |  1 +
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 61a130beef..fd183e8deb 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -106,17 +106,26 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
 static void tpm_tis_show_buffer(const unsigned char *buffer,
                                 size_t buffer_size, const char *string)
 {
-    uint32_t len, i;
+    size_t len, i;
+    char *line_buffer, *p;
 
     len = MIN(tpm_cmd_get_size(buffer), buffer_size);
-    printf("tpm_tis: %s length = %d\n", string, len);
-    for (i = 0; i < len; i++) {
+
+    /*
+     * allocate enough room for 3 chars per buffer entry plus a
+     * newline after every 16 chars and a final null terminator.
+     */
+    line_buffer = g_malloc(len * 3 + (len / 16) + 1);
+
+    for (i = 0, p = line_buffer; i < len; i++) {
         if (i && !(i % 16)) {
-            printf("\n");
+            p += sprintf(p, "\n");
         }
-        printf("%.2X ", buffer[i]);
+        p += sprintf(p, "%.2X ", buffer[i]);
     }
-    printf("\n");
+    trace_tpm_tis_show_buffer(string, len, line_buffer);
+
+    g_free(line_buffer);
 }
 
 /*
@@ -143,9 +152,8 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_t flags)
  */
 static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 {
-    if (DEBUG_TIS) {
-        tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
-                            "tpm_tis: To TPM");
+    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
+        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
     }
 
     /*
@@ -313,9 +321,8 @@ static void tpm_tis_request_completed(TPMIf *ti, int ret)
     s->loc[locty].state = TPM_TIS_STATE_COMPLETION;
     s->rw_offset = 0;
 
-    if (DEBUG_TIS) {
-        tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
-                            "tpm_tis: From TPM");
+    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
+        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
     }
 
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 920d32ad55..f45dcd2209 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -36,6 +36,7 @@ tpm_emulator_pre_save(void) ""
 tpm_emulator_inst_init(void) ""
 
 # hw/tpm/tpm_tis.c
+tpm_tis_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\nbuf: %s"
 tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08x"
 tpm_tis_new_active_locality(uint8_t locty) "Active locality is now %d"
 tpm_tis_abort(uint8_t locty) "New active locality is %d"
-- 
2.17.2
