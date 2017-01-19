Received: from eggs.gnu.org ([2001:4830:134:3::10]:48053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cUGnz-00033L-0k
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cUGnu-0002ZK-Qx
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:47:23 -0500
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:32783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cUGnu-0002Yo-B2
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:47:18 -0500
Received: by mail-pf0-x236.google.com with SMTP id y143so15157753pfb.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:47:18 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <6285FEB6-6536-4276-99B6-3E99C2F2F2E9@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_88B7E219-4940-42E6-9D93-A95AB2FD1B8E";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Thu, 19 Jan 2017 09:47:15 -0800
In-Reply-To: <40ee4c2a-59b6-dc6a-0ce6-97f7026b8d07@redhat.com>
References: <CAO_EM_kuP9kk55bzxWqNOeuL8yW7gKNnacd1-UVGnJPyx2ZNYw@mail.gmail.com>
	<20160916033402-mutt-send-email-mst@kernel.org>
	<CAO_EM_mHyC7cywV4KUqH_MWwt2vVkK6GEOuaUX0FHpffdfaAuQ@mail.gmail.com>
	<20161006041949-mutt-send-email-mst@kernel.org>
	<D5FCB73B-435E-4423-B21C-BEEF1C1EA2FD@skyportsystems.com>
	<20161211052355-mutt-send-email-mst@kernel.org>
	<FBD67273-74C4-4183-8FCF-8260D13B04D4@skyportsystems.com>
	<20170116161857-mutt-send-email-mst@kernel.org>
	<85C3D50B-7AFD-41E7-AD1B-634A42D04BB2@skyportsystems.com>
	<20170117194321-mutt-send-email-mst@kernel.org>
	<BD6CD44B-68C2-40F6-9251-7DFD06821AD4@skyportsystems.com>
	<DD5278F7-9CF4-4BAA-861D-F615430C1991@skyportsystems.com>
	<40ee4c2a-59b6-dc6a-0ce6-97f7026b8d07@redhat.com>
Subject: Re: [Qemu-devel] Virtual Machine Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>


--Apple-Mail=_88B7E219-4940-42E6-9D93-A95AB2FD1B8E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks Laszlo!
> On Jan 19, 2017, at 1:25 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 01/19/17 08:09, Ben Warren wrote:
>>=20
>>> On Jan 18, 2017, at 4:02 PM, Ben Warren <ben@skyportsystems.com>
>>> wrote:
>>>=20
>>> Hi Michael,
>>>> On Jan 17, 2017, at 9:45 AM, Michael S. Tsirkin <mst@redhat.com>
>>>> wrote:
>>>>=20
>>>> On Mon, Jan 16, 2017 at 10:57:42AM -0800, Ben Warren wrote:
>>>>> I think we have a misunderstanding here.  I'm storing the VM
>>>>> Generation ID __data__ (a GUID) in a fw_cfg blob, not the address.
>>>>=20
>>>> Yes, I think I gathered this much from the discussion. This is what
>>>> I'm saying - don't. Have guest loader reserve guest memory and =
write
>>>> the address into a fw cfg blob, and have qemu write the id at that
>>>> address. This way you can update guest memory at any time.
>>>>=20
>>> So I've gone down the path of creating a writeable fw_cfg blob to
>>> hold the VGID address, but it doesn't seem to be getting updated.
>>>=20
>>> Here's the code I've added:
>>>=20
>>> #define VMGENID_FW_CFG_FILE      "etc/vmgenid"
>>> #define VMGENID_FW_CFG_ADDR_FILE      "etc/vmgenid_addr"
>>>=20
>>> // Create writeable fw_cfg blob, vas->vgia is a GArray of size 8 and =
element size 1
>>> fw_cfg_add_file_callback(s, VMGENID_FW_CFG_ADDR_FILE, NULL, NULL, =
vms->vgia->data, 8, false);
>>>=20
>>> // Request BIOS to allocate memory for the read-only DATA file:
>>> bios_linker_loader_alloc(linker, VMGENID_FW_CFG_FILE, guid, =
0,false);
>>>=20
>>> // Request BIOS to allocate memory for the writeable ADDRESS file:
>>> bios_linker_loader_alloc(linker, VMGENID_FW_CFG_ADDR_FILE, s->vgia, =
0, false);
>>>=20
>>> // Request BIOS to write the address of the DATA file into the =
ADDRESS file:
>>> bios_linker_loader_add_pointer(linker, VMGENID_FW_CFG_ADDR_FILE, 0, =
sizeof(uint64_t), VMGENID_FW_CFG_FILE, 0);
>>>=20
>>> I've instrumented SeaBIOS and see the requests being made and memcpy
>>> to the file happening, but don't see any changes in QEMU in the
>>> memory pointed to by VMGENID_FW_CFG_ADDR_FILE.  Is this how =
writeable
>>> fw_cfg is supposed to work?
>>>=20
>> Ed explained it to me and I think I get it now.  I realize that you
>> and Igor have explained this throughout the e-mail chain, but I'm a
>> little bit slower.
>>=20
>> Anyway, is this understanding correct?  BIOS is in fact patching
>> fw_cfg data, but it's in a copy of the fw_cfg file that is in guest
>> space.  In order to get this to work we would need to add a new
>> command to the linker/loader protocol to write back changes to QEMU
>> after patching, and of course implement the change in BIOS and UEFI
>> projects.
>=20
> (1) It's not enough to create just the "etc/vmgenid_addr" file; the
> "etc/vmgenid" file must exist too, so that the firmware can download =
it.
>=20
I do have that file too, just didn=E2=80=99t show it.
> (2) I don't understand why you need the ADD_POINTER command here. I
> think it's unnecessary.
>=20
> (3) The ALLOCATE command for "etc/vmgenid_addr" is also unnecessary.
>=20
For both of these, I was working within the confines of the existing =
API, which we now know is inadequate.
> (4) A new ALLOCATE_RETURN_ADDR command type should be introduced, with
> the following contents:
>=20
>        struct {
>            char file[BIOS_LINKER_LOADER_FILESZ];
>            uint32_t align;
>            uint8_t zone;
>            char addr_file[BIOS_LINKER_LOADER_FILESZ];
>        } alloc_return_addr;
>=20
> The first three fields have identical meanings to those of the current
> ALLOCATE command. The last field instructs the firmware as to what
> fw_cfg file to write the 8-byte physical address back to, in little
> endian byte order, of the actual allocation.
>=20
> (5) The linker/loader script should then use one command in total,
> namely ALLOCATE_RETURN_ADDR, with
>=20
>  file =3D etc/vmgenid
>  addr_file =3D etc/vmgenid_addr
>=20
> This will allow both SeaBIOS and OVMF to do the right thing.
>=20
> In summary:
> - create the read-only "etc/vmgenid" fw_cfg file
> - create the writeable "etc/vmgenid_addr" fw_cfg file
> - use one ALLOCATE_RETURN_ADDR command, and nothing else.
>=20
> I hereby volunteer to write the OVMF patch for the =
ALLOCATE_RETURN_ADDR
> command type.
>=20
Sounds great.  We use SeaBIOS so I=E2=80=99ll try to do the same there.

So, just to make sure everything=E2=80=99s covered: this new mechanism =
will allow QEMU to have the guest allocate an arbitrary blob of memory =
(in the form of a fw_cfg file), and will get an offset within guest =
memory in return (via another fw_cfg file).  It can then translate the =
guest offset into a host address and update the blob at will.  Is this =
correct, because that=E2=80=99s what we need for VM Generation ID?

> If someone is interested, I'll remind us that EFI_ACPI_TABLE_PROTOCOL
> installs *copies* of ACPI tables, out of the fw_cfg blobs that were
> downloaded. Therefore OVMF tracks all ADD_POINTER commands that point
> into fw_cfg blobs, and if an fw_cfg blob is not pointed-to by *any*
> ADD_POINTER command, or else *all* ADD_POINTER commands that point =
into
> it point to ACPI table headers, then OVMF will ultimately free the
> originally downloaded fw_cfg blob. If there is at least one referring
> ADD_POINTER command that points to non-ACPI-table data within the =
blob,
> then OVMF marks the blob to be preserved permanently, in AcpiNVS type
> memory.
>=20
> By introducing the above ALLOCATE_RETURN_ADDR command type, OVMF can =
do
> two things:
>=20
> (a) immediately mark the blob for permanent preservation (i.e., it =
won't
>    be released after the script processing is complete),
> (b) write the actual allocation address back to the appropriate fw_cfg
>    file.
>=20
> For SeaBIOS, only (b) matters -- because it doesn't install *copies* =
of
> ACPI tables; it rather keeps everything in place, as originally
> allocated, and it just links things together --, but
> ALLOCATE_RETURN_ADDR as proposed above should be suitable for SeaBIOS
> just as well.
>=20
> Thanks
> Laszlo
=E2=80=94Ben


--Apple-Mail=_88B7E219-4940-42E6-9D93-A95AB2FD1B8E
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
CQUxDxcNMTcwMTE5MTc0NzE1WjAjBgkqhkiG9w0BCQQxFgQU04XLYTvLj/ky1gnqAU5AAqI/y1Iw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAUr3mpSio0xKrOH3tFdZ1VuAu2W1baqhS+XNn9e4Op7Bns/oeT8sR9ObH
pgIZoyOM2V/7rKZ5KUGQ2J+luwr0HpJ13c4LMT+8hq4o2iegJzvnTVn59yYmX7HrdsRFw1m97Z1p
mnRK9jRMt0ZSToTkNoZHQm/Ax8VT1ptJLjBw/Ufi5jqbGriYEjFIWPmd52zGUrE12Xi3VB5pwW8d
2wJPip/1mhNE8UB/6Hb64gnJ0eArA+g54WtkyP5OjYiRRsWCmVBe0QR/dhXSkXuouir2ogqCZGcy
VOTchNhAHacVgiXBBYGhLXtpH4B1solVTM0byef0px81SELCz2RZSU0SBAAAAAAAAA==
--Apple-Mail=_88B7E219-4940-42E6-9D93-A95AB2FD1B8E--
