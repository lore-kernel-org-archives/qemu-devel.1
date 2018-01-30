Received: from eggs.gnu.org ([2001:4830:134:3::10]:36191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1egROn-0007p6-H1
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 03:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1egROj-0000D6-En
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 03:36:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1egROj-0000C2-4V
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 03:36:09 -0500
Date: Tue, 30 Jan 2018 09:35:56 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180130093556.7397894b@redhat.com>
In-Reply-To: <09b823ea-f0d3-1428-fceb-a54d881e9333@linux.vnet.ibm.com>
References: <20180126120306.19225-1-marcandre.lureau@redhat.com>
	<20180129171848.708a60c5@redhat.com>
	<09b823ea-f0d3-1428-fceb-a54d881e9333@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 29 Jan 2018 11:50:04 -0500
Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> On 01/29/2018 11:24 AM, Igor Mammedov wrote:
> > On Fri, 26 Jan 2018 13:03:06 +0100
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > =20
> >> tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
> >> Interface as defined in TCG PC Client Platform TPM Profile (PTP)
> >> Specification Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 v22.
> >>
> >> The PTP allows device implementation to switch between TIS and CRB
> >> model at run time, but given that CRB is a simpler device to
> >> implement, I chose to implement it as a different device.
> >>
> >> The device doesn't implement other locality than 0 for now (my laptop
> >> TPM doesn't either, so I assume this isn't so bad)
> >>
> >> Tested with some success with Linux upstream and Windows 10, seabios &
> >> modified ovmf. The device is recognized and correctly transmit
> >> command/response with passthrough & emu. However, we are missing PPI
> >> ACPI part atm.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>
> >> The patch is based on stefanb/tpm-next git branch.
> >> =20
> > [...]
> > =20
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index dc4b2b9ffe..ed78c4ed9f 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -2224,6 +2224,22 @@ build_dsdt(GArray *table_data, BIOSLinker *link=
er,
> >>               aml_append(sb_scope, scope);
> >>           }
> >>       }
> >> +
> >> +    if (TPM_IS_CRB(tpm_find())) {
> >> +        dev =3D aml_device("TPM");
> >> +        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101"))=
);
> >> +        crs =3D aml_resource_template();
> >> +        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
> >> +                                           TPM_CRB_ADDR_SIZE, AML_REA=
D_WRITE));
> >> +        aml_append(dev, aml_name_decl("_CRS", crs));
> >> + =20
> > [...] =20
> >> +        method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
> >> +        aml_append(method, aml_return(aml_int(0x0f)));
> >> +        aml_append(dev, method); =20
> > this is not needed as 0x0f is assumed default value if _STA is missing =
=20
>=20
> Well, it seems to be in good neighborhood with other devices created=20
> that do the same thing: build_kbd_device_aml(),=20
> build_mouse_device_aml(), part of \_SB.PCI0.ISA...
I'm in process of getting rid of that, so please don't add
new ones.=20

PS:
(in case there won't be respin, a fixup patch that
maintainer could squash in would do)

[...]
