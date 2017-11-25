Received: from eggs.gnu.org ([2001:4830:134:3::10]:42610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1eIUQK-0007KW-Gu
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 01:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1eIUQJ-0001kZ-CG
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 01:58:48 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:46155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1eIUQJ-0001kP-40
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 01:58:47 -0500
Received: by mail-ot0-x241.google.com with SMTP id j29so20340811oth.13
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 22:58:46 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <A16740D0-F4A3-4EC2-8E55-F4CC519A9285@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_3D86CBFF-F606-4312-8EA7-5A3396DF695A";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Fri, 24 Nov 2017 22:58:43 -0800
In-Reply-To: <20171124153656.30199-2-rkagan@virtuozzo.com>
References: <20171124153656.30199-1-rkagan@virtuozzo.com>
	<20171124153656.30199-2-rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qdev-properties: add UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Denis V. Lunev" <den@openvz.org>


--Apple-Mail=_3D86CBFF-F606-4312-8EA7-5A3396DF695A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Nov 24, 2017, at 7:36 AM, Roman Kagan <rkagan@virtuozzo.com> wrote:
>=20
> UUIDs (GUIDs) are widely used in VMBus-related stuff, so a dedicated
> property type becomes helpful.
>=20
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Reviewed-by: Ben Warren <ben@skyportsystems.com>
> ---
> include/hw/qdev-properties.h |  3 +++
> hw/core/qdev-properties.c    | 52 =
++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 55 insertions(+)
>=20
> diff --git a/include/hw/qdev-properties.h =
b/include/hw/qdev-properties.h
> index e2321f1cc1..d4da7dd1f1 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -30,6 +30,7 @@ extern const PropertyInfo qdev_prop_vlan;
> extern const PropertyInfo qdev_prop_pci_devfn;
> extern const PropertyInfo qdev_prop_blocksize;
> extern const PropertyInfo qdev_prop_pci_host_devaddr;
> +extern const PropertyInfo qdev_prop_uuid;
> extern const PropertyInfo qdev_prop_arraylen;
> extern const PropertyInfo qdev_prop_link;
>=20
> @@ -212,6 +213,8 @@ extern const PropertyInfo qdev_prop_link;
>     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, =
PCIHostDeviceAddress)
> #define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
>     DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, MemoryRegion *)
> +#define DEFINE_PROP_UUID(_n, _s, _f) \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_uuid, QemuUUID)
>=20
> #define DEFINE_PROP_END_OF_LIST()               \
>     {}
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 1dc80fcea2..49fea5a40a 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -10,6 +10,7 @@
> #include "net/hub.h"
> #include "qapi/visitor.h"
> #include "chardev/char.h"
> +#include "qemu/uuid.h"
>=20
> void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>                                   Error **errp)
> @@ -883,6 +884,57 @@ const PropertyInfo qdev_prop_pci_host_devaddr =3D =
{
>     .set =3D set_pci_host_devaddr,
> };
>=20
> +/* --- UUID --- */
> +
> +static void get_uuid(Object *obj, Visitor *v, const char *name, void =
*opaque,
> +                     Error **errp)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    Property *prop =3D opaque;
> +    QemuUUID *uuid =3D qdev_get_prop_ptr(dev, prop);
> +    char buffer[UUID_FMT_LEN + 1];
> +    char *p =3D buffer;
> +
> +    qemu_uuid_unparse(uuid, buffer);
> +
> +    visit_type_str(v, name, &p, errp);
> +}
> +
> +static void set_uuid(Object *obj, Visitor *v, const char *name, void =
*opaque,
> +                    Error **errp)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    Property *prop =3D opaque;
> +    QemuUUID *uuid =3D qdev_get_prop_ptr(dev, prop);
> +    Error *local_err =3D NULL;
> +    char *str;
> +
> +    if (dev->realized) {
> +        qdev_prop_set_after_realize(dev, name, errp);
> +        return;
> +    }
> +
> +    visit_type_str(v, name, &str, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if (!strcmp(str, "auto")) {
> +        qemu_uuid_generate(uuid);
> +    } else if (qemu_uuid_parse(str, uuid) < 0) {
> +        error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
> +    }
> +    g_free(str);
> +}
> +
> +const PropertyInfo qdev_prop_uuid =3D {
> +    .name  =3D "str",
> +    .description =3D "UUID (aka GUID) or \"auto\" for random value",
> +    .get   =3D get_uuid,
> +    .set   =3D set_uuid,
> +};
> +
> /* --- support for array properties --- */
>=20
> /* Used as an opaque for the object properties we add for each
> --=20
> 2.14.3
>=20


--Apple-Mail=_3D86CBFF-F606-4312-8EA7-5A3396DF695A
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
CSqGSIb3DQEJBTEPFw0xNzExMjUwNjU4NDNaMCMGCSqGSIb3DQEJBDEWBBTVbDHpH0h+J+JF/E8E
VYaecNop4TCBvQYJKwYBBAGCNxAEMYGvMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGlt
aXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3Vy
ZSBFbWFpbCBDQQIQP3J7oHmTT6ADgJUNrPKVGjCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJ
BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQx
GjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBB
dXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhA/cnugeZNPoAOAlQ2s8pUaMA0GCSqG
SIb3DQEBAQUABIIBAKEG9cozRhcbd4ZbKxqI0vtmxwU0t19qbzl9zAzuwzqDyyfKFshM9i8ex+Tz
qBMu9csmKkJl0umLv3QnAIP+tEFhbfhj8iLCUtLRoGyUip5R5YNMAFAv36dmNlFMdsef8Wn31jPf
s4tHB4Kn18IqHqPmVap7f4dWxuWVM/+2Dq5xTHXoRhvSM1EzEDb4HsxhNtMt8abEitupXj88XpKt
a0wlHBeldj3nh5Xdwb0dV8so77zmg9ji005N0RXfTCkO7DgEjD0gYkjCT/Z5iL29UWqACCcRuj92
03fvh1fsA277wyGsGDiTgnlB9evh9GqsYIbvLVAdCTgfYQrecEJbeOEAAAAAAAA=
--Apple-Mail=_3D86CBFF-F606-4312-8EA7-5A3396DF695A--
