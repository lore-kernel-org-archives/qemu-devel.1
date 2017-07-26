Received: from eggs.gnu.org ([2001:4830:134:3::10]:49407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1daKi5-0005lo-GA
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1daKi2-0004UJ-7x
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:42:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1daKi1-0004Tu-UK
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:42:34 -0400
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721110636.19412e6c@nial.brq.redhat.com>
	<20170721092338.GE17693@redhat.com>
	<20170721143432.0e888800@nial.brq.redhat.com>
	<CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
	<9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
	<165445ef-c2fb-f49e-8185-2a8af0e27bf2@redhat.com>
	<a92581c5-87b8-26d0-15d3-33ea6e87d442@redhat.com>
	<CAGCz3vvyxbe7D2OL08Bo+mzvgP_51c3iPCQ-+PeROC9aZdMo3A@mail.gmail.com>
	<21592b3f-1a0c-c573-b5e6-754a44582309@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f9db34d0-759a-c2f4-d8a5-9bddd79cca4b@redhat.com>
Date: Wed, 26 Jul 2017 13:42:01 +0200
MIME-Version: 1.0
In-Reply-To: <21592b3f-1a0c-c573-b5e6-754a44582309@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "seabios@seabios.org" <seabios@seabios.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Digressing:

On 07/26/17 10:53, Paolo Bonzini wrote:
> On 25/07/2017 23:25, Phil Dennis-Jordan wrote:
>> Thanks for this, Paolo. Very interesting idea.
>>
>> I couldn't get things working initially, but with a few fixups on the
>> SeaBIOS side I can boot both legacy and modern OSes. See comments
>> inline below for details on changes required.
>>
>> Successfully booted (only a brief test):
>> - Windows 2000
>> - Windows XP (32 bit)
>> - Windows 7 (32 bit)
>> - Windows 10 (64 bit, SeaBIOS)
>> - Windows 10 (64 bit, OVMF)
>> - macOS 10.12 (patched OVMF)
>
> Thanks Phil!  You unwittingly tested the compatibility path on all
> these OSes, since my QEMU patch forgot to setup rsdp->length,
> rsdp->revision and the extended checksum.  However, I've now tested
> Windows XP, Linux w/SeaBIOS, Linux w/patched SeaBIOS and Linux w/OVMF.
>
> I've now found out that edk2 contains similar logic.  It uses a PCD (a
> compile-time flag essentially) to choose between ACPI >= 2.0 tables or
> ACPI 1.0-compatible tables.  In the latter case, edk2 takes care of
> producing a v1 FADT if needed (similar to this patch) and linking the
> RSDT to it; otherwise it keeps whatever FADT was provided by platform
> code and produces an XSDT.

Not exactly; the PCD controls whether the EFI_ACPI_TABLE_PROTOCOL will
expose an RSDT, an XSDT, or both (with matching contents). The FADT
always comes from the specific edk2 platform (i.e., OVMF client code),
and it is not translated in any way, regardless of the PCD value.

>From "MdeModulePkg/MdeModulePkg.dec":

>   ## Indicates which ACPI versions are targeted by the ACPI tables exposed to the OS
>   #  These values are aligned with the definitions in MdePkg/Include/Protocol/AcpiSystemDescriptionTable.h
>   #   BIT 1 - EFI_ACPI_TABLE_VERSION_1_0B.<BR>
>   #   BIT 2 - EFI_ACPI_TABLE_VERSION_2_0.<BR>
>   #   BIT 3 - EFI_ACPI_TABLE_VERSION_3_0.<BR>
>   #   BIT 4 - EFI_ACPI_TABLE_VERSION_4_0.<BR>
>   #   BIT 5 - EFI_ACPI_TABLE_VERSION_5_0.<BR>
>   # @Prompt Exposed ACPI table versions.
>   gEfiMdeModulePkgTokenSpaceGuid.PcdAcpiExposedTableVersions|0x3E|UINT32|0x0001004c

The expectation is that the specific edk2 platform overrides this PCD at
build time (if necessary), and then goes on (at boot time) to install
ACPI tables -- using EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() -- that
actually match the PCD setting.

>From the "MdeModulePkg/Universal/Acpi/AcpiTableDxe/" driver's POV (that
is, from the EFI_ACPI_TABLE_PROTOCOL implementation's POV), the platform
controls *both* the PCD and the actually installed tables like the FADT,
so EFI_ACPI_TABLE_PROTOCOL expects the platform to make these
consistent.

The tiny little problem is that the PCD is a build-time flag, but QEMU
provides the FADT (and friends) at boot time, dynamically, in a format
that is essentially opaque to OVMF. So OVMF is sticking with the default
PCD (see above), resulting in both RSDT and XSDT root tables, regardless
of the contents of the FADT and friends.

A somewhat (but not too much) similar situation is with the SMBIOS
tables. The tables are composed / exported by QEMU over fw_cfg, and OVMF
/ AAVMF have to set some version-like PCDs that match the content:
- PcdSmbiosDocRev
- PcdSmbiosVersion

We do some ugly hacks in OVMF to ensure that these PCDs are set "in
time", before the generic "MdeModulePkg/Universal/SmbiosDxe" --
providing EFI_SMBIOS_PROTOCOL -- starts up and consumes the PCDs.
Namely, we have "OvmfPkg/Library/SmbiosVersionLib" which sets these PCDs
based on fw_cfg, and we link this library via NULL class resolution into
"MdeModulePkg/Universal/SmbiosDxe". So the PCDs will be set up just
before EFI_SMBIOS_PROTOCOL is initialized and provided. In turn,
"OvmfPkg/SmbiosPlatformDxe", which actually calls
EFI_SMBIOS_PROTOCOL.Add() on the tables provided by QEMU, has a depex on
EFI_SMBIOS_PROTOCOL -- first, this depex ensures that
EFI_SMBIOS_PROTOCOL can be used by "OvmfPkg/SmbiosPlatformDxe", but
second, the depex *also* ensures that the PCDs will have been set
correctly by the time "OvmfPkg/SmbiosPlatformDxe" calls
EFI_SMBIOS_PROTOCOL.Add() for the first time.

You might ask why we don't do the same in the ACPI case (i.e., for
PcdAcpiExposedTableVersions). It's due to the following differences:

- (less importantly,) "MdeModulePkg.dec" allows platforms to pick
  "dynamic" for PcdSmbiosDocRev and PcdSmbiosVersion, not just "fixed at
  build". IOW, MdeModulePkg already expects platforms to set the SMBIOS
  version PCDs dynamically, if those platforms can ensure the setting
  occurs "early enough".

- (more importantly,) the information needed by OVMF, for setting the
  SMBIOS version PCDs in "OvmfPkg/Library/SmbiosVersionLib", is readily
  available for parsing from the separate, dedicated fw_cfg file called
  "etc/smbios/smbios-anchor". In fact, OVMF doesn't use this file for
  anything else than grabbing the versions for the PCDs. The actual
  "anchor" table (the smbios entry point) is produced by the
  EFI_SMBIOS_PROTOCOL implementation in
  "MdeModulePkg/Universal/SmbiosDxe", which consumes the version PCDs.

  (The SMBIOS tables themselves are provided in another fw_cfg file,
  called "etc/smbios/smbios-tables". Incidentally, the structure of that
  file is also way simpler than the ACPI linker/loader blobs'; OVMF can
  pick it apart with a simple loop and pass the individual SMBIOS tables
  to EFI_SMBIOS_PROTOCOL.Add().)

Anyway, I'm calling this email a digression because it isn't really
related to the FADT content that is exposed to the OS. I just wanted to
clarify "PcdAcpiExposedTableVersions", and that there isn't any "deep"
FADT translation in edk2, to my knowledge.

Thanks
Laszlo
