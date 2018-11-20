Received: from eggs.gnu.org ([2001:4830:134:3::10]:34756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gP7xT-0004QY-0v
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gP7xQ-0005YA-La
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:28:58 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 19:27:53 +0400
Message-Id: <20181120152753.10463-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181120152753.10463-1-marcandre.lureau@redhat.com>
References: <20181120152753.10463-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1? 3/3] acpi: fix stringop-truncation
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Replace strcpy() that don't mind about having dest not ending with NUL
char by qemu strpadcpy().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/acpi/aml-build.c |  6 ++++--
 hw/acpi/core.c      | 13 +++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 1e43cd736d..0a64a23e09 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -24,6 +24,7 @@
 #include "hw/acpi/aml-build.h"
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
+#include "qemu/cutils.h"
 #include "sysemu/numa.h"
=20
 static GArray *build_alloc_array(void)
@@ -1532,13 +1533,14 @@ build_header(BIOSLinker *linker, GArray *table_da=
ta,
     h->revision =3D rev;
=20
     if (oem_id) {
-        strncpy((char *)h->oem_id, oem_id, sizeof h->oem_id);
+        strpadcpy((char *)h->oem_id, sizeof h->oem_id, oem_id, 0);
     } else {
         memcpy(h->oem_id, ACPI_BUILD_APPNAME6, 6);
     }
=20
     if (oem_table_id) {
-        strncpy((char *)h->oem_table_id, oem_table_id, sizeof(h->oem_tab=
le_id));
+        strpadcpy((char *)h->oem_table_id, sizeof(h->oem_table_id),
+                  oem_table_id, 0);
     } else {
         memcpy(h->oem_table_id, ACPI_BUILD_APPNAME4, 4);
         memcpy(h->oem_table_id + 4, sig, 4);
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index aafdc61648..c1b4dfbfd9 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -31,6 +31,7 @@
 #include "qapi/qapi-visit-misc.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qemu/cutils.h"
=20
 struct acpi_table_header {
     uint16_t _length;         /* our length, not actual part of the hdr =
*/
@@ -181,7 +182,7 @@ static void acpi_table_install(const char unsigned *b=
lob, size_t bloblen,
     ext_hdr->_length =3D cpu_to_le16(acpi_payload_size);
=20
     if (hdrs->has_sig) {
-        strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
+        strpadcpy(ext_hdr->sig, sizeof ext_hdr->sig, hdrs->sig, 0);
         ++changed_fields;
     }
=20
@@ -200,12 +201,12 @@ static void acpi_table_install(const char unsigned =
*blob, size_t bloblen,
     ext_hdr->checksum =3D 0;
=20
     if (hdrs->has_oem_id) {
-        strncpy(ext_hdr->oem_id, hdrs->oem_id, sizeof ext_hdr->oem_id);
+        strpadcpy(ext_hdr->oem_id, sizeof ext_hdr->oem_id, hdrs->oem_id,=
 0);
         ++changed_fields;
     }
     if (hdrs->has_oem_table_id) {
-        strncpy(ext_hdr->oem_table_id, hdrs->oem_table_id,
-                sizeof ext_hdr->oem_table_id);
+        strpadcpy(ext_hdr->oem_table_id, sizeof ext_hdr->oem_table_id,
+                  hdrs->oem_table_id, 0);
         ++changed_fields;
     }
     if (hdrs->has_oem_rev) {
@@ -213,8 +214,8 @@ static void acpi_table_install(const char unsigned *b=
lob, size_t bloblen,
         ++changed_fields;
     }
     if (hdrs->has_asl_compiler_id) {
-        strncpy(ext_hdr->asl_compiler_id, hdrs->asl_compiler_id,
-                sizeof ext_hdr->asl_compiler_id);
+        strpadcpy(ext_hdr->asl_compiler_id, sizeof ext_hdr->asl_compiler=
_id,
+                  hdrs->asl_compiler_id, 0);
         ++changed_fields;
     }
     if (hdrs->has_asl_compiler_rev) {
--=20
2.19.1.708.g4ede3d42df
