Received: from eggs.gnu.org ([2001:4830:134:3::10]:34567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDJx-000456-9r
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDJw-0007Uh-3G
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1epDJv-0007UE-VU
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:28 -0500
From: marcandre.lureau@redhat.com
Date: Fri, 23 Feb 2018 14:23:08 +0100
Message-Id: <20180223132311.26555-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180223132311.26555-1-marcandre.lureau@redhat.com>
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/7] ovmf: link with Tcg2Pei module
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

This module will initialize TPM device, measure reported FVs and BIOS
version.

CC: Laszlo Ersek <lersek@redhat.com>
CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
Contributed-under: TianoCore Contribution Agreement 1.0
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 OvmfPkg/OvmfPkgX64.dsc | 7 +++++++
 OvmfPkg/OvmfPkgX64.fdf | 1 +
 2 files changed, 8 insertions(+)

diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
index b5cbe8430f..34a7c2778e 100644
--- a/OvmfPkg/OvmfPkgX64.dsc
+++ b/OvmfPkg/OvmfPkgX64.dsc
@@ -279,6 +279,8 @@
   PcdLib|MdePkg/Library/PeiPcdLib/PeiPcdLib.inf
   QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
 !if $(TPM2_ENABLE)
+  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/PeiCryptLib.inf
+  HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCryptoR=
outerPei.inf
   Tpm12DeviceLib|SecurityPkg/Library/Tpm12DeviceLibDTpm/Tpm12DeviceLibDT=
pm.inf
   Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDTpm.=
inf
 !endif
@@ -647,6 +649,11 @@
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
   SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf {
+    <LibraryClasses>
+      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1.i=
nf
+      NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSha2=
56.inf
+  }
 !endif
=20
 !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
index dc35d0a1f7..9558142a42 100644
--- a/OvmfPkg/OvmfPkgX64.fdf
+++ b/OvmfPkg/OvmfPkgX64.fdf
@@ -170,6 +170,7 @@ INF  MdeModulePkg/Universal/Variable/Pei/VariablePei.=
inf
 !endif
 !if $(TPM2_ENABLE) =3D=3D TRUE
 INF  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+INF  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
 !endif
=20
 ########################################################################=
########
--=20
2.16.1.73.g5832b7e9f2
