Received: from eggs.gnu.org ([2001:4830:134:3::10]:34997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1egHs0-0004Zh-RJ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 17:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1egHrx-0005tf-KR
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 17:25:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1egHrx-0005tA-B5
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 17:25:41 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0TMNhYi050686
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 17:25:40 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ft8bc2471-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 17:25:39 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 29 Jan 2018 17:25:38 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 29 Jan 2018 17:25:15 -0500
In-Reply-To: <1517264719-18288-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517264719-18288-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1517264719-18288-3-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 2/6] tpm: fix alignment issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, peter.maydell@linaro.org

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The new tpm-crb-test fails on sparc host:

TEST: tests/tpm-crb-test... (pid=3D230409)
  /i386/tpm-crb/test:
Broken pipe
FAIL
GTester: last random seed: R02S29cea50247fe1efa59ee885a26d51a85
(pid=3D230423)
FAIL: tests/tpm-crb-test

and generates a new clang sanitizer runtime warning:

/home/petmay01/linaro/qemu-for-merges/hw/tpm/tpm_util.h:36:24: runtime
error: load of misaligned address 0x7fdc24c00002 for type 'const
uint32_t' (aka 'const unsigned int'), which requires 4 byte alignment
0x7fdc24c00002: note: pointer points here
<memory cannot be printed>

The sparc architecture does not allow misaligned loads and will
segfault if you try them.  For example, this function:

static inline uint32_t tpm_cmd_get_size(const void *b)
{
    return be32_to_cpu(*(const uint32_t *)(b + 2));
}

Should read,
    return ldl_be_p(b + 2);

As a general rule you can't take an arbitrary pointer into a byte
buffer and try to interpret it as a structure or a pointer to a
larger-than-bytesize-data simply by casting the pointer.

Use this clean up as an opportunity to remove unnecessary temporary
buffers and casts.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_emulator.c    | 14 ++++-----
 hw/tpm/tpm_passthrough.c |  6 ++--
 hw/tpm/tpm_util.c        | 75 ++++++++++++++++++++++--------------------=
------
 hw/tpm/tpm_util.h        | 17 ++++++++++-
 4 files changed, 58 insertions(+), 54 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 532d3e3..81bf7d1 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -120,7 +120,6 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm=
_emu,
 {
     ssize_t ret;
     bool is_selftest =3D false;
-    const struct tpm_resp_hdr *hdr =3D NULL;
=20
     if (selftest_done) {
         *selftest_done =3D false;
@@ -132,22 +131,21 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *t=
pm_emu,
         return -1;
     }
=20
-    ret =3D qio_channel_read_all(tpm_emu->data_ioc, (char *)out, sizeof(=
*hdr),
-                               err);
+    ret =3D qio_channel_read_all(tpm_emu->data_ioc, (char *)out,
+              sizeof(struct tpm_resp_hdr), err);
     if (ret !=3D 0) {
         return -1;
     }
=20
-    hdr =3D (struct tpm_resp_hdr *)out;
-    out +=3D sizeof(*hdr);
-    ret =3D qio_channel_read_all(tpm_emu->data_ioc, (char *)out,
-                               be32_to_cpu(hdr->len) - sizeof(*hdr) , er=
r);
+    ret =3D qio_channel_read_all(tpm_emu->data_ioc,
+              (char *)out + sizeof(struct tpm_resp_hdr),
+              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), err);
     if (ret !=3D 0) {
         return -1;
     }
=20
     if (is_selftest) {
-        *selftest_done =3D (be32_to_cpu(hdr->errcode) =3D=3D 0);
+        *selftest_done =3D tpm_cmd_get_errcode(out) =3D=3D 0;
     }
=20
     return 0;
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 29142f3..537e11a 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -87,7 +87,6 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthruStat=
e *tpm_pt,
 {
     ssize_t ret;
     bool is_selftest;
-    const struct tpm_resp_hdr *hdr;
=20
     /* FIXME: protect shared variables or use other sync mechanism */
     tpm_pt->tpm_op_canceled =3D false;
@@ -116,15 +115,14 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthru=
State *tpm_pt,
                          strerror(errno), errno);
         }
     } else if (ret < sizeof(struct tpm_resp_hdr) ||
-               be32_to_cpu(((struct tpm_resp_hdr *)out)->len) !=3D ret) =
{
+               tpm_cmd_get_size(out) !=3D ret) {
         ret =3D -1;
         error_report("tpm_passthrough: received invalid response "
                      "packet from TPM");
     }
=20
     if (is_selftest && (ret >=3D sizeof(struct tpm_resp_hdr))) {
-        hdr =3D (struct tpm_resp_hdr *)out;
-        *selftest_done =3D (be32_to_cpu(hdr->errcode) =3D=3D 0);
+        *selftest_done =3D tpm_cmd_get_errcode(out) =3D=3D 0;
     }
=20
 err_exit:
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 747075e..8abde59 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -106,20 +106,16 @@ const PropertyInfo qdev_prop_tpm =3D {
 void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)
 {
     if (out_len >=3D sizeof(struct tpm_resp_hdr)) {
-        struct tpm_resp_hdr *resp =3D (struct tpm_resp_hdr *)out;
-
-        resp->tag =3D cpu_to_be16(TPM_TAG_RSP_COMMAND);
-        resp->len =3D cpu_to_be32(sizeof(struct tpm_resp_hdr));
-        resp->errcode =3D cpu_to_be32(TPM_FAIL);
+        stw_be_p(out, TPM_TAG_RSP_COMMAND);
+        stl_be_p(out + 2, sizeof(struct tpm_resp_hdr));
+        stl_be_p(out + 6, TPM_FAIL);
     }
 }
=20
 bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len)
 {
-    struct tpm_req_hdr *hdr =3D (struct tpm_req_hdr *)in;
-
-    if (in_len >=3D sizeof(*hdr)) {
-        return (be32_to_cpu(hdr->ordinal) =3D=3D TPM_ORD_ContinueSelfTes=
t);
+    if (in_len >=3D sizeof(struct tpm_req_hdr)) {
+        return tpm_cmd_get_ordinal(in) =3D=3D TPM_ORD_ContinueSelfTest;
     }
=20
     return false;
@@ -129,12 +125,11 @@ bool tpm_util_is_selftest(const uint8_t *in, uint32=
_t in_len)
  * Send request to a TPM device. We expect a response within one second.
  */
 static int tpm_util_request(int fd,
-                            unsigned char *request,
+                            const void *request,
                             size_t requestlen,
-                            unsigned char *response,
+                            void *response,
                             size_t responselen)
 {
-    struct tpm_resp_hdr *resp;
     fd_set readfds;
     int n;
     struct timeval tv =3D {
@@ -164,9 +159,8 @@ static int tpm_util_request(int fd,
         return -EFAULT;
     }
=20
-    resp =3D (struct tpm_resp_hdr *)response;
     /* check the header */
-    if (be32_to_cpu(resp->len) !=3D n) {
+    if (tpm_cmd_get_size(response) !=3D n) {
         return -EMSGSIZE;
     }
=20
@@ -178,12 +172,11 @@ static int tpm_util_request(int fd,
  * (error response is fine).
  */
 static int tpm_util_test(int fd,
-                         unsigned char *request,
+                         const void *request,
                          size_t requestlen,
                          uint16_t *return_tag)
 {
-    struct tpm_resp_hdr *resp;
-    unsigned char buf[1024];
+    char buf[1024];
     ssize_t ret;
=20
     ret =3D tpm_util_request(fd, request, requestlen,
@@ -192,8 +185,7 @@ static int tpm_util_test(int fd,
         return ret;
     }
=20
-    resp =3D (struct tpm_resp_hdr *)buf;
-    *return_tag =3D be16_to_cpu(resp->tag);
+    *return_tag =3D tpm_cmd_get_tag(buf);
=20
     return 0;
 }
@@ -228,7 +220,7 @@ int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_=
version)
     int ret;
=20
     /* Send TPM 2 command */
-    ret =3D tpm_util_test(tpm_fd, (unsigned char *)&test_req_tpm2,
+    ret =3D tpm_util_test(tpm_fd, &test_req_tpm2,
                         sizeof(test_req_tpm2), &return_tag);
     /* TPM 2 would respond with a tag of TPM2_ST_NO_SESSIONS */
     if (!ret && return_tag =3D=3D TPM2_ST_NO_SESSIONS) {
@@ -237,7 +229,7 @@ int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_=
version)
     }
=20
     /* Send TPM 1.2 command */
-    ret =3D tpm_util_test(tpm_fd, (unsigned char *)&test_req,
+    ret =3D tpm_util_test(tpm_fd, &test_req,
                         sizeof(test_req), &return_tag);
     if (!ret && return_tag =3D=3D TPM_TAG_RSP_COMMAND) {
         *tpm_version =3D TPM_VERSION_1_2;
@@ -253,7 +245,6 @@ int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_=
version)
 int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
                              size_t *buffersize)
 {
-    unsigned char buf[1024];
     int ret;
=20
     switch (tpm_version) {
@@ -277,26 +268,27 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion=
 tpm_version,
             struct tpm_resp_hdr hdr;
             uint32_t len;
             uint32_t buffersize;
-        } QEMU_PACKED *tpm_resp =3D (struct tpm_resp_get_buffer_size *)b=
uf;
+        } QEMU_PACKED tpm_resp;
=20
-        ret =3D tpm_util_request(tpm_fd, (unsigned char *)&tpm_get_buffe=
r_size,
-                               sizeof(tpm_get_buffer_size), buf, sizeof(=
buf));
+        ret =3D tpm_util_request(tpm_fd, &tpm_get_buffer_size,
+                               sizeof(tpm_get_buffer_size),
+                               &tpm_resp, sizeof(tpm_resp));
         if (ret < 0) {
             return ret;
         }
=20
-        if (be32_to_cpu(tpm_resp->hdr.len) !=3D sizeof(*tpm_resp) ||
-            be32_to_cpu(tpm_resp->len) !=3D sizeof(uint32_t)) {
+        if (be32_to_cpu(tpm_resp.hdr.len) !=3D sizeof(tpm_resp) ||
+            be32_to_cpu(tpm_resp.len) !=3D sizeof(uint32_t)) {
             DPRINTF("tpm_resp->hdr.len =3D %u, expected =3D %zu\n",
-                    be32_to_cpu(tpm_resp->hdr.len), sizeof(*tpm_resp));
+                    be32_to_cpu(tpm_resp.hdr.len), sizeof(tpm_resp));
             DPRINTF("tpm_resp->len =3D %u, expected =3D %zu\n",
-                    be32_to_cpu(tpm_resp->len), sizeof(uint32_t));
+                    be32_to_cpu(tpm_resp.len), sizeof(uint32_t));
             error_report("tpm_util: Got unexpected response to "
                          "TPM_GetCapability; errcode: 0x%x",
-                         be32_to_cpu(tpm_resp->hdr.errcode));
+                         be32_to_cpu(tpm_resp.hdr.errcode));
             return -EFAULT;
         }
-        *buffersize =3D be32_to_cpu(tpm_resp->buffersize);
+        *buffersize =3D be32_to_cpu(tpm_resp.buffersize);
         break;
     }
     case TPM_VERSION_2_0: {
@@ -324,27 +316,28 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion=
 tpm_version,
             uint32_t value1;
             uint32_t property2;
             uint32_t value2;
-        } QEMU_PACKED *tpm2_resp =3D (struct tpm2_resp_get_buffer_size *=
)buf;
+        } QEMU_PACKED tpm2_resp;
=20
-        ret =3D tpm_util_request(tpm_fd, (unsigned char *)&tpm2_get_buff=
er_size,
-                               sizeof(tpm2_get_buffer_size), buf, sizeof=
(buf));
+        ret =3D tpm_util_request(tpm_fd, &tpm2_get_buffer_size,
+                               sizeof(tpm2_get_buffer_size),
+                               &tpm2_resp, sizeof(tpm2_resp));
         if (ret < 0) {
             return ret;
         }
=20
-        if (be32_to_cpu(tpm2_resp->hdr.len) !=3D sizeof(*tpm2_resp) ||
-            be32_to_cpu(tpm2_resp->count) !=3D 2) {
+        if (be32_to_cpu(tpm2_resp.hdr.len) !=3D sizeof(tpm2_resp) ||
+            be32_to_cpu(tpm2_resp.count) !=3D 2) {
             DPRINTF("tpm2_resp->hdr.len =3D %u, expected =3D %zu\n",
-                    be32_to_cpu(tpm2_resp->hdr.len), sizeof(*tpm2_resp))=
;
+                    be32_to_cpu(tpm2_resp.hdr.len), sizeof(tpm2_resp));
             DPRINTF("tpm2_resp->len =3D %u, expected =3D %u\n",
-                    be32_to_cpu(tpm2_resp->count), 2);
+                    be32_to_cpu(tpm2_resp.count), 2);
             error_report("tpm_util: Got unexpected response to "
                          "TPM2_GetCapability; errcode: 0x%x",
-                         be32_to_cpu(tpm2_resp->hdr.errcode));
+                         be32_to_cpu(tpm2_resp.hdr.errcode));
             return -EFAULT;
         }
-        *buffersize =3D MAX(be32_to_cpu(tpm2_resp->value1),
-                          be32_to_cpu(tpm2_resp->value2));
+        *buffersize =3D MAX(be32_to_cpu(tpm2_resp.value1),
+                          be32_to_cpu(tpm2_resp.value2));
         break;
     }
     case TPM_VERSION_UNSPEC:
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index 19b2847..f003d15 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -31,9 +31,24 @@ bool tpm_util_is_selftest(const uint8_t *in, uint32_t =
in_len);
=20
 int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version);
=20
+static inline uint16_t tpm_cmd_get_tag(const void *b)
+{
+    return lduw_be_p(b);
+}
+
 static inline uint32_t tpm_cmd_get_size(const void *b)
 {
-    return be32_to_cpu(*(const uint32_t *)(b + 2));
+    return ldl_be_p(b + 2);
+}
+
+static inline uint32_t tpm_cmd_get_ordinal(const void *b)
+{
+    return ldl_be_p(b + 6);
+}
+
+static inline uint32_t tpm_cmd_get_errcode(const void *b)
+{
+    return ldl_be_p(b + 6);
 }
=20
 int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
--=20
2.5.5
