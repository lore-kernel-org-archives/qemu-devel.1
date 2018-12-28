Received: from eggs.gnu.org ([208.118.235.92]:51722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gcx6s-000441-Pd
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 13:43:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gcwnV-0000i9-2i
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 13:24:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gcw2C-0001ed-7h
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:34:56 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 28 Dec 2018 18:33:54 +0100
Message-Id: <20181228173356.15359-4-philmd@redhat.com>
In-Reply-To: <20181228173356.15359-1-philmd@redhat.com>
References: <20181228173356.15359-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 3/5] hw/acpi: Use QEMU_NONSTRING for non
 NUL-terminated arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>

GCC 8 added a -Wstringop-truncation warning:

  The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
  bug 81117 is specifically intended to highlight likely unintended
  uses of the strncpy function that truncate the terminating NUL
  character from the source string.

This new warning leads to compilation failures:

    CC      hw/acpi/core.o
  In function 'acpi_table_install', inlined from 'acpi_table_add' at qemu=
/hw/acpi/core.c:296:5:
  qemu/hw/acpi/core.c:184:9: error: 'strncpy' specified bound 4 equals de=
stination size [-Werror=3Dstringop-truncation]
           strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  make: *** [qemu/rules.mak:69: hw/acpi/core.o] Error 1

Use the QEMU_NONSTRING attribute, since ACPI tables don't require the
strings to be NUL-terminated.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v4: rebased

Note this triggers the following checkpatch error (patchew):

  ERROR: space prohibited before open square bracket '['
  #64: FILE: include/hw/acpi/acpi-defs.h:43:
  +    uint8_t  oem_id [6] QEMU_NONSTRING; /* OEM identification */
---
 hw/acpi/core.c              | 12 ++++++++----
 include/hw/acpi/acpi-defs.h | 13 ++++++++-----
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index d6f0709691..47877c0ec1 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -35,14 +35,18 @@
 struct acpi_table_header {
     uint16_t _length;         /* our length, not actual part of the hdr =
*/
                               /* allows easier parsing for fw_cfg client=
s */
-    char sig[4];              /* ACPI signature (4 ASCII characters) */
+    char sig[4]
+             QEMU_NONSTRING;  /* ACPI signature (4 ASCII characters) */
     uint32_t length;          /* Length of table, in bytes, including he=
ader */
     uint8_t revision;         /* ACPI Specification minor version # */
     uint8_t checksum;         /* To make sum of entire table =3D=3D 0 */
-    char oem_id[6];           /* OEM identification */
-    char oem_table_id[8];     /* OEM table identification */
+    char oem_id[6]
+             QEMU_NONSTRING;  /* OEM identification */
+    char oem_table_id[8]
+             QEMU_NONSTRING;  /* OEM table identification */
     uint32_t oem_revision;    /* OEM revision number */
-    char asl_compiler_id[4];  /* ASL compiler vendor ID */
+    char asl_compiler_id[4]
+             QEMU_NONSTRING;  /* ASL compiler vendor ID */
     uint32_t asl_compiler_revision; /* ASL compiler revision number */
 } QEMU_PACKED;
=20
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 5021cb9e79..17f72e9553 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -41,8 +41,8 @@ enum {
 };
=20
 typedef struct AcpiRsdpData {
-    uint8_t oem_id[6]; /* OEM identification */
-    uint8_t revision;  /* Must be 0 for 1.0, 2 for 2.0 */
+    uint8_t oem_id[6] QEMU_NONSTRING; /* OEM identification */
+    uint8_t revision;                 /* Must be 0 for 1.0, 2 for 2.0 */
=20
     unsigned *rsdt_tbl_offset;
     unsigned *xsdt_tbl_offset;
@@ -57,10 +57,13 @@ typedef struct AcpiRsdpData {
     uint32_t length;                 /* Length of table, in bytes, inclu=
ding header */ \
     uint8_t  revision;               /* ACPI Specification minor version=
 # */ \
     uint8_t  checksum;               /* To make sum of entire table =3D=3D=
 0 */ \
-    uint8_t  oem_id [6];             /* OEM identification */ \
-    uint8_t  oem_table_id [8];       /* OEM table identification */ \
+    uint8_t  oem_id [6] \
+                 QEMU_NONSTRING;     /* OEM identification */ \
+    uint8_t  oem_table_id [8] \
+                 QEMU_NONSTRING;     /* OEM table identification */ \
     uint32_t oem_revision;           /* OEM revision number */ \
-    uint8_t  asl_compiler_id [4];    /* ASL compiler vendor ID */ \
+    uint8_t  asl_compiler_id [4] \
+                 QEMU_NONSTRING;     /* ASL compiler vendor ID */ \
     uint32_t asl_compiler_revision;  /* ASL compiler revision number */
=20
=20
--=20
2.17.2
