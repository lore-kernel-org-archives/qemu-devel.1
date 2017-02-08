Received: from eggs.gnu.org ([2001:4830:134:3::10]:49581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbbtc-0000PI-56
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbbtX-0007yd-Tg
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:43:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbbtX-0007yQ-KL
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:43:27 -0500
References: <cover.1486285434.git.ben@skyportsystems.com>
	<28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
	<14f224ed-08e2-cbad-9d1d-8f559cd399a6@redhat.com>
	<D7B3C037-90A4-4456-A3B8-BD8D3CC644F0@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ffba05c5-0b4e-e2a6-2260-4f0da0f53e02@redhat.com>
Date: Thu, 9 Feb 2017 00:43:23 +0100
MIME-Version: 1.0
In-Reply-To: <D7B3C037-90A4-4456-A3B8-BD8D3CC644F0@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Ben Warren <ben@skyportsystems.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On 02/08/17 23:34, Ben Warren wrote:
>=20
>> On Feb 7, 2017, at 4:48 PM, Laszlo Ersek <lersek@redhat.com
>> <mailto:lersek@redhat.com>> wrote:
>>
>> On 02/05/17 10:12, ben@skyportsystems.com
>> <mailto:ben@skyportsystems.com> wrote:
>>> From: Ben Warren <ben@skyportsystems.com <mailto:ben@skyportsystems.c=
om>>
>>>
>>> This implements the VM Generation ID feature by passing a 128-bit
>>> GUID to the guest via a fw_cfg blob.
>>> Any time the GUID changes, an ACPI notify event is sent to the guest
>>>
>>> The user interface is a simple device with one parameter:
>>> - guid (string, must be "auto" or in UUID format
>>>   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>>>
>>> Signed-off-by: Ben Warren <ben@skyportsystems.com
>>> <mailto:ben@skyportsystems.com>>
>>> ---
>>> default-configs/i386-softmmu.mak     |   1 +
>>> default-configs/x86_64-softmmu.mak   |   1 +
>>> hw/acpi/Makefile.objs                |   1 +
>>> hw/acpi/vmgenid.c                    | 206
>>> +++++++++++++++++++++++++++++++++++
>>> hw/i386/acpi-build.c                 |  10 ++
>>> include/hw/acpi/acpi_dev_interface.h |   1 +
>>> include/hw/acpi/vmgenid.h            |  37 +++++++
>>> 7 files changed, 257 insertions(+)
>>> create mode 100644 hw/acpi/vmgenid.c
>>> create mode 100644 include/hw/acpi/vmgenid.h
>>
>> [snip code]
>>
>> So, I'm late to the game. I can't possibly comment on all the concerns
>> that have been raised scattered around the thread, exactly *where* the=
y
>> have been raised. However, I will try to collect the concerns here.
>>
>>
>> (1) Byte swapping for the UUID.
>>
>> The idea of QemuUUID is that wherever it is stored in a non-ephemeral
>> fashion, it is in BE representation. The guest needs it in LE, so we
>> should convert it temporarily -- using a local variable -- just before
>> writing it to guest memory, and then forget about the LE representatio=
n
>> promptly.
>>
>> As far as I understand, we all agree on this (Michael, Ben, myself -- =
I
>> think Igor hasn't commented on this).
>>
>>
> Sure, will rework.
>> (2) Structure of the vmgenid fw_cfg blob, AKA "why that darn offset 40
>> decimal".
>>
>> I explained it under points (6) and (7) in the following message:
>>
>> Message-Id: <c16a03d5-820a-f719-81ea-43858f903395@redhat.com
>> <mailto:c16a03d5-820a-f719-81ea-43858f903395@redhat.com>>
>> URL: https://www.mail-archive.com/qemu-devel@nongnu.org/msg425226.html
>>
>> The story is that *wherever* an ADD_POINTER command points to -- that
>> is, at the *exact* target address --, OVMF will look for an ACPI table
>> header, somewhat heuristically. If it finds a byte pattern that (a) fi=
ts
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
>> caching and other VMGENID requirements, we need to allocate a full pag=
e
>> with the blob (4KB), hence OVMF *will* look. If we placed the GUID rig=
ht
>> at the start of the page, then OVMF would sanity-check it as an ACPI
>> table header. The check would *most likely* not pass, so things would =
be
>> fine in practice, but we can do better than that: just put 40 zero byt=
es
>> at the front of the blob.
>>
>> And this is why the ADD_POINTER command has to point to the beginning =
of
>> the blob (i.e., 36 zero bytes), to "suppress the OVMF ACPI SDT header
>> detection". (The other 4 bytes are for arriving at an address divisibl=
e
>> by 8, which is a VMGENID requirement for the GUID.)
>>
>> The consequence is that both the ADDR method and QEMU's guest memory
>> access code have to add 40 manually.
>>
> Igor has recommended that I have the add_pointer() call that patches AM=
L
> have an offset of 40 from the start of the source file, which will
> result in the VGIA AML variable pointing to the GUID, not offset by 40.
>  I assume this isn=E2=80=99t a problem for you, but please confirm.

No, that would be a problem. The explanation as to why is right above.

Please process the rest of this sub-thread; Igor has agreed that my
request makes sense, he'd just like to see the reasoning behind it
documented:

http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg01640.html

To which I suggested that you please capture the above argument in a new
subsection in the docs file:

http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg01642.html

To which Igor replied that we should reference that documentation from
the exact spot in the code, where 40 decimal is added:

http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg01647.html

That's apparently our agreement on this. :)

>>
>> (3) Whether the VGIA named object should be a DWORD or a QWORD in ACPI=
.
>> Personally, I'm fine with either, but I see that DWORD is more
>> compatible with old OSes.
>>
>> What I really care about though is the new WRITE_POINTER command
>> structure. That should support 8 bytes as well.
>>
>> So this is exactly how Michael summarized it ultimately:
>> - use a DWORD for VGIA in ACPI,
>> - with a matching 4-byte wide ADD_POINTER command;
>> - write the address with a 4-byte wide WRITE_POINTER command into
>>  fw_cfg,
>> - *but* the WRITE_POINTER command struct should support 8-byte as well=
,
>> - and the fw_cfg file that is written (vmgenid_addr) should have size =
8
>>  from the start. (The guest will simply write offsets 0..3 inclusive,
>>  in LE byte order.)
>>
> This is an easy change, WRITE_POINTER already supports 8-byte writes.
>>
>> (4) IIRC Igor asked if sizing the blob to 4KB would guarantee that the
>> GUID ends up in a cacheable page -- yes (see also Michael's followup).
>> This size guarantees that the GUID will have a full page to itself, an=
d
>> its allocated from normal guest RAM, as Reserved memory (SeaBIOS, IIRC=
)
>> or EfiACPIMemoryNVS memory (OVMF).
>>
>> Note that the VMGENID spec says, in ACPI terms, "It must not be in
>> ranges reported as AddressRangeMemory or AddressRangeACPI", but that's
>> fine:
>>
>> ACPI speak           UEFI speak            suitable for VMGENID?
>> ------------------   --------------------- ---------------------
>> AddressRangeMemory   EfiConventionalMemory no
>> AddressRangeACPI     EfiACPIReclaimMemory  no
>> AddressRangeNVS      EfiACPIMemoryNVS      yes, used by OVMF
>> AddressRangeReserved EfiReservedMemoryType yes, used by SeaBIOS
>>
>>
>> (5) The race and fw_cfg callbacks.
>>
>> (a) Michael and Ben identified a problem where
>> - QEMU places the initial GUID in the "vmgenid" fw_cfg blob,
>> - the guest downloads it,
>> - the host admin changes the GUID via the monitor,
>> - and the guest writes the address to "vmgenid_addr" *only* after that=
.
>>
>> In other words, the monitor action occurs between the guest's processi=
ng
>> of the ALLOCATE and WRITE_POINTER linker/loader commands.
>>
>> (b) A similar problem is rebooting the guest.
>> - The guest starts up fine,
>> - the OS runs,
>> - the host admin changes the GUID via the monitor,
>> - and the guest sees the update fine.
>> - At this point the guest is rebooted (within the same QEMU instance).
>>
>> Since the fw_cfg blob is not rebuilt -- more precisely, the blob *is*
>> rebuilt, but it is then thrown away in acpi_build_update() --, the gue=
st
>> will see a different GUID from the last value set on the monitor. (And
>> querying the monitor will actually return that last-set value, which i=
s
>> no longer known by the guest.)
>>
>>
>> The suggestion for these problems was to add a callback to "one" of th=
e
>> fw_cfg files in question.
>>
>> Let's investigate the writeable "vmgenid_addr" file first. Here the id=
ea
>> is to rewrite the GUID in guest RAM as soon as the address is known fr=
om
>> the guest, regardless of what GUID the guest placed there originally,
>> through downloading the "vmgenid" blob.
>>
>> (i) We have no write callbacks at the moment. Before we removed the da=
ta
>> port based write support in QEMU 2.4, the write callback used to be
>> invoked when the end of the fw_cfg blob was reached. Since we intend t=
o
>> pack several addresses in the same writeable fw_cfg blob down the road=
,
>> at different offsets, this method wouldn't work; the final offset in t=
he
>> blob might not be reached at all. (Another thing that wouldn't work is
>> an 8-byte writeable fw_cfg blob, and a 4-byte WRITE_POINTER command th=
at
>> only rewrites offsets 0..3 inclusve -- see (3) above.)
>>
>> So I don't think that a write callback is viable, at least with the
>> "many addresses at different offsets in the same blob" feature. Unless
>> we want to register different callbacks (or different callback
>> arguments) for different offsets. And then a large write could trigger=
 a
>> series of callbacks, even, if it covers several special offsets. This
>> looks too complex to me.
>>
>> (ii) What we do have now is a select callback. Unfortunately, the gues=
t
>> is not required to select the item and atomically rewrite the blob, in
>> the same fw_cfg DMA operation. The guest is allowed to do the selectio=
n
>> with the IO port method, and then write the blob separately with DMA.
>> (This is what OVMF does.) IOW, when we'd get the callback (for the
>> select), the address would not have been written yet.
>>
>> So I don't think that a select callback for the writeable "vmgenid_add=
r"
>> file is viable either.
>>
>> (iii) Let's see a select callback for the "vmgenid" blob itself! The
>> idea is, whenever the guest selects this blob, immediately refresh the
>> blob from the last set GUID. Then let the guest download the
>> just-refreshed blob.
>>
> I like this approach, and have it working.

Cool! :)

> I assume by =E2=80=9Crefresh the
> blob=E2=80=9D you mean making a call to fw_cfg_modify_file().  If that =
is the
> case, I need to modify the function fw_cfg_modify_bytes_read() because
> of the following commented-out problem lines (656:657 in fw_cfg.c):
>=20
>     /* return the old data to the function caller, avoid memory leak */
>     ptr =3D s->entries[arch][key].data;
>     s->entries[arch][key].data =3D data;
>     s->entries[arch][key].len =3D len;
> //    s->entries[arch][key].callback_opaque =3D NULL;
> //    s->entries[arch][key].allow_write =3D false;
>=20
> As you can see, this function modifies not only a fw_cfg object=E2=80=99=
s data,
> but also its metadata, wiping out the callback parameter and forcing it
> to read-only.  I don=E2=80=99t know the history of this function, so wa=
nt to
> tread lightly.  The second parameter doesn=E2=80=99t impact me, since t=
his
> fw_cfg object is read-only, but the callback parameter one does.

It is justified to tread lightly :), because you really don't need to
call fw_cfg_modify_file().

Instead, in vmgenid_add_fw_cfg(), please do this:

diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index af8b35cebbe7..3860e9717e12 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -111,6 +111,8 @@ void vmgenid_add_fw_cfg(FWCfgState *s, GArray *guid)
     assert(obj);
     VmGenIdState *vms =3D VMGENID(obj);

+    vms->guid_blob =3D guid->data;
+
     /* Create a read-only fw_cfg file for GUID */
     fw_cfg_add_file(s, VMGENID_GUID_FW_CFG_FILE, guid->data,
                     VMGENID_FW_CFG_SIZE);

and then, whenever necessary, you can poke the GUID right into
"vms->guid_blob" (i.e., the fw_cfg data), at the appropriate offset
(40). No reallocation / metadata changes are necessary.

However, this means that you have to extend vmgenid_post_load() *too*,
with the same fw_cfg blob update. (You don't have to migrate the blob,
it is a whole bunch of zeroes with a GUID in the middle that has to be
refreshed on the target host anyway.)

>=20
>> The main observation here is that we can *fail* QMP commands. That's
>> good enough if we can tell *when* to fail them.
>>
>> Under this idea, we would fail the "set-vm-generation-id" QMP command
>> with "EAGAIN" if the quest had selected the "vmgenid" blob since machi=
ne
>> reset -- this can be tracked with a latch -- *but* the particular offs=
et
>> range in the "vmgenid_addr" blob were still zero.
>>
>> This is exactly the window between the ALLOCATE and WRITE_POINTER
>> commands where updates from the monitor would be lost. So let's just
>> tell the management layer to try again later (like 1 second later). By
>> that time, any sane guest will have written the address into
>> "vmgenid_addr=E2=80=9D.
>>
> This seems sane.  I=E2=80=99ll just return EAGAIN if vmgenid_addr is ze=
ro,
> meaning the guest is not fully synchronized yet so don=E2=80=99t accept=
 input.

Right, it means that the guest is temporarily in a state where it cannot
accept a new GUID.

Regarding the error structure -- we have structured errors! --, please
don't use error_setg(), nor error_setg_errno(). "EAGAIN" above was just
an example. Both of the aforementioned functions format an
ERROR_CLASS_GENERIC_ERROR, which is not really useful for libvirt if
libvirt wants to treat this condition specially.

Instead, we have another error class that looks appropriate:
ERROR_CLASS_DEVICE_NOT_ACTIVE. If you grep the source for it, you'll
find two independent users, which is (IMO) license to use it for our
purposes as well.

    error_set(errp, ERROR_CLASS_DEVICE_NOT_ACTIVE,
              "<format-string>", arguments ...);

See also "@DeviceNotActive" under "@QapiErrorClass" in "qapi/common.json"=
.

If you grep the libvirt source code for "DeviceNotActive", there are
several hits (with custom error handling) in "src/qemu/qemu_monitor_json.=
c".

>=20
> One other more radical idea I had was to just remove the monitor GUID
> modification capability completely.

You are going to laugh, but this was actually what I was about to
suggest while writing the email you've just replied to :)

I could not figure out *why* the management layer would want to change
the VMGUID for an already running domain. Generate a random one at
startup, or at incoming migration (hence, on the command line!), which
also covers restart from snapshot I guess, is fully justified, but why
mess with it otherwise? Where does this requirement come from?

In the docs patch, you mention Hyper-V and Xen as other VMMs that
support vmgenid. I didn't look into Hyper-V, but googling Xen, it looked
like they had a similar management interface (for runtime). At that
point I said to myself, "okay, so this is for 'feature parity' for all I
know", and deleted like three paragraphs :)

>  The VM Generation ID needs to
> change only in the following situations:
> - new VM (command line processed)
> - start from snapshot (command line processed, VGIA restored from VmSta=
te.

(this is also "incoming migration")

> - VM recovered from backup (like a new VM, command line processed).
> - VM imported, copied or cloned (like a new VM, command line processed)=
.
> - failed over from a disaster recovery environment.  Here I=E2=80=99m n=
ot sure.
> It=E2=80=99s possible I suppose that one would have a DR VM in hot stan=
dby, but
> would want to change its VM Generation ID in order to force Windows to
> re-synchronize Active Directory, crypto seeds etc.  Here the monitor
> might be necessary.

Well, I really don't know. I guess we can follow approach (iii), just to
be safe.

Thanks!
Laszlo
