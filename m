Received: from eggs.gnu.org ([2001:4830:134:3::10]:56613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dvN8j-0000lq-Sk
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dvN8d-00060A-VG
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:33:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:27337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dvN8d-0005pe-KW
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:32:59 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Fri, 22 Sep 2017 15:33:43 +0300
Message-Id: <1506083624-20621-8-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1506083624-20621-1-git-send-email-amarnath.valluri@intel.com>
References: <1506083624-20621-1-git-send-email-amarnath.valluri@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 7/8] tpm-passthrough: move reusable code to
 utils
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Amarnath Valluri <amarnath.valluri@intel.com>

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_passthrough.c | 64 ++++--------------------------------------------
 hw/tpm/tpm_util.c        | 25 +++++++++++++++++++
 hw/tpm/tpm_util.h        |  4 +++
 3 files changed, 34 insertions(+), 59 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 82e7003..637a6e4 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -68,27 +68,6 @@ typedef struct TPMPassthruState TPMPassthruState;
 
 static void tpm_passthrough_cancel_cmd(TPMBackend *tb);
 
-static int tpm_passthrough_unix_write(int fd, const uint8_t *buf, uint32_t len)
-{
-    int ret, remain;
-
-    remain = len;
-    while (remain > 0) {
-        ret = write(fd, buf, remain);
-        if (ret < 0) {
-            if (errno != EINTR && errno != EAGAIN) {
-                return -1;
-            }
-        } else if (ret == 0) {
-            break;
-        } else {
-            buf += ret;
-            remain -= ret;
-        }
-    }
-    return len - remain;
-}
-
 static int tpm_passthrough_unix_read(int fd, uint8_t *buf, uint32_t len)
 {
     int ret;
@@ -102,45 +81,12 @@ static int tpm_passthrough_unix_read(int fd, uint8_t *buf, uint32_t len)
     }
     return ret;
 }
-
-static uint32_t tpm_passthrough_get_size_from_buffer(const uint8_t *buf)
-{
-    struct tpm_resp_hdr *resp = (struct tpm_resp_hdr *)buf;
-
-    return be32_to_cpu(resp->len);
-}
-
-/*
- * Write an error message in the given output buffer.
- */
-static void tpm_write_fatal_error_response(uint8_t *out, uint32_t out_len)
-{
-    if (out_len >= sizeof(struct tpm_resp_hdr)) {
-        struct tpm_resp_hdr *resp = (struct tpm_resp_hdr *)out;
-
-        resp->tag = cpu_to_be16(TPM_TAG_RSP_COMMAND);
-        resp->len = cpu_to_be32(sizeof(struct tpm_resp_hdr));
-        resp->errcode = cpu_to_be32(TPM_FAIL);
-    }
-}
-
-static bool tpm_passthrough_is_selftest(const uint8_t *in, uint32_t in_len)
-{
-    struct tpm_req_hdr *hdr = (struct tpm_req_hdr *)in;
-
-    if (in_len >= sizeof(*hdr)) {
-        return (be32_to_cpu(hdr->ordinal) == TPM_ORD_ContinueSelfTest);
-    }
-
-    return false;
-}
-
 static int tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
                                         const uint8_t *in, uint32_t in_len,
                                         uint8_t *out, uint32_t out_len,
                                         bool *selftest_done)
 {
-    int ret;
+    ssize_t ret;
     bool is_selftest;
     const struct tpm_resp_hdr *hdr;
 
@@ -148,9 +94,9 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
     tpm_pt->tpm_executing = true;
     *selftest_done = false;
 
-    is_selftest = tpm_passthrough_is_selftest(in, in_len);
+    is_selftest = tpm_util_is_selftest(in, in_len);
 
-    ret = tpm_passthrough_unix_write(tpm_pt->tpm_fd, in, in_len);
+    ret = qemu_write_full(tpm_pt->tpm_fd, (const void *)in, (size_t)in_len);
     if (ret != in_len) {
         if (!tpm_pt->tpm_op_canceled || errno != ECANCELED) {
             error_report("tpm_passthrough: error while transmitting data "
@@ -170,7 +116,7 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
                          strerror(errno), errno);
         }
     } else if (ret < sizeof(struct tpm_resp_hdr) ||
-               tpm_passthrough_get_size_from_buffer(out) != ret) {
+               be32_to_cpu(((struct tpm_resp_hdr *)out)->len) != ret) {
         ret = -1;
         error_report("tpm_passthrough: received invalid response "
                      "packet from TPM");
@@ -183,7 +129,7 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
 
 err_exit:
     if (ret < 0) {
-        tpm_write_fatal_error_response(out, out_len);
+        tpm_util_write_fatal_error_response(out, out_len);
     }
 
     tpm_pt->tpm_executing = false;
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 7b35429..fb929f6 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -24,6 +24,31 @@
 #include "tpm_int.h"
 
 /*
+ * Write an error message in the given output buffer.
+ */
+void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)
+{
+    if (out_len >= sizeof(struct tpm_resp_hdr)) {
+        struct tpm_resp_hdr *resp = (struct tpm_resp_hdr *)out;
+
+        resp->tag = cpu_to_be16(TPM_TAG_RSP_COMMAND);
+        resp->len = cpu_to_be32(sizeof(struct tpm_resp_hdr));
+        resp->errcode = cpu_to_be32(TPM_FAIL);
+    }
+}
+
+bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len)
+{
+    struct tpm_req_hdr *hdr = (struct tpm_req_hdr *)in;
+
+    if (in_len >= sizeof(*hdr)) {
+        return (be32_to_cpu(hdr->ordinal) == TPM_ORD_ContinueSelfTest);
+    }
+
+    return false;
+}
+
+/*
  * A basic test of a TPM device. We expect a well formatted response header
  * (error response is fine) within one second.
  */
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index df76245..2f7c961 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -24,6 +24,10 @@
 
 #include "sysemu/tpm_backend.h"
 
+void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len);
+
+bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len);
+
 int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version);
 
 #endif /* TPM_TPM_UTIL_H */
-- 
2.7.4
