Received: from eggs.gnu.org ([2001:4830:134:3::10]:48236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFLz-0006vw-KJ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFLw-0007vd-8b
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:15:43 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:35722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ceFLv-0007vZ-U0
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:15:40 -0500
Received: by mail-ot0-x22c.google.com with SMTP id 45so5227572otd.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 22:15:39 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <18E10853-B22E-457B-83EC-74AAC4DAEA6D@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_95F9D7B4-54D3-4724-BAAB-D892497E0F12";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 15 Feb 2017 22:15:37 -0800
In-Reply-To: <20170215141307.6e68b5f6@nial.brq.redhat.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<b126fbc5e3115a959c8a80c3217b0faf7b7e92d5.1487139038.git.ben@skyportsystems.com>
	<20170215141307.6e68b5f6@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 7/7] tests: Add unit tests for the VM
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


--Apple-Mail=_95F9D7B4-54D3-4724-BAAB-D892497E0F12
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 15, 2017, at 5:13 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>=20
> On Tue, 14 Feb 2017 22:15:49 -0800
> ben@skyportsystems.com <mailto:ben@skyportsystems.com> wrote:
>=20
>> From: Ben Warren <ben@skyportsystems.com>
>>=20
>> The following tests are implemented:
>> * test that a GUID passed in by command line is propagated to the =
guest.
>> * test that changing the GUID at runtime via the monitor is reflected =
in
>>  the guest.
>> * test that the "auto" argument to the GUID generates a different, =
and
>>  correct GUID as seen by the guest.
>>=20
>>  This patch is loosely based on a previous patch from:
>>  Gal Hammer <ghammer@redhat.com>  and Igor Mammedov =
<imammedo@redhat.com>
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> ---
>> tests/Makefile.include |   2 +
>> tests/vmgenid-test.c   | 195 =
+++++++++++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 197 insertions(+)
>> create mode 100644 tests/vmgenid-test.c
>>=20
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 634394a..ca4b3f7 100644
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
>> +tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o
>>=20
>> tests/migration/stress$(EXESUF): tests/migration/stress.o
>> 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o =
$@ $< ,"LINK","$(TARGET_DIR)$@")
>> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
>> new file mode 100644
>> index 0000000..721ba05
>> --- /dev/null
>> +++ b/tests/vmgenid-test.c
>> @@ -0,0 +1,195 @@
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
>> +static uint32_t vgia;
>> +
>> +typedef struct {
>> +    AcpiTableHeader header;
>> +    gchar name_op;
>> +    gchar vgia[4];
>> +    gchar val_op;
>> +    uint32_t vgia_val;
>> +} QEMU_PACKED VgidTable;
>> +
>> +static uint32_t find_vgia(void)
>> +{
> [...]
>=20
> =3D=3D=3D
>> +    /* First, find the RSDP */
>> +    for (off =3D 0xf0000; off < 0x100000; off +=3D 0x10) {
>> +        uint8_t sig[] =3D "RSD PTR ";
>> +
>> +        for (i =3D 0; i < sizeof sig - 1; ++i) {
>> +            sig[i] =3D readb(off + i);
>> +        }
>> +
>> +        if (!memcmp(sig, "RSD PTR ", sizeof sig)) {
>> +            break;
>> +        }
>> +    }
>> +    g_assert_cmphex(off, <, 0x100000);
>> +
>> +    /* Parse the RSDP header so we can find the RSDT */
>> +    ACPI_READ_FIELD(rsdp_table.signature, off);
>> +    ACPI_ASSERT_CMP64(rsdp_table.signature, "RSD PTR ");
>> +
>> +    ACPI_READ_FIELD(rsdp_table.checksum, off);
>> +    ACPI_READ_ARRAY(rsdp_table.oem_id, off);
>> +    ACPI_READ_FIELD(rsdp_table.revision, off);
>> +    ACPI_READ_FIELD(rsdp_table.rsdt_physical_address, off);
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
> =3D=3D=3D
> above is duplicated code from bios-tables-test.c
> please extract it into separate functions and use them in both tests.
>=20
Done in v7
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
>> +static void vmgenid_read_guid(QemuUUID *guid)
>> +{
>> +    int i;
>> +
>> +    if (vgia =3D=3D 0) {
>> +        vgia =3D find_vgia();
>> +    }
>> +    g_assert(vgia);
>> +
>> +    /* Read the GUID directly from guest memory */
>> +    for (i =3D 0; i < 16; i++) {
>> +        guid->data[i] =3D readb(vgia + i);
>> +    }
>> +    /* The GUID is in little-endian format in the guest, while QEMU
>> +     * uses big-endian.  Swap after reading.
>> +     */
>> +    qemu_uuid_bswap(guid);
>> +}
>> +
>> +static void vmgenid_test(void)
>> +{
>> +    QemuUUID expected, measured;
>> +    g_assert(qemu_uuid_parse(VGID_GUID, &expected) =3D=3D 0);
>> +    vmgenid_read_guid(&measured);
>> +    g_assert(memcmp(measured.data, expected.data, =
sizeof(measured.data)) =3D=3D 0);
>> +}
>> +
>> +static void vmgenid_set_guid_test(void)
>> +{
>> +    QDict *response;
>> +    gchar *cmd;
>> +    QemuUUID expected, measured;
>> +    g_assert(qemu_uuid_parse(VGID_GUID, &expected) =3D=3D 0);
>> +    /* Change the GUID slightly */
>> +    expected.data[0] +=3D 1;
>> +
>> +    cmd =3D g_strdup_printf("{ 'execute': 'qom-set', 'arguments': { =
"
>> +                   "'path': '/machine/peripheral/testvgid', "
>> +                   "'property': 'guid', 'value': '%s' } }",
>> +                   qemu_uuid_unparse_strdup(&expected));
>> +    response =3D qmp(cmd);
>> +    g_assert(qdict_haskey(response, "return"));
>> +    QDECREF(response);
>> +
>> +    vmgenid_read_guid(&measured);
>> +    g_assert(memcmp(measured.data, expected.data, =
sizeof(measured.data)) =3D=3D 0);
>> +}
>> +
>> +static void vmgenid_set_guid_auto_test(void)
>> +{
>> +    QDict *response;
>> +    QemuUUID expected, measured;
>> +
>> +    /* Read the initial value */
>> +    vmgenid_read_guid(&expected);
>> +
>> +    /* Setting to 'auto' generates a random GUID */
>> +    response =3D qmp("{ 'execute': 'qom-set', 'arguments': { "
>> +                   "'path': '/machine/peripheral/testvgid', "
>> +                   "'property': 'guid', 'value': 'auto' } }");
>> +
>> +    g_assert(qdict_haskey(response, "return"));
>> +    QDECREF(response);
>> +
>> +    vmgenid_read_guid(&measured);
>> +    g_assert(memcmp(measured.data, expected.data, =
sizeof(measured.data)) !=3D 0);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    int ret;
>> +    gchar *cmd;
>> +
>> +    g_test_init(&argc, &argv, NULL);
>> +
>> +    cmd =3D g_strdup_printf("-machine accel=3Dtcg -device =
vmgenid,id=3Dtestvgid,"
>> +                          "guid=3D%s", VGID_GUID);
>> +    qtest_start(cmd);
>> +    qtest_add_func("/vmgenid/vmgenid", vmgenid_test);
>> +    qtest_add_func("/vmgenid/vmgenid/set-guid", =
vmgenid_set_guid_test);
> this is probably no necessary as you've dropped dynamic set in v6,
> so if this test passes it's a bug in vmgenid and you should forbid
> setting property after device is realized.
> See how qdev_prop_set_after_realize() is used.
>=20
Removed
>> +    qtest_add_func("/vmgenid/vmgenid/set-guid-auto",
>> +                   vmgenid_set_guid_auto_test);
> this should be replaced with this first test but with 'auto' value
>=20
> maybe add query-vm-generation-id test
I added code to read from the monitor and compare to the value read from =
memory.  I hope that=E2=80=99s OK.
>=20
>> +    ret =3D g_test_run();
>> +
>> +    qtest_end();
>> +
>> +    return ret;
>> +}


--Apple-Mail=_95F9D7B4-54D3-4724-BAAB-D892497E0F12
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
CQUxDxcNMTcwMjE2MDYxNTM3WjAjBgkqhkiG9w0BCQQxFgQUSa1jvo7BqjXGUjnu4mEG+gUSbLcw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAb3IcxlDpEffGRDKwNCxBdNO46boSBhH2RHCcULqV96lOnYPvEIKds0wj
2IJDZ00vw9dypYxp/9u3khZ/lLX9HFIptDQWMgrAyXj1ZyHqAI7wrQEqJvCHvmTKsvvdExKAzS/E
FixP+JPAb6dZPi1CSKvNRMnW4hJPEz7jEmjPzaZfwwb+CWqylRSlXsXkEGrxJDF3tot1LniBHYKa
7n4I283kWw1JfMVXm4MyXv9zWzN82nu0LAcJYT9k5LNUukh4XyqKnuLMnneCZgUrW+L0QT2L9/Ls
gM9JX6RG6FFbB/Ko5/piTJEbKjUSKgqNO3i3sXgft4r5W0bfeSYmyzvOVwAAAAAAAA==
--Apple-Mail=_95F9D7B4-54D3-4724-BAAB-D892497E0F12--
