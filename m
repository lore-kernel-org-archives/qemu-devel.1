Received: from eggs.gnu.org ([2001:4830:134:3::10]:41644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1camtz-0003fe-KQ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1camtx-0007us-N6
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:16:31 -0500
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:35937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1camtx-0007tD-EP
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:16:29 -0500
Received: by mail-pg0-x231.google.com with SMTP id v184so30093355pgv.3
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 09:16:27 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <65C02079-7702-4819-8852-1EB294B701FF@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_451A438C-F6A0-43CE-84A2-096CB93DF73A";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Mon, 6 Feb 2017 09:16:25 -0800
In-Reply-To: <20170206165517-mutt-send-email-mst@kernel.org>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<2bb2dd455ea355b279867a312924add82ae685e4.1486285434.git.ben@skyportsystems.com>
	<20170206165517-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v5 02/10] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, imammedo@redhat.com


--Apple-Mail=_451A438C-F6A0-43CE-84A2-096CB93DF73A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 6, 2017, at 6:56 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Sun, Feb 05, 2017 at 01:11:57AM -0800, ben@skyportsystems.com =
wrote:
>> From: Ben Warren <ben@skyportsystems.com>
>>=20
>> This adds to the existing 'add pointer' functionality in that it
>> instructs the guest (BIOS or UEFI) to not patch memory but to instead
>> write the changes back to QEMU via a writeable fw_cfg file.
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> ---
>> hw/acpi/aml-build.c                  |  2 +-
>> hw/acpi/bios-linker-loader.c         | 35 =
++++++++++++++++++++++++-----------
>> hw/acpi/nvdimm.c                     |  2 +-
>> hw/arm/virt-acpi-build.c             |  4 ++--
>> hw/i386/acpi-build.c                 |  8 ++++----
>> include/hw/acpi/bios-linker-loader.h |  3 ++-
>> 6 files changed, 34 insertions(+), 20 deletions(-)
>>=20
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 9fc54c9..03b6c6c 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -1626,7 +1626,7 @@ build_rsdt(GArray *table_data, BIOSLinker =
*linker, GArray *table_offsets,
>>         /* rsdt->table_offset_entry to be filled by Guest linker */
>>         bios_linker_loader_add_pointer(linker,
>>             ACPI_BUILD_TABLE_FILE, rsdt_entry_offset, =
rsdt_entry_size,
>> -            ACPI_BUILD_TABLE_FILE, ref_tbl_offset);
>> +            ACPI_BUILD_TABLE_FILE, ref_tbl_offset, false);
>>     }
>>     build_header(linker, table_data,
>>                  (void *)rsdt, "RSDT", rsdt_len, 1, oem_id, =
oem_table_id);
>> diff --git a/hw/acpi/bios-linker-loader.c =
b/hw/acpi/bios-linker-loader.c
>> index d963ebe..e46bc29 100644
>> --- a/hw/acpi/bios-linker-loader.c
>> +++ b/hw/acpi/bios-linker-loader.c
>> @@ -52,10 +52,13 @@ struct BiosLinkerLoaderEntry {
>>         } alloc;
>>=20
>>         /*
>> -         * COMMAND_ADD_POINTER - patch the table (originating from
>> -         * @dest_file) at @pointer.offset, by adding a pointer to =
the table
>> +         * COMMAND_ADD_POINTER &
>> +         * COMMAND_WRITE_POINTER - patch guest memory (originating =
from
>> +         * @dest_file) at @pointer.offset, by adding a pointer to =
the memory
>>          * originating from @src_file. 1,2,4 or 8 byte unsigned
>>          * addition is used depending on @pointer.size.
>> +         * Instead of patching memory, COMMAND_WRITE_POINTER writes =
the changes
>> +         * to @dest_file in QEMU via fw_cfg DMA.
>>          */
>>         struct {
>>             char dest_file[BIOS_LINKER_LOADER_FILESZ];
>> @@ -85,9 +88,10 @@ struct BiosLinkerLoaderEntry {
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
>> @@ -242,13 +246,15 @@ void bios_linker_loader_add_checksum(BIOSLinker =
*linker, const char *file_name,
>>  * @src_offset: location within source file blob to which
>>  *              @dest_file+@dst_patched_offset will point to after
>>  *              firmware's executed ADD_POINTER command
>> + * @write_back: guest should write change contents back to QEMU =
after patching
>>  */
>> void bios_linker_loader_add_pointer(BIOSLinker *linker,
>>                                     const char *dest_file,
>>                                     uint32_t dst_patched_offset,
>>                                     uint8_t dst_patched_size,
>>                                     const char *src_file,
>> -                                    uint32_t src_offset)
>> +                                    uint32_t src_offset,
>> +                                    bool write_back)
>> {
>>     uint64_t le_src_offset;
>>     BiosLinkerLoaderEntry entry;
>=20
> Frankly I prefer a new bios_linker_loader_write_pointer.
>=20
OK
>=20
>> @@ -257,8 +263,11 @@ void bios_linker_loader_add_pointer(BIOSLinker =
*linker,
>>     const BiosLinkerFileEntry *source_file =3D
>>         bios_linker_find_file(linker, src_file);
>>=20
>> -    assert(dst_patched_offset < dst_file->blob->len);
>> -    assert(dst_patched_offset + dst_patched_size <=3D =
dst_file->blob->len);
>> +    /* dst_file need not exist if writing back */
>=20
> Why not?
Because WRITE_POINTER can be called without having first called =
ALLOCATE.  In the Vm Generation ID example, there=E2=80=99s no reason =
for BIOS to allocate memory for the address fw_cfg, since it=E2=80=99s a =
construct that only matters to QEMU.  This is something that was =
requested by Laszlo.
>=20
>> +    if (!write_back) {
>> +        assert(dst_patched_offset < dst_file->blob->len);
>> +        assert(dst_patched_offset + dst_patched_size <=3D =
dst_file->blob->len);
>> +    }
>>     assert(src_offset < source_file->blob->len);
>>=20
>>     memset(&entry, 0, sizeof entry);
>> @@ -266,15 +275,19 @@ void bios_linker_loader_add_pointer(BIOSLinker =
*linker,
>>             sizeof entry.pointer.dest_file - 1);
>>     strncpy(entry.pointer.src_file, src_file,
>>             sizeof entry.pointer.src_file - 1);
>> -    entry.command =3D =
cpu_to_le32(BIOS_LINKER_LOADER_COMMAND_ADD_POINTER);
>> +    entry.command =3D cpu_to_le32(write_back ?
>> +                                =
BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER :
>> +                                =
BIOS_LINKER_LOADER_COMMAND_ADD_POINTER);
>>     entry.pointer.offset =3D cpu_to_le32(dst_patched_offset);
>>     entry.pointer.size =3D dst_patched_size;
>>     assert(dst_patched_size =3D=3D 1 || dst_patched_size =3D=3D 2 ||
>>            dst_patched_size =3D=3D 4 || dst_patched_size =3D=3D 8);
>>=20
>>     le_src_offset =3D cpu_to_le64(src_offset);
>> -    memcpy(dst_file->blob->data + dst_patched_offset,
>> -           &le_src_offset, dst_patched_size);
>> +    if (!write_back) {
>> +        memcpy(dst_file->blob->data + dst_patched_offset,
>> +               &le_src_offset, dst_patched_size);
>> +    }
>>=20
>>     g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
>> }
>> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
>> index 8e7d6ec..175996e 100644
>> --- a/hw/acpi/nvdimm.c
>> +++ b/hw/acpi/nvdimm.c
>> @@ -1266,7 +1266,7 @@ static void nvdimm_build_ssdt(GArray =
*table_offsets, GArray *table_data,
>>                              sizeof(NvdimmDsmIn), false /* high =
memory */);
>>     bios_linker_loader_add_pointer(linker,
>>         ACPI_BUILD_TABLE_FILE, mem_addr_offset, sizeof(uint32_t),
>> -        NVDIMM_DSM_MEM_FILE, 0);
>> +        NVDIMM_DSM_MEM_FILE, 0, false);
>>     build_header(linker, table_data,
>>         (void *)(table_data->data + nvdimm_ssdt),
>>         "SSDT", table_data->len - nvdimm_ssdt, 1, NULL, "NVDIMM");
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 07a10ac..a13f40d 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -380,7 +380,7 @@ build_rsdp(GArray *rsdp_table, BIOSLinker =
*linker, unsigned rsdt_tbl_offset)
>>     /* Address to be filled by Guest linker */
>>     bios_linker_loader_add_pointer(linker,
>>         ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
>> -        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
>> +        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset, false);
>>=20
>>     /* Checksum to be filled by Guest linker */
>>     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
>> @@ -684,7 +684,7 @@ static void build_fadt(GArray *table_data, =
BIOSLinker *linker,
>>     /* DSDT address to be filled by Guest linker */
>>     bios_linker_loader_add_pointer(linker,
>>         ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
>> -        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
>> +        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset, false);
>>=20
>>     build_header(linker, table_data,
>>                  (void *)fadt, "FACP", sizeof(*fadt), 5, NULL, NULL);
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 1c928ab..78a1d84 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -319,13 +319,13 @@ build_fadt(GArray *table_data, BIOSLinker =
*linker, AcpiPmInfo *pm,
>>     /* FACS address to be filled by Guest linker */
>>     bios_linker_loader_add_pointer(linker,
>>         ACPI_BUILD_TABLE_FILE, fw_ctrl_offset, =
sizeof(fadt->firmware_ctrl),
>> -        ACPI_BUILD_TABLE_FILE, facs_tbl_offset);
>> +        ACPI_BUILD_TABLE_FILE, facs_tbl_offset, false);
>>=20
>>     /* DSDT address to be filled by Guest linker */
>>     fadt_setup(fadt, pm);
>>     bios_linker_loader_add_pointer(linker,
>>         ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
>> -        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
>> +        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset, false);
>>=20
>>     build_header(linker, table_data,
>>                  (void *)fadt, "FACP", sizeof(*fadt), 1, oem_id, =
oem_table_id);
>> @@ -2262,7 +2262,7 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker =
*linker, GArray *tcpalog)
>>     /* log area start address to be filled by Guest linker */
>>     bios_linker_loader_add_pointer(linker,
>>         ACPI_BUILD_TABLE_FILE, log_addr_offset, log_addr_size,
>> -        ACPI_BUILD_TPMLOG_FILE, 0);
>> +        ACPI_BUILD_TPMLOG_FILE, 0, false);
>>=20
>>     build_header(linker, table_data,
>>                  (void *)tcpa, "TCPA", sizeof(*tcpa), 2, NULL, NULL);
>> @@ -2552,7 +2552,7 @@ build_rsdp(GArray *rsdp_table, BIOSLinker =
*linker, unsigned rsdt_tbl_offset)
>>     /* Address to be filled by Guest linker */
>>     bios_linker_loader_add_pointer(linker,
>>         ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
>> -        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
>> +        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset, false);
>>=20
>>     /* Checksum to be filled by Guest linker */
>>     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
>> diff --git a/include/hw/acpi/bios-linker-loader.h =
b/include/hw/acpi/bios-linker-loader.h
>> index fa1e5d1..d97e39d 100644
>> --- a/include/hw/acpi/bios-linker-loader.h
>> +++ b/include/hw/acpi/bios-linker-loader.h
>> @@ -24,7 +24,8 @@ void bios_linker_loader_add_pointer(BIOSLinker =
*linker,
>>                                     uint32_t dst_patched_offset,
>>                                     uint8_t dst_patched_size,
>>                                     const char *src_file,
>> -                                    uint32_t src_offset);
>> +                                    uint32_t src_offset,
>> +                                    bool write_back);
>>=20
>> void bios_linker_loader_cleanup(BIOSLinker *linker);
>> #endif
>> --=20
>> 2.7.4


--Apple-Mail=_451A438C-F6A0-43CE-84A2-096CB93DF73A
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
CQUxDxcNMTcwMjA2MTcxNjI1WjAjBgkqhkiG9w0BCQQxFgQUpYz4uODJspriBp3fl+7bptoqp/Iw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAc2cP8EWeILJ1CXh2Y+IMefCM2hte4lLwaLtgpv2bw6JwPuBqjwByvBlZ
mEZ8RYo9613lCg2JrazhyJMUAjhkNmLR+/200bwI73m0Qjjsu0cU/yccHOeKzMGNyNPbrpHq+T7m
clyCkOF4uBZFDZWdQYRRVQwx3V1LaJoVShBFriJbH33UZAS/otIHJX0gnrOUitkcaPzTXnj0D9+x
3tITYh1EMI7dAn+AGLNieOFv7J+gEaz8VxL4X6aORCzIgvHgOchI7hXMSIMUPvfMWKQnY9nLslvv
GwT4TXt/vTk20k7oQ8//tAQKGQaApB26kukIJqsdnQwhX/jq4UY0BfpKWwAAAAAAAA==
--Apple-Mail=_451A438C-F6A0-43CE-84A2-096CB93DF73A--
