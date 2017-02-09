Received: from eggs.gnu.org ([2001:4830:134:3::10]:48685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbuNr-0004kJ-JH
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 14:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbuNn-0002mm-81
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 14:27:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbuNm-0002kX-VN
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 14:27:55 -0500
References: <cover.1486285434.git.ben@skyportsystems.com>
	<28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
	<14f224ed-08e2-cbad-9d1d-8f559cd399a6@redhat.com>
	<20170209182316.71d5df5f@nial.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e23ba6e2-10b6-0cd2-b42c-0a4c66c706d6@redhat.com>
Date: Thu, 9 Feb 2017 20:27:51 +0100
MIME-Version: 1.0
In-Reply-To: <20170209182316.71d5df5f@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 05/10] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: ben@skyportsystems.com, mst@redhat.com, qemu-devel@nongnu.org

On 02/09/17 18:23, Igor Mammedov wrote:
> On Wed, 8 Feb 2017 01:48:42 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 02/05/17 10:12, ben@skyportsystems.com wrote:
>>> From: Ben Warren <ben@skyportsystems.com>
> [...]
> 
>> (2) Structure of the vmgenid fw_cfg blob, AKA "why that darn offset 40
>> decimal".
>>
>> I explained it under points (6) and (7) in the following message:
>>
>> Message-Id: <c16a03d5-820a-f719-81ea-43858f903395@redhat.com>
>> URL: https://www.mail-archive.com/qemu-devel@nongnu.org/msg425226.html
>>
>> The story is that *wherever* an ADD_POINTER command points to -- that
>> is, at the *exact* target address --, OVMF will look for an ACPI table
>> header, somewhat heuristically. If it finds a byte pattern that (a) fits
>> into the remaining blob and (b) passes some superficial ACPI table
>> header checks, such as length and checksum, then OVMF assumes that the
>> blob contains an ACPI table there, and passes the address (again, the
>> exact, relocated, absolute target address of ADD_POINTER) to
>> EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable().
>>
>> We want to disable this heuristic for the vmgenid blob. *If* the blob
>> contained only 16 bytes (for the GUID), then the heuristic would
>> automatically disable itself, because the ACPI table header (36 bytes)
>> is larger than 16 bytes, so OVMF wouldn't even look. However, for the
>> caching and other VMGENID requirements, we need to allocate a full page
>> with the blob (4KB), hence OVMF *will* look. If we placed the GUID right
>> at the start of the page, then OVMF would sanity-check it as an ACPI
>> table header. The check would *most likely* not pass, so things would be
>> fine in practice, but we can do better than that: just put 40 zero bytes
>> at the front of the blob.
>>
>> And this is why the ADD_POINTER command has to point to the beginning of
>> the blob (i.e., 36 zero bytes), to "suppress the OVMF ACPI SDT header
>> detection". (The other 4 bytes are for arriving at an address divisible
>> by 8, which is a VMGENID requirement for the GUID.)
>>
>> The consequence is that both the ADDR method and QEMU's guest memory
>> access code have to add 40 manually.
> The longer I look "suppress the OVMF ACPI SDT header detection",
> the less I like approach.
> 
> It looks somewhat backwards where a firmware forces QEMU
> to use non obvious offsets to workaround OVMF ACPI table detection
> heuristics.

This is for historical reasons -- when the linker/loader commands were
invented, it wasn't considered that in UEFI, ACPI tables cannot just be
linked together in-place, instead they'd have to be passed to
EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() one by one, for copying. The
commands didn't provide dedicated means for identifying individual
tables in blobs. Hence the heuristics built upon ADD_POINTER.

And once you have heuristics, you want to suppress them occasionally, if
you can find a way.

> Can we add and use explicit flag to mark blobs as ACPI tables,
> so that OVMF won't have to guess whether to hand off table
> as ACPI to UEFI stack or just keep it to yourself?

The ADD_POINTER-based heuristics cannot be turned off for ACPI table
identification, because a single fw_cfg blob can (and does) contain
multiple ACPI tables, and OVMF needs to figure out, somehow, where each
of those tables start. Blob-level hints won't help with this.

The following could be an improvement though: a blob-level hint (perhaps
in the ALLOCATE command) that the blob contains *no* ACPI tables. In
this case, OVMF could turn off the table recognition heuristics for
those ADD_POINTER commands that point into such blobs. (Plus mark the
blob for permanent preservation at once, and not only when an
ADD_POINTER "probe" into the blob fails.)

OVMF currently ignores the Zone field in the ALLOCATE command, so that
could be extended / abused for such a hint, without breaking
compatibility with OVMF. (Not sure about SeaBIOS.)

Otherwise, a new allocation command will be necessary. (Which should
embed the current ALLOCATE command structure fully, at some offset.)

Thanks
Laszlo
