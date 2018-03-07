Received: from eggs.gnu.org ([2001:4830:134:3::10]:40687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbS6-0005ZH-7Y
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbS5-00019f-DQ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1etbS5-00019W-9K
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:01 -0500
From: marcandre.lureau@redhat.com
Date: Wed,  7 Mar 2018 16:57:44 +0100
Message-Id: <20180307155746.18526-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180307155746.18526-1-marcandre.lureau@redhat.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 6/8] ovmf: link with Tcg2Pei module
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
 OvmfPkg/OvmfPkgX64.dsc | 7 +++++++
 OvmfPkg/OvmfPkgX64.fdf | 1 +
 2 files changed, 8 insertions(+)

diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
index 64bd6b6a9f08..3fa1a31f4c37 100644
--- a/OvmfPkg/OvmfPkgX64.dsc
+++ b/OvmfPkg/OvmfPkgX64.dsc
@@ -278,6 +278,8 @@ [LibraryClasses.common.PEIM]
   QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
=20
 !if $(TPM2_ENABLE)
+  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/PeiCryptLib.inf
+  HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCryptoR=
outerPei.inf
   Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDTpm.=
inf
 !endif
=20
@@ -615,6 +617,11 @@ [Components]
=20
 !if $(TPM2_ENABLE) =3D=3D TRUE
   OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf {
+    <LibraryClasses>
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
