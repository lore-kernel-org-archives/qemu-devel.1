Received: from eggs.gnu.org ([2001:4830:134:3::10]:51841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceRN7-0007ST-15
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceRN3-0001Sq-Gj
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:05:41 -0500
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:34986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ceRN3-0001Rp-1V
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:05:37 -0500
Received: by mail-pg0-x22c.google.com with SMTP id t188so8412223pgt.2
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 11:05:36 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <3EC4A8B9-14CD-4F55-AD02-ED8D64372C01@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_C0DD0FD6-48B1-4945-8FE6-3FC4D8FF82A9";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Thu, 16 Feb 2017 11:05:33 -0800
In-Reply-To: <fb101b08-988a-494d-6ede-783ebe4ae4af@redhat.com>
References: <cover.1487224954.git.ben@skyportsystems.com>
	<625570854359178b416000644f68695bc50630ae.1487224954.git.ben@skyportsystems.com>
	<20170216105649.43944bad@nial.brq.redhat.com>
	<41F19D95-ED58-427E-944A-00F872F8DD48@skyportsystems.com>
	<fb101b08-988a-494d-6ede-783ebe4ae4af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/8] ACPI: Add Virtual Machine
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com


--Apple-Mail=_C0DD0FD6-48B1-4945-8FE6-3FC4D8FF82A9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 16, 2017, at 11:03 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 02/16/17 19:32, Ben Warren wrote:
>>=20
>>> On Feb 16, 2017, at 1:56 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>>>=20
>>> On Wed, 15 Feb 2017 22:18:14 -0800
>>> ben@skyportsystems.com wrote:
>>>=20
>>>> From: Ben Warren <ben@skyportsystems.com>
>>>>=20
>>>> This implements the VM Generation ID feature by passing a 128-bit
>>>> GUID to the guest via a fw_cfg blob.
>>>> Any time the GUID changes, an ACPI notify event is sent to the =
guest
>>>>=20
>>>> The user interface is a simple device with one parameter:
>>>> - guid (string, must be "auto" or in UUID format
>>>>  xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>>>>=20
>>>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>>=20
>>> Thing to get fixed on top is to check
>>> that there isn't vmgenid device present already
>>> into realizefn() and fail gracefully is there is.
>>>=20
>> I made the change as follows:
>> =3D=3D=3D
>>=20
>> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
>> index c8465df..fa3de6d 100644
>> --- a/hw/acpi/vmgenid.c
>> +++ b/hw/acpi/vmgenid.c
>> @@ -207,8 +207,15 @@ static void vmgenid_handle_reset(void *opaque)
>>=20
>> static void vmgenid_realize(DeviceState *dev, Error **errp)
>> {
>> +    static bool is_realized =3D false;
>>     VmGenIdState *vms =3D VMGENID(dev);
>> +
>> +    if (is_realized) {
>> +        error_setg(errp, "Device %s may only be specified once",
>> +                   VMGENID_DEVICE);
>> +    }
>>     qemu_register_reset(vmgenid_handle_reset, vms);
>> +    is_realized =3D true;
>> }
>>=20
>> =3D=3D=3D
>> Sample output:
>> $ ../workspace/qemu/x86_64-softmmu/qemu-system-x86_64 -nographic =
-bios ../workspace/seabios/out/bios.bin -machine type=3Dq35 -hda =
beiwe-with-vmgenid-driver.qcow2 -qmp unix:./qmp-sock,server,nowait =
-device vmgenid,guid=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb66" -device =
vmgenid,guid=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb67"
>> qemu-system-x86_64: -device =
vmgenid,guid=3D324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb67: Device vmgenid may =
only be specified once
>>=20
>>=20
>> Good enough?  If so, I=E2=80=99ll roll it in.  Otherwise, it=E2=80=99ll=
 be a supplemental patch.
>=20
> Ehm, I'd say let's postpone that patch. Function (or even file) scope
> static variables that plaster over QOM shortcomings (or, well,
> "non-trivial QOM patterns") are strongly frowned upon. I've done it
> myself before (totally as a last resort, really -- not kidding!), and =
it
> was real hard to get into the tree.
>=20
> This deserves more discussion, so please delay it.
>=20
> (While at it, please remember my other recommendation for realize():
> enforcing that the running machine type / version provides the guest
> with the DMA interface for fw_cfg. For that, based on prior consensus,
> you'll need another device property, to be set in parallel to
> fw_cfg_mem's and fw_cfg_io's "dma-enabled" property. So I think it =
makes
> sense to address all of these things in a separate, followup series.)
>=20
OK, makes sense.
> Thanks!
> Laszlo

=E2=80=94Ben


--Apple-Mail=_C0DD0FD6-48B1-4945-8FE6-3FC4D8FF82A9
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
CQUxDxcNMTcwMjE2MTkwNTM0WjAjBgkqhkiG9w0BCQQxFgQU2/z8HzYNH9WL9LE4ap0Mjhwso8cw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAlgDfiFEzy/6C29Nx3KbzVDqE7l7HohMFWHxWpe5Im93vgjegGUs98LtA
GvAfl5aotzjJ97eLbIq0sKPVFjyOK5cp7dn+KPEReKrsWjzfcqkf9BGcTIiO80rjrNGRD6oN/EER
tO/jksW20kucVCQ+0qXvy2+RnCXiT7ceDJAwOJ4btMc1y4t2WR+bD6b9HGIp3qniq5xZnwUhIBLC
NwOL1ne+QT9SI1h8Rmvv4gyqi9zve2dcv089d3tx2XQwo+nSWrcHFEGexXosjOUzfkhU/dcq69b4
Kb1X+OVG52xUmLH2SyTTnYsvSbE1rFwtjkmZ/zaWUKz1G02eXngAC1oDkgAAAAAAAA==
--Apple-Mail=_C0DD0FD6-48B1-4945-8FE6-3FC4D8FF82A9--
