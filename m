Received: from eggs.gnu.org ([2001:4830:134:3::10]:38164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cePTk-0004vz-2W
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cePTf-0003Sp-Ae
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:04:24 -0500
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:34053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cePTe-0003Rb-Ti
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:04:19 -0500
Received: by mail-pf0-x236.google.com with SMTP id e4so6873134pfg.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 09:04:18 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <B8FC9637-C98D-4484-8E8C-5DFBAA439FFE@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_98D6B1C9-F86D-4E83-ADEF-2EEA3EC94247";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Thu, 16 Feb 2017 09:04:16 -0800
In-Reply-To: <9e222b4c-c05d-8fd0-6c55-4b2e52cab7b0@redhat.com>
References: <cover.1487224954.git.ben@skyportsystems.com>
	<4d92b9f92d2f5b702c23bf135222dfb226ec94a7.1487224954.git.ben@skyportsystems.com>
	<9e222b4c-c05d-8fd0-6c55-4b2e52cab7b0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/8] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, imammedo@redhat.com


--Apple-Mail=_98D6B1C9-F86D-4E83-ADEF-2EEA3EC94247
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 16, 2017, at 9:01 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 02/16/17 07:18, ben@skyportsystems.com =
<mailto:ben@skyportsystems.com> wrote:
>> From: Ben Warren <ben@skyportsystems.com>
>>=20
>> This is similar to the existing 'add pointer' functionality, but =
instead
>> of instructing the guest (BIOS or UEFI) to patch memory, it instructs
>> the guest to write the pointer back to QEMU via a writeable fw_cfg =
file.
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> ---
>> hw/acpi/bios-linker-loader.c         | 66 =
++++++++++++++++++++++++++++++++++--
>> include/hw/acpi/bios-linker-loader.h |  7 ++++
>> 2 files changed, 70 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/acpi/bios-linker-loader.c =
b/hw/acpi/bios-linker-loader.c
>> index d963ebe..d5fb703 100644
>> --- a/hw/acpi/bios-linker-loader.c
>> +++ b/hw/acpi/bios-linker-loader.c
>> @@ -78,6 +78,21 @@ struct BiosLinkerLoaderEntry {
>>             uint32_t length;
>>         } cksum;
>>=20
>> +        /*
>> +         * COMMAND_WRITE_POINTER - write the fw_cfg file =
(originating from
>> +         * @dest_file) at @wr_pointer.offset, by adding a pointer to
>> +         * @src_offset within the table originating from @src_file.
>> +         * 1,2,4 or 8 byte unsigned addition is used depending on
>> +         * @wr_pointer.size.
>> +         */
>> +        struct {
>> +            char dest_file[BIOS_LINKER_LOADER_FILESZ];
>> +            char src_file[BIOS_LINKER_LOADER_FILESZ];
>> +            uint32_t dst_offset;
>> +            uint32_t src_offset;
>> +            uint8_t size;
>> +        } wr_pointer;
>> +
>>         /* padding */
>>         char pad[124];
>>     };
>> @@ -85,9 +100,10 @@ struct BiosLinkerLoaderEntry {
>> typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
>>=20
>> enum {
>> -    BIOS_LINKER_LOADER_COMMAND_ALLOCATE     =3D 0x1,
>> -    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER  =3D 0x2,
>> -    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM =3D 0x3,
>> +    BIOS_LINKER_LOADER_COMMAND_ALLOCATE          =3D 0x1,
>> +    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER       =3D 0x2,
>> +    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM      =3D 0x3,
>> +    BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER     =3D 0x4,
>> };
>>=20
>> enum {
>> @@ -278,3 +294,47 @@ void bios_linker_loader_add_pointer(BIOSLinker =
*linker,
>>=20
>>     g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
>> }
>> +
>> +/*
>> + * bios_linker_loader_write_pointer: ask guest to write a pointer to =
the
>> + * source file into the destination file, and write it back to QEMU =
via
>> + * fw_cfg DMA.
>> + *
>> + * @linker: linker object instance
>> + * @dest_file: destination file that must be written
>> + * @dst_patched_offset: location within destination file blob to be =
patched
>> + *                      with the pointer to @src_file, in bytes
>> + * @dst_patched_offset_size: size of the pointer to be patched
>> + *                      at @dst_patched_offset in @dest_file blob, =
in bytes
>> + * @src_file: source file who's address must be taken
>> + * @src_offset: location within source file blob to which
>> + *              @dest_file+@dst_patched_offset will point to after
>> + *              firmware's executed WRITE_POINTER command
>> + */
>> +void bios_linker_loader_write_pointer(BIOSLinker *linker,
>> +                                    const char *dest_file,
>> +                                    uint32_t dst_patched_offset,
>> +                                    uint8_t dst_patched_size,
>> +                                    const char *src_file,
>> +                                    uint32_t src_offset)
>> +{
>> +    BiosLinkerLoaderEntry entry;
>> +    const BiosLinkerFileEntry *source_file =3D
>> +        bios_linker_find_file(linker, src_file);
>> +
>> +    assert(source_file);
>> +    assert(src_offset <=3D source_file->blob->len);
>=20
> (1) Off by one, as pointed out by Igor.
Oh, =E2=80=9Coff-by-one=E2=80=9D errors.  One of the three biggest =
sources of bugs in programming.  The other being recursion.  Sorry, =
couldn=E2=80=99t resist :)

>=20
>> +    memset(&entry, 0, sizeof entry);
>> +    strncpy(entry.wr_pointer.dest_file, dest_file,
>> +            sizeof entry.wr_pointer.dest_file - 1);
>> +    strncpy(entry.wr_pointer.src_file, src_file,
>> +            sizeof entry.wr_pointer.src_file - 1);
>> +    entry.command =3D =
cpu_to_le32(BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER);
>> +    entry.wr_pointer.dst_offset =3D cpu_to_le32(dst_patched_offset);
>> +    entry.wr_pointer.src_offset =3D cpu_to_le32(dst_patched_offset);
>=20
> (2) copy/paste error, you should be assigning "src_offset", as in:
>=20
Oops.
>> diff --git a/hw/acpi/bios-linker-loader.c =
b/hw/acpi/bios-linker-loader.c
>> index d5fb7033a0be..d1a9f2f33dcc 100644
>> --- a/hw/acpi/bios-linker-loader.c
>> +++ b/hw/acpi/bios-linker-loader.c
>> @@ -331,7 +331,7 @@ void bios_linker_loader_write_pointer(BIOSLinker =
*linker,
>>             sizeof entry.wr_pointer.src_file - 1);
>>     entry.command =3D =
cpu_to_le32(BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER);
>>     entry.wr_pointer.dst_offset =3D cpu_to_le32(dst_patched_offset);
>> -    entry.wr_pointer.src_offset =3D cpu_to_le32(dst_patched_offset);
>> +    entry.wr_pointer.src_offset =3D cpu_to_le32(src_offset);
>>     entry.wr_pointer.size =3D dst_patched_size;
>>     assert(dst_patched_size =3D=3D 1 || dst_patched_size =3D=3D 2 ||
>>            dst_patched_size =3D=3D 4 || dst_patched_size =3D=3D 8);
>=20
> With these errors fixed:
>=20
> Reviewed-by: Laszlo Ersek <lersek@redhat.com =
<mailto:lersek@redhat.com>>
>=20
> I also tested this series (with the assignment under (2) fixed up, of =
course), as documented earlier in =
<https://www.mail-archive.com/qemu-devel@nongnu.org/msg430075.html =
<https://www.mail-archive.com/qemu-devel@nongnu.org/msg430075.html>> =
(msgid <678c203f-3768-7e65-6e48-6729473b6ffa@redhat.com =
<mailto:678c203f-3768-7e65-6e48-6729473b6ffa@redhat.com>>).
>=20
> Hence, with (1) and (2) fixed, you can also add
>=20
> Tested-by: Laszlo Ersek <lersek@redhat.com <mailto:lersek@redhat.com>>
>=20
> Thanks
> Laszlo
>=20
Thanks a lot!

=E2=80=94Ben
>> +    entry.wr_pointer.size =3D dst_patched_size;
>> +    assert(dst_patched_size =3D=3D 1 || dst_patched_size =3D=3D 2 ||
>> +           dst_patched_size =3D=3D 4 || dst_patched_size =3D=3D 8);
>> +
>> +    g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
>> +}
>> diff --git a/include/hw/acpi/bios-linker-loader.h =
b/include/hw/acpi/bios-linker-loader.h
>> index fa1e5d1..efe17b0 100644
>> --- a/include/hw/acpi/bios-linker-loader.h
>> +++ b/include/hw/acpi/bios-linker-loader.h
>> @@ -26,5 +26,12 @@ void bios_linker_loader_add_pointer(BIOSLinker =
*linker,
>>                                     const char *src_file,
>>                                     uint32_t src_offset);
>>=20
>> +void bios_linker_loader_write_pointer(BIOSLinker *linker,
>> +                                      const char *dest_file,
>> +                                      uint32_t dst_patched_offset,
>> +                                      uint8_t dst_patched_size,
>> +                                      const char *src_file,
>> +                                      uint32_t src_offset);
>> +
>> void bios_linker_loader_cleanup(BIOSLinker *linker);
>> #endif


--Apple-Mail=_98D6B1C9-F86D-4E83-ADEF-2EEA3EC94247
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
CQUxDxcNMTcwMjE2MTcwNDE2WjAjBgkqhkiG9w0BCQQxFgQUIYvBTkf83lKbAjvQ7ZWF7tIUmAQw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAo8LeZzA5lXhtthO8YvBX9ArqZkUTU48vl3r7hUQEVhsk6DoCDT7CbmhK
HC0tfWYJC/prDbZxrQHaIzrEEHV04nYgGypMh/ZG7ri9htBbn0TgX9IrKnYx9rUfZT+A3MS79Y2A
Y/2pjQkJMqVL+vZ9WB3OLDS4BbkI79Ee6P3ftrdkoFrJjVpysayCUGd63kAUPP8BIxiE2069caGf
l514PKIlBL42gs432foFqgjxxNdOwBvcol7o2uxp7a+G9lVXppYf9LbMMuDybZXegp9YYfUWk2qj
cVSRH7tRXs+lSpmj3rwuzHHOERvLMxr7ssxySQZP+TUG9usXlj7gZtdaiwAAAAAAAA==
--Apple-Mail=_98D6B1C9-F86D-4E83-ADEF-2EEA3EC94247--
