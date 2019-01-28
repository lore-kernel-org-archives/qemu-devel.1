Received: from eggs.gnu.org ([209.51.188.92]:59303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1go2us-0005i9-6O
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1go2uo-0001jY-G2
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:09:18 -0500
Date: Mon, 28 Jan 2019 10:08:46 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190128090846.GB16630@andariel.pipo.sk>
References: <20190125174653.4604-1-kwolf@redhat.com>
	<20190125174653.4604-3-kwolf@redhat.com>
	<20190128085041.GA16630@andariel.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20190128085041.GA16630@andariel.pipo.sk>
Subject: Re: [Qemu-devel] [PATCH 2/3] scsi-disk: Add device_id property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, berrange@redhat.com, eblake@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 09:50:41 +0100, Peter Krempa wrote:
> On Fri, Jan 25, 2019 at 18:46:52 +0100, Kevin Wolf wrote:
> > The new device_id property specifies which value to use for the vendor
> > specific designator in the Device Identification VPD page.
> >=20
> > In particular, this is necessary for libvirt to maintain guest ABI
> > compatibility when no serial number is given and a VM is switched from
> > -drive (where the BlockBackend name is used) to -blockdev (where the
> > vendor specific designator is left out by default).
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  hw/scsi/scsi-disk.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
>=20
> [...]
>=20
> > @@ -2904,7 +2910,9 @@ static const TypeInfo scsi_disk_base_info =3D {
> >      DEFINE_PROP_STRING("ver", SCSIDiskState, version),               \
> >      DEFINE_PROP_STRING("serial", SCSIDiskState, serial),             \
> >      DEFINE_PROP_STRING("vendor", SCSIDiskState, vendor),             \
> > -    DEFINE_PROP_STRING("product", SCSIDiskState, product)
> > +    DEFINE_PROP_STRING("product", SCSIDiskState, product),           \
> > +    DEFINE_PROP_STRING("device_id", SCSIDiskState, device_id)
>=20
> This adds the property only to 'scsi-disk', whereas libvirt will use
> 'scsi-cd' or 'scsi-hd' depending on the media type if the 'scsi-cd'
> device is detected. The following logic decides:
>=20
> https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dblob;f=3Dsrc/qemu/qemu_comma=
nd.c;h=3D3e46f3ced3c1e6a4865e98e2d0cdce3214c4a5d2;hb=3DHEAD#l1978
>=20
> This brings multiple questions:

I've found:

commit b443ae67130d32ad06b06fc9aa6d04d05ccd93ce
Author: Markus Armbruster <armbru@redhat.com>
Date:   Mon May 16 15:04:53 2011 +0200

    scsi: Split qdev "scsi-disk" into "scsi-hd" and "scsi-cd"

Which seems to put scsi-hd and scsi-cd as the thing to use.

Libvirt's code obviously did not adapt after that and we still keep to
probe scsi-disk instead of the split up devices, whereas we will never
use scsi-disk.

Also some of our tests seem to look as if scsi-disk was used which
confused me.

Since the new property is present also for scsi-hd and scsi-cd we really
need to adapt our code to that.

Btw, this also means that qemu can deprecate scsi-disk.

Sorry for the noise.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlxOxpsACgkQHGwCByjY
1Gpa0RAAl0zAiW0IQ4r2kmPRjZ/Vke+xc9lUvuEMQ0BJI1C4eWXFJ8/N+D1OD7uk
mcjvIhxY1qfux/Y7RXJaglazuRM8A6NvxgOUlSHZ/6gtwtirz+O1rB/Yu+9ERaXI
gOcNs86snR7Vv6ao3K9REy/0h8tnKoN63aatuxT8gu2pJpd4wW2OeR97mZA85Vpe
B1ToXSPaSW9mZdoejo/wTU8xOctcRZDJpHkm5gk4DfX/OBKMNQnIWiarRNRtPhXD
jK9kbHWbmgjT7Qf5i2x7u+TjXKWRJvXnYYRqm4b4VqbF4cKAyvTwIAImT+tq8XBR
zrlJzAvd9v4vmPGFW2Ogl51Tm+vtNfQGvCrkViQlqk4uA5eGCo+zemriaucVUo2q
s8CobHA5pyeSsFo/wVJGEOmED5LMDRgszRCPu6nn1bioBP7uak2UlDu4BqYu9Ild
3YJaRE8YFUsfSB9A0yiiDNIvbpXeZeUWPdywJh95bYJu7NUg281KbBw0W6eohF2L
BWXI3oljnOr1XyelW0TmhIeJhW5Okrf84jsHouEmELLjhvDR2YeK0tCK0c8OX56/
Mdas0isWeWBEPN+Zc4PtZbL/ZNcMOT/KXRDAIwji6/e09oVdfvujFDHM0joCnZo2
M57RaQaWl+YHk8z/roeRpOfErxT1JyYssdVanMTOhlAIqSI6BNo=
=+mUi
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
