Received: from eggs.gnu.org ([2001:4830:134:3::10]:50131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1epFh4-0003lm-As
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1epFh1-0008UL-2O
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:55:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1epFh0-0008TA-TT
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:55:27 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f9e4d63e-5e70-09ee-488b-3ab246708ee7@redhat.com>
Date: Fri, 23 Feb 2018 16:55:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180223132311.26555-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 0/7] RFC: ovmf: preliminary TPM2
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
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:
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
> Tcg2ConfigDxe is mostly interesting for debugging for now.
>=20
> A major lack is the support for Physical Present Interface (PPI, more
> below).
>=20
> Linux guests seem to work fine. But windows guest generally complains
> about the lack of PPI interface (most HLK tests require it, tpm.msc
> admin interactions too). I haven't done "real" use-cases tests, as I
> lack experience with TPM usage. Any help appreciated to test the TPM.
>=20
> Tcg2ConfigPei requires variable access, therefore
> <https://bugzilla.tianocore.org/show_bug.cgi?id=3D386> must be solved
> first. I used "[edk2] [PATCH v2 0/8] OvmfPkg: add the Variable PEIM,
> defragment the UEFI memmap" as a base for this series.
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

Thanks for this work -- extra thanks for the instructions regarding the
software TPM backend.

> PPI is problematic, because we generally don't want or need SMM, and
> qemu is preferred to provide the ACPI tables. We therefore exclude
> using Tcg2Smm for now (which also brings other problems). Stefan
> Berger has been prototyping qemu code that provides PPI ACPI
> interface, but there is some complication regarding memory location,
> using a fixed address. My understanding is that the firmware
> (seabios/edk2) should allocate the required memory itself (using qemu
> linker script for ex) and patch the ACPI table. Then it's hopefully
> only a matter of hooking Tcg2PhysicalPresenceLibProcessRequest() as
> was done by Stefan in
> https://github.com/stefanberger/edk2/commits/tpm2. The main problem I
> see with this approach is that the location should remain stable
> across reboots (not necessarily poweroff, edk2 uses nvram variables
> for PPI flags). More investigation and help needed to support PPI!

Indeed the main requirement for the OS to queue PPI operations for the
next boot of the firmware seems a "semi-persistent" storage. "Semi-"
because we target (warm) reboot, not complete poweroff plus re-launch.

The ACPI linker/loader is not suitable for this. It is great for making
the firmware allocate memory, but such allocations are never expected to
be stable. At the first boot, the firmware can allocate some blob just
fine, patch ACPI tables with the allocation address, and even write back
the allocation address to QEMU (for some device model to use).
Furthermore, the kernel can populate this blob. However, at reboot, the
firmware won't know where to look.

The firmware could use / set aside a RAM area at a dedicated
(pre-defined) memory address for this. However, that is incompatible
with our goal that as much as possible ACPI stuff should be generated
by, and come from, QEMU. We should also minimize the differences between
SeaBIOS and OVMF.

So, we need some kind of emulated NVRAM for the PPI opcode storage, such
that both its contents and its address survive a warm reboot.

- For SeaBIOS this means dedicated hw support from QEMU (hence Stefan's
"virtual memory device" as part of the TPM MMIO register block).

- For OVMF, in theory the pflash chip could be used, via UEFI variables.
However, this requires QEMU-generated AML to call into the firmware
(namely the UEFI variable driver). This is only possible with SMM (there
is no calling convention, from AML to the firmware, other than
formatting a request buffer and raising an SMI). That would mean many
complications, and also limit the feature to Q35.

So, as long as we'd like to target both firmwares eventually, the PPI
opcode storage should be carved out of the TPM MMIO register block, and
OVMF should be taught to consume the opcodes from there.


I'll try to go through these patches soon.

FWIW, the dependency on Tcg2ConfigPei is not great. I've tried to
upstream my series for TianoCore BZ#386 several times, and I've always
failed.

In
<http://mid.mail-archive.com/74D8A39837DF1E4DA445A8C0B3885C503A97A4CF@shs=
msx102.ccr.corp.intel.com>,
Jiewen wrote,

"Tcg2ConfigPei/Dxe are platform sample driver. A platform may have its
own version based upon platform requirement [...]"

So, because Tcg2ConfigPei seems to consume the UEFI variable only for
speeding up TPM detection, I guess we could add a "trimmed clone" to
OvmfPkg that performed the hw detection unconditionally (not relying on
any cached state). This would make sense in a virt world especially
because the TPM device model might disappear from, and reapper in, the
domain config, from one cold boot to the next.

Laszlo

>=20
> Thanks
>=20
> Related bug:
> https://bugzilla.tianocore.org/show_bug.cgi?id=3D594
>=20
> Marc-Andr=C3=A9 Lureau (7):
>   SecurityPkg/Tcg2Pei: drop Tcg2PhysicalPresenceLib dependency
>   ovmf: link with Tcg2ConfigPei module
>   HACK: HobLib: workaround infinite loop
>   ovmf: link with Tcg2Pei module
>   ovmf: link with Tcg2Dxe module
>   ovmf: link with Tcg2ConfigDxe module
>   ovmf: add DxeTpm2MeasureBootLib
>=20
>  MdePkg/Library/PeiHobLib/HobLib.c   |  4 +++
>  OvmfPkg/OvmfPkgX64.dsc              | 49 +++++++++++++++++++++++++++++=
+++++++-
>  OvmfPkg/OvmfPkgX64.fdf              |  9 +++++++
>  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c   |  2 --
>  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf |  1 -
>  5 files changed, 61 insertions(+), 4 deletions(-)
>=20
