Received: from eggs.gnu.org ([2001:4830:134:3::10]:47761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cYbIo-0007xw-5F
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cYbIk-0002oc-Ss
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:29:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cYbIk-0002oD-Is
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:29:02 -0500
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
	<20170118181918.783cb7bd@nial.brq.redhat.com>
	<CAAibmn0OEBsZUyxuKcssk-4V-=fA94QWFCk04Lt9rbFN66OgEg@mail.gmail.com>
	<20170131165802-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <fe787fcc-0c92-5842-1a67-b50466b6f38f@redhat.com>
Date: Tue, 31 Jan 2017 17:28:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170131165802-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 01/31/17 15:58, Michael S. Tsirkin wrote:
> On Tue, Jan 31, 2017 at 03:31:46PM +0100, Phil Dennis-Jordan wrote:
>> On 18 January 2017 at 18:19, Igor Mammedov <imammedo@redhat.com> wrote:
>>> On Wed, 18 Jan 2017 18:30:59 +0200
>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>
>>>> On Wed, Jan 18, 2017 at 12:45:54PM +0100, Phil Dennis-Jordan wrote:
>>> [...]
>>>
>>>>> I suspect more might be involved in enabling ACPI 2.0, and it should probably be an option so as to avoid regressions. I don't know what the best approach would be for this, so comments welcome. Should adding the reset register to the FADT also be configurable?
>>>>
>>>> I would say an option to make FADT use rev 3 format would be a good
>>>> idea.
>>>>
>>>> I'd make it the default if XP survives.
>>> if XP and legacy linux survive,
>>> I'd skip adding option as probably there won't be any users,
>>> in unlikely case such user surfaces we always can add option later
>>> but we can't do it other way around (i.e. take it away).
>>
>> I have now finally solved the mystery of why my FADT patch has been
>> going so disastrously wrong - I've now got working code, but I'd
>> appreciate some guidance on the best way to structure a patch to
>> minimise further back-and forth.
> 
> + lersek
> 
>> The culprit turned out to be OVMF,
>> specifically 2 bugs/shortcomings:
>>
>> 1. It completely gives up on parsing Qemu's ACPI tables if more than
>> one "add pointer" linker command points to the same table. In this
>> case, if you add a command for both the DSDT and X_DSDT fields of the
>> FADT, it aborts completely and uses fallback tables. (The following
>> InstallAcpiTable call fails if called twice with the same table type.)
>> https://github.com/tianocore/edk2/blob/master/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c#L518

Unlike SeaBIOS, OVMF can only use EFI_ACPI_TABLE_PROTOCOL to install
ACPI tables.

EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() installs a *copy* of the
table that is passed in. In addition, EFI_ACPI_TABLE_PROTOCOL (whose
implementation is in generic edk2 code, not in OVMF platform code) has
built-in "smarts" for handling and linking together the various specific
tables defined by the ACPI spec.

The way we were able to make EFI_ACPI_TABLE_PROTOCOL cooperate with
QEMU's linker/loader is a two-phase process.

In the first phase, the fw_cfg blobs are allocated, downloaded, linked
together, and checksummed, in AcpiNVS type memory, as instructed by the
linker/loader script.

In the second phase, all ADD_POINTER commands are processed again, and
the targets of those pointers are investigated for ACPI SDT headers.
Every such pointer target that looks like an ACPI SDT header is passed
to EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable(); except root tables like
RSDT etc. This member function handles the actual copying, installation,
and cross-table linking (to the extent specified in the ACPI spec).

Additionally, for each allocated  / downloaded fw_cfg blob, the second
phase tracks if there is at least one pointer into the blob that does
*not* point to an ACPI SDT header. If that's the case, then it implies
the presence of some non-ACPI-table-buffer within the blob (that is
referenced by some other field elsewhere). In turn such fw_cfg blobs are
not freed at the end of the whole process. (If an fw_cfg blob turns out
to host *only* ACPI tables -- which were then all copied for
installation, see above -- then the blob is released in the end.)

Finally, EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() may return
EFI_ACCESS_DENIED (quoting the UEFI spec):

"The table signature matches a table already present in the system and
platform policy does not allow duplicate tables of this type."

(And see edk2 commit 5966402ed51c, "MdeModulePkg/IntelFrameworkModulePkg
ACPI: Follow the new UEFI 2.4a spec to return EFI_ACCESS_DENIED for
duplicated FADT, FACS or DSDT installation.", 2014-05-06.)


... BTW, we discussed the question of multiply-pointed-to tables before,
in connection with XSDT support. Under "XSDT support", I mean an XSDT
built by QEMU explicitly (because EFI_ACPI_TABLE_PROTOCOL handles both
XSDT and RSDT internally, automatically). Clearly, if some ACPI table is
referenced from QEMU's RSDT and XSDT both, that immediately triggers the
same problem.

Looking at my older notes, I find two references:

Message-Id: <20150827205706-mutt-send-email-mst@redhat.com>
URL: http://lists.nongnu.org/archive/html/qemu-devel/2015-08/msg03528.html

Message-Id: <20151228141917-mutt-send-email-mst@redhat.com>
URL: http://lists.nongnu.org/archive/html/qemu-devel/2015-12/msg04636.html

Looking further at my notes, I find the following idea:

    in the second pass only, maintain a global rbtree that contains
    VOID* objects, pointing to actual physcal addresses in the relocated
    blobs that have already been passed to InstallAcpiTable. This will
    ensure that no address is passed to InstallAcpiTable twice

IOW, it's simple memoization for ADD_POINTER targets (in absolute
guest-phys addr space) so that duplicate
EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() can be avoided.

If this feature is important, I can file an upstream OVMF bug for it,
and work on it. (I already have another open BZ for the linker/loader
anyway, <https://bugzilla.tianocore.org/show_bug.cgi?id=359>.)

Please confirm if this is necessary.


>>
>> 2. After applying all the linker commands, it goes and rewrites part
>> of the FADT anyway. Specifically, it rewrites the DSDT and X_DSDT
>> fields - and it always sets one of them to 0. Which one depends on
>> whether the DSDT is above the 4G barrier:
>> https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Universal/Acpi/AcpiTableDxe/AcpiTableProtocol.c#L650

Yes. This is precisely what I meant above with:

    EFI_ACPI_TABLE_PROTOCOL (whose implementation is in generic edk2
    code, not in OVMF platform code) has built-in "smarts" for handling
    and linking together the various specific tables defined by the
    ACPI spec.

>>
>> Both of these are easily fixed, and I will submit a corresponding patch to EDK2.

What easy fixes do you have in mind?

For problem (1), simply ignoring EFI_ACCESS_DENIED from
EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() is not right. Unless we can
ensure in a future-proof way that an error code gets returned for *only
one* error scenario and nothing else, suppressing the error code is
risky. I'd much rather prevent a function call (with memoization) that
we know in advance will fail.

For symptom (2), I'm unsure if we can call that a problem at all. You'd
have to prove that "MdeModulePkg/Universal/Acpi/AcpiTableDxe" violates
the ACPI spec (or that it's within the spec, but works sub-optimally),
when it ensures exclusivity between FADT.DSDT and FADT.X_DSDT.

The ACPI 6.1 spec says,

- DSDT: [...] If the X_DSDT field contains a non-zero value then this
  field must be zero.
- X_DSDT: [...] If the DSDT field contains a non-zero value then this
  field must be zero.

Therefore the EFI_ACPI_TABLE_PROTOCOL implementation in edk2 seems
conformant & correct to me.

Related edk2 commits:

- the one that added the code you reference above:

f9bbb8d9c3f0 ("MdeModulePkg: AcpiTableDxe: make 4 GB table allocation
limit optional", 2016-02-17)

- the earlier, similar one, that enforces exclusivity between
FADT.FIRMWARE_CTRL and FADT.X_FIRMWARE_CTRL:

f798e8bff773 ("MdeModulePkg: Acpi: enforce exclusion between
FirmwareCtrl and XFirmwareCtrl", 2015-01-26)

>>
>> With that fixed, the rest of the FADT provided by Qemu is accepted by
>> OVMF and the operating systems. On the Qemu side, it does mean we'll
>> need to still retain the ACPI 1.0 tables for backwards compatibility.
>>
>> Q1: How should the option be structured and named? Should the FADT
>> revision be selectable via a sub-option on -machine? Or as a
>> standalone option? Something else?

No input from me on this one.

>> Q2: To avoid any more confusion, I'd appreciate
>> confirmation/clarification on the X_ and non-X FADT fields in the case
>> where 32-bit pointers suffice.
>>
>> Q2a: DSDT/X_DSDT: Both variants appear to be de-facto required.

I disagree. The 6.1 release of the ACPI spec requires exclusivity.

The changelog at the top of the spec lists:

Revision    Change Description                         Affected Sections
----------  -----------------------------------------  -----------------
6.0 Errata  1393 In FADT: if X_DSDT field is           Table 5-34
            non-zero, DSDT field should be ignored or
            deprecated

The number "1393" is most likely the Mantis ticket number:

https://mantis.uefi.org/mantis/view.php?id=1393

(Unfortunately, I don't have the necessary credentials to verify if this
Mantis ticket actually corresponds to this change. I could do that for
Platform Init or UEFI spec items -- without quoting any specifics --,
but apparently my ASWG membership level isn't high enough for this one.)

>> Q2b: FIRMWARE_CTRL/X_FIRMWARE_CTRL: leave X_FIRMWARE_CTRL zero.

Sounds good.

>>
>> Q2c: X_PM1a_EVT_BLK, X_PM1a_CNT_BLK, X_PM_TMR_BLK: These all state
>> "This is a required field" for both variants.

Hmmm, I don't think so (again, from ACPI 6.1):

- PM1a_EVT_BLK: [...] This is a required field. If the X_PM1a_CNT_BLK
  field contains a non-zero value then this field must be zero.
- X_PM1a_EVT_BLK: [...] This is a required field. If the PM1a_EVT_BLK
  field contains a non-zero value then this field must be zero.

(Not checking the rest.)

>>
>> Q2d: GPE0_BLK/X_GPE0_BLK: Both variants state "if this register block
>> is not supported, this field contains zero." - I understand this to
>> mean that when the register block IS supported and 32-bit, both
>> variants must be filled.
>>
>> In other words, only X_FIRMWARE_CTRL stays zero in Qemu's x86 case.
>>
>>
>> I'll come up with a revised patch in the next few days.
>>
>> Thanks for your help and patience so far, everyone!

In summary, here's my opinion:

- I think that setting both FADT.DSDT and FADT.X_DSDT to nonzero values
simultaneously would break the ACPI 6.1 spec (update originating from
Mantis #1393, most likely)

- "MdeModulePkg/Universal/Acpi/AcpiTableDxe", implementing
EFI_ACPI_TABLE_PROTOCOL in edk2, appears to conform to this requirement
specifically

- if remedying symptom (1) were only necessary for setting both DSDT and
X_DSDT -- which, I claim, should not be done --, then I'd like to
postpone the above memoization indefinitely. It's too complex to be
added speculatively.

Thank you,
Laszlo
