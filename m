Received: from eggs.gnu.org ([2001:4830:134:3::10]:35896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fJKBc-00015z-Sr
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fJKBY-0006o1-4o
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:47:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fJKBX-0006no-Va
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:47:16 -0400
From: marcandre.lureau@redhat.com
Date: Thu, 17 May 2018 16:47:09 +0200
Message-Id: <20180517144713.18647-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] RFC: ovmf: Add support for TPM Physical
 Presence interface
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

Hi,

The following series adds basic TPM PPI 1.3 support for OVMF-on-QEMU
with TPM2 (I haven't tested TPM1, for lack of interest).

PPI test runs successfully with Windows 10 WHLK, despite the limited
number of supported funcions (tpm2_ppi_funcs table, in particular, no
function allows to manipulate Tcg2PhysicalPresenceFlags)

The way it works is relatively simple: a memory region is allocated by
QEMU to save PPI related variables. An ACPI interface is exposed by
QEMU to let the guest manipulate those. At boot, ovmf processes and
updates the PPI qemu region and request variables.

I build edk2 with:

$ build -DTPM2_ENABLE -DSECURE_BOOT_ENABLE

I test with qemu & swtpm/libtpms (tpm2 branches, swtpm_setup.sh --tpm2 --=
tpm-state tpmstatedir)

$ swtpm socket --tpmstate tpmstatedir --ctrl type=3Dunixio,path=3Dtpmsock=
  --tpm2 &
$ qemu .. -chardev socket,id=3Dchrtpm,path=3Dtpmsock -tpmdev emulator,id=3D=
tpm0,chardev=3Dchrtpm -device tpm-crb,tpmdev=3Dtpm0

Github trees:
https://github.com/elmarco/edk2/tree/tpm-ppi
https://github.com/elmarco/qemu/tree/tpm-ppi

Thanks

v2:
 - style and commit message fixes

Marc-Andr=C3=A9 Lureau (4):
  OvmfPkg: add Tcg2PhysicalPresenceLibNull when !TPM2_ENABLE
  OvmfPkg/IndustryStandard: add QemuTpm.h header
  OvmfPkg: add Tcg2PhysicalPresenceLibQemu
  OvmfPkg/PlatformBootManagerLib: process TPM PPI request

 OvmfPkg/OvmfPkgIa32.dsc                       |   4 +-
 OvmfPkg/OvmfPkgIa32X64.dsc                    |   4 +-
 OvmfPkg/OvmfPkgX64.dsc                        |   4 +-
 .../PlatformBootManagerLib.inf                |   2 +
 .../DxeTcg2PhysicalPresenceLib.inf            |  34 +
 .../DxeTcg2PhysicalPresenceLib.inf            |  25 +-
 OvmfPkg/Include/IndustryStandard/QemuTpm.h    |  69 ++
 .../PlatformBootManagerLib/BdsPlatform.c      |   8 +
 .../DxeTcg2PhysicalPresenceLib.c              |  19 +-
 .../DxeTcg2PhysicalPresenceLib.c              | 889 ++++++++++++++++++
 .../DxeTcg2PhysicalPresenceLib.uni            |   3 +-
 .../PhysicalPresenceStrings.uni               |  28 +-
 12 files changed, 1039 insertions(+), 50 deletions(-)
 create mode 100644 OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2Ph=
ysicalPresenceLib.inf
 copy {SecurityPkg/Library/DxeTcg2PhysicalPresenceLib =3D> OvmfPkg/Librar=
y/Tcg2PhysicalPresenceLibQemu}/DxeTcg2PhysicalPresenceLib.inf (80%)
 create mode 100644 OvmfPkg/Include/IndustryStandard/QemuTpm.h
 copy EdkCompatibilityPkg/Foundation/Library/EdkIIGlueLib/Library/BaseLib=
/Ia32/CpuSleep.c =3D> OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2=
PhysicalPresenceLib.c (55%)
 create mode 100644 OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2Ph=
ysicalPresenceLib.c
 copy {SecurityPkg/Library/DxeTcg2PhysicalPresenceLib =3D> OvmfPkg/Librar=
y/Tcg2PhysicalPresenceLibQemu}/DxeTcg2PhysicalPresenceLib.uni (97%)
 copy {SecurityPkg/Library/DxeTcg2PhysicalPresenceLib =3D> OvmfPkg/Librar=
y/Tcg2PhysicalPresenceLibQemu}/PhysicalPresenceStrings.uni (62%)

--=20
2.17.0.253.g3dd125b46d
