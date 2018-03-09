Received: from eggs.gnu.org ([2001:4830:134:3::10]:53179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euMuq-0000jT-1l
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euMum-0000Gd-P4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:38:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1euMum-0000GZ-JZ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:38:48 -0500
References: <20180309130918.734-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f055b8f0-0642-b9d4-978d-77da2ba9ec11@redhat.com>
Date: Fri, 9 Mar 2018 19:38:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180309130918.734-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH v3 0/7] ovmf: preliminary TPM2
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com, Brijesh Singh <brijesh.singh@amd.com>

Hi Marc-Andr=C3=A9,

On 03/09/18 14:09, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Hi,
>=20
> The following series adds basic TPM2 support for OVMF-on-QEMU (I
> haven't tested TPM1, for lack of interest). It links with the modules
> to initializes the device in PEI phase, and do measurements (both PEI
> and DXE). The Tcg2Dxe module provides the Tcg2 protocol which allows
> the guest to access the measurement log and other facilities.
>=20
> DxeTpm2MeasureBootLib seems to do its job at measuring images that are
> not measured in PEI phase (such as PCI PXE rom)
>=20
> Tcg2ConfigDxe is not included due to its integration with edk2 own PPI
> implementation which conflicts with qemu design. PPI design is still
> being discussed & experimented at this point.
>=20
> Linux guests seem to work fine. But windows guest generally complains
> about the lack of PPI interface (most HLK tests require it, tpm.msc
> admin interactions too). I haven't done "real" use-cases tests, as I
> lack experience with TPM usage. Any help appreciated to test the TPM.
>=20
> I build edk2 with:
>=20
> $ build -DTPM2_ENABLE -DSECURE_BOOT_ENABLE  -DMEM_VARSTORE_EMU_ENABLE=3D=
FALSE
>=20
> I test with qemu & swtpm/libtpms (tpm2 branches, swtpm_setup.sh --tpm2 =
--tpm-state tpmstatedir)
>=20
> $ swtpm socket --tpmstate tpmstatedir --ctrl type=3Dunixio,path=3Dtpmso=
ck  --tpm2 &
> $ qemu .. -chardev socket,id=3Dchrtpm,path=3Dtpmsock -tpmdev emulator,i=
d=3Dtpm0,chardev=3Dchrtpm -device tpm-crb,tpmdev=3Dtpm0
>=20
> Thanks
>=20
> Github tree:
> https://github.com/elmarco/edk2/tree/tpm2 (tpm2-v2 tag)
>=20
> Related bug:
> https://bugzilla.tianocore.org/show_bug.cgi?id=3D594
>=20
> v3:  after Laszlo review
> - many simplifications to "add customized Tcg2ConfigPei clone" patch
> - various move of fdf/dsc sections
> - modify Ia32 & Ia32x64 fdf/dsc too
> - modify commit messages
> - add r-b tags
>=20
> v2:
> - the series can now be applied to master directly, thanks to dropping
>   PeiReadOnlyVariable requirement
> - remove the HOB list workaround, the main fix is now upstream. Add a
>   preliminary patch to complete it.
> - removed traces of TPM1.2 support
> - add own OvmfPkg Tcg2ConfigPei, which performs only TPM2 detection
> - make PcdTpmInstanceGuid default all-bits-zero
> - drop unneeded Pcd values
> - explain why SHA1 is still nice to have (for 1.2 log format)
> - drop Tcg2ConfigDxe
> - more detailed commit messages, thanks to Laszlo explanations!
> - rebased
>=20
> TODO:
> - modify Ia32 and Ia32X64 builds
>=20
> Marc-Andr=C3=A9 Lureau (7):
>   SecurityPkg/Tcg2Pei: drop PeiReadOnlyVariable from Depex
>   MdeModulePkg/Core/Pei: fix REGISITER -> REGISTER typo
>   OvmfPkg: simplify SecurityStubDxe.inf inclusion
>   OvmfPkg: add customized Tcg2ConfigPei clone
>   OvmfPkg: include Tcg2Pei module
>   OvmfPkg: include Tcg2Dxe module
>   OvmfPkg: plug DxeTpm2MeasureBootLib into SecurityStubDxe
>=20
>  MdeModulePkg/Core/Pei/Dispatcher/Dispatcher.c | 18 ++--
>  MdeModulePkg/Core/Pei/Image/Image.c           |  4 +-
>  MdeModulePkg/Core/Pei/PeiMain.h               |  2 +-
>  MdeModulePkg/Core/Pei/PeiMain/PeiMain.c       |  2 +-
>  OvmfPkg/OvmfPkgIa32.dsc                       | 49 ++++++++++-
>  OvmfPkg/OvmfPkgIa32.fdf                       |  9 ++
>  OvmfPkg/OvmfPkgIa32X64.dsc                    | 49 ++++++++++-
>  OvmfPkg/OvmfPkgIa32X64.fdf                    |  9 ++
>  OvmfPkg/OvmfPkgX64.dsc                        | 49 ++++++++++-
>  OvmfPkg/OvmfPkgX64.fdf                        |  9 ++
>  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf      | 53 ++++++++++++
>  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c       | 84 +++++++++++++++++++
>  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf           |  1 -
>  13 files changed, 312 insertions(+), 26 deletions(-)
>  create mode 100644 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
>  create mode 100644 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c
>=20

huge kudos for this work. I've pushed it now: commit range
7878f706e7eb..d5a002aba0aa.

* For future work, please update your git setting so that you include,
in your commit message:

    Contributed-under: TianoCore Contribution Agreement 1.1
                                                        ^^^

The patches in this series vary between 1.0 and 1.1. For now, 1.0 is
acceptable as well (see
<https://bugzilla.tianocore.org/show_bug.cgi?id=3D628> and commit
f2d1b866dfd9, "BaseTools/PatchCheck: Support Contribution Agreement
1.1", 2017-08-03).

The difference between 1.0 and 1.1 is basically "docs files" -- please
see commit b6538c118ae8 ("edk2: Update to TianoCore Contribution
Agreement 1.1", 2017-08-03). You don't touch documentation in this
series, just source code, so 1.0 is fine (wherever you used that); in
the future 1.1 should be used consistently.

* I did some regression testing too, with this set applied, for both
TRUE and FALSE values of TPM2_ENABLE. (Note that I didn't actually set
up swtpm, so my regression-testing for TRUE exercised the "detection
failed" branch.) Normal boot and S3 suspend/resume continues to work
under all the usual circumstances (with or without SMM etc).

* One scenario that I didn't test (and I expect it *not* to work) is
TPM2 detection in a SEV guest (CC'ing Brijesh for this, just as a
heads-up). In a SEV guest, we currently mark MMIO ranges as decrypted /
plaintext in the DXE phase first. This means that Tcg2ConfigPei (which
detects the TPM2 chip) and Tcg2Pei (which measures the firmware volumes
into TPM2) wouldn't be able to access the TPM2 chip. We might attempt to
massage the PTE C-bit in the PEI phase specifically on the TPM2 MMIO
range, however that's architecturally impossible in the IA32 and IA32X64
builds (where the PEI phase is 32-bit). And, if we use the X64 build,
then the SMM+S3 combination doesn't work (because S3Resume2Pei doesn't
support that scenario).

All in all, with all of these seemingly orthogonal features, we
unavoidably run into obscure combinations that don't, or even can't,
work. This is a hard problem; we should figure it out later. (One dirty
hack could be to add an IO-port mapped register block to the TPM2 chip
in QEMU, and create adapted variants of the necessary edk2 libs -- IO
access is entirely unaffected by SEV.) For now, TPM2_ENABLE defaults to
FALSE (a good choice), so no issue for SEV guests. And, Peter and Javier
on the RH Bootloader Team can rebuild OVMF with TPM2_ENABLE, for testing
their TCG2 protocol client code -- that use case doesn't involve SEV. So
I think this is an acceptable state to push to the master branch, for
the time being.

Thanks!
Laszlo
