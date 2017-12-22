Received: from eggs.gnu.org ([2001:4830:134:3::10]:41874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSTkU-0001HN-Fe
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSTkP-0000oO-DI
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eSTkP-0000ny-4Y
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:49 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBMKES7x111918
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 15:16:46 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f13r0evfq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 15:16:45 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 22 Dec 2017 13:16:45 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 22 Dec 2017 15:16:24 -0500
In-Reply-To: <1513973785-14427-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513973785-14427-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513973785-14427-10-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 09/10] tpm: Implement tpm_sized_buffer_reset
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

Move the definition of TPMSizedBuffer out of tpm_tis.c into tpm_util.h
and implement tpm_sized_buffer_reset() for the following patches to use.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c  | 5 -----
 hw/tpm/tpm_util.c | 7 +++++++
 hw/tpm/tpm_util.h | 7 +++++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index ac5d5c6..561384c 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -48,11 +48,6 @@ typedef enum {
     TPM_TIS_STATE_RECEPTION,
 } TPMTISState;
=20
-typedef struct TPMSizedBuffer {
-    uint32_t size;
-    uint8_t  *buffer;
-} TPMSizedBuffer;
-
 /* locality data  -- all fields are persisted */
 typedef struct TPMLocality {
     TPMTISState state;
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 17cafbe..747075e 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -355,3 +355,10 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion =
tpm_version,
=20
     return 0;
 }
+
+void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
+{
+    g_free(tsb->buffer);
+    tsb->buffer =3D NULL;
+    tsb->size =3D 0;
+}
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index 2393b6b..19b2847 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -42,4 +42,11 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tp=
m_version,
 #define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
     DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
=20
+typedef struct TPMSizedBuffer {
+    uint32_t size;
+    uint8_t  *buffer;
+} TPMSizedBuffer;
+
+void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
+
 #endif /* TPM_TPM_UTIL_H */
--=20
2.5.5
