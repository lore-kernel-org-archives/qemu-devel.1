Received: from eggs.gnu.org ([209.51.188.92]:32774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCNRg-0003Mq-Sp
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCNRf-0004O9-Lb
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:55:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCNRf-0004N2-3T
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:55:43 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  5 Apr 2019 13:55:29 +0200
Message-Id: <20190405115529.11590-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0] roms: Allow the EFIROM variable to be
 overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Since commit f590a812c210 we build the EfiRom utility
unconditionally. This has been tested on all the Linux
distribution providing continuous integration (namely
Debian and Fedora). Not all distributions are able to
build the EfiRom without specific patches (In particular
SUSE which enforces the PIE protection, see [*]).
Restore the possibility to other distributions to
override the EFIROM variable.

[*] https://lists.opensuse.org/opensuse-factory/2017-06/msg00403.html

Reported-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/roms/Makefile b/roms/Makefile
index 78d5dd18c30..0bcfa665ccf 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -47,7 +47,7 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
 # We need that to combine multiple images (legacy bios,
 # efi ia32, efi x64) into a single rom binary.
 #
-EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
+EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom
=20
 default:
 	@echo "nothing is build by default"
@@ -120,8 +120,11 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
=20
+# Do not compile $(EFIROM) if the variable is overridden
+ifeq "$(origin EFIROM)" "file"
 $(EFIROM):
 	$(MAKE) -C edk2/BaseTools
+endif
=20
 slof:
 	$(MAKE) -C SLOF CROSS=3D$(powerpc64_cross_prefix) qemu
--=20
2.20.1
