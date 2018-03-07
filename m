Received: from eggs.gnu.org ([2001:4830:134:3::10]:54443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1etYYH-0003Xt-J5
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1etYYD-0008Hj-HF
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53476
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1etYYD-0008Gh-B3
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:09 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w27Co1dw119297
	for <qemu-devel@nongnu.org>; Wed, 7 Mar 2018 07:52:08 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gjdpq718r-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 07:52:08 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 7 Mar 2018 05:52:07 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  7 Mar 2018 07:51:56 -0500
In-Reply-To: <1520427119-6236-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1520427119-6236-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1520427119-6236-3-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 2/5] tpm: convert tpm_passthrough.c to use
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
=20
 #define TYPE_TPM_PASSTHROUGH "tpm-passthrough"
 #define TPM_PASSTHROUGH(obj) \
@@ -137,7 +130,7 @@ static void tpm_passthrough_handle_request(TPMBackend=
 *tb, TPMBackendCmd *cmd,
 {
     TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
=20
-    DPRINTF("tpm_passthrough: processing command %p\n", cmd);
+    trace_tpm_passthrough_handle_request(cmd);
=20
     tpm_passthrough_unix_tx_bufs(tpm_pt, cmd->in, cmd->in_len,
                                  cmd->out, cmd->out_len, &cmd->selftest_=
done,
@@ -146,7 +139,7 @@ static void tpm_passthrough_handle_request(TPMBackend=
 *tb, TPMBackendCmd *cmd,
=20
 static void tpm_passthrough_reset(TPMBackend *tb)
 {
-    DPRINTF("tpm_passthrough: CALL TO TPM_RESET!\n");
+    trace_tpm_passthrough_reset();
=20
     tpm_passthrough_cancel_cmd(tb);
 }
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 336b06d..8557dd9 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -3,3 +3,7 @@
 # hw/tpm/tpm_crb.c
 tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read =
0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
 tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB writ=
e 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
+
+# hw/tpm/tpm_passthrough.c
+tpm_passthrough_handle_request(void *cmd) "processing command %p"
+tpm_passthrough_reset(void) "reset"
--=20
2.5.5
