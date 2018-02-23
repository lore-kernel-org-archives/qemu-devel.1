Received: from eggs.gnu.org ([2001:4830:134:3::10]:34560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDJx-000450-6g
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDJu-0007T2-3P
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33519 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1epDJt-0007Rr-Td
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:26 -0500
From: marcandre.lureau@redhat.com
Date: Fri, 23 Feb 2018 14:23:06 +0100
Message-Id: <20180223132311.26555-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180223132311.26555-1-marcandre.lureau@redhat.com>
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/7] ovmf: link with Tcg2ConfigPei module
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

This module initializes TPM device type based on variable and
detection.

The module requires VariablePei, which is built with
MEM_VARSTORE_EMU_ENABLE=3DFALSE.

CC: Laszlo Ersek <lersek@redhat.com>
CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
Contributed-under: TianoCore Contribution Agreement 1.0
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 OvmfPkg/OvmfPkgX64.dsc | 20 ++++++++++++++++++++
 OvmfPkg/OvmfPkgX64.fdf |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
index 32c57b04e1..b5cbe8430f 100644
--- a/OvmfPkg/OvmfPkgX64.dsc
+++ b/OvmfPkg/OvmfPkgX64.dsc
@@ -40,6 +40,7 @@
   DEFINE SMM_REQUIRE             =3D FALSE
   DEFINE TLS_ENABLE              =3D FALSE
   DEFINE MEM_VARSTORE_EMU_ENABLE =3D TRUE
+  DEFINE TPM2_ENABLE             =3D FALSE
=20
   #
   # Flash size selection. Setting FD_SIZE_IN_KB on the command line dire=
ctly to
@@ -209,6 +210,11 @@
   OrderedCollectionLib|MdePkg/Library/BaseOrderedCollectionRedBlackTreeL=
ib/BaseOrderedCollectionRedBlackTreeLib.inf
   XenHypercallLib|OvmfPkg/Library/XenHypercallLib/XenHypercallLib.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  Tpm12CommandLib|SecurityPkg/Library/Tpm12CommandLib/Tpm12CommandLib.in=
f
+  Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
+!endif
+
 [LibraryClasses.common]
   BaseCryptLib|CryptoPkg/Library/BaseCryptLib/BaseCryptLib.inf
=20
@@ -272,6 +278,10 @@
   QemuFwCfgS3Lib|OvmfPkg/Library/QemuFwCfgS3Lib/PeiQemuFwCfgS3LibFwCfg.i=
nf
   PcdLib|MdePkg/Library/PeiPcdLib/PeiPcdLib.inf
   QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
+!if $(TPM2_ENABLE)
+  Tpm12DeviceLib|SecurityPkg/Library/Tpm12DeviceLibDTpm/Tpm12DeviceLibDT=
pm.inf
+  Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDTpm.=
inf
+!endif
=20
 [LibraryClasses.common.DXE_CORE]
   HobLib|MdePkg/Library/DxeCoreHobLib/DxeCoreHobLib.inf
@@ -558,6 +568,12 @@
=20
   gEfiSecurityPkgTokenSpaceGuid.PcdOptionRomImageVerificationPolicy|0x00
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  gEfiSecurityPkgTokenSpaceGuid.PcdTpmInstanceGuid|{0xb6, 0xe5, 0x01, 0x=
8b, 0x19, 0x4f, 0xe8, 0x46, 0xab, 0x93, 0x1c, 0x53, 0x67, 0x1b, 0x90, 0xc=
c}
+  gEfiSecurityPkgTokenSpaceGuid.PcdTpm2InitializationPolicy|1
+  gEfiSecurityPkgTokenSpaceGuid.PcdTpmInitializationPolicy|1
+!endif
+
 ########################################################################=
########
 #
 # Components Section - list of all EDK II Modules needed by this Platfor=
m.
@@ -629,6 +645,10 @@
=20
   MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+!endif
+
 !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
   MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf {
     <LibraryClasses>
diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
index bb46a409d9..dc35d0a1f7 100644
--- a/OvmfPkg/OvmfPkgX64.fdf
+++ b/OvmfPkg/OvmfPkgX64.fdf
@@ -168,6 +168,9 @@ INF  UefiCpuPkg/CpuMpPei/CpuMpPei.inf
 INF  MdeModulePkg/Universal/FaultTolerantWritePei/FaultTolerantWritePei.=
inf
 INF  MdeModulePkg/Universal/Variable/Pei/VariablePei.inf
 !endif
+!if $(TPM2_ENABLE) =3D=3D TRUE
+INF  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+!endif
=20
 ########################################################################=
########
=20
--=20
2.16.1.73.g5832b7e9f2
