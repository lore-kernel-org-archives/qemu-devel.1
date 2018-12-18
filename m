Received: from eggs.gnu.org ([2001:4830:134:3::10]:33542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZJYJ-0005sG-LM
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZJYH-00041Y-KD
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:53:07 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 18:51:20 +0100
Message-Id: <20181218175122.3229-4-philmd@redhat.com>
In-Reply-To: <20181218175122.3229-1-philmd@redhat.com>
References: <20181218175122.3229-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/5] hw/acpi: Use QEMU_NONSTRING for non
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Max Reitz <mreitz@redhat.com>

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
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/acpi/core.c              | 8 ++++----
 include/hw/acpi/acpi-defs.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index aafdc61648..f60f750c3d 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -35,14 +35,14 @@
 struct acpi_table_header {
     uint16_t _length;         /* our length, not actual part of the hdr =
*/
                               /* allows easier parsing for fw_cfg client=
s */
-    char sig[4];              /* ACPI signature (4 ASCII characters) */
+    char sig[4] QEMU_NONSTRING; /* ACPI signature (4 ASCII characters) *=
/
     uint32_t length;          /* Length of table, in bytes, including he=
ader */
     uint8_t revision;         /* ACPI Specification minor version # */
     uint8_t checksum;         /* To make sum of entire table =3D=3D 0 */
-    char oem_id[6];           /* OEM identification */
-    char oem_table_id[8];     /* OEM table identification */
+    char oem_id[6] QEMU_NONSTRING; /* OEM identification */
+    char oem_table_id[8] QEMU_NONSTRING; /* OEM table identification */
     uint32_t oem_revision;    /* OEM revision number */
-    char asl_compiler_id[4];  /* ASL compiler vendor ID */
+    char asl_compiler_id[4] QEMU_NONSTRING; /* ASL compiler vendor ID */
     uint32_t asl_compiler_revision; /* ASL compiler revision number */
 } QEMU_PACKED;
=20
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index af8e023968..3bf0bec8ba 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -43,7 +43,7 @@ enum {
 struct AcpiRsdpDescriptor {        /* Root System Descriptor Pointer */
     uint64_t signature;              /* ACPI signature, contains "RSD PT=
R " */
     uint8_t  checksum;               /* To make sum of struct =3D=3D 0 *=
/
-    uint8_t  oem_id [6];             /* OEM identification */
+    uint8_t  oem_id [6] QEMU_NONSTRING; /* OEM identification */
     uint8_t  revision;               /* Must be 0 for 1.0, 2 for 2.0 */
     uint32_t rsdt_physical_address;  /* 32-bit physical address of RSDT =
*/
     uint32_t length;                 /* XSDT Length in bytes including h=
dr */
@@ -62,10 +62,10 @@ typedef struct AcpiRsdpDescriptor AcpiRsdpDescriptor;
     uint32_t length;                 /* Length of table, in bytes, inclu=
ding header */ \
     uint8_t  revision;               /* ACPI Specification minor version=
 # */ \
     uint8_t  checksum;               /* To make sum of entire table =3D=3D=
 0 */ \
-    uint8_t  oem_id [6];             /* OEM identification */ \
-    uint8_t  oem_table_id [8];       /* OEM table identification */ \
+    uint8_t  oem_id [6] QEMU_NONSTRING; /* OEM identification */ \
+    uint8_t  oem_table_id [8] QEMU_NONSTRING; /* OEM table identificatio=
n */ \
     uint32_t oem_revision;           /* OEM revision number */ \
-    uint8_t  asl_compiler_id [4];    /* ASL compiler vendor ID */ \
+    uint8_t  asl_compiler_id [4] QEMU_NONSTRING; /* ASL compiler vendor =
ID */ \
     uint32_t asl_compiler_revision;  /* ASL compiler revision number */
=20
=20
--=20
2.17.2
