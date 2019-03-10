Received: from eggs.gnu.org ([209.51.188.92]:42566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38HV-0004t8-DK
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38HU-0002WP-HH
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:55:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38HU-0002W7-8o
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 19:55:00 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 00:53:49 +0100
Message-Id: <20190310235351.1863-7-philmd@redhat.com>
In-Reply-To: <20190310235351.1863-1-philmd@redhat.com>
References: <20190310235351.1863-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/8] hw/southbridge: Add ACPI_PIIX4 to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Since the default-configs/mips-softmmu-common.mak is not yet ported
to the Kconfig format, we have to select this variable there (used
by the MIPS Malta machine).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/mips-softmmu-common.mak | 1 +
 hw/acpi/Kconfig                         | 7 +++++++
 hw/acpi/Makefile.objs                   | 3 ++-
 hw/i386/Kconfig                         | 2 ++
 hw/isa/Kconfig                          | 2 +-
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mi=
ps-softmmu-common.mak
index 0795d522db..61cc3d2c6b 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -20,6 +20,7 @@ CONFIG_ACPI_X86=3Dy
 CONFIG_ACPI_MEMORY_HOTPLUG=3Dy
 CONFIG_ACPI_NVDIMM=3Dy
 CONFIG_ACPI_CPU_HOTPLUG=3Dy
+CONFIG_ACPI_PIIX4=3Dy
 CONFIG_APM=3Dy
 CONFIG_I8257=3Dy
 CONFIG_PIIX4=3Dy
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index eca3beed75..627f5e9768 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -8,6 +8,13 @@ config ACPI_X86
     select ACPI_CPU_HOTPLUG
     select ACPI_MEMORY_HOTPLUG
=20
+config ACPI_PIIX4
+    bool
+    select ACPI
+    select ACPI_NVDIMM
+    select ACPI_CPU_HOTPLUG
+    select ACPI_MEMORY_HOTPLUG
+
 config ACPI_X86_ICH
     bool
     select ACPI_X86
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 2d46e3789a..2ef78175cb 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -1,5 +1,6 @@
 ifeq ($(CONFIG_ACPI),y)
-common-obj-$(CONFIG_ACPI_X86) +=3D core.o piix4.o pcihp.o
+common-obj-$(CONFIG_ACPI_X86) +=3D core.o pcihp.o
+common-obj-$(CONFIG_ACPI_PIIX4) +=3D piix4.o
 common-obj-$(CONFIG_ACPI_X86_ICH) +=3D ich9.o tco.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu_hotplug.o
 common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hotplug.o
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 78fd70396a..f6b74e2dc0 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -69,6 +69,8 @@ config ISAPC
     # FIXME: it is in the same file as i440fx, and does not compile
     # if separated
     depends on I440FX
+    # QEMU isapc weirdness: it uses PIIX3 with ACPI features from PIIX4
+    select ACPI_PIIX4
=20
 config Q35
     bool
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 1c923dfd07..d3f03ef7d5 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -49,7 +49,7 @@ config PIIX3
 config PIIX4
     bool
     select PIIX3
-    #select ACPI_PIIX4
+    select ACPI_PIIX4
     #select IDE_PIIX4
     select ACPI_SMBUS
     select MC146818RTC
--=20
2.20.1
