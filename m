Received: from eggs.gnu.org ([2001:4830:134:3::10]:42701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGvsQ-0004xj-5z
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 19:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGvsN-00022D-0g
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 19:21:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGvsM-00020p-I6
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 19:21:02 -0400
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<20170602191230-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c2f1189a-48cf-4e01-c761-c20fe50ab67d@redhat.com>
Date: Sat, 3 Jun 2017 01:20:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170602191230-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] allocation zone extensions for the firmware
 linker/loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: SeaBIOS devel list <SeaBIOS@seabios.org>, qemu devel list <qemu-devel@nongnu.org>, edk2-devel-ml01 <edk2-devel@ml01.01.org>, Kevin O'Connor <kevin@koconnor.net>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ben Warren <ben@skyportsystems.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, "Jordan Justen (Intel address)" <jordan.l.justen@intel.com>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

On 06/02/17 18:30, Michael S. Tsirkin wrote:
> On Fri, Jun 02, 2017 at 05:45:21PM +0200, Laszlo Ersek wrote:
>> Hi,
>>
>> this message is cross-posted to three lists (qemu, seabios, edk2). I'll
>> follow up with three patch series, one series for each project. I'll
>> cross-post all of the patches as well, but I'll add the project name in
>> the "bag of tags" in the subject lines.
>>
>> The QEMU series introduces two extensions to the ALLOCATE firmware
>> linker/loader command.
>>
>> One extension is a new allocation zone, with value 3, for allowing the
>> firmware to allocate the fw_cfg blobs in 64-bit address space.
> 
> Seems to make sense. I guess it's safe to do this if no
> pointers to this table are 32 bit, right?

That's right. For example, the TCPA patch (6 of 7) in the QEMU series
does this, because the ACPI_BUILD_TPMLOG_FILE is only referenced by a
64-bit pointer.

> Is there a chance we'll ever be able to use this on PC
> assuming the need to support 32 bit guests?

Well, sticking with the TCPA example, if an ACPI table defines *only* an
8-byte pointer to some memory area, that seems to preclude support for
32-bit guests already, generally speaking, no?

But otherwise I agree, requiring support for 32-bit guests makes this
allocation zone a lot less useful.

>> The other extension is a repurposing of the most significant bit (bit 7)
>> in the zone field. This bit becomes orthogonal to the rest of the zone
>> field. If the bit is set, it means that QEMU promises the firmware that
>> the blob referenced by the ALLOCATE command contains no ACPI tables at all.
> 
> This one is a bit strange in that it does not seem to be about
> allocations - it seems to be about content.

Sure, I only stuffed it in the Zone field because that's where I found a
free bit :)

> 
> I'd like to better understand what makes ACPI special.
> 
> I see two other things that make acpi special, but I'd like to make sure
> 1. I think that RSDT from qemu is more or less ignored by OVMF, it
>    builds it from tables supplied. Thus pointers from RSDT only serve to
>    find beginning of tables - they are not really patched in. So ACPI
>    tables are special in that their actual addresses are unused. As a
>    result they can be moved at will after linker runs.

Sort of. OVMF performs two passes on the linker/loader script. The first
pass is fully identical to what SeaBIOS does, so the RSDT too is
allocated (as part of its containing fw_cfg blob, of course) and its
fields are patched like anything else.

In the second pass, the (now relocated) pointers are checked again,
based on the ADD_POINTER commands. Wherever the (now relocated) pointers
point, we probe for ACPI table headers. If the target passes the probe
(i.e., it looks like an ACPI table), we call
EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() with it. This installs a
separate copy of that table, maintaining RSDT and XSDT internally.

Now, the RSD PTR table has a pointer to the RSDT, so normally we'd
invoke InstallAcpiTable() with the RSDT as well, in the second pass. To
prevent that, we have a quirk that recognizes RSDT and XSDT, and skips them.

So you can say that the RSDT from QEMU is *ultimately* ignored in OVMF,
but for the first pass to complete (which is identical to SeaBIOS's only
pass), OVMF uses the RSDT (as embedded in its containing fw_cfg blob) too.

There are more details about the second pass. If a (relocated) pointer
points to some stuff that doesn't look like an ACPI table header, then
we don't install that thing with InstallAcpiTable(). Instead, we think
that at that location the containing fw_cfg blob contains an
opregion-like area, so its actual absolute address is relevant (remember
we are past the first pass, which completed all the relocations). So in
this case, the containing fw_cfg blob is marked as "non-releasable", and
we'll keep it forever (in AcpiNVS memory). Otherwise, if at the end of
processing a blob is marked as releasable (the default), because all
pointers into it pointed only at ACPI table headers, we free the blob.

There are more details about the second pass. There can be several
pointers that point to the same address (= same offset of the same
pointed-to fw_cfg blob). In such cases, only the first encounter is
honored with an InstallAcpiTable() call, further surfacings of the same
target address are skipped.

Now, the heuristics to determine whether a pointed-to location is an
ACPI table header or not, is not fool-proof. It recognizes all valid
headers (so no false negatives), I think, but it could also
mis-recognize random garbage in an opregion-like blob as an ACPI table
header (so there's a chance for false positives). In order to suppress
these false positives deterministically, there are two methods:

- prefix all such areas in the pointed-to blobs with a sufficient number
of zeroes so that the probe would fail, guaranteed. However, this means
that you have to keep the ADD_POINTER commands pointed at the zeroes,
not at the real opregion, so you need to add the offset in the AML code
at runtime, to actually access the opregion.

- the other method is the "no ACPI content" hint, proposed here. In this
case whenever an ADD_POINTER command is found, in the 2nd pass, to point
into a blob that had this "no ACPI content" hint at ALLOCATE time, the
probing is skipped immediately.

> 2. Some tables can go into AddressRangeACPI, some into AddressRangeNVS,
>    but they never need to be in AddressRangeReserved.
>    It would be simple if we could just say "allocate this table
>    from AddressRangeACPI". But I am not sure this is true
>    since e.g. stuff used for power management can't go into
>    AddressRangeACPI.  Thoughts?

For the first pass, OVMF allocates all the blobs in AcpiNVS memory. Most
of these blobs are ultimately released (because they only contain ACPI
tables, of which EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() creates deep
copies). The blobs that are marked as non-releasable (see above) are
preserved in AcpiNVS memory.

Regarding the tables that EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable()
installs -- this protocol member function has internal knowledge about
what table should be allocated in what kind of memory. It cannot be
influenced from the outside. Years ago I proposed and
EFI_ACPI_TABLE_PROTOCOL2 on the USWG list, in which the
InstallAcpiTable() member would additionally take the memory type to
place the copied / installed table into. I received zero feedback.

Thanks
Laszlo

>> After introducing these, the QEMU series puts them to use, covering all
>> of the currently generated ALLOCATE commands, as appropriate. Among the
>> benefits we can mention
>> - the removal of the OVMF ACPI SDT Header Probe suppressor from VMGENID
>> (and from any similar future devices),
>> - and the fact that the "virt" machine type (and maybe other machine
>> types) of the arm/aarch64 target will no longer require RAM under 4GB
>> for ACPI to work.
>>
>> Both of these extensions are irrelevant for SeaBIOS, therefore the
>> SeaBIOS patches simply mask out bit 7 (for ignoring the "no ACPI
>> content" hint), and fall back to the HIGH zone (= 32-bit address space)
>> when the 64-bit zone is permitted.
>>
>> In other words, SeaBIOS needs some patches to recognize the new zone
>> values, but beyond that, the behavior is unchanged.
>>
>> Both extensions are important for virtual UEFI firmware (OVMF in x86
>> guests and ArmVirtQemu in aarch64 guests). The edk2 patches add support
>> to OvmfPkg/AcpiPlatformDxe for the extensions. Please see the commit
>> messages for details (all the extensions are explained in detail in the
>> relevant patches for all of the projects).
>>
>> The patches can cause linker/loader breakage when old firmware is booted
>> on new QEMU. However, that's no problem (it's nothing new), the next
>> release of QEMU should bundle the new firmware binaries as always.
>>
>> New firmware will continue running on old QEMU without issues.
>>
>> (In case you have sent me emails about this in the last few tens of
>> hours, please know that I'm not ignoring them, I just haven't seen /
>> read them. Reading emails every five minutes makes focused work
>> impossible, so when I'm busy, I tend to read email once per day.)
>>
>> Thanks
>> Laszlo
