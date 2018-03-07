Received: from eggs.gnu.org ([2001:4830:134:3::10]:54471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1etYYK-0003Z0-PR
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1etYYG-0008NZ-SS
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1etYYG-0008La-JL
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:12 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w27CpRa1134621
	for <qemu-devel@nongnu.org>; Wed, 7 Mar 2018 07:52:11 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gjf2tugnv-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 07:52:10 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 7 Mar 2018 05:52:09 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  7 Mar 2018 07:51:57 -0500
In-Reply-To: <1520427119-6236-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1520427119-6236-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1520427119-6236-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 3/5] tpm: convert tpm_util.c to use
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
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
=20
 /* tpm backend property */
=20
@@ -279,10 +272,11 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion=
 tpm_version,
=20
         if (be32_to_cpu(tpm_resp.hdr.len) !=3D sizeof(tpm_resp) ||
             be32_to_cpu(tpm_resp.len) !=3D sizeof(uint32_t)) {
-            DPRINTF("tpm_resp->hdr.len =3D %u, expected =3D %zu\n",
-                    be32_to_cpu(tpm_resp.hdr.len), sizeof(tpm_resp));
-            DPRINTF("tpm_resp->len =3D %u, expected =3D %zu\n",
-                    be32_to_cpu(tpm_resp.len), sizeof(uint32_t));
+            trace_tpm_util_get_buffer_size_hdr_len(
+                be32_to_cpu(tpm_resp.hdr.len),
+                sizeof(tpm_resp));
+            trace_tpm_util_get_buffer_size_len(be32_to_cpu(tpm_resp.len)=
,
+                                               sizeof(uint32_t));
             error_report("tpm_util: Got unexpected response to "
                          "TPM_GetCapability; errcode: 0x%x",
                          be32_to_cpu(tpm_resp.hdr.errcode));
@@ -327,10 +321,11 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion=
 tpm_version,
=20
         if (be32_to_cpu(tpm2_resp.hdr.len) !=3D sizeof(tpm2_resp) ||
             be32_to_cpu(tpm2_resp.count) !=3D 2) {
-            DPRINTF("tpm2_resp->hdr.len =3D %u, expected =3D %zu\n",
-                    be32_to_cpu(tpm2_resp.hdr.len), sizeof(tpm2_resp));
-            DPRINTF("tpm2_resp->len =3D %u, expected =3D %u\n",
-                    be32_to_cpu(tpm2_resp.count), 2);
+            trace_tpm_util_get_buffer_size_hdr_len2(
+                be32_to_cpu(tpm2_resp.hdr.len),
+                sizeof(tpm2_resp));
+            trace_tpm_util_get_buffer_size_len2(
+                be32_to_cpu(tpm2_resp.count), 2);
             error_report("tpm_util: Got unexpected response to "
                          "TPM2_GetCapability; errcode: 0x%x",
                          be32_to_cpu(tpm2_resp.hdr.errcode));
@@ -344,7 +339,7 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion t=
pm_version,
         return -EFAULT;
     }
=20
-    DPRINTF("buffersize of device: %zu\n", *buffersize);
+    trace_tpm_util_get_buffer_size(*buffersize);
=20
     return 0;
 }
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 8557dd9..66b2b91 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -7,3 +7,10 @@ tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_=
t val) "CRB write 0x" TA
 # hw/tpm/tpm_passthrough.c
 tpm_passthrough_handle_request(void *cmd) "processing command %p"
 tpm_passthrough_reset(void) "reset"
+
+# hw/tpm/tpm_util.c
+tpm_util_get_buffer_size_hdr_len(uint32_t len, size_t expected) "tpm_res=
p->hdr.len =3D %u, expected =3D %zu"
+tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->l=
en =3D %u, expected =3D %zu"
+tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_r=
esp->hdr.len =3D %u, expected =3D %zu"
+tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp-=
>len =3D %u, expected =3D %zu"
+tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
--=20
2.5.5
