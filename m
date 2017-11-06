Received: from eggs.gnu.org ([2001:4830:134:3::10]:40023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKb-0007ax-Vv
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKX-0005GV-2r
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmKW-0005Fc-SX
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:05 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:17 +0100
Message-Id: <20171106183925.16747-21-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 20/28] tpm: add tpm_cmd_get_size() to
 tpm_util
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The function is generally useful and used in the following patches.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_util.h | 8 +++++++-
 hw/tpm/tpm_tis.c  | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index 2f7c96146d..aca10c97bf 100644
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
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index a0b39b6211..d313347144 100644
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
--=20
2.15.0.rc0.40.gaefcc5f6f
