Received: from eggs.gnu.org ([209.51.188.92]:48371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCQqt-0005UF-Ni
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCQqo-00038N-LJ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:33:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCQqk-0002qn-Hh
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:33:53 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  5 Apr 2019 17:33:14 +0200
Message-Id: <20190405153314.2068-3-philmd@redhat.com>
In-Reply-To: <20190405153314.2068-1-philmd@redhat.com>
References: <20190405153314.2068-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v2 2/2] roms: Allow the EDK2_EFIROM
 variable to be overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Olaf Hering <olaf@aepfle.de>
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Since commit f590a812c210 we build the EDK2 EfiRom utility
unconditionally. This has been tested on all the Linux
distribution providing continuous integration (namely Debian
and Fedora). Not all distributions are able to build the
EfiRom without specific patches (In particular SUSE which
enforces the PIE protection, see [*]).

Restore the possibility to other distributions to override
the EDK2_EFIROM variable.

[*] https://lists.opensuse.org/opensuse-factory/2017-06/msg00403.html

Reported-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/roms/Makefile b/roms/Makefile
index d28252dafdf..ea19aa9b33c 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -47,7 +47,11 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
 # We need that to combine multiple images (legacy bios,
 # efi ia32, efi x64) into a single rom binary.
 #
-EDK2_EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
+# By default we build the latest EDK2 stable EfiRom utility.
+# If you have to use another one, you can also pass the location on
+# the command line, i.e. "make EDK2_EFIROM=3D$(type -P EfiRom) efirom"
+#
+EDK2_EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom
=20
 default:
 	@echo "nothing is build by default"
@@ -120,8 +124,11 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
=20
+# Do not compile $(EDK2_EFIROM) if the variable is overridden
+ifeq "$(origin EDK2_EFIROM)" "file"
 $(EDK2_EFIROM):
 	$(MAKE) -C edk2/BaseTools
+endif
=20
 slof:
 	$(MAKE) -C SLOF CROSS=3D$(powerpc64_cross_prefix) qemu
--=20
2.20.1
