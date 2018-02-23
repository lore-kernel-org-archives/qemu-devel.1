Received: from eggs.gnu.org ([2001:4830:134:3::10]:34629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDK1-00049J-MA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDK0-0007Zt-Py
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1epDK0-0007ZX-Kw
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:32 -0500
From: marcandre.lureau@redhat.com
Date: Fri, 23 Feb 2018 14:23:11 +0100
Message-Id: <20180223132311.26555-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180223132311.26555-1-marcandre.lureau@redhat.com>
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/7] ovmf: add DxeTpm2MeasureBootLib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, lersek@redhat.com, qemu-devel@nongnu.org, javierm@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The library registers a security management handler, to measure images
that are not measure in PEI phase.

This seems to work for example with the qemu PXE rom:

Loading driver at 0x0003E6C2000 EntryPoint=3D0x0003E6C9076 8086100e.efi

And the following binary_bios_measurements log entry seems to be
added:

PCR: 2	type: EV_EFI_BOOT_SERVICES_DRIVER     	size: 0x4e	digest: 70a22475=
e9f18806d2ed9193b48d80d26779d9a4

CC: Laszlo Ersek <lersek@redhat.com>
CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
Contributed-under: TianoCore Contribution Agreement 1.0
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 OvmfPkg/OvmfPkgX64.dsc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
index 2281bd5ff8..92ed9f3b0c 100644
--- a/OvmfPkg/OvmfPkgX64.dsc
+++ b/OvmfPkg/OvmfPkgX64.dsc
@@ -677,7 +677,10 @@
   MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf {
     <LibraryClasses>
       NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerificat=
ionLib.inf
-	}
+!if $(TPM2_ENABLE) =3D=3D TRUE
+      NULL|SecurityPkg/Library/DxeTpm2MeasureBootLib/DxeTpm2MeasureBootL=
ib.inf
+!endif
+  }
 !else
   MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf
 !endif
--=20
2.16.1.73.g5832b7e9f2
