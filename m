Received: from eggs.gnu.org ([2001:4830:134:3::10]:36877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daL5U-0003eg-LB
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daL5R-0002IP-UM
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:06:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daL5R-0002Hp-LT
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:06:45 -0400
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
	<f9db34d0-759a-c2f4-d8a5-9bddd79cca4b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c8a6dc2-7732-1dd3-982a-f39b3fe69e11@redhat.com>
Date: Wed, 26 Jul 2017 14:06:38 +0200
MIME-Version: 1.0
In-Reply-To: <f9db34d0-759a-c2f4-d8a5-9bddd79cca4b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Laszlo Ersek <lersek@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "seabios@seabios.org" <seabios@seabios.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 26/07/2017 13:42, Laszlo Ersek wrote:
> Not exactly; the PCD controls whether the EFI_ACPI_TABLE_PROTOCOL will
> expose an RSDT, an XSDT, or both (with matching contents).

You're right that the code does not produce a v1 FADT, I mis-skimmed the
awful code of AcpiTableDxe.  Though the intentions seems to be there in
the UEFI spec, because UEFI has different GUIDs for ACPI 1.0 and 2.0+
RSDPs---and they need not point to the same tables, even though the ACPI
1.0 RSDP is a subset of the 2.0+ one.

AcpiTableDxe's data structures have an "Rsdp1" field (pointing to
"Rsdt1" and from there to "Fadt1") and an "Rsdp3" field (pointing to
"Xsdt" and optionally "Rsdt3", and from both to "Fadt3").  However:

* Fadt1 and Fadt3 have exactly the same content.

* Rsdt3 doesn't point to Fadt1.

It should be easy to make "Fadt1" a v1 table instead of copying the same
contents to Fadt1 and Fadt3, and to make Rsdt3 point to Fadt1.  The CSM
would just work if edk2 did this; until then Windows 2000 over SeaBIOS
over OVMF remains broken, but I guess that's not that much of an issue.

Anyway, once you take CSM into account, IMHO a firmware solution becomes
preferrable to Kevin's proposals to add a etc/table-loader-legacy (or
similar) file in fw_cfg.

Paolo

> The FADT
> always comes from the specific edk2 platform (i.e., OVMF client code),
> and it is not translated in any way, regardless of the PCD value.
>=20
> From "MdeModulePkg/MdeModulePkg.dec":
>=20
>>   ## Indicates which ACPI versions are targeted by the ACPI tables exp=
osed to the OS
>>   #  These values are aligned with the definitions in MdePkg/Include/P=
rotocol/AcpiSystemDescriptionTable.h
>>   #   BIT 1 - EFI_ACPI_TABLE_VERSION_1_0B.<BR>
>>   #   BIT 2 - EFI_ACPI_TABLE_VERSION_2_0.<BR>
>>   #   BIT 3 - EFI_ACPI_TABLE_VERSION_3_0.<BR>
>>   #   BIT 4 - EFI_ACPI_TABLE_VERSION_4_0.<BR>
>>   #   BIT 5 - EFI_ACPI_TABLE_VERSION_5_0.<BR>
>>   # @Prompt Exposed ACPI table versions.
>>   gEfiMdeModulePkgTokenSpaceGuid.PcdAcpiExposedTableVersions|0x3E|UINT=
32|0x0001004c
> The expectation is that the specific edk2 platform overrides this PCD a=
t
> build time (if necessary), and then goes on (at boot time) to install
> ACPI tables -- using EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() -- that
> actually match the PCD setting.
