Received: from eggs.gnu.org ([2001:4830:134:3::10]:39760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehca3-0001U9-Ry
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehcZy-00033K-Uu
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56598
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ehcZy-00032h-P7
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:38 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12EgxBh019931
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 09:44:38 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvrwbbf0p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 09:44:37 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 2 Feb 2018 07:44:36 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri,  2 Feb 2018 09:44:26 -0500
In-Reply-To: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1517582668-10923-3-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] tpm: wrap stX_be_p in tpm_cmd_set_XYZ
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com

Wrap the calls to stl_be_p and stw_be_p in tpm_cmd_set_XYZ functions
that are similar to existing getters.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_util.c |  6 +++---
 hw/tpm/tpm_util.h | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 8abde59..2de52a0 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -106,9 +106,9 @@ const PropertyInfo qdev_prop_tpm =3D {
 void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)
 {
     if (out_len >=3D sizeof(struct tpm_resp_hdr)) {
-        stw_be_p(out, TPM_TAG_RSP_COMMAND);
-        stl_be_p(out + 2, sizeof(struct tpm_resp_hdr));
-        stl_be_p(out + 6, TPM_FAIL);
+        tpm_cmd_set_tag(out, TPM_TAG_RSP_COMMAND);
+        tpm_cmd_set_size(out, sizeof(struct tpm_resp_hdr));
+        tpm_cmd_set_error(out, TPM_FAIL);
     }
 }
=20
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index f003d15..f397ac2 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -36,11 +36,21 @@ static inline uint16_t tpm_cmd_get_tag(const void *b)
     return lduw_be_p(b);
 }
=20
+static inline void tpm_cmd_set_tag(void *b, uint16_t tag)
+{
+    stw_be_p(b, tag);
+}
+
 static inline uint32_t tpm_cmd_get_size(const void *b)
 {
     return ldl_be_p(b + 2);
 }
=20
+static inline void tpm_cmd_set_size(void *b, uint32_t size)
+{
+    stl_be_p(b + 2, size);
+}
+
 static inline uint32_t tpm_cmd_get_ordinal(const void *b)
 {
     return ldl_be_p(b + 6);
@@ -51,6 +61,11 @@ static inline uint32_t tpm_cmd_get_errcode(const void =
*b)
     return ldl_be_p(b + 6);
 }
=20
+static inline void tpm_cmd_set_error(void *b, uint32_t error)
+{
+    stl_be_p(b + 6, error);
+}
+
 int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
                              size_t *buffersize);
=20
--=20
2.5.5
