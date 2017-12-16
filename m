Received: from eggs.gnu.org ([2001:4830:134:3::10]:46144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGU6-0006Rq-4h
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGU2-0000Lt-6h
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47238
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGU2-0000Le-0l
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:46 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdU4i134488
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:45 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ew0h5k78t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:45 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:44 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:47 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-31-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 30/32] tpm: tpm_passthrough: Read the buffer
 size from the host device
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

Rather than hard coding the buffer size in the tpm_passthrough
backend read the TPM I/O buffer size from the host device.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_int.h         |   9 ++++
 hw/tpm/tpm_passthrough.c |  11 ++++-
 hw/tpm/tpm_util.c        | 115 +++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/tpm/tpm_util.h        |   3 ++
 4 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index 1df5883..abbca51 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -45,11 +45,20 @@ struct tpm_resp_hdr {
=20
 #define TPM_ORD_ContinueSelfTest  0x53
 #define TPM_ORD_GetTicks          0xf1
+#define TPM_ORD_GetCapability     0x65
=20
+#define TPM_CAP_PROPERTY          0x05
+
+#define TPM_CAP_PROP_INPUT_BUFFER 0x124
=20
 /* TPM2 defines */
 #define TPM2_ST_NO_SESSIONS       0x8001
=20
 #define TPM2_CC_ReadClock         0x00000181
+#define TPM2_CC_GetCapability     0x0000017a
+
+#define TPM2_CAP_TPM_PROPERTIES   0x6
+
+#define TPM2_PT_MAX_COMMAND_SIZE  0x11e
=20
 #endif /* TPM_TPM_INT_H */
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index daac67d..886af9e 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -57,6 +57,7 @@ struct TPMPassthruState {
     int cancel_fd;
=20
     TPMVersion tpm_version;
+    size_t tpm_buffersize;
 };
=20
 typedef struct TPMPassthruState TPMPassthruState;
@@ -201,7 +202,15 @@ static TPMVersion tpm_passthrough_get_tpm_version(TP=
MBackend *tb)
=20
 static size_t tpm_passthrough_get_buffer_size(TPMBackend *tb)
 {
-    return 4096;
+    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
+    int ret;
+
+    ret =3D tpm_util_get_buffer_size(tpm_pt->tpm_fd, tpm_pt->tpm_version=
,
+                                   &tpm_pt->tpm_buffersize);
+    if (ret < 0) {
+        tpm_pt->tpm_buffersize =3D 4096;
+    }
+    return tpm_pt->tpm_buffersize;
 }
=20
 /*
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index b852f53..a317243 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -20,10 +20,19 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "tpm_util.h"
 #include "tpm_int.h"
 #include "exec/memory.h"
=20
+#define DEBUG_TPM 0
+
+#define DPRINTF(fmt, ...) do { \
+    if (DEBUG_TPM) { \
+        fprintf(stderr, "tpm-util:"fmt"\n", ## __VA_ARGS__); \
+    } \
+} while (0)
+
 /*
  * Write an error message in the given output buffer.
  */
@@ -173,3 +182,109 @@ int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tp=
m_version)
=20
     return 1;
 }
+
+int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
+                             size_t *buffersize)
+{
+    unsigned char buf[1024];
+    int ret;
+
+    switch (tpm_version) {
+    case TPM_VERSION_1_2: {
+        const struct tpm_req_get_buffer_size {
+            struct tpm_req_hdr hdr;
+            uint32_t capability;
+            uint32_t len;
+            uint32_t subcap;
+        } QEMU_PACKED tpm_get_buffer_size =3D {
+            .hdr =3D {
+                .tag =3D cpu_to_be16(TPM_TAG_RQU_COMMAND),
+                .len =3D cpu_to_be32(sizeof(tpm_get_buffer_size)),
+                .ordinal =3D cpu_to_be32(TPM_ORD_GetCapability),
+            },
+            .capability =3D cpu_to_be32(TPM_CAP_PROPERTY),
+            .len =3D cpu_to_be32(sizeof(uint32_t)),
+            .subcap =3D cpu_to_be32(TPM_CAP_PROP_INPUT_BUFFER),
+        };
+        struct tpm_resp_get_buffer_size {
+            struct tpm_resp_hdr hdr;
+            uint32_t len;
+            uint32_t buffersize;
+        } QEMU_PACKED *tpm_resp =3D (struct tpm_resp_get_buffer_size *)b=
uf;
+
+        ret =3D tpm_util_request(tpm_fd, (unsigned char *)&tpm_get_buffe=
r_size,
+                               sizeof(tpm_get_buffer_size), buf, sizeof(=
buf));
+        if (ret < 0) {
+            return ret;
+        }
+
+        if (be32_to_cpu(tpm_resp->hdr.len) !=3D sizeof(*tpm_resp) ||
+            be32_to_cpu(tpm_resp->len) !=3D sizeof(uint32_t)) {
+            DPRINTF("tpm_resp->hdr.len =3D %u, expected =3D %zu\n",
+                    be32_to_cpu(tpm_resp->hdr.len), sizeof(*tpm_resp));
+            DPRINTF("tpm_resp->len =3D %u, expected =3D %zu\n",
+                    be32_to_cpu(tpm_resp->len), sizeof(uint32_t));
+            error_report("tpm_util: Got unexpected response to "
+                         "TPM_GetCapability; errcode: 0x%x",
+                         be32_to_cpu(tpm_resp->hdr.errcode));
+            return -EFAULT;
+        }
+        *buffersize =3D be32_to_cpu(tpm_resp->buffersize);
+        break;
+    }
+    case TPM_VERSION_2_0: {
+        const struct tpm2_req_get_buffer_size {
+            struct tpm_req_hdr hdr;
+            uint32_t capability;
+            uint32_t property;
+            uint32_t count;
+        } QEMU_PACKED tpm2_get_buffer_size =3D {
+            .hdr =3D {
+                .tag =3D cpu_to_be16(TPM2_ST_NO_SESSIONS),
+                .len =3D cpu_to_be32(sizeof(tpm2_get_buffer_size)),
+                .ordinal =3D cpu_to_be32(TPM2_CC_GetCapability),
+            },
+            .capability =3D cpu_to_be32(TPM2_CAP_TPM_PROPERTIES),
+            .property =3D cpu_to_be32(TPM2_PT_MAX_COMMAND_SIZE),
+            .count =3D cpu_to_be32(2), /* also get TPM2_PT_MAX_RESPONSE_=
SIZE */
+        };
+        struct tpm2_resp_get_buffer_size {
+            struct tpm_resp_hdr hdr;
+            uint8_t more;
+            uint32_t capability;
+            uint32_t count;
+            uint32_t property1;
+            uint32_t value1;
+            uint32_t property2;
+            uint32_t value2;
+        } QEMU_PACKED *tpm2_resp =3D (struct tpm2_resp_get_buffer_size *=
)buf;
+
+        ret =3D tpm_util_request(tpm_fd, (unsigned char *)&tpm2_get_buff=
er_size,
+                               sizeof(tpm2_get_buffer_size), buf, sizeof=
(buf));
+        if (ret < 0) {
+            return ret;
+        }
+
+        if (be32_to_cpu(tpm2_resp->hdr.len) !=3D sizeof(*tpm2_resp) ||
+            be32_to_cpu(tpm2_resp->count) !=3D 2) {
+            DPRINTF("tpm2_resp->hdr.len =3D %u, expected =3D %zu\n",
+                    be32_to_cpu(tpm2_resp->hdr.len), sizeof(*tpm2_resp))=
;
+            DPRINTF("tpm2_resp->len =3D %u, expected =3D %u\n",
+                    be32_to_cpu(tpm2_resp->count), 2);
+            error_report("tpm_util: Got unexpected response to "
+                         "TPM2_GetCapability; errcode: 0x%x",
+                         be32_to_cpu(tpm2_resp->hdr.errcode));
+            return -EFAULT;
+        }
+        *buffersize =3D MAX(be32_to_cpu(tpm2_resp->value1),
+                          be32_to_cpu(tpm2_resp->value2));
+        break;
+    }
+    case TPM_VERSION_UNSPEC:
+        return -EFAULT;
+    }
+
+    DPRINTF("buffersize of device: %zu\n", *buffersize);
+
+    return 0;
+}
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index aca10c9..1c17e39 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -36,4 +36,7 @@ static inline uint32_t tpm_cmd_get_size(const void *b)
     return be32_to_cpu(*(const uint32_t *)(b + 2));
 }
=20
+int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
+                             size_t *buffersize);
+
 #endif /* TPM_TPM_UTIL_H */
--=20
2.5.5
