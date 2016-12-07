Received: from eggs.gnu.org ([2001:4830:134:3::10]:34445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cERn5-0002kT-J2
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 21:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cERn0-0004XN-M9
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 21:17:03 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cERn0-0004No-CM
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 21:16:58 -0500
Received: by mail-pf0-f176.google.com with SMTP id d2so73790086pfd.0
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 18:16:36 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <D5FCB73B-435E-4423-B21C-BEEF1C1EA2FD@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_667DC3CE-38EE-4645-A307-EC303E32717B";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Date: Tue, 6 Dec 2016 18:15:34 -0800
In-Reply-To: <20161006041949-mutt-send-email-mst@kernel.org>
References: <CAO_EM_kuP9kk55bzxWqNOeuL8yW7gKNnacd1-UVGnJPyx2ZNYw@mail.gmail.com>
	<20160916033402-mutt-send-email-mst@kernel.org>
	<CAO_EM_mHyC7cywV4KUqH_MWwt2vVkK6GEOuaUX0FHpffdfaAuQ@mail.gmail.com>
	<20161006041949-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] Virtual Machine Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ed Swierk <eswierk@skyportsystems.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>


--Apple-Mail=_667DC3CE-38EE-4645-A307-EC303E32717B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Michael,

I=E2=80=99m well on my way to implementing this, but I am really new to =
the QEMU code base and am struggling with some concepts.  Please see =
below:
> On Oct 5, 2016, at 6:29 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Oct 04, 2016 at 03:51:40PM -0700, Ed Swierk wrote:
>> On Thu, Sep 15, 2016 at 5:36 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>> On Thu, Sep 15, 2016 at 05:23:28PM -0700, Ed Swierk wrote:
>>>> I'm wondering what it will take to finish up work on vmgenid.
>>>>=20
>>>> https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg05599.html
>>>=20
>>> We have ACPI_BUILD_TPMLOG_FILE in tree now and I think it could be
>>> allocated in a similar way.
>>> Integrate patch "fw-cfg: support writeable blobs" to communicate the
>>> allocated address back to QEMU.
>>=20
>> Starting with Igor's last version at
>> https://github.com/imammedo/qemu/commits/vmgen_wip , it's not clear =
to
>> me which changes need to be ported, which changes are obsoleted by
>> your new fw-cfg stuff and/or upstream churn in ACPI, device
>> properties, etc. In particular ACPI is still a total mystery to me,
>> though passing a single address from guest to host can't be that =
hard,
>> can it?
>>=20
>> Any clues would be appreciated.
>>=20
>> --Ed
>=20
> It might be best to just re-start from the beginning.
> So the idea is that ACPI should be about supplying the address
> to guest. To supply address to host we'll use fw cfg.
> This would be new I think:
>=20
> - add support for writeable fw cfg blobs
patch applied
> - add linker/loader command to write address of a blob into
>  such a fw cfg file
> - add a new file used for vm gen id, use loader command above
>  to pass the address of a blob allocated for it to host
I don=E2=80=99t really understand the meaning of =E2=80=9Cfile=E2=80=9D =
in this context.  It seems to be a way of specifying individual fw_cfg =
entries without explicitly giving an index, but is not something that is =
visible in either the host or guest file system.  Is this about right?  =
In my code I=E2=80=99m using =E2=80=9C/etc/vmgenid=E2=80=9D

As for the blob, I=E2=80=99m thinking this is where my main problem is.  =
The =E2=80=98fw_cfg_add_*()=E2=80=99 functions take a data pointer but =
doesn=E2=80=99t seem to copy the data anywhere.  We pass essentially a =
pointer via ACPI to the guest, so what it points to needs to be in an =
accessible region.  I don=E2=80=99t get how to define the blob contents. =
 There are command-line =E2=80=98fw-cfg=E2=80=99 options where you can =
specify a file, but it=E2=80=99s not clear to me how to use them.  Maybe =
I reserve some IO memory or something?
> - whenever vm gen id changes, update file, if we have address
>  of blob update that as well
Will do that once I understand the other parts
> - use linker to patch address of blob into acpi as well
>  it needs to be in a separate ssdt at top level
>  otherwise it's hard to figure out the offset.
I have this going into a separate SSDT and can decode it using iasl on =
the guest:
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
[root@playground ~]# cat SSDT.dsl=20
/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20150717-64
 * Copyright (c) 2000 - 2015 Intel Corporation
 *=20
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT, Tue Dec  6 16:35:14 2016
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000007C (124)
 *     Revision         0x01
 *     Checksum         0x29
 *     OEM ID           "BOCHS "
 *     OEM Table ID     "VMGENID"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "BXPC"
 *     Compiler Version 0x00000001 (1)
 */
DefinitionBlock ("SSDT.aml", "SSDT", 1, "BOCHS ", "VMGENID", 0x00000001)
{
    Scope (_SB)
    {
        Device (VGEN)
        {
            Name (_HID, "QEMU0003")  // _HID: Hardware ID
            Name (_CID, "VM_Gen_Counter")  // _CID: Compatible ID
            Name (_DDN, "VM_Gen_Counter")  // _DDN: DOS Device Name
            Name (ADDR, Package (0x02)
            {
                0xE7AAD010,=20
                0x559F
            })
        }
    }
}
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
The address you see is the address of the host memory where I have the =
GUID stored, so is obviously incorrect.

>=20
> This can be reused from one of the previus versions:
> - command line, interrupts and commands to update vm gen id
>=20
I have these all applied and can set/get the GUID via the QMP shell, and =
can pass GUID via QEMU command line.  As for parsing the input, I have =
it modeled as a device right on the sysbus.  Is this how it should be =
done, or would I pass the GUID in via the =E2=80=98fw_cfg=E2=80=99 =
command-line options, or something else?  It=E2=80=99s a bit problematic =
as-is because it depends on machine types that allow dynamic-sysbus.
> I can help with acpi if all the rest is clear.
>=20


> --=20
> MST
>=20
>=20
Sorry for being so dense - I think once I get the main concepts the rest =
of this should be straightforward.  I=E2=80=99m happy to post a patch of =
the current work if that would help.  Thanks in advance for your help.

=E2=80=94Ben=

--Apple-Mail=_667DC3CE-38EE-4645-A307-EC303E32717B
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
CQUxDxcNMTYxMjA3MDIxNTM0WjAjBgkqhkiG9w0BCQQxFgQU3i3B7ZvIdfyS3hwGgTF4whFbkZAw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAn3afPKdiWpnPpnA4ytSe9vxhpco9x397sS8A1Io4a5meMUSjcUbJMuoD
/DW+FMVIFpyEh9ENV6dHtY+yDHkFGafmxfYSlZRBSnBSVjufuxhp5xgsf1pA4dOADQLeFBeIXlda
Ogi209yCmJxVLDSOwoYyNP4Fn2P7h3v3Olqo7Uao3o2m+DCRyHvhGdWuw12+O5MyHoPmV0q76dP2
wfC0zu/oFz7WEAdNs6JKPwpOhQvNS3J57Gl0PcFrO5AEVtRsoMoDgdtUlmMH2chs1HN3v1LzjHJD
dN1uLAn5z2ZgcTo7tLSNmrbVIvkK0mRdcI0XnpgbpFdIduVUu/bzw8Gj5gAAAAAAAA==
--Apple-Mail=_667DC3CE-38EE-4645-A307-EC303E32717B--
