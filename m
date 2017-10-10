Received: from eggs.gnu.org ([2001:4830:134:3::10]:41750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1jRJ-0003qS-G7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 21:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1jRG-0000JK-Ao
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 21:34:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51130
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1jRG-0000Ix-5d
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 21:34:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9A1Y9Bn017404
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 21:34:24 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dgh9fr922-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 21:34:24 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 19:34:23 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon,  9 Oct 2017 21:33:52 -0400
In-Reply-To: <1507599235-25123-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507599235-25123-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1507599235-25123-8-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 07/10] tpm-passthrough: move reusable code to
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
Cc: Peter Maydell <peter.maydell@linaro.org>, amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Amarnath Valluri <amarnath.valluri@intel.com>

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c | 64 ++++--------------------------------------=
------
 hw/tpm/tpm_util.c        | 25 +++++++++++++++++++
 hw/tpm/tpm_util.h        |  4 +++
 3 files changed, 34 insertions(+), 59 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 22d3460..e6ace28 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -68,27 +68,6 @@ typedef struct TPMPassthruState TPMPassthruState;
=20
 static void tpm_passthrough_cancel_cmd(TPMBackend *tb);
=20
-static int tpm_passthrough_unix_write(int fd, const uint8_t *buf, uint32=
_t len)
-{
-    int ret, remain;
-
-    remain =3D len;
-    while (remain > 0) {
-        ret =3D write(fd, buf, remain);
-        if (ret < 0) {
-            if (errno !=3D EINTR && errno !=3D EAGAIN) {
-                return -1;
-            }
-        } else if (ret =3D=3D 0) {
-            break;
-        } else {
-            buf +=3D ret;
-            remain -=3D ret;
-        }
-    }
-    return len - remain;
-}
-
 static int tpm_passthrough_unix_read(int fd, uint8_t *buf, uint32_t len)
 {
     int ret;
@@ -102,45 +81,12 @@ static int tpm_passthrough_unix_read(int fd, uint8_t=
 *buf, uint32_t len)
     }
     return ret;
 }
-
-static uint32_t tpm_passthrough_get_size_from_buffer(const uint8_t *buf)
-{
-    struct tpm_resp_hdr *resp =3D (struct tpm_resp_hdr *)buf;
-
-    return be32_to_cpu(resp->len);
-}
-
-/*
- * Write an error message in the given output buffer.
- */
-static void tpm_write_fatal_error_response(uint8_t *out, uint32_t out_le=
n)
-{
-    if (out_len >=3D sizeof(struct tpm_resp_hdr)) {
-        struct tpm_resp_hdr *resp =3D (struct tpm_resp_hdr *)out;
-
-        resp->tag =3D cpu_to_be16(TPM_TAG_RSP_COMMAND);
-        resp->len =3D cpu_to_be32(sizeof(struct tpm_resp_hdr));
-        resp->errcode =3D cpu_to_be32(TPM_FAIL);
-    }
-}
-
-static bool tpm_passthrough_is_selftest(const uint8_t *in, uint32_t in_l=
en)
-{
-    struct tpm_req_hdr *hdr =3D (struct tpm_req_hdr *)in;
-
-    if (in_len >=3D sizeof(*hdr)) {
-        return (be32_to_cpu(hdr->ordinal) =3D=3D TPM_ORD_ContinueSelfTes=
t);
-    }
-
-    return false;
-}
-
 static int tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
                                         const uint8_t *in, uint32_t in_l=
en,
                                         uint8_t *out, uint32_t out_len,
                                         bool *selftest_done)
 {
-    int ret;
+    ssize_t ret;
     bool is_selftest;
     const struct tpm_resp_hdr *hdr;
=20
@@ -148,9 +94,9 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthruSta=
te *tpm_pt,
     tpm_pt->tpm_executing =3D true;
     *selftest_done =3D false;
=20
-    is_selftest =3D tpm_passthrough_is_selftest(in, in_len);
+    is_selftest =3D tpm_util_is_selftest(in, in_len);
=20
-    ret =3D tpm_passthrough_unix_write(tpm_pt->tpm_fd, in, in_len);
+    ret =3D qemu_write_full(tpm_pt->tpm_fd, (const void *)in, (size_t)in=
_len);
     if (ret !=3D in_len) {
         if (!tpm_pt->tpm_op_canceled || errno !=3D ECANCELED) {
             error_report("tpm_passthrough: error while transmitting data=
 "
@@ -170,7 +116,7 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthruSt=
ate *tpm_pt,
                          strerror(errno), errno);
         }
     } else if (ret < sizeof(struct tpm_resp_hdr) ||
-               tpm_passthrough_get_size_from_buffer(out) !=3D ret) {
+               be32_to_cpu(((struct tpm_resp_hdr *)out)->len) !=3D ret) =
{
         ret =3D -1;
         error_report("tpm_passthrough: received invalid response "
                      "packet from TPM");
@@ -183,7 +129,7 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthruSt=
ate *tpm_pt,
=20
 err_exit:
     if (ret < 0) {
-        tpm_write_fatal_error_response(out, out_len);
+        tpm_util_write_fatal_error_response(out, out_len);
     }
=20
     tpm_pt->tpm_executing =3D false;
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 7b35429..fb929f6 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -24,6 +24,31 @@
 #include "tpm_int.h"
=20
 /*
+ * Write an error message in the given output buffer.
+ */
+void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)
+{
+    if (out_len >=3D sizeof(struct tpm_resp_hdr)) {
+        struct tpm_resp_hdr *resp =3D (struct tpm_resp_hdr *)out;
+
+        resp->tag =3D cpu_to_be16(TPM_TAG_RSP_COMMAND);
+        resp->len =3D cpu_to_be32(sizeof(struct tpm_resp_hdr));
+        resp->errcode =3D cpu_to_be32(TPM_FAIL);
+    }
+}
+
+bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len)
+{
+    struct tpm_req_hdr *hdr =3D (struct tpm_req_hdr *)in;
+
+    if (in_len >=3D sizeof(*hdr)) {
+        return (be32_to_cpu(hdr->ordinal) =3D=3D TPM_ORD_ContinueSelfTes=
t);
+    }
+
+    return false;
+}
+
+/*
  * A basic test of a TPM device. We expect a well formatted response hea=
der
  * (error response is fine) within one second.
  */
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index df76245..2f7c961 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -24,6 +24,10 @@
=20
 #include "sysemu/tpm_backend.h"
=20
+void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)=
;
+
+bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len);
+
 int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version);
=20
 #endif /* TPM_TPM_UTIL_H */
--=20
2.5.5
