Received: from eggs.gnu.org ([2001:4830:134:3::10]:48030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFKD-0005el-Gd
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:13:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFKB-0007NU-Ij
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:13:53 -0500
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:37860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ceFKB-0007NO-BC
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:13:51 -0500
Received: by mail-it0-x22c.google.com with SMTP id x75so13967124itb.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 22:13:51 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <CA4C0334-08DE-4455-A3BF-1C6AA5F03023@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_C1124983-A3DF-412B-A3B5-DA31901564E0";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 15 Feb 2017 22:13:49 -0800
In-Reply-To: <6845273b-aa91-c00c-bdf5-4353d5dbdd3a@redhat.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<fe5a0d87343f282cab0bedf0cca4d0bb2ad8b29c.1487139038.git.ben@skyportsystems.com>
	<6845273b-aa91-c00c-bdf5-4353d5dbdd3a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 5/7] qmp/hmp: add query-vm-generation-id
 and 'info vm-generation-id' commands
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


--Apple-Mail=_C1124983-A3DF-412B-A3B5-DA31901564E0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Feb 15, 2017, at 7:36 AM, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> Two questions:
>=20
> On 02/15/17 07:15, ben@skyportsystems.com =
<mailto:ben@skyportsystems.com> wrote:
>> From: Igor Mammedov <imammedo@redhat.com>
>>=20
>> Add commands to query Virtual Machine Generation ID counter.
>>=20
>> QMP command example:
>>    { "execute": "query-vm-generation-id" }
>>=20
>> HMP command example:
>>    info vm-generation-id
>>=20
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> ---
>> hmp-commands-info.hx | 13 +++++++++++++
>> hmp.c                |  9 +++++++++
>> hmp.h                |  1 +
>> hw/acpi/vmgenid.c    | 16 ++++++++++++++++
>> qapi-schema.json     | 20 ++++++++++++++++++++
>> stubs/Makefile.objs  |  1 +
>> stubs/vmgenid.c      |  8 ++++++++
>> 7 files changed, 68 insertions(+)
>> create mode 100644 stubs/vmgenid.c
>>=20
>> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
>> index b0f35e6..f3df793 100644
>> --- a/hmp-commands-info.hx
>> +++ b/hmp-commands-info.hx
>> @@ -802,6 +802,19 @@ Show information about hotpluggable CPUs
>> ETEXI
>>=20
>> STEXI
>> +@item info vm-generation-id
>=20
> (1) Don't we need some kind of @findex here, for consistency with the
> rest of the file?
>=20
>> +Show Virtual Machine Generation ID
>> +ETEXI
>> +
>> +    {
>> +        .name       =3D "vm-generation-id",
>> +        .args_type  =3D "",
>> +        .params     =3D "",
>> +        .help       =3D "Show Virtual Machine Generation ID",
>> +        .cmd =3D hmp_info_vm_generation_id,
>> +    },
>> +
>> +STEXI
>> @end table
>> ETEXI
>>=20
>> diff --git a/hmp.c b/hmp.c
>> index 2bc4f06..535613d 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -2565,3 +2565,12 @@ void hmp_hotpluggable_cpus(Monitor *mon, const =
QDict *qdict)
>>=20
>>     qapi_free_HotpluggableCPUList(saved);
>> }
>> +
>> +void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
>> +{
>> +    GuidInfo *info =3D qmp_query_vm_generation_id(NULL);
>> +    if (info) {
>> +        monitor_printf(mon, "%s\n", info->guid);
>> +    }
>> +    qapi_free_GuidInfo(info);
>> +}
>> diff --git a/hmp.h b/hmp.h
>> index 05daf7c..799fd37 100644
>> --- a/hmp.h
>> +++ b/hmp.h
>> @@ -137,5 +137,6 @@ void hmp_rocker_of_dpa_flows(Monitor *mon, const =
QDict *qdict);
>> void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict);
>> void hmp_info_dump(Monitor *mon, const QDict *qdict);
>> void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>> +void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
>>=20
>> #endif
>> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
>> index b1b7b32..c159c76 100644
>> --- a/hw/acpi/vmgenid.c
>> +++ b/hw/acpi/vmgenid.c
>> @@ -235,3 +235,19 @@ static void vmgenid_register_types(void)
>> }
>>=20
>> type_init(vmgenid_register_types)
>> +
>> +GuidInfo *qmp_query_vm_generation_id(Error **errp)
>> +{
>> +    GuidInfo *info;
>> +    VmGenIdState *vms;
>> +    Object *obj =3D find_vmgenid_dev();
>> +
>> +    if (!obj) {
>> +        return NULL;
>> +    }
>> +    vms =3D VMGENID(obj);
>> +
>> +    info =3D g_malloc0(sizeof(*info));
>> +    info->guid =3D qemu_uuid_unparse_strdup(&vms->guid);
>> +    return info;
>> +}
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 61151f3..5e2a47f 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -6051,3 +6051,23 @@
>> #
>> ##
>> { 'command': 'query-hotpluggable-cpus', 'returns': =
['HotpluggableCPU'] }
>> +
>> +##
>> +# @GuidInfo:
>> +#
>> +# GUID information.
>> +#
>> +# @guid: the globally unique identifier
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
>> +
>> +##
>> +# @query-vm-generation-id:
>> +#
>> +# Show Virtual Machine Generation ID
>> +#
>> +# Since 2.9
>> +##
>> +{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
>> index a187295..0bffca6 100644
>> --- a/stubs/Makefile.objs
>> +++ b/stubs/Makefile.objs
>> @@ -35,3 +35,4 @@ stub-obj-y +=3D qmp_pc_dimm_device_list.o
>> stub-obj-y +=3D target-monitor-defs.o
>> stub-obj-y +=3D target-get-monitor-def.o
>> stub-obj-y +=3D pc_madt_cpu_entry.o
>> +stub-obj-y +=3D vmgenid.o
>> diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
>> new file mode 100644
>> index 0000000..8c448ac
>> --- /dev/null
>> +++ b/stubs/vmgenid.c
>> @@ -0,0 +1,8 @@
>> +#include "qemu/osdep.h"
>> +#include "qmp-commands.h"
>> +
>> +GuidInfo *qmp_query_vm_generation_id(Error **errp)
>> +{
>> +    error_setg(errp, "this command is not currently supported");
>> +    return NULL;
>> +}
>>=20
>=20
> (2) Don't we usually employ QERR_UNSUPPORTED for the format string in
> such cases?
>=20
> With or without updates:
>=20
> Reviewed-by: Laszlo Ersek <lersek@redhat.com =
<mailto:lersek@redhat.com>>
>=20
Both items changed.  Thanks!
> Thanks
> Laszlo


--Apple-Mail=_C1124983-A3DF-412B-A3B5-DA31901564E0
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
CQUxDxcNMTcwMjE2MDYxMzUwWjAjBgkqhkiG9w0BCQQxFgQUxAp0RlyO7dAZHOWNtduPYCkU358w
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAfmddxIhrkAL66r9MvTinlkuwwMpHfXZEKAlGaBdoy3pjc+UTG+wVQSac
0jrUlOf6ELAvmPNrstMy49eLYo6EpKNdTjFt66AoVEacbKEmqZ3zPK1qxFJKRRS/CcK+z58fjLi4
NsvVYH721EMOMHqw7raptf94qjsDVQQkRxbYYGPdOwVAhvVG4/OlttBr44H98gGa7Z//ouo/VbU3
YJpdNasXNOEN/vcoH2KBTqsZiqeiK3CkQiYBGH7T246QtENiDmgiV0XBlUkoVm04PDltYW6PJoWQ
m0mZZ9VG1Rtzh7VkO0AmGC/iXzCaROhta254K8L4/IN+LkSB0lchDSCE6AAAAAAAAA==
--Apple-Mail=_C1124983-A3DF-412B-A3B5-DA31901564E0--
