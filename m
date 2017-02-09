Received: from eggs.gnu.org ([2001:4830:134:3::10]:38336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cbvVC-0000gJ-M8
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cbvV9-0004lS-Fj
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:39:38 -0500
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:36576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cbvV9-0004kR-6E
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:39:35 -0500
Received: by mail-pf0-x235.google.com with SMTP id 189so3052339pfu.3
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 12:39:33 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <0B9E0F74-743C-4223-8D50-0166EB6D3324@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_4C30EE75-F944-4C20-9B1A-12B367CEC43E";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Thu, 9 Feb 2017 12:39:30 -0800
In-Reply-To: <38ac53a6-3f10-a4ea-073e-2a65450f4f71@redhat.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
	<14f224ed-08e2-cbad-9d1d-8f559cd399a6@redhat.com>
	<20170209182316.71d5df5f@nial.brq.redhat.com>
	<e23ba6e2-10b6-0cd2-b42c-0a4c66c706d6@redhat.com>
	<46B6079A-029E-4207-BDE9-354E9B1698D3@skyportsystems.com>
	<38ac53a6-3f10-a4ea-073e-2a65450f4f71@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 05/10] ACPI: Add Virtual Machine
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
Cc: Igor Mammedov <imammedo@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org


--Apple-Mail=_4C30EE75-F944-4C20-9B1A-12B367CEC43E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 9, 2017, at 12:24 PM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 02/09/17 21:02, Ben Warren wrote:
>>=20
>>> On Feb 9, 2017, at 11:27 AM, Laszlo Ersek <lersek@redhat.com
>>> <mailto:lersek@redhat.com>> wrote:
>>>=20
>>> On 02/09/17 18:23, Igor Mammedov wrote:
>>>> On Wed, 8 Feb 2017 01:48:42 +0100
>>>> Laszlo Ersek <lersek@redhat.com <mailto:lersek@redhat.com>> wrote:
>>>>=20
>>>>> On 02/05/17 10:12, ben@skyportsystems.com
>>>>> <mailto:ben@skyportsystems.com> wrote:
>>>>>> From: Ben Warren <ben@skyportsystems.com
>>>>>> <mailto:ben@skyportsystems.com>>
>>>> [...]
>>>>=20
>>>>> (2) Structure of the vmgenid fw_cfg blob, AKA "why that darn =
offset 40
>>>>> decimal".
>>>>>=20
>>>>> I explained it under points (6) and (7) in the following message:
>>>>>=20
>>>>> Message-Id: <c16a03d5-820a-f719-81ea-43858f903395@redhat.com
>>>>> <mailto:c16a03d5-820a-f719-81ea-43858f903395@redhat.com>>
>>>>> URL: =
https://www.mail-archive.com/qemu-devel@nongnu.org/msg425226.html
>>>>>=20
>>>>> The story is that *wherever* an ADD_POINTER command points to -- =
that
>>>>> is, at the *exact* target address --, OVMF will look for an ACPI =
table
>>>>> header, somewhat heuristically. If it finds a byte pattern that =
(a) fits
>>>>> into the remaining blob and (b) passes some superficial ACPI table
>>>>> header checks, such as length and checksum, then OVMF assumes that =
the
>>>>> blob contains an ACPI table there, and passes the address (again, =
the
>>>>> exact, relocated, absolute target address of ADD_POINTER) to
>>>>> EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable().
>>>>>=20
>>>>> We want to disable this heuristic for the vmgenid blob. *If* the =
blob
>>>>> contained only 16 bytes (for the GUID), then the heuristic would
>>>>> automatically disable itself, because the ACPI table header (36 =
bytes)
>>>>> is larger than 16 bytes, so OVMF wouldn't even look. However, for =
the
>>>>> caching and other VMGENID requirements, we need to allocate a full =
page
>>>>> with the blob (4KB), hence OVMF *will* look. If we placed the GUID =
right
>>>>> at the start of the page, then OVMF would sanity-check it as an =
ACPI
>>>>> table header. The check would *most likely* not pass, so things =
would be
>>>>> fine in practice, but we can do better than that: just put 40 zero =
bytes
>>>>> at the front of the blob.
>>>>>=20
>>>>> And this is why the ADD_POINTER command has to point to the =
beginning of
>>>>> the blob (i.e., 36 zero bytes), to "suppress the OVMF ACPI SDT =
header
>>>>> detection". (The other 4 bytes are for arriving at an address =
divisible
>>>>> by 8, which is a VMGENID requirement for the GUID.)
>>>>>=20
>>>>> The consequence is that both the ADDR method and QEMU's guest =
memory
>>>>> access code have to add 40 manually.
>>>> The longer I look "suppress the OVMF ACPI SDT header detection",
>>>> the less I like approach.
>>>>=20
>>>> It looks somewhat backwards where a firmware forces QEMU
>>>> to use non obvious offsets to workaround OVMF ACPI table detection
>>>> heuristics.
>>>=20
>>> This is for historical reasons -- when the linker/loader commands =
were
>>> invented, it wasn't considered that in UEFI, ACPI tables cannot just =
be
>>> linked together in-place, instead they'd have to be passed to
>>> EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() one by one, for copying. =
The
>>> commands didn't provide dedicated means for identifying individual
>>> tables in blobs. Hence the heuristics built upon ADD_POINTER.
>>>=20
>>> And once you have heuristics, you want to suppress them =
occasionally, if
>>> you can find a way.
>>>=20
>>>> Can we add and use explicit flag to mark blobs as ACPI tables,
>>>> so that OVMF won't have to guess whether to hand off table
>>>> as ACPI to UEFI stack or just keep it to yourself?
>>>=20
>>> The ADD_POINTER-based heuristics cannot be turned off for ACPI table
>>> identification, because a single fw_cfg blob can (and does) contain
>>> multiple ACPI tables, and OVMF needs to figure out, somehow, where =
each
>>> of those tables start. Blob-level hints won't help with this.
>>>=20
>>> The following could be an improvement though: a blob-level hint =
(perhaps
>>> in the ALLOCATE command) that the blob contains *no* ACPI tables. In
>>> this case, OVMF could turn off the table recognition heuristics for
>>> those ADD_POINTER commands that point into such blobs. (Plus mark =
the
>>> blob for permanent preservation at once, and not only when an
>>> ADD_POINTER "probe" into the blob fails.)
>>>=20
>>> OVMF currently ignores the Zone field in the ALLOCATE command, so =
that
>>> could be extended / abused for such a hint, without breaking
>>> compatibility with OVMF. (Not sure about SeaBIOS.)
>>>=20
>> Overloading the ALLOCATE command in theory could be done with a =
simple
>> change to SeaBIOS.  Here=E2=80=99s where the zone is handled:
>>=20
>>    switch (entry->alloc_zone) {
>>        case ROMFILE_LOADER_ALLOC_ZONE_HIGH:
>>            zone =3D &ZoneHigh;
>>            break;
>>        case ROMFILE_LOADER_ALLOC_ZONE_FSEG:
>>            zone =3D &ZoneFSeg;
>>            break;
>>        default:
>>            goto err;
>>    }
>>=20
>> ZONE_HIGH =3D 1, and ZONE_FSEG =3D 2 and alloc_zone is 8 bits.  =
Stealing the
>> MSB and masking it off would be dirty, but could work.
>=20
> Even assuming that we don't horribly break cross-version compatibility
> with tricks like this, the problem is that such changes only look =
simple
> and easy in isolation. They add up, and their testing impact is not =
small.
>=20
> This week I've been working practically every waking moment -- I =
wanted
> to provide quick and detailed feedback (as far as OVMF was concerned)
> under both this series and on the topic of DSDT / X_DSDT /
> multiply-pointed-to tables. I'm also "racing you" to create a good
> quality OVMF series for WRITE_POINTER (including replay at S3 resume),
> so that as soon you post v6, we can test it together with OVMF too.
> (Last night I thought I had WRITE_POINTER ready, and started testing =
it
> against your v5, but then I suddenly thought of device reset and S3...
> Sigh.)
>=20
> We can certainly file RFEs for stuff like the above (maybe in RHBZ,
> maybe in Launchpad), but the scope creep is already significant for
> VMGENID (it's noone's fault, VMGENID has tentacles into everything).
> Igor's suggestion is good, it aims to decrease technical debt, but I'm
> grasping at cycles -- review is very time consuming (albeit just as
> necessary). Also, for QEMU, the 2.9 soft freeze is around the =
corner=E2=80=A6

OK, well I=E2=80=99m fine with things as they are.  I=E2=80=99ll try to =
get v6 out tomorrow.  This optimization can wait until later.

> Best I can recommend now is filing an RFE for this.
>=20
> Thanks
> Laszlo
>=20
>>> Otherwise, a new allocation command will be necessary. (Which should
>>> embed the current ALLOCATE command structure fully, at some offset.)
>>>=20
>>> Thanks
>>> Laszlo
>>=20
>=20


--Apple-Mail=_4C30EE75-F944-4C20-9B1A-12B367CEC43E
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
CQUxDxcNMTcwMjA5MjAzOTMxWjAjBgkqhkiG9w0BCQQxFgQUt4XyyveK5AJBVHQp3TC2vNToeMQw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAP/cpgKsq8uz8lgLohXrPz00Do0TgSQognNvqSL2IxdhTGeAzdDcAq7pO
JoaljK+L+pSdxQFh2RyLD+Q1ffjQAh6f0ZXcSgGBau0NQuSrTOcTd+zd7jKSWSjVHlBJOIpBWzer
K6WL0g33cOz8CaLdSkvCtge24uXi6ySDCwfmQb/f3NyuJyFSwiXm3k/W3yORl0TauEFDLBcr3mgs
md48CLYQG1fqc5xekRQ7403NZyxmoC9OJbnjKdJCpzMoQn3aTaG5LojbZS8rTUXQGBw3EWRy2Hpy
E/f43cNkFRupfY7peZ+C+dFQ48H5UccN45Wb4UPLvU/eG30QxtxxAaBmywAAAAAAAA==
--Apple-Mail=_4C30EE75-F944-4C20-9B1A-12B367CEC43E--
