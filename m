Received: from eggs.gnu.org ([2001:4830:134:3::10]:33334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1esbcb-00023u-IR
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1esbcW-0004ln-Mq
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:56:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1esbcW-0004lb-Dn
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 16:56:40 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w24LuVbW055587
	for <qemu-devel@nongnu.org>; Sun, 4 Mar 2018 16:56:38 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gga4fw5cq-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 04 Mar 2018 16:56:38 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sun, 4 Mar 2018 14:56:37 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sun,  4 Mar 2018 16:56:25 -0500
In-Reply-To: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1520200587-14681-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1520200587-14681-4-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/5] tpm: convert tpm_util.c to use trace-events
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
 hw/tpm/tpm_util.c   | 29 ++++++++++++-----------------
 hw/tpm/trace-events |  7 +++++++
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 2de52a0..ee41757 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -28,14 +28,7 @@
 #include "exec/memory.h"
 #include "sysemu/tpm_backend.h"
 #include "hw/qdev.h"
-
-#define DEBUG_TPM 0
-
-#define DPRINTF(fmt, ...) do { \
-    if (DEBUG_TPM) { \
-        fprintf(stderr, "tpm-util:"fmt"\n", ## __VA_ARGS__); \
-    } \
-} while (0)
+#include "trace.h"
 
 /* tpm backend property */
 
@@ -279,10 +272,11 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
 
         if (be32_to_cpu(tpm_resp.hdr.len) != sizeof(tpm_resp) ||
             be32_to_cpu(tpm_resp.len) != sizeof(uint32_t)) {
-            DPRINTF("tpm_resp->hdr.len = %u, expected = %zu\n",
-                    be32_to_cpu(tpm_resp.hdr.len), sizeof(tpm_resp));
-            DPRINTF("tpm_resp->len = %u, expected = %zu\n",
-                    be32_to_cpu(tpm_resp.len), sizeof(uint32_t));
+            trace_tpm_util_get_buffer_size_hdr_len(
+                be32_to_cpu(tpm_resp.hdr.len),
+                sizeof(tpm_resp));
+            trace_tpm_util_get_buffer_size_len(be32_to_cpu(tpm_resp.len),
+                                               sizeof(uint32_t));
             error_report("tpm_util: Got unexpected response to "
                          "TPM_GetCapability; errcode: 0x%x",
                          be32_to_cpu(tpm_resp.hdr.errcode));
@@ -327,10 +321,11 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
 
         if (be32_to_cpu(tpm2_resp.hdr.len) != sizeof(tpm2_resp) ||
             be32_to_cpu(tpm2_resp.count) != 2) {
-            DPRINTF("tpm2_resp->hdr.len = %u, expected = %zu\n",
-                    be32_to_cpu(tpm2_resp.hdr.len), sizeof(tpm2_resp));
-            DPRINTF("tpm2_resp->len = %u, expected = %u\n",
-                    be32_to_cpu(tpm2_resp.count), 2);
+            trace_tpm_util_get_buffer_size_hdr_len2(
+                be32_to_cpu(tpm2_resp.hdr.len),
+                sizeof(tpm2_resp));
+            trace_tpm_util_get_buffer_size_len2(
+                be32_to_cpu(tpm2_resp.count), 2);
             error_report("tpm_util: Got unexpected response to "
                          "TPM2_GetCapability; errcode: 0x%x",
                          be32_to_cpu(tpm2_resp.hdr.errcode));
@@ -344,7 +339,7 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
         return -EFAULT;
     }
 
-    DPRINTF("buffersize of device: %zu\n", *buffersize);
+    trace_tpm_util_get_buffer_size(*buffersize);
 
     return 0;
 }
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 8557dd9..66b2b91 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -7,3 +7,10 @@ tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x" TA
 # hw/tpm/tpm_passthrough.c
 tpm_passthrough_handle_request(void *cmd) "processing command %p"
 tpm_passthrough_reset(void) "reset"
+
+# hw/tpm/tpm_util.c
+tpm_util_get_buffer_size_hdr_len(uint32_t len, size_t expected) "tpm_resp->hdr.len = %u, expected = %zu"
+tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->len = %u, expected = %zu"
+tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_resp->hdr.len = %u, expected = %zu"
+tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp->len = %u, expected = %zu"
+tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
-- 
2.5.5
