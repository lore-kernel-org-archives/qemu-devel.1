Received: from eggs.gnu.org ([2001:4830:134:3::10]:33336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1esbcb-000240-LU
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1esbcX-0004lz-8b
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:56:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43286
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1esbcX-0004lr-2k
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:56:41 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w24Ls5lp054540
	for <qemu-devel@nongnu.org>; Sun, 4 Mar 2018 16:56:40 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gga95cy8m-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 04 Mar 2018 16:56:39 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sun, 4 Mar 2018 14:56:39 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sun,  4 Mar 2018 16:56:26 -0500
In-Reply-To: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1520200587-14681-5-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/5] tpm: convert tpm_emulator.c to use
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
 hw/tpm/tpm_emulator.c | 45 +++++++++++++++++++++++----------------------
 hw/tpm/trace-events   | 14 ++++++++++++++
 2 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index b787aee..d0da10a 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -39,14 +39,7 @@
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
 #include "chardev/char-fe.h"
-
-#define DEBUG_TPM 0
-
-#define DPRINTF(fmt, ...) do { \
-    if (DEBUG_TPM) { \
-        fprintf(stderr, "tpm-emulator:"fmt"\n", ## __VA_ARGS__); \
-    } \
-} while (0)
+#include "trace.h"
 
 #define TYPE_TPM_EMULATOR "tpm-emulator"
 #define TPM_EMULATOR(obj) \
@@ -151,13 +144,12 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t locty_number,
 {
     ptm_loc loc;
 
-    DPRINTF("%s : locality: 0x%x", __func__, locty_number);
-
     if (tpm_emu->cur_locty_number == locty_number) {
         return 0;
     }
 
-    DPRINTF("setting locality : 0x%x", locty_number);
+    trace_tpm_emulator_set_locality(locty_number);
+
     loc.u.req.loc = locty_number;
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_LOCALITY, &loc,
                              sizeof(loc), sizeof(loc)) < 0) {
@@ -183,7 +175,7 @@ static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
 
-    DPRINTF("processing TPM command");
+    trace_tpm_emulator_handle_request();
 
     if (tpm_emulator_set_locality(tpm_emu, cmd->locty, errp) < 0 ||
         tpm_emulator_unix_tx_bufs(tpm_emu, cmd->in, cmd->in_len,
@@ -195,7 +187,6 @@ static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
 
 static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
 {
-    DPRINTF("%s", __func__);
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY,
                              &tpm_emu->caps, 0, sizeof(tpm_emu->caps)) < 0) {
         error_report("tpm-emulator: probing failed : %s", strerror(errno));
@@ -204,7 +195,7 @@ static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
 
     tpm_emu->caps = be64_to_cpu(tpm_emu->caps);
 
-    DPRINTF("capabilities : 0x%"PRIx64, tpm_emu->caps);
+    trace_tpm_emulator_probe_caps(tpm_emu->caps);
 
     return 0;
 }
@@ -293,7 +284,7 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
         *actual_size = be32_to_cpu(psbs.u.resp.buffersize);
     }
 
-    DPRINTF("buffer size: %u, min: %u, max: %u\n",
+    trace_tpm_emulator_set_buffer_size(
             be32_to_cpu(psbs.u.resp.buffersize),
             be32_to_cpu(psbs.u.resp.minsize),
             be32_to_cpu(psbs.u.resp.maxsize));
@@ -314,7 +305,7 @@ static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
         goto err_exit;
     }
 
-    DPRINTF("%s", __func__);
+    trace_tpm_emulator_startup_tpm();
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
                              sizeof(init)) < 0) {
         error_report("tpm-emulator: could not send INIT: %s",
@@ -348,7 +339,7 @@ static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
                      strerror(errno));
         return false;
     }
-    DPRINTF("got established flag: %0x", est.u.resp.bit);
+    trace_tpm_emulator_get_tpm_established_flag(est.u.resp.bit);
 
     tpm_emu->established_flag_cached = 1;
     tpm_emu->established_flag = (est.u.resp.bit != 0);
@@ -395,7 +386,7 @@ static void tpm_emulator_cancel_cmd(TPMBackend *tb)
     ptm_res res;
 
     if (!TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_emu, PTM_CAP_CANCEL_TPM_CMD)) {
-        DPRINTF("Backend does not support CANCEL_TPM_CMD");
+        trace_tpm_emulator_cancel_cmd_not_supt();
         return;
     }
 
@@ -521,8 +512,16 @@ static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, QemuOpts *opts)
         goto err;
     }
 
-    DPRINTF("TPM Version %s", tpm_emu->tpm_version == TPM_VERSION_1_2 ? "1.2" :
-            (tpm_emu->tpm_version == TPM_VERSION_2_0 ?  "2.0" : "Unspecified"));
+    switch (tpm_emu->tpm_version) {
+    case TPM_VERSION_1_2:
+        trace_tpm_emulator_handle_device_opts_tpm12();
+        break;
+    case TPM_VERSION_2_0:
+        trace_tpm_emulator_handle_device_opts_tpm2();
+        break;
+    default:
+        trace_tpm_emulator_handle_device_opts_unspec();
+    }
 
     if (tpm_emulator_probe_caps(tpm_emu) ||
         tpm_emulator_check_caps(tpm_emu)) {
@@ -532,7 +531,8 @@ static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, QemuOpts *opts)
     return tpm_emulator_block_migration(tpm_emu);
 
 err:
-    DPRINTF("Startup error");
+    trace_tpm_emulator_handle_device_opts_startup_error();
+
     return -1;
 }
 
@@ -573,7 +573,8 @@ static void tpm_emulator_inst_init(Object *obj)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(obj);
 
-    DPRINTF("%s", __func__);
+    trace_tpm_emulator_inst_init();
+
     tpm_emu->options = g_new0(TPMEmulatorOptions, 1);
     tpm_emu->cur_locty_number = ~0;
     qemu_mutex_init(&tpm_emu->mutex);
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 66b2b91..fe88fa6 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -14,3 +14,17 @@ tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->len = %u,
 tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_resp->hdr.len = %u, expected = %zu"
 tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp->len = %u, expected = %zu"
 tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
+
+# hw/tpm/tpm_emulator.c
+tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
+tpm_emulator_handle_request(void) "processing TPM command"
+tpm_emulator_probe_caps(uint64_t caps) "capabilities: 0x%"PRIx64
+tpm_emulator_set_buffer_size(uint32_t buffersize, uint32_t minsize, uint32_t maxsize) "buffer size: %u, min: %u, max: %u"
+tpm_emulator_startup_tpm(void) "startup"
+tpm_emulator_get_tpm_established_flag(uint8_t flag) "got established flag: %d"
+tpm_emulator_cancel_cmd_not_supt(void) "Backend does not support CANCEL_TPM_CMD"
+tpm_emulator_handle_device_opts_tpm12(void) "TPM Version 1.2"
+tpm_emulator_handle_device_opts_tpm2(void) "TPM Version 2"
+tpm_emulator_handle_device_opts_unspec(void) "TPM Version Unspecified"
+tpm_emulator_handle_device_opts_startup_error(void) "Startup error"
+tpm_emulator_inst_init(void) ""
-- 
2.5.5
