Received: from eggs.gnu.org ([2001:4830:134:3::10]:45991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTq-00068O-6u
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTn-0000CA-MF
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58550
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTn-0000Bs-GO
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:31 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdVdM066288
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:31 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2evxh669d5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:30 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:30 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:37 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-21-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 20/32] tpm: add tpm_cmd_get_size() to tpm_util
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The function is generally useful and used in the following patches.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c  | 3 ++-
 hw/tpm/tpm_util.h | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 4d13335..06b30c4 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -30,6 +30,7 @@
 #include "hw/pci/pci_ids.h"
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
+#include "tpm_util.h"
=20
 #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
 #define TPM_TIS_LOCALITY_SHIFT      12
@@ -215,7 +216,7 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr addr=
)
=20
 static uint32_t tpm_tis_get_size_from_buffer(const TPMSizedBuffer *sb)
 {
-    return be32_to_cpu(*(uint32_t *)&sb->buffer[2]);
+    return tpm_cmd_get_size(sb->buffer);
 }
=20
 static void tpm_tis_show_buffer(const TPMSizedBuffer *sb, const char *st=
ring)
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index 2f7c961..aca10c9 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -22,7 +22,8 @@
 #ifndef TPM_TPM_UTIL_H
 #define TPM_TPM_UTIL_H
=20
-#include "sysemu/tpm_backend.h"
+#include "sysemu/tpm.h"
+#include "qemu/bswap.h"
=20
 void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_len)=
;
=20
@@ -30,4 +31,9 @@ bool tpm_util_is_selftest(const uint8_t *in, uint32_t i=
n_len);
=20
 int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version);
=20
+static inline uint32_t tpm_cmd_get_size(const void *b)
+{
+    return be32_to_cpu(*(const uint32_t *)(b + 2));
+}
+
 #endif /* TPM_TPM_UTIL_H */
--=20
2.5.5
