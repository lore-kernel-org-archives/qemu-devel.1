Received: from eggs.gnu.org ([2001:4830:134:3::10]:34568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDJx-000458-AM
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1epDJu-0007Sn-28
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33518 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1epDJt-0007Rq-Td
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:23:25 -0500
From: marcandre.lureau@redhat.com
Date: Fri, 23 Feb 2018 14:23:04 +0100
Message-Id: <20180223132311.26555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/7] RFC: ovmf: preliminary TPM2 support
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

Tcg2ConfigDxe is mostly interesting for debugging for now.

A major lack is the support for Physical Present Interface (PPI, more
below).

Linux guests seem to work fine. But windows guest generally complains
about the lack of PPI interface (most HLK tests require it, tpm.msc
admin interactions too). I haven't done "real" use-cases tests, as I
lack experience with TPM usage. Any help appreciated to test the TPM.

Tcg2ConfigPei requires variable access, therefore
<https://bugzilla.tianocore.org/show_bug.cgi?id=3D386> must be solved
first. I used "[edk2] [PATCH v2 0/8] OvmfPkg: add the Variable PEIM,
defragment the UEFI memmap" as a base for this series.

I build edk2 with:

$ build -DTPM2_ENABLE -DSECURE_BOOT_ENABLE  -DMEM_VARSTORE_EMU_ENABLE=3DF=
ALSE

I test with qemu & swtpm/libtpms (tpm2 branches, swtpm_setup.sh --tpm2 --=
tpm-state tpmstatedir)

$ swtpm socket --tpmstate tpmstatedir --ctrl type=3Dunixio,path=3Dtpmsock=
  --tpm2 &
$ qemu .. -chardev socket,id=3Dchrtpm,path=3Dtpmsock -tpmdev emulator,id=3D=
tpm0,chardev=3Dchrtpm -device tpm-crb,tpmdev=3Dtpm0

PPI is problematic, because we generally don't want or need SMM, and
qemu is preferred to provide the ACPI tables. We therefore exclude
using Tcg2Smm for now (which also brings other problems). Stefan
Berger has been prototyping qemu code that provides PPI ACPI
interface, but there is some complication regarding memory location,
using a fixed address. My understanding is that the firmware
(seabios/edk2) should allocate the required memory itself (using qemu
linker script for ex) and patch the ACPI table. Then it's hopefully
only a matter of hooking Tcg2PhysicalPresenceLibProcessRequest() as
was done by Stefan in
https://github.com/stefanberger/edk2/commits/tpm2. The main problem I
see with this approach is that the location should remain stable
across reboots (not necessarily poweroff, edk2 uses nvram variables
for PPI flags). More investigation and help needed to support PPI!

Thanks

Related bug:
https://bugzilla.tianocore.org/show_bug.cgi?id=3D594

Marc-Andr=C3=A9 Lureau (7):
  SecurityPkg/Tcg2Pei: drop Tcg2PhysicalPresenceLib dependency
  ovmf: link with Tcg2ConfigPei module
  HACK: HobLib: workaround infinite loop
  ovmf: link with Tcg2Pei module
  ovmf: link with Tcg2Dxe module
  ovmf: link with Tcg2ConfigDxe module
  ovmf: add DxeTpm2MeasureBootLib

 MdePkg/Library/PeiHobLib/HobLib.c   |  4 +++
 OvmfPkg/OvmfPkgX64.dsc              | 49 +++++++++++++++++++++++++++++++=
+++++-
 OvmfPkg/OvmfPkgX64.fdf              |  9 +++++++
 SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c   |  2 --
 SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf |  1 -
 5 files changed, 61 insertions(+), 4 deletions(-)

--=20
2.16.1.73.g5832b7e9f2
