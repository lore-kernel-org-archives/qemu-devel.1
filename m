Received: from eggs.gnu.org ([209.51.188.92]:48068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38qf-0007ct-RB
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38qe-0003T7-Vu
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38qe-0003Se-OG
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:20 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 01:30:48 +0100
Message-Id: <20190311003052.13778-2-philmd@redhat.com>
In-Reply-To: <20190311003052.13778-1-philmd@redhat.com>
References: <20190311003052.13778-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/5] roms/edk2: Avoid bashism in Makefile
 'shell' function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Michal=20Pr=C3=ADvozn=C3=ADk?= <mprivozn@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The shell builtin 'source' command is a bash extension.
Use the '.' portable command.

This fix building when /bin/sh is dash (Ubuntu 16):

  $ make -C roms efi
  [...]
  Fd File Name:QEMU_EFI
  (/source/qemu/roms/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_EF=
I.fd)
  Fd File Name:QEMU_VARS
  (/source/qemu/roms/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_VA=
RS.fd)
  GUID cross reference file can be found at
  /source/qemu/roms/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/Guid.xre=
f
  - Done -
  Build end time: 16:33:29, Mar.09 2019
  Build total time: 00:03:35
  cp edk2/Build/ArmVirtQemu-AARCH64/DEBUG_/FV/QEMU_EFI.fd \
  	../pc-bios/edk2-aarch64-code.fd
  cp: cannot stat 'edk2/Build/ArmVirtQemu-AARCH64/DEBUG_/FV/QEMU_EFI.fd':
  No such file or directory
  Makefile.edk2:45: recipe for target '../pc-bios/edk2-aarch64-code.fd' f=
ailed
  make[1]: *** [../pc-bios/edk2-aarch64-code.fd] Error 1
  make[1]: Leaving directory '/source/qemu/roms'
  Makefile:148: recipe for target 'efi' failed
  make: *** [efi] Error 2
  make: Leaving directory '/source/qemu/roms'

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/Makefile.edk2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
index ad6fff044c..6c5e9b9eea 100644
--- a/roms/Makefile.edk2
+++ b/roms/Makefile.edk2
@@ -11,7 +11,7 @@
 # THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, =
WITHOUT
 # WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
=20
-toolchain =3D $(shell source ./edk2-funcs.sh && qemu_edk2_get_toolchain =
$(1))
+toolchain =3D $(shell . ./edk2-funcs.sh && qemu_edk2_get_toolchain $(1))
=20
 licenses :=3D \
 	edk2/License.txt \
--=20
2.20.1
