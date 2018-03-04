Received: from eggs.gnu.org ([2001:4830:134:3::10]:33318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1esbcY-00022r-TV
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1esbcT-0004lG-Sg
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:56:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51902
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1esbcT-0004l4-NF
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:56:37 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w24Ls6FO053030
	for <qemu-devel@nongnu.org>; Sun, 4 Mar 2018 16:56:37 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gg9wvdhhd-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 04 Mar 2018 16:56:36 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sun, 4 Mar 2018 14:56:36 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sun,  4 Mar 2018 16:56:24 -0500
In-Reply-To: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1520200587-14681-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/5] tpm: convert tpm_passthrough.c to use
 trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, dgilbert@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c | 13 +++----------
 hw/tpm/trace-events      |  4 ++++
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index a495fe0..2589c4d 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -31,14 +31,7 @@
 #include "hw/hw.h"
 #include "qapi/clone-visitor.h"
 #include "tpm_util.h"
-
-#define DEBUG_TPM 0
-
-#define DPRINTF(fmt, ...) do { \
-    if (DEBUG_TPM) { \
-        fprintf(stderr, fmt, ## __VA_ARGS__); \
-    } \
-} while (0)
+#include "trace.h"
 
 #define TYPE_TPM_PASSTHROUGH "tpm-passthrough"
 #define TPM_PASSTHROUGH(obj) \
@@ -137,7 +130,7 @@ static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
 {
     TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
 
-    DPRINTF("tpm_passthrough: processing command %p\n", cmd);
+    trace_tpm_passthrough_handle_request(cmd);
 
     tpm_passthrough_unix_tx_bufs(tpm_pt, cmd->in, cmd->in_len,
                                  cmd->out, cmd->out_len, &cmd->selftest_done,
@@ -146,7 +139,7 @@ static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
 
 static void tpm_passthrough_reset(TPMBackend *tb)
 {
-    DPRINTF("tpm_passthrough: CALL TO TPM_RESET!\n");
+    trace_tpm_passthrough_reset();
 
     tpm_passthrough_cancel_cmd(tb);
 }
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 336b06d..8557dd9 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -3,3 +3,7 @@
 # hw/tpm/tpm_crb.c
 tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
 tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
+
+# hw/tpm/tpm_passthrough.c
+tpm_passthrough_handle_request(void *cmd) "processing command %p"
+tpm_passthrough_reset(void) "reset"
-- 
2.5.5
