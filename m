Received: from eggs.gnu.org ([2001:4830:134:3::10]:41419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cYavf-0001kw-T9
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cYavd-0005GV-V3
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:05:11 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:35211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cYavd-0005G5-Nq
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:05:09 -0500
Received: by mail-oi0-x236.google.com with SMTP id j15so216951872oih.2
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 08:05:09 -0800 (PST)
MIME-Version: 1.0
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
	<20170118181918.783cb7bd@nial.brq.redhat.com>
	<CAAibmn0OEBsZUyxuKcssk-4V-=fA94QWFCk04Lt9rbFN66OgEg@mail.gmail.com>
	<20170131165802-mutt-send-email-mst@kernel.org>
	<20170131164102.583323d7@nial.brq.redhat.com>
In-Reply-To: <20170131164102.583323d7@nial.brq.redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 31 Jan 2017 16:04:58 +0000
Message-ID: <CAAibmn1T=3A5wdenc=8H7G2OAMZVPjTHiM8XCO27BCAfpPYvpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, lersek@redhat.com, qemu-devel@nongnu.org

On Tue, 31 Jan 2017 at 16:41, Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 31 Jan 2017 16:58:22 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> > On Tue, Jan 31, 2017 at 03:31:46PM +0100, Phil Dennis-Jordan wrote:
> > > On 18 January 2017 at 18:19, Igor Mammedov <imammedo@redhat.com>
> wrote:
> > > > On Wed, 18 Jan 2017 18:30:59 +0200
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >
> > > >> On Wed, Jan 18, 2017 at 12:45:54PM +0100, Phil Dennis-Jordan wrote:
> > > > [...]
> > > >
> > > >> > I suspect more might be involved in enabling ACPI 2.0, and it
> should probably be an option so as to avoid regressions. I don't know what
> the best approach would be for this, so comments welcome. Should adding the
> reset register to the FADT also be configurable?
> > > >>
> > > >> I would say an option to make FADT use rev 3 format would be a good
> > > >> idea.
> > > >>
> > > >> I'd make it the default if XP survives.
> > > > if XP and legacy linux survive,
> > > > I'd skip adding option as probably there won't be any users,
> > > > in unlikely case such user surfaces we always can add option later
> > > > but we can't do it other way around (i.e. take it away).
> > >
> > > I have now finally solved the mystery of why my FADT patch has been
> > > going so disastrously wrong - I've now got working code, but I'd
> > > appreciate some guidance on the best way to structure a patch to
> > > minimise further back-and forth.
> >
> > + lersek
> >
> > > The culprit turned out to be OVMF,
> > > specifically 2 bugs/shortcomings:
> > >
> > > 1. It completely gives up on parsing Qemu's ACPI tables if more than
> > > one "add pointer" linker command points to the same table. In this
> > > case, if you add a command for both the DSDT and X_DSDT fields of the
> > > FADT, it aborts completely and uses fallback tables. (The following
> > > InstallAcpiTable call fails if called twice with the same table type.)
> > >
> https://github.com/tianocore/edk2/blob/master/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c#L518
> > >
> > > 2. After applying all the linker commands, it goes and rewrites part
> > > of the FADT anyway. Specifically, it rewrites the DSDT and X_DSDT
> > > fields - and it always sets one of them to 0. Which one depends on
> > > whether the DSDT is above the 4G barrier:
> > >
> https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Universal/Acpi/AcpiTableDxe/AcpiTableProtocol.c#L650
> > >
> > > Both of these are easily fixed, and I will submit a corresponding
> patch to EDK2.
> > >
> > > With that fixed, the rest of the FADT provided by Qemu is accepted by
> > > OVMF and the operating systems. On the Qemu side, it does mean we'll
> > > need to still retain the ACPI 1.0 tables for backwards compatibility.
> > >
> > > Q1: How should the option be structured and named? Should the FADT
> > > revision be selectable via a sub-option on -machine? Or as a
> > > standalone option? Something else?
> WinXP is main reason why we are using 1.0 revisions,
> but if bumping revision doesn't affect it or later versions
> and linux kernel (ancient/contemporary) boots fine,
> I wouldn't bother with yet another option.
>

XP is fine. My concern is that setups with OVMF+Windows (10 confirmed, but
probably 7/8 too) will suddenly bluescreen on boot because unpatched OVMF
delivers a non-compliant FADT.


> > > Q2: To avoid any more confusion, I'd appreciate
> > > confirmation/clarification on the X_ and non-X FADT fields in the case
> > > where 32-bit pointers suffice.
> > >
> > > Q2a: DSDT/X_DSDT: Both variants appear to be de-facto required.
> spec doesn't say that X_DSDT is optional and Windows requires it if field
> is present.
>
> > >
> > > Q2b: FIRMWARE_CTRL/X_FIRMWARE_CTRL: leave X_FIRMWARE_CTRL zero.
> > >
> > > Q2c: X_PM1a_EVT_BLK, X_PM1a_CNT_BLK, X_PM_TMR_BLK: These all state
> > > "This is a required field" for both variants.
> > >
> > > Q2d: GPE0_BLK/X_GPE0_BLK: Both variants state "if this register block
> > > is not supported, this field contains zero." - I understand this to
> > > mean that when the register block IS supported and 32-bit, both
> > > variants must be filled.
> > >
> > > In other words, only X_FIRMWARE_CTRL stays zero in Qemu's x86 case.
> > >
> > >
> > > I'll come up with a revised patch in the next few days.
> > >
> > > Thanks for your help and patience so far, everyone!
>
>
