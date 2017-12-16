Received: from eggs.gnu.org ([2001:4830:134:3::10]:46130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGU4-0006QI-Cp
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGU0-0000L4-FO
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGU0-0000Kc-6q
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:44 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHfRs6018611
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:43 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2evypbch42-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:42 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:42 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:46 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-30-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 29/32] tpm: pull tpm_util_request() out of
 tpm_util_test()
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_util.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index daf1faa..b852f53 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -50,13 +50,13 @@ bool tpm_util_is_selftest(const uint8_t *in, uint32_t=
 in_len)
 }
=20
 /*
- * A basic test of a TPM device. We expect a well formatted response hea=
der
- * (error response is fine) within one second.
+ * Send request to a TPM device. We expect a response within one second.
  */
-static int tpm_util_test(int fd,
-                         unsigned char *request,
-                         size_t requestlen,
-                         uint16_t *return_tag)
+static int tpm_util_request(int fd,
+                            unsigned char *request,
+                            size_t requestlen,
+                            unsigned char *response,
+                            size_t responselen)
 {
     struct tpm_resp_hdr *resp;
     fd_set readfds;
@@ -65,7 +65,6 @@ static int tpm_util_test(int fd,
         .tv_sec =3D 1,
         .tv_usec =3D 0,
     };
-    unsigned char buf[1024];
=20
     n =3D write(fd, request, requestlen);
     if (n < 0) {
@@ -84,17 +83,40 @@ static int tpm_util_test(int fd,
         return -errno;
     }
=20
-    n =3D read(fd, &buf, sizeof(buf));
+    n =3D read(fd, response, responselen);
     if (n < sizeof(struct tpm_resp_hdr)) {
         return -EFAULT;
     }
=20
-    resp =3D (struct tpm_resp_hdr *)buf;
+    resp =3D (struct tpm_resp_hdr *)response;
     /* check the header */
     if (be32_to_cpu(resp->len) !=3D n) {
         return -EMSGSIZE;
     }
=20
+    return 0;
+}
+
+/*
+ * A basic test of a TPM device. We expect a well formatted response hea=
der
+ * (error response is fine).
+ */
+static int tpm_util_test(int fd,
+                         unsigned char *request,
+                         size_t requestlen,
+                         uint16_t *return_tag)
+{
+    struct tpm_resp_hdr *resp;
+    unsigned char buf[1024];
+    ssize_t ret;
+
+    ret =3D tpm_util_request(fd, request, requestlen,
+                           buf, sizeof(buf));
+    if (ret < 0) {
+        return ret;
+    }
+
+    resp =3D (struct tpm_resp_hdr *)buf;
     *return_tag =3D be16_to_cpu(resp->tag);
=20
     return 0;
--=20
2.5.5
