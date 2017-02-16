Received: from eggs.gnu.org ([2001:4830:134:3::10]:38539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cePUg-0005k5-1N
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cePUb-0003qP-Vq
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:05:22 -0500
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:36525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cePUb-0003qH-Ig
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:05:17 -0500
Received: by mail-pf0-x22e.google.com with SMTP id 189so6871710pfu.3
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 09:05:17 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <F9F54680-60AB-4519-B1B5-FA12653CA066@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_5C49B36E-B005-4023-AB8B-0073AD3D0246";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Thu, 16 Feb 2017 09:05:15 -0800
In-Reply-To: <20170216113627.759cc396@nial.brq.redhat.com>
References: <cover.1487224954.git.ben@skyportsystems.com>
	<56acb26636bb86ff1f04145c2911100f15e2689c.1487224954.git.ben@skyportsystems.com>
	<20170216113627.759cc396@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 7/8] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, mst@redhat.com


--Apple-Mail=_5C49B36E-B005-4023-AB8B-0073AD3D0246
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 16, 2017, at 2:36 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>=20
> On Wed, 15 Feb 2017 22:18:17 -0800
> ben@skyportsystems.com <mailto:ben@skyportsystems.com> wrote:
>=20
>> From: Ben Warren <ben@skyportsystems.com>
>>=20
>> The following tests are implemented:
>> * test that a GUID passed in by command line is propagated to the =
guest.
>>  Read the GUID both from guest memory and from the monitor
>> * test that the "auto" argument to the GUID generates a valid GUID, =
as
>>  seen by the guest.
>>=20
>>  This patch is loosely based on a previous patch from:
>>  Gal Hammer <ghammer@redhat.com>  and Igor Mammedov =
<imammedo@redhat.com>
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> ---
>> tests/Makefile.include |   2 +
>> tests/vmgenid-test.c   | 174 =
+++++++++++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 176 insertions(+)
>> create mode 100644 tests/vmgenid-test.c
>>=20
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 143507e..8d36341 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -241,6 +241,7 @@ check-qtest-i386-y +=3D =
tests/usb-hcd-xhci-test$(EXESUF)
>> gcov-files-i386-y +=3D hw/usb/hcd-xhci.c
>> check-qtest-i386-y +=3D tests/pc-cpu-test$(EXESUF)
>> check-qtest-i386-y +=3D tests/q35-test$(EXESUF)
>> +check-qtest-i386-y +=3D tests/vmgenid-test$(EXESUF)
>> gcov-files-i386-y +=3D hw/pci-host/q35.c
>> check-qtest-i386-$(CONFIG_VHOST_NET_TEST_i386) +=3D =
tests/vhost-user-test$(EXESUF)
>> ifeq ($(CONFIG_VHOST_NET_TEST_i386),)
>> @@ -726,6 +727,7 @@ tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o =
contrib/ivshmem-server/ivshmem
>> tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o =
contrib/libvhost-user/libvhost-user.o $(test-util-obj-y)
>> tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
>> tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
>> +tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/acpi-utils.o
>>=20
>> tests/migration/stress$(EXESUF): tests/migration/stress.o
>> 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o =
$@ $< ,"LINK","$(TARGET_DIR)$@")
>> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
>> new file mode 100644
>> index 0000000..1741455
>> --- /dev/null
>> +++ b/tests/vmgenid-test.c
>> @@ -0,0 +1,174 @@
>> +/*
>> + * QTest testcase for VM Generation ID
>> + *
>> + * Copyright (c) 2016 Red Hat, Inc.
>> + * Copyright (c) 2017 Skyport Systems
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include <glib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include "qemu/osdep.h"
>> +#include "qemu/bitmap.h"
>> +#include "qemu/uuid.h"
>> +#include "hw/acpi/acpi-defs.h"
>> +#include "acpi-utils.h"
>> +#include "libqtest.h"
>> +
>> +#define VGID_GUID "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
>> +#define VMGENID_GUID_OFFSET      40   /* allow space for
>> +                                       * OVMF SDT Header Probe =
Supressor
>> +                                       */
>> +
>> +typedef struct {
>> +    AcpiTableHeader header;
>> +    gchar name_op;
>> +    gchar vgia[4];
>> +    gchar val_op;
>> +    uint32_t vgia_val;
>> +} QEMU_PACKED VgidTable;
>> +
>> +static uint32_t acpi_find_vgia(void)
>> +{
>> +    uint32_t off;
>> +    AcpiRsdpDescriptor rsdp_table;
>> +    uint32_t rsdt;
>> +    AcpiRsdtDescriptorRev1 rsdt_table;
>> +    int tables_nr;
>> +    uint32_t *tables;
>> +    AcpiTableHeader ssdt_table;
>> +    VgidTable vgid_table;
>> +    int i;
>> +
>> +    off =3D acpi_find_rsdp_address();
>> +    g_assert_cmphex(off, <, 0x100000);
> something's off here,
> it fails for me for me with:
>=20
> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 =
tests/vmgenid-test
> /x86_64/vmgenid/vmgenid: **
> =
ERROR:/home/imammedo/builds/qemu/tests/vmgenid-test.c:47:acpi_find_vgia: =
assertion failed (off < 0x100000): (0x00100000 < 0x00100000)
>=20
Probably a timing issue.  I=E2=80=99ll get to the bottom of it ASAP

>> +
>> +    acpi_parse_rsdp_table(off, &rsdp_table);
>> +
>> +    rsdt =3D rsdp_table.rsdt_physical_address;
>> +    /* read the header */
>> +    ACPI_READ_TABLE_HEADER(&rsdt_table, rsdt);
>> +    ACPI_ASSERT_CMP(rsdt_table.signature, "RSDT");
>> +
>> +    /* compute the table entries in rsdt */
>> +    tables_nr =3D (rsdt_table.length - =
sizeof(AcpiRsdtDescriptorRev1)) /
>> +                sizeof(uint32_t);
>> +    g_assert_cmpint(tables_nr, >, 0);
>> +
>> +    /* get the addresses of the tables pointed by rsdt */
>> +    tables =3D g_new0(uint32_t, tables_nr);
>> +    ACPI_READ_ARRAY_PTR(tables, tables_nr, rsdt);
>> +
>> +    for (i =3D 0; i < tables_nr; i++) {
>> +        ACPI_READ_TABLE_HEADER(&ssdt_table, tables[i]);
>> +        if (!strncmp((char *)ssdt_table.oem_table_id, "VMGENID", 7)) =
{
>> +            /* the first entry in the table should be VGIA
>> +             * That's all we need
>> +             */
>> +            ACPI_READ_FIELD(vgid_table.name_op, tables[i]);
>> +            g_assert(vgid_table.name_op =3D=3D 0x08);  /* name */
>> +            ACPI_READ_ARRAY(vgid_table.vgia, tables[i]);
>> +            g_assert(memcmp(vgid_table.vgia, "VGIA", 4) =3D=3D 0);
>> +            ACPI_READ_FIELD(vgid_table.val_op, tables[i]);
>> +            g_assert(vgid_table.val_op =3D=3D 0x0C);  /* dword */
>> +            ACPI_READ_FIELD(vgid_table.vgia_val, tables[i]);
>> +            /* The GUID is written at a fixed offset into the fw_cfg =
file
>> +             * in order to implement the "OVMF SDT Header probe =
suppressor"
>> +             * see docs/specs/vmgenid.txt for more details
>> +             */
>> +            return vgid_table.vgia_val + VMGENID_GUID_OFFSET;
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>> +static void read_guid_from_memory(QemuUUID *guid)
>> +{
>> +    uint32_t vmgenid_addr;
>> +    int i;
>> +
>> +    vmgenid_addr =3D acpi_find_vgia();
>> +    g_assert(vmgenid_addr);
>> +
>> +    /* Read the GUID directly from guest memory */
>> +    for (i =3D 0; i < 16; i++) {
>> +        guid->data[i] =3D readb(vmgenid_addr + i);
>> +    }
>> +    /* The GUID is in little-endian format in the guest, while QEMU
>> +     * uses big-endian.  Swap after reading.
>> +     */
>> +    qemu_uuid_bswap(guid);
>> +}
>> +
>> +static void read_guid_from_monitor(QemuUUID *guid)
>> +{
>> +    QDict *rsp, *rsp_ret;
>> +    const char *guid_str;
>> +
>> +    rsp =3D qmp("{ 'execute': 'query-vm-generation-id' }");
>> +    if (qdict_haskey(rsp, "return")) {
>> +        rsp_ret =3D qdict_get_qdict(rsp, "return");
>> +        g_assert(qdict_haskey(rsp_ret, "guid"));
>> +        guid_str =3D qdict_get_str(rsp_ret, "guid");
>> +        g_assert(qemu_uuid_parse(guid_str, guid) =3D=3D 0);
>> +    }
>> +    QDECREF(rsp);
>> +}
>> +
>> +static void vmgenid_test(void)
>> +{
>> +    QemuUUID expected, measured;
>> +    gchar *cmd;
>> +
>> +    g_assert(qemu_uuid_parse(VGID_GUID, &expected) =3D=3D 0);
>> +
>> +    cmd =3D g_strdup_printf("-machine accel=3Dtcg -device =
vmgenid,id=3Dtestvgid,"
>> +                          "guid=3D%s", VGID_GUID);
>> +    qtest_start(cmd);
>> +
>> +    /* Read the GUID from accessing guest memory */
>> +    read_guid_from_memory(&measured);
>> +    g_assert(memcmp(measured.data, expected.data, =
sizeof(measured.data)) =3D=3D 0);
>> +
>> +    /* Read the GUID via the monitor */
>> +    read_guid_from_monitor(&measured);
>> +    g_assert(memcmp(measured.data, expected.data, =
sizeof(measured.data)) =3D=3D 0);
>> +
>> +    qtest_quit(global_qtest);
>> +    g_free(cmd);
>> +}
>> +
>> +static void vmgenid_set_guid_auto_test(void)
>> +{
>> +    const char *cmd;
>> +    QemuUUID measured;
>> +
>> +    cmd =3D "-machine accel=3Dtcg -device vmgenid,id=3Dtestvgid," =
"guid=3Dauto";
>> +    qtest_start(cmd);
>> +
>> +    read_guid_from_memory(&measured);
>> +
>> +    /* Just check that the GUID is non-null */
>> +    g_assert(!qemu_uuid_is_null(&measured));
>> +
>> +    qtest_quit(global_qtest);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    int ret;
>> +
>> +    g_test_init(&argc, &argv, NULL);
>> +
>> +    qtest_add_func("/vmgenid/vmgenid", vmgenid_test);
>> +    qtest_add_func("/vmgenid/vmgenid/set-guid-auto",
>> +                   vmgenid_set_guid_auto_test);
>> +    ret =3D g_test_run();
>> +
>> +    qtest_end();
>> +
>> +    return ret;
>> +}


--Apple-Mail=_5C49B36E-B005-4023-AB8B-0073AD3D0246
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
CQUxDxcNMTcwMjE2MTcwNTE1WjAjBgkqhkiG9w0BCQQxFgQUVJLiP8S6OTq8UZjacHX57Kqbgt8w
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAKVZRNqMjw8aCg9mcsOEeNySslK7k3UUcVG9pXc1krmU0nTHMNipZyym0
xNBW6ZsRtlSOxvqlDJfUiSJEp82yg1XDuzmyKOZDjTCjTFrZivol43csPq3iofhb7n502XYymYxk
ZVxYceTnO7ZWBLfALCSfMHpvuqUdEi/+40HlSBuMyYeLo1TWjTFvw2wB6pqYtWZRYS64XjcKjVXX
rOQgG0IdmuVubdu6EPNobPUKMZksxmJ76krbho/1RyG4IzilCaJ9ZNhn5IivnkDOCxGg2XrvxhKG
v5ksHWYRy9OUI2VF1pYGq2A4eDHuzQYLLd/amu+pjIsZT6GSoLpYqhmOCgAAAAAAAA==
--Apple-Mail=_5C49B36E-B005-4023-AB8B-0073AD3D0246--
