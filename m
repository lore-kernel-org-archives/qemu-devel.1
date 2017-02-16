Received: from eggs.gnu.org ([2001:4830:134:3::10]:45111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceQrS-00077f-DS
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceQrP-0004Ag-9X
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:32:58 -0500
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:33225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ceQrP-0004Aa-0x
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:32:55 -0500
Received: by mail-pg0-x22d.google.com with SMTP id y6so4613072pgy.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 10:32:54 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <41F19D95-ED58-427E-944A-00F872F8DD48@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_018EEF1B-71FE-43F4-93A0-944E93ECFDC6";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Thu, 16 Feb 2017 10:32:52 -0800
In-Reply-To: <20170216105649.43944bad@nial.brq.redhat.com>
References: <cover.1487224954.git.ben@skyportsystems.com>
	<625570854359178b416000644f68695bc50630ae.1487224954.git.ben@skyportsystems.com>
	<20170216105649.43944bad@nial.brq.redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, mst@redhat.com


--Apple-Mail=_018EEF1B-71FE-43F4-93A0-944E93ECFDC6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 16, 2017, at 1:56 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>=20
> On Wed, 15 Feb 2017 22:18:14 -0800
> ben@skyportsystems.com wrote:
>=20
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
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>=20
> Thing to get fixed on top is to check
> that there isn't vmgenid device present already
> into realizefn() and fail gracefully is there is.
>=20
I made the change as follows:
=3D=3D=3D

diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index c8465df..fa3de6d 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -207,8 +207,15 @@ static void vmgenid_handle_reset(void *opaque)
=20
 static void vmgenid_realize(DeviceState *dev, Error **errp)
 {
+    static bool is_realized =3D false;
     VmGenIdState *vms =3D VMGENID(dev);
+
+    if (is_realized) {
+        error_setg(errp, "Device %s may only be specified once",
+                   VMGENID_DEVICE);
+    }
     qemu_register_reset(vmgenid_handle_reset, vms);
+    is_realized =3D true;
 }

=3D=3D=3D
Sample output:
$ ../workspace/qemu/x86_64-softmmu/qemu-system-x86_64 -nographic -bios =
../workspace/seabios/out/bios.bin -machine type=3Dq35 -hda =
beiwe-with-vmgenid-driver.qcow2 -qmp unix:./qmp-sock,server,nowait =
-device vmgenid,guid=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb66" -device =
vmgenid,guid=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb67"
qemu-system-x86_64: -device =
vmgenid,guid=3D324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb67: Device vmgenid may =
only be specified once


Good enough?  If so, I=E2=80=99ll roll it in.  Otherwise, it=E2=80=99ll =
be a supplemental patch.

=E2=80=94Ben

<snip>=

--Apple-Mail=_018EEF1B-71FE-43F4-93A0-944E93ECFDC6
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
CQUxDxcNMTcwMjE2MTgzMjUyWjAjBgkqhkiG9w0BCQQxFgQUMlKCHqn7LzcOMEq8s55cUVpqX5Aw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAfVwp7AlbGm7Lkw/7jLV+7AEEtB9nrV7FpTzmbb93Wlc32t3IUZMFu4oM
jt05m1OBuv4TMHlV9Y3PQ6G6DPw9+ci7HnNQ1Y9Z13k2E5pOnRTN10R9/ZTue1ymc+HcBlpAEIK0
K89eQ5Gfla1dMM+IMw/DqZx0epnrenUH02LI91/c4RVL7SbnLinRl7nDyUhWAR55ZYbJ1vfDyLuf
eq1xE0o9E7lNqJ+3n/0VeAhO/SFqzH2VVQegLqTwSmH7GJ6hAZ1/zfWAqCEXEOwlSa5qup9XNxpZ
Okj2ufpwwccr0PAnRRaIyAhCWeWrws47h5Oa4I/jHrZPxSxRZx8lu8SqSgAAAAAAAA==
--Apple-Mail=_018EEF1B-71FE-43F4-93A0-944E93ECFDC6--
