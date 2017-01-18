Received: from eggs.gnu.org ([2001:4830:134:3::10]:53125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTyUn-0005Kj-Vu
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTyUk-0002SE-TR
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:14:22 -0500
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:36747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cTyUk-0002Rc-I8
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:14:18 -0500
Received: by mail-pg0-x22a.google.com with SMTP id t6so7780938pgt.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:14:18 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <94E06BEE-6460-4DA5-A012-53804DCC3F0C@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_E03B0B23-9179-4661-BA48-2FB39411F658";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 18 Jan 2017 14:14:16 -0800
In-Reply-To: <20170118095556.1ff151cb@nial.brq.redhat.com>
References: <cover.1484593565.git.ben@skyportsystems.com>
	<625a11ec95fc51d4aae4811a06eab586454e1135.1484594095.git.ben@skyportsystems.com>
	<20170118095556.1ff151cb@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] qmp/hmp: add set-vm-generation-id
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org


--Apple-Mail=_E03B0B23-9179-4661-BA48-2FB39411F658
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jan 18, 2017, at 12:55 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>=20
> On Mon, 16 Jan 2017 11:20:57 -0800
> ben@skyportsystems.com <mailto:ben@skyportsystems.com> wrote:
>=20
>> From: Igor Mammedov <imammedo@redhat.com>
>>=20
>> Add set-vm-generation-id command to set Virtual Machine
>> Generation ID counter.
>>=20
>> QMP command example:
>>    { "execute": "set-vm-generation-id",
>>          "arguments": {
>>              "guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
>>          }
>>    }
>>=20
>> HMP command example:
>>    set-vm-generation-id guid=3D324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
> when you are reposting someone else written patch,
> you are supposed to keep SoB lines patch has had and just add
> your own SoB after original SoB lines.
>=20
> If you made non trivial change to the patch then ask
> original author(s) if they wish to keep their SoB
> before posting modified patch.
> (Usually I do it offline).
>=20
Yeah, this was a mistake on my part.  This is essentially your older =
patch rebased to ToT.  I meant to just append my SoB

>> ---
>> hmp-commands.hx  | 13 +++++++++++++
>> hmp.c            | 12 ++++++++++++
>> hmp.h            |  1 +
>> qapi-schema.json | 12 ++++++++++++
>> stubs/vmgenid.c  |  6 ++++++
>> 5 files changed, 44 insertions(+)
>>=20
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 8819281..56744aa 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -1775,5 +1775,18 @@ ETEXI
>>     },
>>=20
>> STEXI
>> +@item set-vm-generation-id @var{uuid}
>> +Set Virtual Machine Generation ID counter to @var{guid}
>> +ETEXI
>> +
>> +    {
>> +        .name       =3D "set-vm-generation-id",
>> +        .args_type  =3D "guid:s",
>> +        .params     =3D "guid",
>> +        .help       =3D "Set Virtual Machine Generation ID counter",
>> +        .cmd =3D hmp_set_vm_generation_id,
>> +    },
>> +
>> +STEXI
>> @end table
>> ETEXI
>> diff --git a/hmp.c b/hmp.c
>> index 9ec27ae..a54a312 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -2579,3 +2579,15 @@ void hmp_info_vm_generation_id(Monitor *mon, =
const QDict *qdict)
>>     }
>>     qapi_free_GuidInfo(info);
>> }
>> +
>> +void hmp_set_vm_generation_id(Monitor *mon, const QDict *qdict)
>> +{
>> +    Error *errp =3D NULL;
>> +    const char *guid =3D qdict_get_str(qdict, "guid");
>> +
>> +    qmp_set_vm_generation_id(guid, &errp);
>> +    if (errp) {
>> +        hmp_handle_error(mon, &errp);
>> +        return;
>> +    }
>> +}
>> diff --git a/hmp.h b/hmp.h
>> index 799fd37..e0ac1e8 100644
>> --- a/hmp.h
>> +++ b/hmp.h
>> @@ -138,5 +138,6 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const =
QDict *qdict);
>> void hmp_info_dump(Monitor *mon, const QDict *qdict);
>> void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>> void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
>> +void hmp_set_vm_generation_id(Monitor *mon, const QDict *qdict);
>>=20
>> #endif
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 2348391..c5ebea4 100644
>> --- a/qapi-schema.json
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
>> +{ 'command': 'set-vm-generation-id', 'data': {'guid': 'str'} }
>> diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
>> index 8c448ac..d25d41b 100644
>> --- a/stubs/vmgenid.c
>> +++ b/stubs/vmgenid.c
>> @@ -6,3 +6,9 @@ GuidInfo *qmp_query_vm_generation_id(Error **errp)
>>     error_setg(errp, "this command is not currently supported");
>>     return NULL;
>> }
>> +
>> +void qmp_set_vm_generation_id(const char *guid, Error **errp)
>> +{
>> +    error_setg(errp, "this command is not currently supported");
>> +    return;
>> +}


--Apple-Mail=_E03B0B23-9179-4661-BA48-2FB39411F658
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
CQUxDxcNMTcwMTE4MjIxNDE2WjAjBgkqhkiG9w0BCQQxFgQU79oUoZYdivdJx3qVKZIljIVOxQgw
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAU0YF9ngwJ74U14wh6slIaGccv0werASjn0ktW/W423/yQ6TkqaZQsGmk
vqZRpcaXLDH4BT+AC1U+qL37O+9m7ZG6/H/VkMJTHZiDo2fs28iFL5ENFd43fz/HUJDw8m5X+wtT
tWhP7rNiuDnrX90wt0AoGUuSOwx68JS8BH/bDhdDh9iHxLAsOFXcokvyRQl58AOw+c8PlQ2Z7uiU
VlR3w/Dcjb/5HJ3H3C5w8dAXoKRfgMKriL7CKhUbyQ7fmPGdoEoh3DE/Mu5v/wzxSz4vUuRMptpX
8UKA41yg5C2S1znbIbcWODN38/DS3Ka87jIDnnSm0x8Psqwtnn5wAVE6fwAAAAAAAA==
--Apple-Mail=_E03B0B23-9179-4661-BA48-2FB39411F658--
