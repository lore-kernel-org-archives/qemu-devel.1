Received: from eggs.gnu.org ([2001:4830:134:3::10]:37106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cbCuf-00070y-MS
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 16:03:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cbCuY-0005wf-2l
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 16:02:53 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cbCuX-0005wF-RO
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 16:02:50 -0500
Received: by mail-ot0-x241.google.com with SMTP id 65so15630208otq.2
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 13:02:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <58a49e30-7e64-9d0f-3a45-f0ff19e72210@redhat.com>
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
	<20170118181918.783cb7bd@nial.brq.redhat.com>
	<CAAibmn0OEBsZUyxuKcssk-4V-=fA94QWFCk04Lt9rbFN66OgEg@mail.gmail.com>
	<20170131165802-mutt-send-email-mst@kernel.org>
	<fe787fcc-0c92-5842-1a67-b50466b6f38f@redhat.com>
	<CAAibmn1eEFMdn_-hcaFudOO8D7crkfYYw+k88=CGJfJ0fmU6JA@mail.gmail.com>
	<58a49e30-7e64-9d0f-3a45-f0ff19e72210@redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 7 Feb 2017 22:02:23 +0100
Message-ID: <CAAibmn1teqEghW0C5qSKL3zJXkH9obkLfKZ3VtBjuu4U2V99kw@mail.gmail.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 7 February 2017 at 20:54, Laszlo Ersek <lersek@redhat.com> wrote:
> On 02/06/17 17:30, Phil Dennis-Jordan wrote:
>> Thanks for the in-depth reply - apologies for abandoning the thread
>> for a few days. Looks like a bunch of things have already been hashed
>> out, but I have a few more comments:
>
> Vice versa... Sorry about responding a bit late. Yesterday I severely
> overworked myself and for all of today I've been struggling with a
> terrible headache. Having had trouble at forming coherent thoughts, I've
> sort of procrastinated following up here.

No worries, I can't spend time every day on this either.

>> On 31 January 2017 at 17:28, Laszlo Ersek <lersek@redhat.com> wrote:
>>> On 01/31/17 15:58, Michael S. Tsirkin wrote:
>>>> On Tue, Jan 31, 2017 at 03:31:46PM +0100, Phil Dennis-Jordan wrote:
>>>>> On 18 January 2017 at 18:19, Igor Mammedov <imammedo@redhat.com> wrot=
e:
>>>>>> On Wed, 18 Jan 2017 18:30:59 +0200
>>>>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>>>>
>>>>>>> On Wed, Jan 18, 2017 at 12:45:54PM +0100, Phil Dennis-Jordan wrote:
>>>>>> [...]
>>>>>>
>>>>>>>> I suspect more might be involved in enabling ACPI 2.0, and it shou=
ld probably be an option so as to avoid regressions. I don't know what the =
best approach would be for this, so comments welcome. Should adding the res=
et register to the FADT also be configurable?
>>>>>>>
>>>>>>> I would say an option to make FADT use rev 3 format would be a good
>>>>>>> idea.
>>>>>>>
>>>>>>> I'd make it the default if XP survives.
>>>>>> if XP and legacy linux survive,
>>>>>> I'd skip adding option as probably there won't be any users,
>>>>>> in unlikely case such user surfaces we always can add option later
>>>>>> but we can't do it other way around (i.e. take it away).
>>>>>
>>>>> I have now finally solved the mystery of why my FADT patch has been
>>>>> going so disastrously wrong - I've now got working code, but I'd
>>>>> appreciate some guidance on the best way to structure a patch to
>>>>> minimise further back-and forth.
>>>>
>>>> + lersek
>>>>
>>>>> The culprit turned out to be OVMF,
>>>>> specifically 2 bugs/shortcomings:
>>>>>
>>>>> 1. It completely gives up on parsing Qemu's ACPI tables if more than
>>>>> one "add pointer" linker command points to the same table. In this
>>>>> case, if you add a command for both the DSDT and X_DSDT fields of the
>>>>> FADT, it aborts completely and uses fallback tables. (The following
>>>>> InstallAcpiTable call fails if called twice with the same table type.=
)
>>>>> https://github.com/tianocore/edk2/blob/master/OvmfPkg/AcpiPlatformDxe=
/QemuFwCfgAcpi.c#L518
>>>
>>> Unlike SeaBIOS, OVMF can only use EFI_ACPI_TABLE_PROTOCOL to install
>>> ACPI tables.
>>>
>>> EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() installs a *copy* of the
>>> table that is passed in. In addition, EFI_ACPI_TABLE_PROTOCOL (whose
>>> implementation is in generic edk2 code, not in OVMF platform code) has
>>> built-in "smarts" for handling and linking together the various specifi=
c
>>> tables defined by the ACPI spec.
>>>
>>> The way we were able to make EFI_ACPI_TABLE_PROTOCOL cooperate with
>>> QEMU's linker/loader is a two-phase process.
>>>
>>> In the first phase, the fw_cfg blobs are allocated, downloaded, linked
>>> together, and checksummed, in AcpiNVS type memory, as instructed by the
>>> linker/loader script.
>>>
>>> In the second phase, all ADD_POINTER commands are processed again, and
>>> the targets of those pointers are investigated for ACPI SDT headers.
>>> Every such pointer target that looks like an ACPI SDT header is passed
>>> to EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable(); except root tables like
>>> RSDT etc. This member function handles the actual copying, installation=
,
>>> and cross-table linking (to the extent specified in the ACPI spec).
>>>
>>> Additionally, for each allocated  / downloaded fw_cfg blob, the second
>>> phase tracks if there is at least one pointer into the blob that does
>>> *not* point to an ACPI SDT header. If that's the case, then it implies
>>> the presence of some non-ACPI-table-buffer within the blob (that is
>>> referenced by some other field elsewhere). In turn such fw_cfg blobs ar=
e
>>> not freed at the end of the whole process. (If an fw_cfg blob turns out
>>> to host *only* ACPI tables -- which were then all copied for
>>> installation, see above -- then the blob is released in the end.)
>>>
>>> Finally, EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() may return
>>> EFI_ACCESS_DENIED (quoting the UEFI spec):
>>>
>>> "The table signature matches a table already present in the system and
>>> platform policy does not allow duplicate tables of this type."
>>>
>>> (And see edk2 commit 5966402ed51c, "MdeModulePkg/IntelFrameworkModulePk=
g
>>> ACPI: Follow the new UEFI 2.4a spec to return EFI_ACCESS_DENIED for
>>> duplicated FADT, FACS or DSDT installation.", 2014-05-06.)
>>>
>>>
>>> ... BTW, we discussed the question of multiply-pointed-to tables before=
,
>>> in connection with XSDT support. Under "XSDT support", I mean an XSDT
>>> built by QEMU explicitly (because EFI_ACPI_TABLE_PROTOCOL handles both
>>> XSDT and RSDT internally, automatically). Clearly, if some ACPI table i=
s
>>> referenced from QEMU's RSDT and XSDT both, that immediately triggers th=
e
>>> same problem.
>>>
>>> Looking at my older notes, I find two references:
>>>
>>> Message-Id: <20150827205706-mutt-send-email-mst@redhat.com>
>>> URL: http://lists.nongnu.org/archive/html/qemu-devel/2015-08/msg03528.h=
tml
>>>
>>> Message-Id: <20151228141917-mutt-send-email-mst@redhat.com>
>>> URL: http://lists.nongnu.org/archive/html/qemu-devel/2015-12/msg04636.h=
tml
>>>
>>> Looking further at my notes, I find the following idea:
>>>
>>>     in the second pass only, maintain a global rbtree that contains
>>>     VOID* objects, pointing to actual physcal addresses in the relocate=
d
>>>     blobs that have already been passed to InstallAcpiTable. This will
>>>     ensure that no address is passed to InstallAcpiTable twice
>>>
>>> IOW, it's simple memoization for ADD_POINTER targets (in absolute
>>> guest-phys addr space) so that duplicate
>>> EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() can be avoided.
>>>
>>> If this feature is important, I can file an upstream OVMF bug for it,
>>> and work on it. (I already have another open BZ for the linker/loader
>>> anyway, <https://bugzilla.tianocore.org/show_bug.cgi?id=3D359>.)
>>>
>>> Please confirm if this is necessary.
>>
>> That sounds good. Some background on the specific issue I'm trying to so=
lve:
>>
>>  - OS X/macOS guests currently can't reboot with upstream Qemu, as it
>> expects the reset register to be advertised by the FADT, but x86 Qemu
>> currently only publishes a rev1 FADT, which lacks said register spec.
>> (OVMF still requires a large array of patches to boot OS X/macOS,
>> which is a separate issue.)
>>  - I therefore would like to update Qemu such that it publishes a rev3
>> (ACPI 2.0) or newer FADT, including the reset register.
>>  - Windows 10 appears to require both DSDT AND X_DSDT to be filled for
>> rev3-rev4 FADTs, else it won't boot at all. (Not sure about 5+)
>>  - Guest OS backwards compatibility without a flag is desirable, and
>> ACPI 1.0 era guest OSes will not try to find the DSDT via X_DSDT, so
>> we need to fill both.
>>  - This should work with both SeaBIOS and OVMF, so Qemu needs to set
>> up linker commands for both DSDT and X_DSDT, and OVMF itself needs to
>> produce a FADT with both fields filled.
>>
>
> I filed <https://bugzilla.tianocore.org/show_bug.cgi?id=3D368>.

That looks nice and thorough.

>> Your EDK2 patch
>
> For the record:
> [1] https://lists.01.org/pipermail/edk2-devel/2017-February/007072.html
>
>> fixes the problem with values OVMF writes to
>> DSDT/X_DSDT, but the issue of it refusing Qemu's linker commands for
>> those two still needs to be solved so that SeaBIOS can boot a wide
>> range of OSes.
>>
>> I'd be happy to give writing the memoising patch a go myself if that
>> helps. Looks like setting up an ORDERED_COLLECTION during phase 2
>> might be the simplest solution?
>
> Thanks for the offer. :)
>
> * If you'd like to help me with my load and reach a good "development
>   throughput", then I prefer to write the patch myself. On this
>   *specific* occasion, I think it will be faster.
>
>   I intend to send an OVMF series this week that addresses both
>   TianoCore#368 (see above) and TianoCore#359 too (mentioned earlier).
>   Both are for OvmfPkg/AcpiPlatformDxe, and it makes sense to round
>   them up.
>
>   I plan to CC the QEMU stakeholders as appropriate. Your feedback
>   would be greatly appreciated; the same way as [1] is very helpful
>   (thanks again for it!)
>
> * If your main interest is rather to get into OVMF development, then I
>   positively welcome that, and encourage you to send the patch.
>   Completing the patch will likely take longer (the edk2 coding style
>   is... arcane... and your reviewer is somewhat pedantic :)), but if
>   you plan to get into OVMF development, then it's worth both our times.
>
> (The above should not be misunderstood as "Laszlo doesn't value one-off
> contributions" -- it really depends on feature size and area. Hence the
> emphasis on "specific" above.)
>
> Your call :) If possible, please let me know it tomorrow.

I actually ended up writing said pointer memoisation patch yesterday,
and it appears to work fine in initial tests. I still need to fully
work my way through the edk2 coding and contribution guidelines, so
I'll need to re-visit that patch with a fine tooth comb before
submitting it. In any case, here it is so far:
https://github.com/pmj/edk2/commit/58e0510c6da62d5a985b97e9bff84bc53442d3fe

I am intending to submit more patches to edk2 over time - like this
one, they'll mostly be based on Reza Jelveh's GSoC project from a few
years ago. Some of his work on getting OS X/macOS guests working in
Qemu/OVMF have got upstreamed, most of it has not. I'm hoping I can
improve the ratio a little.

I've also written an EFI framebuffer driver for the VMware virtual
SVGA adapter in Qemu, which again I need to tidy up to conform with
the coding conventions before submitting. (The only advantage of this
vs. QXL or virtio-gpu being that there are OSes, including OSX/macOS
for which there exist drivers for neither QXL nor virtio-gpu.)

So I guess I may as well get some practice. :-)


I anticipate submitting the memoisation patch for review on Thursday
or Friday as I'll be out tomorrow.

>>>>> 2. After applying all the linker commands, it goes and rewrites part
>>>>> of the FADT anyway. Specifically, it rewrites the DSDT and X_DSDT
>>>>> fields - and it always sets one of them to 0. Which one depends on
>>>>> whether the DSDT is above the 4G barrier:
>>>>> https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Universal/=
Acpi/AcpiTableDxe/AcpiTableProtocol.c#L650
>>>
>>> Yes. This is precisely what I meant above with:
>>>
>>>     EFI_ACPI_TABLE_PROTOCOL (whose implementation is in generic edk2
>>>     code, not in OVMF platform code) has built-in "smarts" for handling
>>>     and linking together the various specific tables defined by the
>>>     ACPI spec.
>>>
>>>>>
>>>>> Both of these are easily fixed, and I will submit a corresponding pat=
ch to EDK2.
>>>
>>> What easy fixes do you have in mind?
>>>
>>> For problem (1), simply ignoring EFI_ACCESS_DENIED from
>>> EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() is not right. Unless we can
>>> ensure in a future-proof way that an error code gets returned for *only
>>> one* error scenario and nothing else, suppressing the error code is
>>> risky. I'd much rather prevent a function call (with memoization) that
>>> we know in advance will fail.
>>
>> That's been my prototype workaround - the memoisation should be pretty
>> straightforward too though.
>
> It's also more correct for ACPI table *types* that are permitted to have
> several (different!) instances installed. For those table types, passing
> the exact same table to InstallAcpiTable() might succeed -- and that
> would be even worse. I commented on this in TianoCore#368.

Yes, good point.

>>> For symptom (2), I'm unsure if we can call that a problem at all. You'd
>>> have to prove that "MdeModulePkg/Universal/Acpi/AcpiTableDxe" violates
>>> the ACPI spec (or that it's within the spec, but works sub-optimally),
>>> when it ensures exclusivity between FADT.DSDT and FADT.X_DSDT.
>>>
>>> The ACPI 6.1 spec says,
>>>
>>> - DSDT: [...] If the X_DSDT field contains a non-zero value then this
>>>   field must be zero.
>>> - X_DSDT: [...] If the DSDT field contains a non-zero value then this
>>>   field must be zero.
>>>
>>> Therefore the EFI_ACPI_TABLE_PROTOCOL implementation in edk2 seems
>>> conformant & correct to me.
>>>
>>> Related edk2 commits:
>>>
>>> - the one that added the code you reference above:
>>>
>>> f9bbb8d9c3f0 ("MdeModulePkg: AcpiTableDxe: make 4 GB table allocation
>>> limit optional", 2016-02-17)
>>>
>>> - the earlier, similar one, that enforces exclusivity between
>>> FADT.FIRMWARE_CTRL and FADT.X_FIRMWARE_CTRL:
>>>
>>> f798e8bff773 ("MdeModulePkg: Acpi: enforce exclusion between
>>> FirmwareCtrl and XFirmwareCtrl", 2015-01-26)
>>
>> Between you you've already established the apparent revision-dependent
>> rules on whether or not DSDT and X_DSDT are mutually exclusive, so I
>> have nothing to add there, other than that Windows 10 fails to boot if
>> they're not both filled for rev3 and rev4 FADTs. (I'm so far having
>> some issues with producing a rev5 FADT it likes, regardless of DSDT
>> pointers.)
>
> I think it's prudent to stick with as low a version as possible.

I've got a Qemu patch for a changing the FADT from rev1 to rev3 (ACPI
2.0); I'll post that Thursday or Friday as well assuming all the guest
OSes I can throw at it are happy.

>> The X_FIRMWARE_CTRL vs FIRMWARE_CTRL situation appears to me to be
>> slightly different. They're already explicitly mutually exclusive from
>> ACPI 4.0 onwards, not 5.1. Note however, that it's not specified that
>> one should be preferred over the other in the sub-4G case, not even in
>> 6.1. Note also that both ACPI 3 and 4 specify FADT revision 4, but
>> only 4.0 makes the fields mutually exclusive.
>>
>> I therefore think the safest behaviour for the FIRMWARE_CTRL fields,
>> also with a view to backwards compatibility, is to always use the
>> 32-bit variant where possible, and the X_ field only if a 64-bit
>> pointer is necessary. I have thus far encountered no issues with
>> booting real OSes using this policy.
>
> Sounds good to me.
>
> And, I think the edk2 code already does this. Commit f798e8bff773
> ("MdeModulePkg: Acpi: enforce exclusion between FirmwareCtrl and
> XFirmwareCtrl", 2015-01-26) is one half of the puzzle.
>
> The other half is that MdeModulePkg/Universal/Acpi/AcpiTableDxe, as
> built into OVMF (Ia32 and X64), keeps the tables under 4GB. So in
> practice it's always the 32-bit FIRMWARE_CTRL field that gets set.

I haven't reviewed the corresponding code, but I certainly haven't run
into any issues with its behaviour in practice so far.

>>>>> With that fixed, the rest of the FADT provided by Qemu is accepted by
>>>>> OVMF and the operating systems. On the Qemu side, it does mean we'll
>>>>> need to still retain the ACPI 1.0 tables for backwards compatibility.
>>>>>
>>>>> Q1: How should the option be structured and named? Should the FADT
>>>>> revision be selectable via a sub-option on -machine? Or as a
>>>>> standalone option? Something else?
>>>
>>> No input from me on this one.
>>>
>>>>> Q2: To avoid any more confusion, I'd appreciate
>>>>> confirmation/clarification on the X_ and non-X FADT fields in the cas=
e
>>>>> where 32-bit pointers suffice.
>>>>>
>>>>> Q2a: DSDT/X_DSDT: Both variants appear to be de-facto required.
>>>
>>> I disagree. The 6.1 release of the ACPI spec requires exclusivity.
>>>
>>> The changelog at the top of the spec lists:
>>>
>>> Revision    Change Description                         Affected Section=
s
>>> ----------  -----------------------------------------  ----------------=
-
>>> 6.0 Errata  1393 In FADT: if X_DSDT field is           Table 5-34
>>>             non-zero, DSDT field should be ignored or
>>>             deprecated
>>>
>>> The number "1393" is most likely the Mantis ticket number:
>>>
>>> https://mantis.uefi.org/mantis/view.php?id=3D1393
>>>
>>> (Unfortunately, I don't have the necessary credentials to verify if thi=
s
>>> Mantis ticket actually corresponds to this change. I could do that for
>>> Platform Init or UEFI spec items -- without quoting any specifics --,
>>> but apparently my ASWG membership level isn't high enough for this one.=
)
>>>
>>>>> Q2b: FIRMWARE_CTRL/X_FIRMWARE_CTRL: leave X_FIRMWARE_CTRL zero.
>>>
>>> Sounds good.
>>>
>>>>>
>>>>> Q2c: X_PM1a_EVT_BLK, X_PM1a_CNT_BLK, X_PM_TMR_BLK: These all state
>>>>> "This is a required field" for both variants.
>>>
>>> Hmmm, I don't think so (again, from ACPI 6.1):
>>>
>>> - PM1a_EVT_BLK: [...] This is a required field. If the X_PM1a_CNT_BLK
>>>   field contains a non-zero value then this field must be zero.
>>> - X_PM1a_EVT_BLK: [...] This is a required field. If the PM1a_EVT_BLK
>>>   field contains a non-zero value then this field must be zero.
>>>
>>> (Not checking the rest.)
>>>
>>>>>
>>>>> Q2d: GPE0_BLK/X_GPE0_BLK: Both variants state "if this register block
>>>>> is not supported, this field contains zero." - I understand this to
>>>>> mean that when the register block IS supported and 32-bit, both
>>>>> variants must be filled.
>>>>>
>>>>> In other words, only X_FIRMWARE_CTRL stays zero in Qemu's x86 case.
>>>>>
>>>>>
>>>>> I'll come up with a revised patch in the next few days.
>>>>>
>>>>> Thanks for your help and patience so far, everyone!
>>>
>>> In summary, here's my opinion:
>>>
>>> - I think that setting both FADT.DSDT and FADT.X_DSDT to nonzero values
>>> simultaneously would break the ACPI 6.1 spec (update originating from
>>> Mantis #1393, most likely)
>>>
>>> - "MdeModulePkg/Universal/Acpi/AcpiTableDxe", implementing
>>> EFI_ACPI_TABLE_PROTOCOL in edk2, appears to conform to this requirement
>>> specifically
>>>
>>> - if remedying symptom (1) were only necessary for setting both DSDT an=
d
>>> X_DSDT -- which, I claim, should not be done --, then I'd like to
>>> postpone the above memoization indefinitely. It's too complex to be
>>> added speculatively.
>>>
>>> Thank you,
>>> Laszlo
>>
>
