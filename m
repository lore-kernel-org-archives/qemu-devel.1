Received: from eggs.gnu.org ([2001:4830:134:3::10]:47542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFGk-0002e9-Ld
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFGj-0005lx-EL
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:10:18 -0500
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:36608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ceFGj-0005lj-6s
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:10:17 -0500
Received: by mail-oi0-x233.google.com with SMTP id u143so3844460oif.3
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 22:10:17 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <088D760B-A48E-4B79-9177-C63753C306D6@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_ACAC52A9-F437-49E6-9E08-A5A351C31376";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 15 Feb 2017 22:10:14 -0800
In-Reply-To: <e7e9cf57-a5b4-4f2b-36e5-3e08dee70d68@redhat.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<678c203f-3768-7e65-6e48-6729473b6ffa@redhat.com>
	<20170215220837-mutt-send-email-mst@kernel.org>
	<e7e9cf57-a5b4-4f2b-36e5-3e08dee70d68@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/7] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com


--Apple-Mail=_ACAC52A9-F437-49E6-9E08-A5A351C31376
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 15, 2017, at 12:52 PM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> On 02/15/17 21:09, Michael S. Tsirkin wrote:
>> On Wed, Feb 15, 2017 at 08:47:48PM +0100, Laszlo Ersek wrote:
>=20
> [snip]
>=20
>>> For patches #1, #3, #4 and #5:
>>>=20
>>> Tested-by: Laszlo Ersek <lersek@redhat.com>
>>>=20
>>> I'll soon post the OVMF patches.
>>>=20
>>> Thanks!
>>> Laszlo
>>=20
>>=20
>> How do you feel about Igor's request to change WRITE_POINTER to add
>> offset in there, so guest can pass in the address of GUID and
>> not start of table? Would that be a lot of work to add?
>=20
> I think it's doable in practice: simply add a constant from the =
command
> itself, for passing the value back to QEMU, and also for saving the
> fw_cfg write commend for S3 resume time.
>=20
> But, I disagree with it from a design POV.
>=20
> Igor's point is:
>=20
>> Math complicates QEMU code though and not only QMEMU but AML code as
>> well.
>=20
> As I understand it, the goal is to push the addition to the firmware
> (which is "one place"), rather than having to implement it twice in
> QEMU, i.e., in two places ((a) native QEMU logic, (b) AML generator).
>=20
> Here's my counter-argument:
>=20
> (a) As I mentioned earlier, assume a complex communication structure
> between the guest OS and QEMU. Currently our shared structure consists
> of a single field (the GUID), but next time it might contain several =
fields.
>=20
> For such a multi-field shared structure, QEMU will have to do manual
> offsetting into the guest RAM anyway, for accessing fields F1, F2, and
> F3. We will not create three separate WRITE_POINTER commands and let =
the
> firmware calculate and return the absolute GPAs of the fields F1, F2 =
and
> F3. Instead, there will be one WRITE_POINTER command, and QEMU will do
> the offsetting manually, minimally for fields F2 and F3.
>=20
> "src_offset" looks tempting now only because we have a shared =
structure
> with only one field, the GUID at offset 40 decimal.
>=20
> (b) Regarding the runtime addition in the AML code:
>=20
> As discussed before, the main reason *now*, for not pointing VGIA (and
> other named integer objects) with ADD_POINTER commands directly to
> "meaningful" fields, is that OVMF probes the targets of ADD_POINTER
> commands for patterns that look like ACPI table headers. And, for the
> time being, we want to suppress any mis-recognitions by prepending =
some
> padding.
>=20
> Igor was right to dislike this, and we agreed that *down the road* we
> should add allocation flags, or further allocation commands, to =
supplant
> this kind of heuristics in OVMF. But:
>=20
> - we don't have time to do it now, plus
>=20
> - please observe that the runtime addition in AML relates to the
>  ADD_POINTER and the ALLOCATE commands. It does not relate to
>  WRITE_POINTER at all.
>=20
>  Whatever we change on WRITE_POINTER will do nothing for suppressing
>  OVMF's table header probing -- because that is tied to ADD_POINTER
>  --, therefore WRITE_POINTER tweaks cannot eliminate the "need to add"
>  in AML.
>=20
>=20
> In summary, I think the proposed WRITE_POINTER modification is
> implementable, but I think it will not pay off, because:
>=20
> (a) for QEMU logic, it will not prove useful as soon as we have a
> multi-field shared structure (QEMU will have to add field offsets =
anyway),
>=20
> (b) and for eliminating the AML addition (which is a consequence of =
the
> current ADD_POINTER handling in OVMF), it does nothing.
>=20
OK Laszlo, in v7 (imminent)  I went ahead and implemented this =
src_offset.  If you are truly dead-set against it, it=E2=80=99s not very =
hard to remove.  To me it seems pretty harmless.

> Thanks
> Laszlo


--Apple-Mail=_ACAC52A9-F437-49E6-9E08-A5A351C31376
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
CQUxDxcNMTcwMjE2MDYxMDE0WjAjBgkqhkiG9w0BCQQxFgQU3okzwauaP9SbPrEPCvnzfllAQesw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEATmLH+KmUczp+5cTmUm1NFGxiUPLoOSMm34pW4S1p1gFrXNlknSnqHcP3
9Ei2c2HcwLo9sOGvCy8O1Q2YGmJb3GjGUiqMWYgh5SYueuCYjvlg36AFGqn86MyXU0YCz24syUzZ
oyQtZMOw7z5cWOxEdPKi6pZUAaGIU6n7BBhMDT4Igy64rdWnc3Nuh2KlupVE4wIfbywOkJM+c472
Wmkz498u/k7rwVips5CnQFuTd5FdHSKwD/WlrXuxtbOLEzSiaakaa9ZHhMXXhZeSqYh8JwoValsS
RJ0SIHb0augxnIxrCnH25khA2nb9Ux3iqauMHsiSfuZAwEmwm6c5Fk8JIAAAAAAAAA==
--Apple-Mail=_ACAC52A9-F437-49E6-9E08-A5A351C31376--
