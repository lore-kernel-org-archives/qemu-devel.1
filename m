Received: from eggs.gnu.org ([2001:4830:134:3::10]:58178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cbaof-0005uJ-T4
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cbaoZ-0005M0-O6
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:34:21 -0500
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:33954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cbaoZ-0005K6-5X
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:34:15 -0500
Received: by mail-pf0-x22e.google.com with SMTP id e4so44528699pfg.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 14:34:15 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <D7B3C037-90A4-4456-A3B8-BD8D3CC644F0@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_024AAB12-8BA2-4F45-A3E6-EC28FAAAEFFB";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 8 Feb 2017 14:34:11 -0800
In-Reply-To: <14f224ed-08e2-cbad-9d1d-8f559cd399a6@redhat.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
	<14f224ed-08e2-cbad-9d1d-8f559cd399a6@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org


--Apple-Mail=_024AAB12-8BA2-4F45-A3E6-EC28FAAAEFFB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 7, 2017, at 4:48 PM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 02/05/17 10:12, ben@skyportsystems.com =
<mailto:ben@skyportsystems.com> wrote:
>> From: Ben Warren <ben@skyportsystems.com>
>>=20
>> This implements the VM Generation ID feature by passing a 128-bit
>> GUID to the guest via a fw_cfg blob.
>> Any time the GUID changes, an ACPI notify event is sent to the guest
>>=20
>> The user interface is a simple device with one parameter:
>> - guid (string, must be "auto" or in UUID format
>>   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> ---
>> default-configs/i386-softmmu.mak     |   1 +
>> default-configs/x86_64-softmmu.mak   |   1 +
>> hw/acpi/Makefile.objs                |   1 +
>> hw/acpi/vmgenid.c                    | 206 =
+++++++++++++++++++++++++++++++++++
>> hw/i386/acpi-build.c                 |  10 ++
>> include/hw/acpi/acpi_dev_interface.h |   1 +
>> include/hw/acpi/vmgenid.h            |  37 +++++++
>> 7 files changed, 257 insertions(+)
>> create mode 100644 hw/acpi/vmgenid.c
>> create mode 100644 include/hw/acpi/vmgenid.h
>=20
> [snip code]
>=20
> So, I'm late to the game. I can't possibly comment on all the concerns
> that have been raised scattered around the thread, exactly *where* =
they
> have been raised. However, I will try to collect the concerns here.
>=20
>=20
> (1) Byte swapping for the UUID.
>=20
> The idea of QemuUUID is that wherever it is stored in a non-ephemeral
> fashion, it is in BE representation. The guest needs it in LE, so we
> should convert it temporarily -- using a local variable -- just before
> writing it to guest memory, and then forget about the LE =
representation
> promptly.
>=20
> As far as I understand, we all agree on this (Michael, Ben, myself -- =
I
> think Igor hasn't commented on this).
>=20
>=20
Sure, will rework.
> (2) Structure of the vmgenid fw_cfg blob, AKA "why that darn offset 40
> decimal".
>=20
> I explained it under points (6) and (7) in the following message:
>=20
> Message-Id: <c16a03d5-820a-f719-81ea-43858f903395@redhat.com =
<mailto:c16a03d5-820a-f719-81ea-43858f903395@redhat.com>>
> URL: https://www.mail-archive.com/qemu-devel@nongnu.org/msg425226.html =
<https://www.mail-archive.com/qemu-devel@nongnu.org/msg425226.html>
>=20
> The story is that *wherever* an ADD_POINTER command points to -- that
> is, at the *exact* target address --, OVMF will look for an ACPI table
> header, somewhat heuristically. If it finds a byte pattern that (a) =
fits
> into the remaining blob and (b) passes some superficial ACPI table
> header checks, such as length and checksum, then OVMF assumes that the
> blob contains an ACPI table there, and passes the address (again, the
> exact, relocated, absolute target address of ADD_POINTER) to
> EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable().
>=20
> We want to disable this heuristic for the vmgenid blob. *If* the blob
> contained only 16 bytes (for the GUID), then the heuristic would
> automatically disable itself, because the ACPI table header (36 bytes)
> is larger than 16 bytes, so OVMF wouldn't even look. However, for the
> caching and other VMGENID requirements, we need to allocate a full =
page
> with the blob (4KB), hence OVMF *will* look. If we placed the GUID =
right
> at the start of the page, then OVMF would sanity-check it as an ACPI
> table header. The check would *most likely* not pass, so things would =
be
> fine in practice, but we can do better than that: just put 40 zero =
bytes
> at the front of the blob.
>=20
> And this is why the ADD_POINTER command has to point to the beginning =
of
> the blob (i.e., 36 zero bytes), to "suppress the OVMF ACPI SDT header
> detection". (The other 4 bytes are for arriving at an address =
divisible
> by 8, which is a VMGENID requirement for the GUID.)
>=20
> The consequence is that both the ADDR method and QEMU's guest memory
> access code have to add 40 manually.
>=20
Igor has recommended that I have the add_pointer() call that patches AML =
have an offset of 40 from the start of the source file, which will =
result in the VGIA AML variable pointing to the GUID, not offset by 40.  =
I assume this isn=E2=80=99t a problem for you, but please confirm.
>=20
> (3) Whether the VGIA named object should be a DWORD or a QWORD in =
ACPI.
> Personally, I'm fine with either, but I see that DWORD is more
> compatible with old OSes.
>=20
> What I really care about though is the new WRITE_POINTER command
> structure. That should support 8 bytes as well.
>=20
> So this is exactly how Michael summarized it ultimately:
> - use a DWORD for VGIA in ACPI,
> - with a matching 4-byte wide ADD_POINTER command;
> - write the address with a 4-byte wide WRITE_POINTER command into
>  fw_cfg,
> - *but* the WRITE_POINTER command struct should support 8-byte as =
well,
> - and the fw_cfg file that is written (vmgenid_addr) should have size =
8
>  from the start. (The guest will simply write offsets 0..3 inclusive,
>  in LE byte order.)
>=20
This is an easy change, WRITE_POINTER already supports 8-byte writes.
>=20
> (4) IIRC Igor asked if sizing the blob to 4KB would guarantee that the
> GUID ends up in a cacheable page -- yes (see also Michael's followup).
> This size guarantees that the GUID will have a full page to itself, =
and
> its allocated from normal guest RAM, as Reserved memory (SeaBIOS, =
IIRC)
> or EfiACPIMemoryNVS memory (OVMF).
>=20
> Note that the VMGENID spec says, in ACPI terms, "It must not be in
> ranges reported as AddressRangeMemory or AddressRangeACPI", but that's =
fine:
>=20
> ACPI speak           UEFI speak            suitable for VMGENID?
> ------------------   --------------------- ---------------------
> AddressRangeMemory   EfiConventionalMemory no
> AddressRangeACPI     EfiACPIReclaimMemory  no
> AddressRangeNVS      EfiACPIMemoryNVS      yes, used by OVMF
> AddressRangeReserved EfiReservedMemoryType yes, used by SeaBIOS
>=20
>=20
> (5) The race and fw_cfg callbacks.
>=20
> (a) Michael and Ben identified a problem where
> - QEMU places the initial GUID in the "vmgenid" fw_cfg blob,
> - the guest downloads it,
> - the host admin changes the GUID via the monitor,
> - and the guest writes the address to "vmgenid_addr" *only* after =
that.
>=20
> In other words, the monitor action occurs between the guest's =
processing
> of the ALLOCATE and WRITE_POINTER linker/loader commands.
>=20
> (b) A similar problem is rebooting the guest.
> - The guest starts up fine,
> - the OS runs,
> - the host admin changes the GUID via the monitor,
> - and the guest sees the update fine.
> - At this point the guest is rebooted (within the same QEMU instance).
>=20
> Since the fw_cfg blob is not rebuilt -- more precisely, the blob *is*
> rebuilt, but it is then thrown away in acpi_build_update() --, the =
guest
> will see a different GUID from the last value set on the monitor. (And
> querying the monitor will actually return that last-set value, which =
is
> no longer known by the guest.)
>=20
>=20
> The suggestion for these problems was to add a callback to "one" of =
the
> fw_cfg files in question.
>=20
> Let's investigate the writeable "vmgenid_addr" file first. Here the =
idea
> is to rewrite the GUID in guest RAM as soon as the address is known =
from
> the guest, regardless of what GUID the guest placed there originally,
> through downloading the "vmgenid" blob.
>=20
> (i) We have no write callbacks at the moment. Before we removed the =
data
> port based write support in QEMU 2.4, the write callback used to be
> invoked when the end of the fw_cfg blob was reached. Since we intend =
to
> pack several addresses in the same writeable fw_cfg blob down the =
road,
> at different offsets, this method wouldn't work; the final offset in =
the
> blob might not be reached at all. (Another thing that wouldn't work is
> an 8-byte writeable fw_cfg blob, and a 4-byte WRITE_POINTER command =
that
> only rewrites offsets 0..3 inclusve -- see (3) above.)
>=20
> So I don't think that a write callback is viable, at least with the
> "many addresses at different offsets in the same blob" feature. Unless
> we want to register different callbacks (or different callback
> arguments) for different offsets. And then a large write could trigger =
a
> series of callbacks, even, if it covers several special offsets. This
> looks too complex to me.
>=20
> (ii) What we do have now is a select callback. Unfortunately, the =
guest
> is not required to select the item and atomically rewrite the blob, in
> the same fw_cfg DMA operation. The guest is allowed to do the =
selection
> with the IO port method, and then write the blob separately with DMA.
> (This is what OVMF does.) IOW, when we'd get the callback (for the
> select), the address would not have been written yet.
>=20
> So I don't think that a select callback for the writeable =
"vmgenid_addr"
> file is viable either.
>=20
> (iii) Let's see a select callback for the "vmgenid" blob itself! The
> idea is, whenever the guest selects this blob, immediately refresh the
> blob from the last set GUID. Then let the guest download the
> just-refreshed blob.
>=20
I like this approach, and have it working.  I assume by =E2=80=9Crefresh =
the blob=E2=80=9D you mean making a call to fw_cfg_modify_file().  If =
that is the case, I need to modify the function =
fw_cfg_modify_bytes_read() because of the following commented-out =
problem lines (656:657 in fw_cfg.c):

    /* return the old data to the function caller, avoid memory leak */
    ptr =3D s->entries[arch][key].data;
    s->entries[arch][key].data =3D data;
    s->entries[arch][key].len =3D len;
//    s->entries[arch][key].callback_opaque =3D NULL;
//    s->entries[arch][key].allow_write =3D false;

As you can see, this function modifies not only a fw_cfg object=E2=80=99s =
data, but also its metadata, wiping out the callback parameter and =
forcing it to read-only.  I don=E2=80=99t know the history of this =
function, so want to tread lightly.  The second parameter doesn=E2=80=99t =
impact me, since this fw_cfg object is read-only, but the callback =
parameter one does.

> The main observation here is that we can *fail* QMP commands. That's
> good enough if we can tell *when* to fail them.
>=20
> Under this idea, we would fail the "set-vm-generation-id" QMP command
> with "EAGAIN" if the quest had selected the "vmgenid" blob since =
machine
> reset -- this can be tracked with a latch -- *but* the particular =
offset
> range in the "vmgenid_addr" blob were still zero.
>=20
> This is exactly the window between the ALLOCATE and WRITE_POINTER
> commands where updates from the monitor would be lost. So let's just
> tell the management layer to try again later (like 1 second later). By
> that time, any sane guest will have written the address into =
"vmgenid_addr=E2=80=9D.
>=20
This seems sane.  I=E2=80=99ll just return EAGAIN if vmgenid_addr is =
zero, meaning the guest is not fully synchronized yet so don=E2=80=99t =
accept input.

One other more radical idea I had was to just remove the monitor GUID =
modification capability completely.  The VM Generation ID needs to =
change only in the following situations:
- new VM (command line processed)
- start from snapshot (command line processed, VGIA restored from =
VmState.
- VM recovered from backup (like a new VM, command line processed).
- VM imported, copied or cloned (like a new VM, command line processed).
- failed over from a disaster recovery environment.  Here I=E2=80=99m =
not sure. It=E2=80=99s possible I suppose that one would have a DR VM in =
hot standby, but would want to change its VM Generation ID in order to =
force Windows to re-synchronize Active Directory, crypto seeds etc.  =
Here the monitor might be necessary.

> Thanks
> Laszlo


--Apple-Mail=_024AAB12-8BA2-4F45-A3E6-EC28FAAAEFFB
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJ+zCCBK8w
ggOXoAMCAQICEQDgI8sVEoNTia1hbnpUZ2shMA0GCSqGSIb3DQEBCwUAMG8xCzAJBgNVBAYTAlNF
MRQwEgYDVQQKEwtBZGRUcnVzdCBBQjEmMCQGA1UECxMdQWRkVHJ1c3QgRXh0ZXJuYWwgVFRQIE5l
dHdvcmsxIjAgBgNVBAMTGUFkZFRydXN0IEV4dGVybmFsIENBIFJvb3QwHhcNMTQxMjIyMDAwMDAw
WhcNMjAwNTMwMTA0ODM4WjCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNV
BAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAibEN2npTGU5wUh28VqYGJre4SeCW
51Gr8fBaE0kVo7SMG2C8elFCp3mMpCLfF2FOkdV2IwoU00oCf7YdCYBupQQ92bq7Fv6hh6kuQ1JD
FnyvMlDIpk9a6QjYz5MlnHuI6DBk5qT4VoD9KiQUMxeZrETlaYujRgZLwjPU6UCfBrCxrJNAubUI
kzqcKlOjENs9IGE8VQOO2U52JQIhKfqjfHF2T+7hX4Hp+1SA28N7NVK3hN4iPSwwLTF/Wb1SN7Az
aS1D6/rWpfGXd2dRjNnuJ+u8pQc4doykqTj/34z1A6xJvsr3c5k6DzKrnJU6Ez0ORjpXdGFQvsZA
P8vk4p+iIQIDAQABo4IBFzCCARMwHwYDVR0jBBgwFoAUrb2YejS0Jvf6xCZU7wO94CTLVBowHQYD
VR0OBBYEFJJha4LhoqCqT+xn8cKj97SAAMHsMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAG
AQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAw
RAYDVR0fBD0wOzA5oDegNYYzaHR0cDovL2NybC51c2VydHJ1c3QuY29tL0FkZFRydXN0RXh0ZXJu
YWxDQVJvb3QuY3JsMDUGCCsGAQUFBwEBBCkwJzAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNl
cnRydXN0LmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAGypurFXBOquIxdjtzVXzqmthK8AJECOZD8Vm
am+x9bS1d14PAmEA330F/hKzpICAAPz7HVtqcgIKQbwFusFY1SbC6tVNhPv+gpjPWBvjImOcUvi7
BTarfVil3qs7Y+Xa1XPv7OD7e+Kj//BCI5zKto1NPuRLGAOyqC3U2LtCS5BphRDbpjc06HvgARCl
nMo6x59PiDRuimXQGoq7qdzKyjbR9PzCZCk1r9axp3ER0gNDsY8+muyeMlP0dpLKhjQHuSzK5hxK
2JkNwYbikJL7WkJqIyEQ6WXH9dW7fuqMhSACYurROgcsWcWZM/I4ieW26RZ6H3kU9koQGib6fIr7
mzCCBUQwggQsoAMCAQICEQCWOeMVlifzA+PvGfHjMeybMA0GCSqGSIb3DQEBCwUAMIGbMQswCQYD
VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRow
GAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTYwNTE5MDAwMDAwWhcNMTcw
NTE5MjM1OTU5WjAnMSUwIwYJKoZIhvcNAQkBFhZiZW5Ac2t5cG9ydHN5c3RlbXMuY29tMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAryjnKj/3VRzbNXiWAp7RAZSzUCOzDG6WJ2ybuDWP
A7uDl48iX2v3ulbcZq8G0sL1nwGvBdSrmd5X3Qzirx0ti0Qe0mlAd22PEOL/xR5ChLDhNI6i43cM
R1qM1JNtuC5Dz8h2TfYbF/VuKkA1YVuXNguSP8Z1DQXptE1m3yS0gk9LLdDkqq7Vi/zfSmD1NYHN
gEGvtux/3lMp8pHgQiZo8PxKH2Y4zem0AiWtZ9fKZqYWRIhECJ+etvpGvh4dNIj8vdo/ig3uSwLv
ePX7rFz3C5WHOyKjl4VGHNOA5IRZjabp4bdAEIiMPU7lfWt0o4nCRtM/G/6FvFinR6PIHSma1wID
AQABo4IB9DCCAfAwHwYDVR0jBBgwFoAUkmFrguGioKpP7GfxwqP3tIAAwewwHQYDVR0OBBYEFJv6
uT+NCtbUQ0MHZLryEY65oKgbMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZ
MBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7
BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwXQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2
Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBkAYIKwYBBQUHAQEEgYMw
gYAwWAYIKwYBBQUHMAKGTGh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAhBgNVHREEGjAYgRZiZW5Ac2t5cG9ydHN5c3RlbXMuY29tMA0GCSqG
SIb3DQEBCwUAA4IBAQAwVeCMNqTr20+cqsHnSK2AtzxKZyVG9y51wB88lPnRGHe2m+qKGdPgAh/7
iDzEEXsy4sDwHVHVq4kLHW9lX7CvRTxCtmOAtsty5ePhJjh3CX+nsK2HKpi043E6azad6L64DNVN
dMZFwUrUu8dYjOp48TPpIhW13Sbu2t/SOZK4G8EZAaZPX8Dg34tyHRUvM/B/eaJuUgdM5qY2IU+F
7U2K4hBHkhJMJgQ7TyVe8GhdBMaztY4GHqhWP5cCgZBdC9QII8E5jqX7//FbBRB0zVHRVeBZO32H
TvapSOG8ZYd0n5l5j3rBQnLfHWsnQ07rL2+w8W9BBPSZBbciPuwOe3ksMYIDxjCCA8ICAQEwgbEw
gZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1Nh
bGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1
NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z
8eMx7JswCQYFKw4DAhoFAKCCAekwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTcwMjA4MjIzNDEyWjAjBgkqhkiG9w0BCQQxFgQUMsk+LOpOC54CVp4fTFiM5iInmYYw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAbNOC6sUlnzr7M47Ewx2huANcz2Mvn0iGBg48z5LZ7Pjg6tjLlfFN7yx5
hDHU/uYHzfud5bJUslbrYxDvB4I9JBX3x/XkoWOywSpvIKmfodWFM2fF7VO6YCKWUiEVn8efyUVF
9xr1ouZpr0N4yJgsLNH2yRrpXj7L8Q/lKWuEvWXPvm/KQZVZlXS+u5wDE+K0JmzZsf9sX//AfDsg
vSrChPA3a+dCbEKOpH8OC+3XG4zVm98Lv8Q89RcDmDz02ukSCANYYAB6tJMaEwHaGmi4wwE+1nEd
9B4rQLTJcFLjiQ0pfRAzGy2my2OtptwqCIEHXnGW1XeDT8OHF5E67nqHRwAAAAAAAA==
--Apple-Mail=_024AAB12-8BA2-4F45-A3E6-EC28FAAAEFFB--
