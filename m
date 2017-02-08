Received: from eggs.gnu.org ([2001:4830:134:3::10]:60293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbGRF-00009H-S6
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbGRC-00072e-Ng
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:48:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbGRC-000723-FL
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:48:46 -0500
References: <cover.1486285434.git.ben@skyportsystems.com>
	<28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <14f224ed-08e2-cbad-9d1d-8f559cd399a6@redhat.com>
Date: Wed, 8 Feb 2017 01:48:42 +0100
MIME-Version: 1.0
In-Reply-To: <28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
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
To: ben@skyportsystems.com, imammedo@redhat.com, mst@redhat.com
Cc: qemu-devel@nongnu.org

On 02/05/17 10:12, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> This implements the VM Generation ID feature by passing a 128-bit
> GUID to the guest via a fw_cfg blob.
> Any time the GUID changes, an ACPI notify event is sent to the guest
> 
> The user interface is a simple device with one parameter:
>  - guid (string, must be "auto" or in UUID format
>    xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  default-configs/i386-softmmu.mak     |   1 +
>  default-configs/x86_64-softmmu.mak   |   1 +
>  hw/acpi/Makefile.objs                |   1 +
>  hw/acpi/vmgenid.c                    | 206 +++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c                 |  10 ++
>  include/hw/acpi/acpi_dev_interface.h |   1 +
>  include/hw/acpi/vmgenid.h            |  37 +++++++
>  7 files changed, 257 insertions(+)
>  create mode 100644 hw/acpi/vmgenid.c
>  create mode 100644 include/hw/acpi/vmgenid.h

[snip code]

So, I'm late to the game. I can't possibly comment on all the concerns
that have been raised scattered around the thread, exactly *where* they
have been raised. However, I will try to collect the concerns here.


(1) Byte swapping for the UUID.

The idea of QemuUUID is that wherever it is stored in a non-ephemeral
fashion, it is in BE representation. The guest needs it in LE, so we
should convert it temporarily -- using a local variable -- just before
writing it to guest memory, and then forget about the LE representation
promptly.

As far as I understand, we all agree on this (Michael, Ben, myself -- I
think Igor hasn't commented on this).


(2) Structure of the vmgenid fw_cfg blob, AKA "why that darn offset 40
decimal".

I explained it under points (6) and (7) in the following message:

Message-Id: <c16a03d5-820a-f719-81ea-43858f903395@redhat.com>
URL: https://www.mail-archive.com/qemu-devel@nongnu.org/msg425226.html

The story is that *wherever* an ADD_POINTER command points to -- that
is, at the *exact* target address --, OVMF will look for an ACPI table
header, somewhat heuristically. If it finds a byte pattern that (a) fits
into the remaining blob and (b) passes some superficial ACPI table
header checks, such as length and checksum, then OVMF assumes that the
blob contains an ACPI table there, and passes the address (again, the
exact, relocated, absolute target address of ADD_POINTER) to
EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable().

We want to disable this heuristic for the vmgenid blob. *If* the blob
contained only 16 bytes (for the GUID), then the heuristic would
automatically disable itself, because the ACPI table header (36 bytes)
is larger than 16 bytes, so OVMF wouldn't even look. However, for the
caching and other VMGENID requirements, we need to allocate a full page
with the blob (4KB), hence OVMF *will* look. If we placed the GUID right
at the start of the page, then OVMF would sanity-check it as an ACPI
table header. The check would *most likely* not pass, so things would be
fine in practice, but we can do better than that: just put 40 zero bytes
at the front of the blob.

And this is why the ADD_POINTER command has to point to the beginning of
the blob (i.e., 36 zero bytes), to "suppress the OVMF ACPI SDT header
detection". (The other 4 bytes are for arriving at an address divisible
by 8, which is a VMGENID requirement for the GUID.)

The consequence is that both the ADDR method and QEMU's guest memory
access code have to add 40 manually.


(3) Whether the VGIA named object should be a DWORD or a QWORD in ACPI.
Personally, I'm fine with either, but I see that DWORD is more
compatible with old OSes.

What I really care about though is the new WRITE_POINTER command
structure. That should support 8 bytes as well.

So this is exactly how Michael summarized it ultimately:
- use a DWORD for VGIA in ACPI,
- with a matching 4-byte wide ADD_POINTER command;
- write the address with a 4-byte wide WRITE_POINTER command into
  fw_cfg,
- *but* the WRITE_POINTER command struct should support 8-byte as well,
- and the fw_cfg file that is written (vmgenid_addr) should have size 8
  from the start. (The guest will simply write offsets 0..3 inclusive,
  in LE byte order.)


(4) IIRC Igor asked if sizing the blob to 4KB would guarantee that the
GUID ends up in a cacheable page -- yes (see also Michael's followup).
This size guarantees that the GUID will have a full page to itself, and
its allocated from normal guest RAM, as Reserved memory (SeaBIOS, IIRC)
or EfiACPIMemoryNVS memory (OVMF).

Note that the VMGENID spec says, in ACPI terms, "It must not be in
ranges reported as AddressRangeMemory or AddressRangeACPI", but that's fine:

ACPI speak           UEFI speak            suitable for VMGENID?
------------------   --------------------- ---------------------
AddressRangeMemory   EfiConventionalMemory no
AddressRangeACPI     EfiACPIReclaimMemory  no
AddressRangeNVS      EfiACPIMemoryNVS      yes, used by OVMF
AddressRangeReserved EfiReservedMemoryType yes, used by SeaBIOS


(5) The race and fw_cfg callbacks.

(a) Michael and Ben identified a problem where
- QEMU places the initial GUID in the "vmgenid" fw_cfg blob,
- the guest downloads it,
- the host admin changes the GUID via the monitor,
- and the guest writes the address to "vmgenid_addr" *only* after that.

In other words, the monitor action occurs between the guest's processing
of the ALLOCATE and WRITE_POINTER linker/loader commands.

(b) A similar problem is rebooting the guest.
- The guest starts up fine,
- the OS runs,
- the host admin changes the GUID via the monitor,
- and the guest sees the update fine.
- At this point the guest is rebooted (within the same QEMU instance).

Since the fw_cfg blob is not rebuilt -- more precisely, the blob *is*
rebuilt, but it is then thrown away in acpi_build_update() --, the guest
will see a different GUID from the last value set on the monitor. (And
querying the monitor will actually return that last-set value, which is
no longer known by the guest.)


The suggestion for these problems was to add a callback to "one" of the
fw_cfg files in question.

Let's investigate the writeable "vmgenid_addr" file first. Here the idea
is to rewrite the GUID in guest RAM as soon as the address is known from
the guest, regardless of what GUID the guest placed there originally,
through downloading the "vmgenid" blob.

(i) We have no write callbacks at the moment. Before we removed the data
port based write support in QEMU 2.4, the write callback used to be
invoked when the end of the fw_cfg blob was reached. Since we intend to
pack several addresses in the same writeable fw_cfg blob down the road,
at different offsets, this method wouldn't work; the final offset in the
blob might not be reached at all. (Another thing that wouldn't work is
an 8-byte writeable fw_cfg blob, and a 4-byte WRITE_POINTER command that
only rewrites offsets 0..3 inclusve -- see (3) above.)

So I don't think that a write callback is viable, at least with the
"many addresses at different offsets in the same blob" feature. Unless
we want to register different callbacks (or different callback
arguments) for different offsets. And then a large write could trigger a
series of callbacks, even, if it covers several special offsets. This
looks too complex to me.

(ii) What we do have now is a select callback. Unfortunately, the guest
is not required to select the item and atomically rewrite the blob, in
the same fw_cfg DMA operation. The guest is allowed to do the selection
with the IO port method, and then write the blob separately with DMA.
(This is what OVMF does.) IOW, when we'd get the callback (for the
select), the address would not have been written yet.

So I don't think that a select callback for the writeable "vmgenid_addr"
file is viable either.

(iii) Let's see a select callback for the "vmgenid" blob itself! The
idea is, whenever the guest selects this blob, immediately refresh the
blob from the last set GUID. Then let the guest download the
just-refreshed blob.

The main observation here is that we can *fail* QMP commands. That's
good enough if we can tell *when* to fail them.

Under this idea, we would fail the "set-vm-generation-id" QMP command
with "EAGAIN" if the quest had selected the "vmgenid" blob since machine
reset -- this can be tracked with a latch -- *but* the particular offset
range in the "vmgenid_addr" blob were still zero.

This is exactly the window between the ALLOCATE and WRITE_POINTER
commands where updates from the monitor would be lost. So let's just
tell the management layer to try again later (like 1 second later). By
that time, any sane guest will have written the address into "vmgenid_addr".

Thanks
Laszlo
