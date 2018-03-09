Received: from eggs.gnu.org ([2001:4830:134:3::10]:43009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1euHmH-0002Op-Pr
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1euHmG-0006Ry-Ec
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:09:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1euHmG-0006RE-8t
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:09:40 -0500
From: marcandre.lureau@redhat.com
Date: Fri,  9 Mar 2018 14:09:16 +0100
Message-Id: <20180309130918.734-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180309130918.734-1-marcandre.lureau@redhat.com>
References: <20180309130918.734-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/7] OvmfPkg: include Tcg2Pei module
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
version. We keep both SHA-1 and SHA-256 for the TCG 1.2 log format
compatibility, but the SHA-256 measurements and TCG 2 log format are
now recommended.

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Contributed-under: TianoCore Contribution Agreement 1.0
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 OvmfPkg/OvmfPkgIa32.dsc    | 7 +++++++
 OvmfPkg/OvmfPkgIa32.fdf    | 1 +
 OvmfPkg/OvmfPkgIa32X64.dsc | 7 +++++++
 OvmfPkg/OvmfPkgIa32X64.fdf | 1 +
 OvmfPkg/OvmfPkgX64.dsc     | 7 +++++++
 OvmfPkg/OvmfPkgX64.fdf     | 1 +
 6 files changed, 24 insertions(+)

diff --git a/OvmfPkg/OvmfPkgIa32.dsc b/OvmfPkg/OvmfPkgIa32.dsc
index ef25e5037028..05ad5cf3754e 100644
--- a/OvmfPkg/OvmfPkgIa32.dsc
+++ b/OvmfPkg/OvmfPkgIa32.dsc
@@ -273,6 +273,7 @@ [LibraryClasses.common.PEIM]
   QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
+  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/PeiCryptLib.inf
   Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDTpm.=
inf
 !endif
=20
@@ -608,6 +609,12 @@ [Components]
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
   OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf {
+    <LibraryClasses>
+      HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCry=
ptoRouterPei.inf
+      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1.i=
nf
+      NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSha2=
56.inf
+  }
 !endif
=20
   #
diff --git a/OvmfPkg/OvmfPkgIa32.fdf b/OvmfPkg/OvmfPkgIa32.fdf
index 76f35e859eca..e9e8611d4cd9 100644
--- a/OvmfPkg/OvmfPkgIa32.fdf
+++ b/OvmfPkg/OvmfPkgIa32.fdf
@@ -167,6 +167,7 @@ [FV.PEIFV]
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
 INF  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+INF  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
 !endif
=20
 ########################################################################=
########
diff --git a/OvmfPkg/OvmfPkgIa32X64.dsc b/OvmfPkg/OvmfPkgIa32X64.dsc
index 0364dafdcb3a..9a095c3ed88d 100644
--- a/OvmfPkg/OvmfPkgIa32X64.dsc
+++ b/OvmfPkg/OvmfPkgIa32X64.dsc
@@ -278,6 +278,7 @@ [LibraryClasses.common.PEIM]
   QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
+  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/PeiCryptLib.inf
   Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDTpm.=
inf
 !endif
=20
@@ -616,6 +617,12 @@ [Components.IA32]
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
   OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf {
+    <LibraryClasses>
+      HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCry=
ptoRouterPei.inf
+      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1.i=
nf
+      NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSha2=
56.inf
+  }
 !endif
=20
 [Components.X64]
diff --git a/OvmfPkg/OvmfPkgIa32X64.fdf b/OvmfPkg/OvmfPkgIa32X64.fdf
index 16c67fa90c75..e2a370ce22c5 100644
--- a/OvmfPkg/OvmfPkgIa32X64.fdf
+++ b/OvmfPkg/OvmfPkgIa32X64.fdf
@@ -167,6 +167,7 @@ [FV.PEIFV]
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
 INF  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+INF  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
 !endif
=20
 ########################################################################=
########
diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
index a2845804fc4b..861320e9c1f4 100644
--- a/OvmfPkg/OvmfPkgX64.dsc
+++ b/OvmfPkg/OvmfPkgX64.dsc
@@ -278,6 +278,7 @@ [LibraryClasses.common.PEIM]
   QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
+  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/PeiCryptLib.inf
   Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDTpm.=
inf
 !endif
=20
@@ -615,6 +616,12 @@ [Components]
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
   OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf {
+    <LibraryClasses>
+      HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCry=
ptoRouterPei.inf
+      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1.i=
nf
+      NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSha2=
56.inf
+  }
 !endif
=20
   #
diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
index dbafada5226b..c0173e7adf5f 100644
--- a/OvmfPkg/OvmfPkgX64.fdf
+++ b/OvmfPkg/OvmfPkgX64.fdf
@@ -167,6 +167,7 @@ [FV.PEIFV]
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
 INF  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+INF  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
 !endif
=20
 ########################################################################=
########
--=20
2.16.2.346.g9779355e34
