Received: from eggs.gnu.org ([209.51.188.92]:56022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gtf4o-0005cr-6B
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gtez9-0007dJ-Oz
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:48:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gtez5-0007N4-Fu
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:48:55 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Tue, 12 Feb 2019 20:48:20 +0000
Message-Id: <1550004500-24485-3-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1550004500-24485-1-git-send-email-liam.merwick@oracle.com>
References: <1550004500-24485-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v3 3/3] tpm_tis: convert tpm_tis_show_buffer()
 to use trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanb@linux.ibm.com, qemu-devel@nongnu.org
Cc: liam.merwick@oracle.com, philmd@redhat.com

cppcheck reports:

[hw/tpm/tpm_tis.c:113]: (warning) %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'

Rather than just converting the format specifier to use '%u", the
tpm_tis_show_buffer() function is converted to use trace points and
the two debug callers use the trace event infrastructure so that it's
available in production cases also and not just when DEBUG_TIS is enabled.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---

Sample trace output

% echo tpm_tis_show_buffer > /tmp/events 
% export QTEST_QEMU_BINARY="/home/Development/qemu-upstream/x86_64-softmmu/qemu-system-x86_64 --trace events=/tmp/events"
% tests/tpm-tis-test 
/D=/home/Development/qemu-upstream/hw/tpm/tpm-tis/test_check_localities: OK
/D=/home/Development/qemu-upstream/hw/tpm/tpm-tis/test_check_access_reg: OK
/D=/home/Development/qemu-upstream/hw/tpm/tpm-tis/test_check_access_reg_seize: OK
/D=/home/Development/qemu-upstream/hw/tpm/tpm-tis/test_check_access_reg_release: OK
/D=/home/Development/qemu-upstream/hw/tpm/tpm-tis/test_check_transmit: OK
% ./scripts/simpletrace.py trace-events-all trace-30665
tpm_tis_show_buffer 0.000 pid=30665 string=tpm_tis: To TPM len=0xc line=80 01 00 00 00 0C 00 00 01 44 00 00 
tpm_tis_show_buffer 256.581 pid=30665 string=tpm_tis: From TPM len=0xa line=80 01 00 00 00 0A 00 00 01 01 

 hw/tpm/tpm_tis.c    | 25 +++++++++++++++++--------
 hw/tpm/trace-events |  1 +
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 772431f20874..18e19d5f900d 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -108,17 +108,26 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
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
+     * allocate enough room for 3 chars per buffer entry plus
+     * a newline after every 16 chars.
+     */
+    line_buffer = g_malloc(len * 3 + (len / 16));
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
@@ -145,7 +154,7 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_t flags)
  */
 static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 {
-    if (DEBUG_TIS) {
+    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
         tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
                             "tpm_tis: To TPM");
     }
@@ -315,7 +324,7 @@ static void tpm_tis_request_completed(TPMIf *ti, int ret)
     s->loc[locty].state = TPM_TIS_STATE_COMPLETION;
     s->rw_offset = 0;
 
-    if (DEBUG_TIS) {
+    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
         tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
                             "tpm_tis: From TPM");
     }
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 920d32ad5514..c0267d075027 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -36,6 +36,7 @@ tpm_emulator_pre_save(void) ""
 tpm_emulator_inst_init(void) ""
 
 # hw/tpm/tpm_tis.c
+tpm_tis_show_buffer(const char *string, size_t len, const char *line) "tpm_tis: %s length = %zu\n%s"
 tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08x"
 tpm_tis_new_active_locality(uint8_t locty) "Active locality is now %d"
 tpm_tis_abort(uint8_t locty) "New active locality is %d"
-- 
1.8.3.1
