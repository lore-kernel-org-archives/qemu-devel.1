Received: from eggs.gnu.org ([2001:4830:134:3::10]:47630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFHV-00032c-VY
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFHU-00063W-T7
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:11:05 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:34818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ceFHU-000635-MT
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:11:04 -0500
Received: by mail-oi0-x22e.google.com with SMTP id j15so3881466oih.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 22:11:04 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <F8CA5B90-142E-4CE9-B47C-32A1954C7075@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_AE827837-EFA4-4987-9B87-50E1C19F22E8";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 15 Feb 2017 22:11:02 -0800
In-Reply-To: <a155508d-4b44-6ca3-02cb-d36bb9b8f100@redhat.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<60b6ece3ce0a24aec79c1061627fa2e6ab058fc2.1487139038.git.ben@skyportsystems.com>
	<a155508d-4b44-6ca3-02cb-d36bb9b8f100@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 3/7] ACPI: Add vmgenid blob storage to
 the build tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com


--Apple-Mail=_AE827837-EFA4-4987-9B87-50E1C19F22E8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Feb 15, 2017, at 6:30 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 02/15/17 07:15, ben@skyportsystems.com wrote:
>> From: Ben Warren <ben@skyportsystems.com>
>>=20
>> This allows them to be centrally initialized and destroyed
>>=20
>> The "AcpiBuildTables.vmgenid" array will be used to construct the
>> "etc/vmgenid" fw_cfg blob.
>=20
> Trivial wart: the blob is now called "etc/vmgenid_guid".
>=20
> If you send a v7, feel free to fix it up. Not critical.
>=20
Fixed in v7
> My R-b stands.
>=20
> Thanks!
> Laszlo
>=20
>> Its contents will be linked into fw_cfg after being built on the
>> pc_machine_done() -> acpi_setup() -> acpi_build() call path, and =
dropped
>> without use on the subsequent, guest triggered, acpi_build_update() =
->
>> acpi_build() call path.
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>> hw/acpi/aml-build.c         | 2 ++
>> include/hw/acpi/aml-build.h | 1 +
>> 2 files changed, 3 insertions(+)
>>=20
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index b2a1e40..c6f2032 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -1559,6 +1559,7 @@ void acpi_build_tables_init(AcpiBuildTables =
*tables)
>>     tables->rsdp =3D g_array_new(false, true /* clear */, 1);
>>     tables->table_data =3D g_array_new(false, true /* clear */, 1);
>>     tables->tcpalog =3D g_array_new(false, true /* clear */, 1);
>> +    tables->vmgenid =3D g_array_new(false, true /* clear */, 1);
>>     tables->linker =3D bios_linker_loader_init();
>> }
>>=20
>> @@ -1568,6 +1569,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables =
*tables, bool mfre)
>>     g_array_free(tables->rsdp, true);
>>     g_array_free(tables->table_data, true);
>>     g_array_free(tables->tcpalog, mfre);
>> +    g_array_free(tables->vmgenid, mfre);
>> }
>>=20
>> /* Build rsdt table */
>> diff --git a/include/hw/acpi/aml-build.h =
b/include/hw/acpi/aml-build.h
>> index 559326c..00c21f1 100644
>> --- a/include/hw/acpi/aml-build.h
>> +++ b/include/hw/acpi/aml-build.h
>> @@ -210,6 +210,7 @@ struct AcpiBuildTables {
>>     GArray *table_data;
>>     GArray *rsdp;
>>     GArray *tcpalog;
>> +    GArray *vmgenid;
>>     BIOSLinker *linker;
>> } AcpiBuildTables;
>>=20
>>=20
>=20


--Apple-Mail=_AE827837-EFA4-4987-9B87-50E1C19F22E8
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
CQUxDxcNMTcwMjE2MDYxMTAzWjAjBgkqhkiG9w0BCQQxFgQUjL6quBqakmJtcoo0Tt2ukPVP/eAw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAFLBD5kSffPIdJ3L/nIuSRIuRQCyOSLp6JnKlKxgP20e+o2mUtaAtvRxN
VRVTosVzkdpMwr+Ppdl358ESHtnXuTqizefwC4Fvk+TTph8qHncpI2tcaY0b582B9d+le8gcO9he
F/Fo68JEWmF6Nv5fumup4ckyadlpiynQVfz5xA7DVMkTeQbdw3/XAZ47HBoBAN2IvONbiZIbbmy3
XSXw9aChVS/MBFyMb1rrRUnfexL4P/KPz4dPgnTuzEKW+V+06MLyvxpb0NJ8PtmCo/ae6XFFHqAA
MG/aST6XhZI01eZ01afcUb1yHEL1R18sKMf9OAX2OpW0SdHp4z1pxZxQVgAAAAAAAA==
--Apple-Mail=_AE827837-EFA4-4987-9B87-50E1C19F22E8--
