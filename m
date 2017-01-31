Received: from eggs.gnu.org ([2001:4830:134:3::10]:46790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cYZTd-0006xi-05
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cYZTb-0003iY-PF
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:32:08 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:34434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cYZTb-0003iC-HE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:32:07 -0500
Received: by mail-ot0-x232.google.com with SMTP id f9so266711221otd.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 06:32:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170118181918.783cb7bd@nial.brq.redhat.com>
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
	<20170118181918.783cb7bd@nial.brq.redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 31 Jan 2017 15:31:46 +0100
Message-ID: <CAAibmn0OEBsZUyxuKcssk-4V-=fA94QWFCk04Lt9rbFN66OgEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 18 January 2017 at 18:19, Igor Mammedov <imammedo@redhat.com> wrote:
> On Wed, 18 Jan 2017 18:30:59 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> On Wed, Jan 18, 2017 at 12:45:54PM +0100, Phil Dennis-Jordan wrote:
> [...]
>
>> > I suspect more might be involved in enabling ACPI 2.0, and it should p=
robably be an option so as to avoid regressions. I don't know what the best=
 approach would be for this, so comments welcome. Should adding the reset r=
egister to the FADT also be configurable?
>>
>> I would say an option to make FADT use rev 3 format would be a good
>> idea.
>>
>> I'd make it the default if XP survives.
> if XP and legacy linux survive,
> I'd skip adding option as probably there won't be any users,
> in unlikely case such user surfaces we always can add option later
> but we can't do it other way around (i.e. take it away).

I have now finally solved the mystery of why my FADT patch has been
going so disastrously wrong - I've now got working code, but I'd
appreciate some guidance on the best way to structure a patch to
minimise further back-and forth. The culprit turned out to be OVMF,
specifically 2 bugs/shortcomings:

1. It completely gives up on parsing Qemu's ACPI tables if more than
one "add pointer" linker command points to the same table. In this
case, if you add a command for both the DSDT and X_DSDT fields of the
FADT, it aborts completely and uses fallback tables. (The following
InstallAcpiTable call fails if called twice with the same table type.)
https://github.com/tianocore/edk2/blob/master/OvmfPkg/AcpiPlatformDxe/QemuF=
wCfgAcpi.c#L518

2. After applying all the linker commands, it goes and rewrites part
of the FADT anyway. Specifically, it rewrites the DSDT and X_DSDT
fields - and it always sets one of them to 0. Which one depends on
whether the DSDT is above the 4G barrier:
https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Universal/Acpi/A=
cpiTableDxe/AcpiTableProtocol.c#L650

Both of these are easily fixed, and I will submit a corresponding patch to =
EDK2.

With that fixed, the rest of the FADT provided by Qemu is accepted by
OVMF and the operating systems. On the Qemu side, it does mean we'll
need to still retain the ACPI 1.0 tables for backwards compatibility.

Q1: How should the option be structured and named? Should the FADT
revision be selectable via a sub-option on -machine? Or as a
standalone option? Something else?


Q2: To avoid any more confusion, I'd appreciate
confirmation/clarification on the X_ and non-X FADT fields in the case
where 32-bit pointers suffice.

Q2a: DSDT/X_DSDT: Both variants appear to be de-facto required.

Q2b: FIRMWARE_CTRL/X_FIRMWARE_CTRL: leave X_FIRMWARE_CTRL zero.

Q2c: X_PM1a_EVT_BLK, X_PM1a_CNT_BLK, X_PM_TMR_BLK: These all state
"This is a required field" for both variants.

Q2d: GPE0_BLK/X_GPE0_BLK: Both variants state "if this register block
is not supported, this field contains zero." - I understand this to
mean that when the register block IS supported and 32-bit, both
variants must be filled.

In other words, only X_FIRMWARE_CTRL stays zero in Qemu's x86 case.


I'll come up with a revised patch in the next few days.

Thanks for your help and patience so far, everyone!
