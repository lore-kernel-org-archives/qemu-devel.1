Received: from eggs.gnu.org ([2001:4830:134:3::10]:56103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBEb-0001Qt-7q
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBEa-0004Dl-1v
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBEZ-0004DE-Py
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:03 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F290461BAC
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:16:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:36 +0400
Message-Id: <20170221141451.28305-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/30] pc: pcihp: avoid adding
 ACPI_PCIHP_PROP_BSEL twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

PCI hotplug for bridges was introduced only since 2.0 however
  acpi_set_bsel()->object_property_add_uint32_ptr(bus, ACPI_PCIHP_PROP_BS=
EL)
didn't take in account that for legacy mode (1.7) when
PCI hotplug for bridges is unavailable and ACPI_PCIHP_PROP_BSEL property
the only bus "PCI.0' has been created earlier at acpi_pcihp_init() time.

We managed to live with it only because of error rised by adding
a duplicate property in acpi_set_bsel() has been ignored which
resulted in useless leaking of just allocated (int)bus_bsel.

Issue affects only 1.7 machine type as ACPI tables supported by
QEMU were introduced at that time, but there wasn't PCI hotplug
for bridges till the next release (2.0).

Fix it by removing duplicate ACPI_PCIHP_PROP_BSEL intialization
in acpi_pcihp_init() and doing it only in one place acpi_set_pci_info().

PS:
do not ignore error returned by object_property_add_uint32_ptr()
and abort QEMU since it's programming error which should be fixed
instead of being ignored.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <1470211497-116801-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[ Marc-Andr=C3=A9 - Remove now unused ACPI_PCIHP_LEGACY_SIZE ]
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/acpi/pcihp.c      | 11 -----------
 hw/i386/acpi-build.c |  4 ++--
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index d957d1e30d..2b0f3e1bfb 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -49,7 +49,6 @@
=20
 #define ACPI_PCIHP_ADDR 0xae00
 #define ACPI_PCIHP_SIZE 0x0014
-#define ACPI_PCIHP_LEGACY_SIZE 0x000f
 #define PCI_UP_BASE 0x0000
 #define PCI_DOWN_BASE 0x0004
 #define PCI_EJ_BASE 0x0008
@@ -302,16 +301,6 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *=
s, PCIBus *root_bus,
     s->root=3D root_bus;
     s->legacy_piix =3D !bridges_enabled;
=20
-    if (s->legacy_piix) {
-        unsigned *bus_bsel =3D g_malloc(sizeof *bus_bsel);
-
-        s->io_len =3D ACPI_PCIHP_LEGACY_SIZE;
-
-        *bus_bsel =3D ACPI_PCIHP_BSEL_DEFAULT;
-        object_property_add_uint32_ptr(OBJECT(root_bus), ACPI_PCIHP_PROP=
_BSEL,
-                                       bus_bsel, NULL);
-    }
-
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
                           "acpi-pci-hotplug", s->io_len);
     memory_region_add_subregion(address_space_io, s->io_base, &s->io);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1c928abb28..f44767b9be 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -462,7 +462,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
=20
         *bus_bsel =3D (*bsel_alloc)++;
         object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL=
,
-                                       bus_bsel, NULL);
+                                       bus_bsel, &error_abort);
     }
=20
     return bsel_alloc;
@@ -471,7 +471,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
 static void acpi_set_pci_info(void)
 {
     PCIBus *bus =3D find_i440fx(); /* TODO: Q35 support */
-    unsigned bsel_alloc =3D 0;
+    unsigned bsel_alloc =3D ACPI_PCIHP_BSEL_DEFAULT;
=20
     if (bus) {
         /* Scan all PCI buses. Set property to enable acpi based hotplug=
. */
--=20
2.11.0.295.gd7dffce1c.dirty
