Received: from eggs.gnu.org ([2001:4830:134:3::10]:45572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fL8Qe-0007mX-Fz
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fL8QZ-0006Gb-HK
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:38:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fL8QZ-0006GQ-Bv
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:38:15 -0400
References: <20180518122304.31020-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b7e6a6bf-c4bb-f677-c269-d7b3e3a75151@redhat.com>
Date: Tue, 22 May 2018 16:38:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180518122304.31020-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH v3 0/4] RFC: ovmf: Add support for
 TPM Physical Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

On 05/18/18 14:23, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Hi,
>=20
> The following series adds basic TPM PPI 1.3 support for OVMF-on-QEMU
> with TPM2 (I haven't looked at TPM1, for lack of interest).
>=20
> PPI test runs successfully with Windows 10 WHLK, despite the limited
> number of supported funcions (tpm2_ppi_funcs table, in particular, no
> function allows to manipulate Tcg2PhysicalPresenceFlags)
>=20
> The way it works is relatively simple: a memory region is allocated by
> QEMU to save PPI related variables. An ACPI interface is exposed by
> QEMU to let the guest manipulate those. At boot, ovmf processes and
> updates the PPI qemu region and request variables.
>=20
> I build edk2 with:
>=20
> $ build -DTPM2_ENABLE
>=20
> I test with qemu & swtpm/libtpms (tpm2 branches, swtpm_setup.sh --tpm2
>  --tpm-state tpmstatedir)
>=20
> $ swtpm socket --tpmstate tpmstatedir --ctrl type=3Dunixio,path=3Dtpmso=
ck
>   --tpm2 &
>=20
> $ qemu .. -chardev socket,id=3Dchrtpm,path=3Dtpmsock -tpmdev
>   emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-crb,tpmdev=3Dtpm0
>=20
> Github trees:
> https://github.com/elmarco/edk2/tree/tpm-ppi
> https://github.com/elmarco/qemu/tree/tpm-ppi
>=20
> Thanks
>=20
> v3: after Laszlo review
>  - dropped DxeTcg2PhysicalPresenceLib.uni
>  - removed mTpm2PPIFuncs static initialization, use hard-coded assignme=
nts
>  - declared STATIC the functions that should be
>  - fixed an OUT/IN decorator
>  - use EFI_PROTOCOL_ERROR instead of EFI_INVALID_PARAMETER when PPI
>    initialization fails
>  - replaced EFI_D_INFO with DEBUG_INFO
>  - added a check for mPpi address that it doesn't cross a page boundary
>  - added a GetMemorySpaceDescriptor() check for memory type
>  - declared *mPpi as volatile, to correct mmio access
>  - a few more style changes
>  - comments updated
>  - some minor dead code/inclusion/defines removal
>  - added a few r-b tags
>=20
> v2:
>  - style and commit message fixes
>=20
> Marc-Andr=C3=A9 Lureau (4):
>   OvmfPkg: add Tcg2PhysicalPresenceLibNull when !TPM2_ENABLE
>   OvmfPkg/IndustryStandard: add QemuTpm.h header
>   OvmfPkg: add Tcg2PhysicalPresenceLibQemu
>   OvmfPkg/PlatformBootManagerLib: process TPM PPI request
>=20
>  OvmfPkg/OvmfPkgIa32.dsc                       |   4 +-
>  OvmfPkg/OvmfPkgIa32X64.dsc                    |   4 +-
>  OvmfPkg/OvmfPkgX64.dsc                        |   4 +-
>  .../PlatformBootManagerLib.inf                |   2 +
>  .../DxeTcg2PhysicalPresenceLib.inf            |  33 +
>  .../DxeTcg2PhysicalPresenceLib.inf            |  46 +-
>  OvmfPkg/Include/IndustryStandard/QemuTpm.h    |  69 ++
>  .../PlatformBootManagerLib/BdsPlatform.c      |   6 +
>  .../DxeTcg2PhysicalPresenceLib.c              |  20 +-
>  .../DxeTcg2PhysicalPresenceLib.c              | 919 ++++++++++++++++++
>  .../PhysicalPresenceStrings.uni               |  33 +-
>  11 files changed, 1081 insertions(+), 59 deletions(-)
>  create mode 100644 OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2=
PhysicalPresenceLib.inf
>  copy {SecurityPkg/Library/DxeTcg2PhysicalPresenceLib =3D> OvmfPkg/Libr=
ary/Tcg2PhysicalPresenceLibQemu}/DxeTcg2PhysicalPresenceLib.inf (66%)
>  create mode 100644 OvmfPkg/Include/IndustryStandard/QemuTpm.h
>  copy EdkCompatibilityPkg/Foundation/Library/EdkIIGlueLib/Library/BaseL=
ib/Ia32/CpuSleep.c =3D> OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTc=
g2PhysicalPresenceLib.c (55%)
>  create mode 100644 OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2=
PhysicalPresenceLib.c
>  copy {SecurityPkg/Library/DxeTcg2PhysicalPresenceLib =3D> OvmfPkg/Libr=
ary/Tcg2PhysicalPresenceLibQemu}/PhysicalPresenceStrings.uni (56%)
>=20

I briefly summarized the updates that I mentioned in review on the
patches themselves, and pushed the series as commit range
75135cc6988e..8d65d3b25e35.

Thank you guys again!
Laszlo
