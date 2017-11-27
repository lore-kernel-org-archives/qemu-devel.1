Received: from eggs.gnu.org ([2001:4830:134:3::10]:33615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1eJMQh-0000T0-2O
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1eJMQd-0004XJ-Uy
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:38:47 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1eJMQd-0004Wa-Lm
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:38:43 -0500
Received: by mail-pl0-x244.google.com with SMTP id b12so8780897plm.3
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 08:38:43 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <A9252286-892F-40F4-9BE5-A9F92CC75DF9@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_6D1C0930-E14C-4FEE-8563-7130A677DA3D";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Mon, 27 Nov 2017 08:38:41 -0800
In-Reply-To: <20171127130518.26703-3-rkagan@virtuozzo.com>
References: <20171127130518.26703-1-rkagan@virtuozzo.com>
	<20171127130518.26703-3-rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vmgenid: use UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Denis V. Lunev" <den@openvz.org>, minyard@acm.org, "Daniel P. Berrange" <berrange@redhat.com>


--Apple-Mail=_6D1C0930-E14C-4FEE-8563-7130A677DA3D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

It looks like you dropped Marc-Andr=C3=A9 and my Reviewed-by lines.  =
Please put them back.

> On Nov 27, 2017, at 5:05 AM, Roman Kagan <rkagan@virtuozzo.com> wrote:
>=20
> Switch vmgenid device to use the UUID property type introduced in the
> previous patch for its 'guid' property.
>=20
> One semantic change it introduces is that post-realize modification of
> 'guid' via HMP or QMP will now be rejected with an error; however,
> according to docs/specs/vmgenid.txt this is actually desirable.
>=20
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
> v1 -> v2:
> - use the corresponding define for "guid" field name
>=20
> hw/acpi/vmgenid.c | 30 ++++++++----------------------
> 1 file changed, 8 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index 105044f666..ba6f47b67b 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -162,21 +162,6 @@ static void vmgenid_update_guest(VmGenIdState =
*vms)
>     }
> }
>=20
> -static void vmgenid_set_guid(Object *obj, const char *value, Error =
**errp)
> -{
> -    VmGenIdState *vms =3D VMGENID(obj);
> -
> -    if (!strcmp(value, "auto")) {
> -        qemu_uuid_generate(&vms->guid);
> -    } else if (qemu_uuid_parse(value, &vms->guid) < 0) {
> -        error_setg(errp, "'%s. %s': Failed to parse GUID string: %s",
> -                   object_get_typename(OBJECT(vms)), VMGENID_GUID, =
value);
> -        return;
> -    }
> -
> -    vmgenid_update_guest(vms);
> -}
> -
> /* After restoring an image, we need to update the guest memory and =
notify
>  * it of a potential change to VM Generation ID
>  */
> @@ -224,23 +209,24 @@ static void vmgenid_realize(DeviceState *dev, =
Error **errp)
>     }
>=20
>     qemu_register_reset(vmgenid_handle_reset, vms);
> +
> +    vmgenid_update_guest(vms);
> }
>=20
> +static Property vmgenid_device_properties[] =3D {
> +    DEFINE_PROP_UUID(VMGENID_GUID, VmGenIdState, guid),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> static void vmgenid_device_class_init(ObjectClass *klass, void *data)
> {
>     DeviceClass *dc =3D DEVICE_CLASS(klass);
>=20
>     dc->vmsd =3D &vmstate_vmgenid;
>     dc->realize =3D vmgenid_realize;
> +    dc->props =3D vmgenid_device_properties;
>     dc->hotpluggable =3D false;
>     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> -
> -    object_class_property_add_str(klass, VMGENID_GUID, NULL,
> -                                  vmgenid_set_guid, NULL);
> -    object_class_property_set_description(klass, VMGENID_GUID,
> -                                    "Set Global Unique Identifier "
> -                                    "(big-endian) or auto for random =
value",
> -                                    NULL);
> }
>=20
> static const TypeInfo vmgenid_device_info =3D {
> --=20
> 2.14.3
>=20


--Apple-Mail=_6D1C0930-E14C-4FEE-8563-7130A677DA3D
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILJTCCBTcw
ggQfoAMCAQICED9ye6B5k0+gA4CVDazylRowDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNVBAYTAkdC
MRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoT
EUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNh
dGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE3MDcxOTAwMDAwMFoXDTE4MDcxOTIzNTk1OVow
JzElMCMGCSqGSIb3DQEJARYWYmVuQHNreXBvcnRzeXN0ZW1zLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAKNRYZm9a+xmI5BPBvGwd5GTtRYq3MeP41a2WqewywtPjLGDhanKK0wI
BghAAqwmQSfs1dukqG1N9fprI5+R+IqOqYle90tdF/P1YdEw6QGYxIfNLJP4Awc3No2LajOw4FcC
zRkkfCTnetztBMX7Jj2mu9+TRDlH/5nlRHZsXLbUgA5jiqha5u4RlgWCrcIdB3f1IBrQeDEaaWqc
XUiTbzqqUgTHEMAmwMf0g587n6tU/l6GhLCzPc49rF1ZD6fQoLN0Mxa/zt81MZrsXgaoz2mzvzn5
ty+9rhGIlKprjnn4vrOzYaU2ieciRLQdAz3B16/nrlVge+EwAe8KCPPIj20CAwEAAaOCAewwggHo
MB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBQCjA79fz82hhynuOG0
ET1twIBPlzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcD
BAYLKwYBBAGyMQEDBQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQEC
AQEBMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMFoGA1UdHwRT
MFEwT6BNoEuGSWh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRp
Y2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYsGCCsGAQUFBwEBBH8wfTBVBggrBgEFBQcwAoZJ
aHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRT
ZWN1cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMCEG
A1UdEQQaMBiBFmJlbkBza3lwb3J0c3lzdGVtcy5jb20wDQYJKoZIhvcNAQELBQADggEBAERxWav/
xDSN35gLVL+7SiNwEUTMMI11WRTwYzP4uhcA5cihdsQDdT8+jljvIcVAQmSd/mLZBjbkYsJa4zpC
fX2D/EtB2D547Fj63efh0vyjLpX4hzhToiLXSXUaLWUhjUQKgGyBpDTpb/2Xbwpg7clWBHy/h4Ax
75RfOdWpaZtQ6g/VxR2mten4dQ8NhtDiv+TlB89LRlQbcGk5A0k/++HlXKwRdTlOXee8+YePAENO
OVUV4C3xuI6eXhxcHuZnBZdVdMTsb5WBsSUTONBTNR5BOUE7xLxcEchP8kHqmqaLSiN7unuUTrug
EYpB7jWGysgKCeKgkEpI9dF++Oqqp70wggXmMIIDzqADAgECAhBqm+E4O/8ra58B1dm4p1JWMA0G
CSqGSIb3DQEBDAUAMIGFMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMi
Q09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xMzAxMTAwMDAwMDBaFw0yODAx
MDkyMzU5NTlaMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAw
DgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09N
T0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAL6znlesKHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+
nKcxLqf2NHbZhGra0D00SOTq9bus3/mxgUsg/Wh/eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQ
yDMqVaVUkbIr5SU0RDX/kSsKwer3H1pT/HUrBN0X8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWW
Co63OTTqRvaq8aWccm+KOMjTcE6s2mj6RkalweyDI7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJ
QaDaElmOupyTf1Qib+cpukNJnQmwygjD8m046DQkLnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEA
AaOCATwwggE4MB8GA1UdIwQYMBaAFLuvfgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSCr2yM
+MX+lmF86B89K3FIXsSLwDAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNV
HSAECjAIMAYGBFUdIAAwTAYDVR0fBEUwQzBBoD+gPYY7aHR0cDovL2NybC5jb21vZG9jYS5jb20v
Q09NT0RPUlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwcQYIKwYBBQUHAQEEZTBjMDsGCCsG
AQUFBzAChi9odHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FBZGRUcnVzdENBLmNydDAk
BggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQB4
XLKBKDRPPO5fVs6fl1bsj6JrF/bz9kkIBtTYLzXN30D+03Hj6OxCDBEaIeNmsBhrJmuubvyE7Hto
SmR809AgcYboW+rcTNZ/8u/Hv+GTrNI/AhqX2/kiQNxmgUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7
I5Px+TbO+88G4zipA2psZaWeEykgzClZlPz1FjTCkk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4
o50YJafX8mnahjp3I2Y2mkjhk0xQfhNqbzlLWPoT3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu
6t99p17bTbY7+1RTWBviN9YJzK8HxzObXYWBf/L+VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QI
hhmiNOr84JHoy+fNLpfvYc/Q9EtFOI5ISYgOxLk3nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv
9mj2PMnXoc7mbrS22XUSeTwxCTP9bcmUdp4jmIoWfhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIv
xqith7DoJC91WJ8Lce3CVJqb1XWeKIJ84F7YLXZN0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/
vOYRUM1cWcef20Wkyk5S/GFyyPJwG0fR1nRas3DqAf4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjGC
A7cwggOzAgEBMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0
Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQP3J7
oHmTT6ADgJUNrPKVGjAJBgUrDgMCGgUAoIIB3zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0xNzExMjcxNjM4NDJaMCMGCSqGSIb3DQEJBDEWBBTYuLLZpeH5PAaoFjA1
dC/QU8pfqDCBvQYJKwYBBAGCNxAEMYGvMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGlt
aXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3Vy
ZSBFbWFpbCBDQQIQP3J7oHmTT6ADgJUNrPKVGjCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJ
BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQx
GjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBB
dXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhA/cnugeZNPoAOAlQ2s8pUaMA0GCSqG
SIb3DQEBAQUABIIBAHq992h8ZBW9MxRyQjIP07pKp7wyTnr23WSLQlqorIVndpiG6WdC7y4y/AhX
wjw6+cjTmJ6Aci6krdQj473PrBMvAC6ZL5NSHvHpsmNvxSKiZAcKTcxzDTId2nsEYEaI4cb3JHHc
1DsHVRpweD7yAP5mj9mEz3UgyVHZ88Gl2WNScEJsVOhT7WOGPg5Fh31vHau88ZFzPHovCTmxpfdr
eKUfi7yISSRqekEumYBM7dipvUttcktGhfsuD4gLSxQzdLNu/mdc96uT0Tu+pnRl0GaIuAlT1vv7
YAGrOTgyYzLfCkg6uxP1UzZPSmtFHvjGuywLlS3gP13EQayqaRBQc1QAAAAAAAA=
--Apple-Mail=_6D1C0930-E14C-4FEE-8563-7130A677DA3D--
