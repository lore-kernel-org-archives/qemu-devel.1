Received: from eggs.gnu.org ([2001:4830:134:3::10]:57624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1eRWfJ-0005Fv-UL
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 00:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1eRWfI-00037e-Sx
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 00:11:37 -0500
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:35432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1eRWfI-00036E-K3
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 00:11:36 -0500
Received: by mail-pl0-x22e.google.com with SMTP id b96so8404886pli.2
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 21:11:36 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <5E450532-FCCA-4785-8C96-E3569FE683EE@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_04019475-2E2D-4F45-A277-38A173AF9037";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Tue, 19 Dec 2017 21:11:31 -0800
In-Reply-To: <20171220062738-mutt-send-email-mst@kernel.org>
References: <20171213082644.83113-1-ben@skyportsystems.com>
	<20171220062738-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Add subsystem-vendor-id
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, yan@daynix.com, lprosek@redhat.com, eswierk@skyportsystems.com


--Apple-Mail=_04019475-2E2D-4F45-A277-38A173AF9037
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Michael,

> On Dec 19, 2017, at 8:27 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>=20
> On Wed, Dec 13, 2017 at 12:26:44AM -0800, ben@skyportsystems.com =
wrote:
>> From: Ben Warren <ben@skyportsystems.com>
>>=20
>> Now that virtio-win guest drivers provided by non-Redhat vendors need =
to
>> use a different Subsystem Vendor ID value, a way is needed to set =
this
>> parameter on the host.  This works with all of the PCI-based devices,
>> such as NetKVM, viostor, vioscsi, vioserial and balloon.
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>=20
> I applied a related patch by Ladi, pls take a look.
>=20
If you=E2=80=99re talking about the one titled "virtio-pci: Don't force =
Subsystem Vendor ID =3D Vendor ID=E2=80=9D, then this is complementary.  =
If it=E2=80=99s another one, I must have missed it.  The patch I=E2=80=99m=
 aware of doesn=E2=80=99t provide any way of setting the subsystem =
vendor ID, which is needed.

BTW - would you prefer this to be contained to virtio-pci, or all of =
PCI, as another reviewer suggested.  Either is easy.

>> ---
>> hw/virtio/virtio-pci.c | 5 +++++
>> hw/virtio/virtio-pci.h | 1 +
>> 2 files changed, 6 insertions(+)
>>=20
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index e92837c..b5c86e3 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -1757,6 +1757,9 @@ static void virtio_pci_realize(PCIDevice =
*pci_dev, Error **errp)
>>     if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_AUTO) {
>>         proxy->disable_legacy =3D pcie_port ? ON_OFF_AUTO_ON : =
ON_OFF_AUTO_OFF;
>>     }
>> +    /* Set the PCI Subsystem Vendor ID */
>> +    k->parent_class.subsystem_vendor_id =3D =
proxy->subsystem_vendor_id;
>> +    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID, =
proxy->subsystem_vendor_id);
>>=20
>>     if (!virtio_pci_modern(proxy) && !virtio_pci_legacy(proxy)) {
>>         error_setg(errp, "device cannot work as neither modern nor =
legacy mode"
>> @@ -1876,6 +1879,8 @@ static Property virtio_pci_properties[] =3D {
>>                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
>>     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
>>                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
>> +    DEFINE_PROP_UINT16("subsystem-vendor-id", VirtIOPCIProxy,
>> +                       subsystem_vendor_id, =
PCI_VENDOR_ID_REDHAT_QUMRANET),
>>     DEFINE_PROP_END_OF_LIST(),
>> };
>>=20
>> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
>> index 12d3a90..8a897ea 100644
>> --- a/hw/virtio/virtio-pci.h
>> +++ b/hw/virtio/virtio-pci.h
>> @@ -186,6 +186,7 @@ struct VirtIOPCIProxy {
>>     VirtIOIRQFD *vector_irqfd;
>>     int nvqs_with_notifiers;
>>     VirtioBusState bus;
>> +    uint16_t subsystem_vendor_id;
>> };
>>=20
>> static inline bool virtio_pci_modern(VirtIOPCIProxy *proxy)
>> --=20
>> 2.7.4


--Apple-Mail=_04019475-2E2D-4F45-A277-38A173AF9037
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
CSqGSIb3DQEJBTEPFw0xNzEyMjAwNTExMzFaMCMGCSqGSIb3DQEJBDEWBBQtQH7u3CvB+op5pmui
UF2Zm8RQrTCBvQYJKwYBBAGCNxAEMYGvMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGlt
aXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3Vy
ZSBFbWFpbCBDQQIQP3J7oHmTT6ADgJUNrPKVGjCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJ
BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQx
GjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBB
dXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhA/cnugeZNPoAOAlQ2s8pUaMA0GCSqG
SIb3DQEBAQUABIIBADP5aMyI7dNvQH+2WPzqf01hFVk9EtTs9+ByHursAebxeme4ECBGjZwZsOMO
/97mI8l++qr3oxVFVbi6cwYur976yipitsl9FkhvZtSEUPpN2UBfo97qeA5c3mT2wpqPRoRwPtj1
BPvpg9yybkk6LsnwVeHyKIc2JfjRpHvyk032jcXhOGL7B1AozgprUvwrgZN7AlfINU1G6lijhSg/
7XbgTZ7gl79TA5Fs0GEMtNqAdWL71iitF85Mn10St5CsBlogA3VnEJA51VDa0OYEMzY8y4QxVzIU
nuf4e1lP1R4Q2T/Rqfrp/y0rI3bOU9q2jn1+Mue2XOv9ygFg5gL3sW0AAAAAAAA=
--Apple-Mail=_04019475-2E2D-4F45-A277-38A173AF9037--
