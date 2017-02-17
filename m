Received: from eggs.gnu.org ([2001:4830:134:3::10]:53973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cenMa-0005DE-A4
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cenMW-0002VN-Ve
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:34:36 -0500
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:34608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cenMW-0002Tv-IQ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:34:32 -0500
Received: by mail-pg0-x22c.google.com with SMTP id z67so17519236pgb.1
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 10:34:32 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <9B914CBD-40ED-46CF-9420-E7BB13EB6D1B@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_8410853C-C848-4354-AF73-DC616A4699F0";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Fri, 17 Feb 2017 10:34:29 -0800
In-Reply-To: <de706a53-137c-a49d-5765-4afecc5ce3d8@redhat.com>
References: <cover.1487286467.git.ben@skyportsystems.com>
	<88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<4F60B53E-1A5D-4D4C-954F-F1C3ED5B487C@skyportsystems.com>
	<de706a53-137c-a49d-5765-4afecc5ce3d8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine
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


--Apple-Mail=_8410853C-C848-4354-AF73-DC616A4699F0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 17, 2017, at 8:03 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 02/17/17 16:33, Ben Warren wrote:
>>=20
>>> On Feb 17, 2017, at 2:43 AM, Igor Mammedov <imammedo@redhat.com =
<mailto:imammedo@redhat.com>
>>> <mailto:imammedo@redhat.com <mailto:imammedo@redhat.com>>> wrote:
>>>=20
>>> On Thu, 16 Feb 2017 15:15:36 -0800
>>> ben@skyportsystems.com <mailto:ben@skyportsystems.com> =
<mailto:ben@skyportsystems.com <mailto:ben@skyportsystems.com>> wrote:
>>>=20
>>>> From: Ben Warren <ben@skyportsystems.com =
<mailto:ben@skyportsystems.com> <mailto:ben@skyportsystems.com =
<mailto:ben@skyportsystems.com>>>
>>>>=20
>>>> This implements the VM Generation ID feature by passing a 128-bit
>>>> GUID to the guest via a fw_cfg blob.
>>>> Any time the GUID changes, an ACPI notify event is sent to the =
guest
>>>>=20
>>>> The user interface is a simple device with one parameter:
>>>> - guid (string, must be "auto" or in UUID format
>>>>  xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
>>> I've given it some testing with WS2012R2 and v4 patches for Seabios,
>>>=20
>>> Windows is able to read initial GUID allocation and writeback
>>> seems to work somehow:
>>>=20
>>> (qemu) info vm-generation-id
>>> c109c09b-0e8b-42d5-9b33-8409c9dcd16c
>>>=20
>>> vmgenid client in Windows reads it as 2 following 64bit integers:
>>> 42d50e8bc109c09b:6cd1dcc90984339b
>>>=20
>>> However update path/restore from snapshot doesn't
>>> here is as I've tested it:
>>>=20
>>> qemu-system-x86_64 -device vmgenid,id=3Dtestvgid,guid=3Dauto =
-monitor stdio
>>> (qemu) info vm-generation-id
>>> c109c09b-0e8b-42d5-9b33-8409c9dcd16c
>>> (qemu) stop
>>> (qemu) migrate "exec:gzip -c > STATEFILE.gz"
>>> (qemu) quit
>>>=20
>>> qemu-system-x86_64 -device vmgenid,id=3Dtestvgid,guid=3Dauto =
-monitor stdio
>>> -incoming "exec: gzip -c -d STATEFILE.gz"
>>> (qemu) info vm-generation-id
>>> 28b587fa-991b-4267-80d7-9cf28b746fe9
>>>=20
>>> guest
>>> 1. doesn't get GPE notification that it must receive
>>> 2. vmgenid client in Windows reads the same value
>>>     42d50e8bc109c09b:6cd1dcc90984339b
>>>=20
>> Strange, this was working for me, but with a slightly different test =
method:
>>=20
>>  * I use virsh save/restore
>=20
> Awesome, this actually what I should try. All my guests are managed by
> libvirt (with the occasional <qemu:arg>, for development), and direct
> QEMU monitor commands such as
>=20
>  virsh qemu-monitor-command ovmf.rhel7 --hmp 'info vm-generation-id'
>=20
> only work for me if they are reasonably non-intrusive.
>=20
>>  * While I do later testing with Windows, during development I use a
>>    Linux kernel module I wrote that keeps track of GUID and
>>    notifications.  I=E2=80=99m happy to share this with you if =
interested.
>=20
> Please do. If you have a public git repo somewhere, that would be
> awesome. (Bonus points if the module builds out-of-tree, if the
> kernel-devel package is installed.)
>=20
Here you go:
https://github.com/ben-skyportsystems/vmgenid-test =
<https://github.com/ben-skyportsystems/vmgenid-test>

I don=E2=80=99t know if something like this would ever be accepted into =
the Linux kernel, but it has been invaluable to me, and I=E2=80=99d like =
to see it somewhere better.

> NB: while the set-id monitor command was part of the series, I did =
test
> it to the extent that I checked the SCI ("ACPI interrupt") count in =
the
> guest, in /proc/interrupts. I did see it increase, so minimally the =
SCI
> injection was fine.
>=20
> Thanks!
> Laszlo
>=20
>> I=E2=80=99ll dig into this morning.
>>=20
>> =E2=80=94Ben
>> <snip>


--Apple-Mail=_8410853C-C848-4354-AF73-DC616A4699F0
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
CQUxDxcNMTcwMjE3MTgzNDMwWjAjBgkqhkiG9w0BCQQxFgQU81/iXZPSR7DoTEqny8Dr5Xt4LOcw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAS3DsKr+4AoyJ8A2cXQH/G8WeSg+MEXSGoLb0//vBuOzLJHuCP4OlzIwL
v1MfO6Bmn0OsGgAguBJpNMD5ZlC+eLrOYG+48V8hsXOTbBAbEF17ey8KsWLnhSLkTxSCoccRwUpE
6Zj/e5Qp9WDM1C4c38StVjPPfdocLKTYB+dcYTWtgM46rSbYmJZD3kv3ZmClk8JdDthpdw13JmrQ
pkXVpKPeyNrEdTFvOIw1E9NA29HFvR6m3J72ymyvfBnJQRE34ssCpwMURtEafiUdfMYZBC3V4d0+
nnbMqb+DHLpb9RiyXK8spcWbIY0orh8tmBArZ20ZYapQFmrww8z1UpGovwAAAAAAAA==
--Apple-Mail=_8410853C-C848-4354-AF73-DC616A4699F0--
