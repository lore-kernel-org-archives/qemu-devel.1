Received: from eggs.gnu.org ([2001:4830:134:3::10]:55410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cJO8b-0002OZ-OI
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cJO8Z-0002Ex-0c
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:23:41 -0500
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:35274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cJO8Y-0002En-NH
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:23:38 -0500
Received: by mail-pg0-x236.google.com with SMTP id i5so9972817pgh.2
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 09:23:38 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <A8668167-7B89-4DE3-A6E3-6591DEBC46E0@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_C800E94D-BF02-4D8E-828A-C2EB6923FC73";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Date: Tue, 20 Dec 2016 09:23:36 -0800
In-Reply-To: <9b8edae8-b08d-7413-af41-39c854b8b696@redhat.com>
References: <cover.1482187052.git.ben@skyportsystems.com>
	<d73fe3d84b15c6bda193c709ed11d9335f99d9f8.1482187052.git.ben@skyportsystems.com>
	<9b8edae8-b08d-7413-af41-39c854b8b696@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] qmp/hmp: add set-vm-generation-id
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>


--Apple-Mail=_C800E94D-BF02-4D8E-828A-C2EB6923FC73
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Eric,
> On Dec 20, 2016, at 6:36 AM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 12/19/2016 04:46 PM, ben@skyportsystems.com =
<mailto:ben@skyportsystems.com> wrote:
>> From: Igor Mammedov <imammedo@redhat.com>
>>=20
>> Add set-vm-generation-id command to set Virtual Machine
>> Generation ID counter.
>>=20
>> QMP command example:
>>    { "execute": "set-vm-generation-id",
>>          "arguments": {
>>              "changed": true,
>>              "guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
>>          }
>>    }
>>=20
>> HMP command example:
>>    set-vm-generation-id changed=3Dtrue =
guid=3D324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> ---
>=20
>> +++ b/qapi-schema.json
>> @@ -4796,3 +4796,15 @@
>> # Since 2.9
>> ##
>> { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>> +
>> +##
>> +# @set-vm-generation-id
>> +#
>> +# Set Virtual Machine Generation ID
>> +#
>> +# @changed: Is the Virtual Machine Generation ID a new value?
>> +# @guid: new GUID to set as Virtual Machine Generation ID
>> +#
>> +# Since 2.9
>> +##
>> +{ 'command': 'set-vm-generation-id', 'data': { 'changed': 'bool', =
'guid': 'str' } }
>=20
> When should 'changed' ever be set to false?  Should it be an optional
> parameter, defaulting to true, if it is even needed?
>=20
Let me explain the intent, then we can talk about implementation.  I =
apologize if this is stuff you already know.  The purpose of VM =
Generation ID in Windows is to detect time rollbacks.  Active Directory =
in particular can get out of sync in hard-to-debug ways.  VM Generation =
ID is supposed to help with this, in that it tells Windows that a time =
rollback has occurred and therefore its AD data is =E2=80=9Cdirty=E2=80=9D=
 and must be =E2=80=9Cpull-synced=E2=80=9D from its replication =
partners.  The problem is that this replication can be quite costly in =
large installations, so I want to only do it if necessary.  So the =
answer to your question is that =E2=80=9Cchanged=E2=80=9D will be false =
most of the time, and will be set to true only in a couple of =
situations: new VM instantiation and snapshot rollback.  It=E2=80=99s up =
to the managing service (libvirt or custom SW, I guess) to manage the =
lifecycle of a VM and set this flag accordingly.

Now, the VM Generation ID spec identifies an ACPI Notify operation that =
is bound to the VM Generation ID ACPI object.  I have this GPE only =
being set if the =E2=80=98changed=E2=80=99 variable is true.  I don=E2=80=99=
t know enough about ACPI to know if this is the right approach, and will =
be doing as much testing within Windows to see if this does what I want, =
but as I=E2=80=99m sure you know Windows is pretty opaque and it=E2=80=99s=
 not always obvious how to get the relevant information.

I have both Hyper-V and Xen setups available and am trying to emulate =
the Hyper-V one since we should probably consider it to be a reference =
design.  I know Xen just sets this thing blindly and we can do better =
than that.

> --=20
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org =
<http://libvirt.org/>
=E2=80=94Ben


--Apple-Mail=_C800E94D-BF02-4D8E-828A-C2EB6923FC73
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
CQUxDxcNMTYxMjIwMTcyMzM2WjAjBgkqhkiG9w0BCQQxFgQU83kCvxpWNi2tKscjiztHtisb6r0w
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAO04zW8JGGZ2xygk9Q+IUoikeBtWCSaB9G8irWo1KsCljGz4kBoCHS8r2
w5eQBbYBBLKg8kJ1NLhhR3qbL97rbgOL4v/ix2v1xEoDhx7SNBeGenqJBnWskHzQDo10o1f5rGas
BcZNNJ5hJX/Xu+4Kt20oj9WMQGsMf7qL5TcSxXwMa/riEYiF7CZOhA11CQMdMc3kVRszOoFeFtOj
Sv2iOC2Yyccp+5d5JNeQZxXsKEPbzNPYWxqKVBOr7GVIt6hAGvtr5eRUowVtpvKX2MgANsQ7RFUv
ApOmktTXGY9XRivRMlTuqtIJOrF5a49FQkXLq3J5V8H1mJodAmYqdXoGUgAAAAAAAA==
--Apple-Mail=_C800E94D-BF02-4D8E-828A-C2EB6923FC73--
