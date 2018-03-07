Received: from eggs.gnu.org ([2001:4830:134:3::10]:40613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbS1-0005SU-2d
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbRw-00012E-Tm
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1etbRw-00011e-Nc
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:52 -0500
From: marcandre.lureau@redhat.com
Date: Wed,  7 Mar 2018 16:57:38 +0100
Message-Id: <20180307155746.18526-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/8] RFC: ovmf: preliminary TPM2 support
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

The following series adds basic TPM2 support for OVMF-on-QEMU (I
haven't tested TPM1, for lack of interest). It links with the modules
to initializes the device in PEI phase, and do measurements (both PEI
and DXE). The Tcg2Dxe module provides the Tcg2 protocol which allows
the guest to access the measurement log and other facilities.

DxeTpm2MeasureBootLib seems to do its job at measuring images that are
not measured in PEI phase (such as PCI PXE rom)

Tcg2ConfigDxe is not included due to its integration with edk2 own PPI
implementation which conflicts with qemu design. PPI design is still
being discussed & experimented at this point.

Linux guests seem to work fine. But windows guest generally complains
about the lack of PPI interface (most HLK tests require it, tpm.msc
admin interactions too). I haven't done "real" use-cases tests, as I
lack experience with TPM usage. Any help appreciated to test the TPM.

I build edk2 with:

$ build -DTPM2_ENABLE -DSECURE_BOOT_ENABLE  -DMEM_VARSTORE_EMU_ENABLE=3DF=
ALSE

I test with qemu & swtpm/libtpms (tpm2 branches, swtpm_setup.sh --tpm2 --=
tpm-state tpmstatedir)

$ swtpm socket --tpmstate tpmstatedir --ctrl type=3Dunixio,path=3Dtpmsock=
  --tpm2 &
$ qemu .. -chardev socket,id=3Dchrtpm,path=3Dtpmsock -tpmdev emulator,id=3D=
tpm0,chardev=3Dchrtpm -device tpm-crb,tpmdev=3Dtpm0

Thanks

Github tree:
https://github.com/elmarco/edk2/tree/tpm2 (tpm2-v2 tag)

Related bug:
https://bugzilla.tianocore.org/show_bug.cgi?id=3D594

v2:
- the series can now be applied to master directly, thanks to dropping
  PeiReadOnlyVariable requirement
- remove the HOB list workaround, the main fix is now upstream. Add a
  preliminary patch to complete it.
- removed traces of TPM1.2 support
- add own OvmfPkg Tcg2ConfigPei, which performs only TPM2 detection
- make PcdTpmInstanceGuid default all-bits-zero
- drop unneeded Pcd values
- explain why SHA1 is still nice to have (for 1.2 log format)
- drop Tcg2ConfigDxe
- more detailed commit messages, thanks to Laszlo explanations!
- rebased

TODO:
- modify Ia32 and Ia32X64 builds

Marc-Andr=C3=A9 Lureau (8):
  SecurityPkg: also clear HashInterfaceHob.SupportedHashMask
  SecurityPkg/Tcg2Pei: drop PeiReadOnlyVariable from Depex
  MdeModulePkg: fix REGISITER -> REGISTER
  ovmf: simplify SecurityStubDxe.inf inclusion
  ovmf: add OvmfPkg Tcg2ConfigPei module
  ovmf: link with Tcg2Pei module
  ovmf: link with Tcg2Dxe module
  ovmf: add DxeTpm2MeasureBootLib

 MdeModulePkg/Core/Pei/Dispatcher/Dispatcher.c |  18 +--
 MdeModulePkg/Core/Pei/Image/Image.c           |   4 +-
 MdeModulePkg/Core/Pei/PeiMain.h               |   2 +-
 MdeModulePkg/Core/Pei/PeiMain/PeiMain.c       |   2 +-
 OvmfPkg/OvmfPkgIa32.dsc                       |   6 +-
 OvmfPkg/OvmfPkgIa32X64.dsc                    |   6 +-
 OvmfPkg/OvmfPkgX64.dsc                        |  49 ++++++-
 OvmfPkg/OvmfPkgX64.fdf                        |   9 ++
 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf      |  57 ++++++++
 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c       | 124 ++++++++++++++++++
 OvmfPkg/Tcg/Tcg2Config/TpmDetection.c         |  46 +++++++
 .../HashLibBaseCryptoRouterPei.c              |   1 +
 SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf           |   1 -
 13 files changed, 299 insertions(+), 26 deletions(-)
 create mode 100644 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
 create mode 100644 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c
 create mode 100644 OvmfPkg/Tcg/Tcg2Config/TpmDetection.c

--=20
2.16.2.346.g9779355e34
