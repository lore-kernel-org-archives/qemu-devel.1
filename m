Received: from eggs.gnu.org ([2001:4830:134:3::10]:45221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqygN-0008IO-EN
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqygK-00005P-9t
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:05:23 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cqygK-00005B-36
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:05:20 -0400
Received: by mail-wm0-x244.google.com with SMTP id z133so15217995wmb.2
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 02:05:19 -0700 (PDT)
Date: Thu, 23 Mar 2017 09:05:16 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323090516.GN16717@stefanha-x1.localdomain>
References: <4712D8F4B26E034E80552F30A67BE0B1A2D69E@ORSMSX112.amr.corp.intel.com>
	<cce399b0-45d2-ac24-4975-6e27ad04f833@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yK/6QRnH3Zanb0EF"
Content-Disposition: inline
In-Reply-To: <cce399b0-45d2-ac24-4975-6e27ad04f833@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] only link current target arch traces to
 qemu-system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Xu, Anthony" <anthony.xu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Daniel Berrange <berrange@redhat.com>


--yK/6QRnH3Zanb0EF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 02:37:21PM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 22/03/2017 03:03, Xu, Anthony wrote:
> > When building target x86_64-softmmu, all other architectures' trace.o a=
re linked into=20
> > x86_64-softmmu/qemu-system-x86_64, like hw/arm/trace.o, hw/mips/trace.o=
 etc.,=20
> > that is not necessary.
> >  Same thing happens when building other targets.
> >=20
> > Only current target arch traces should be linked into qemu-system.
> >=20
> > Signed-off -by: Anthony Xu <anthony.xu@intel.com>
>=20
> It's a bit cleaner, but does the benefit outweight the maintenance cost
> of the additional code added to the Makefiles?

Perhaps all trace.o files should be put into their own .a instead of
being added directly to the linker line:

COMMON_LDADDS =3D $(trace-obj-y) libqemuutil.a libqemustub.a

I think the linker would only pull in .o files containing symbols that are
actually referenced by the program.

It would look like this:

######################################################################
# Build libraries

libqemustub.a: $(stub-obj-y)
libqemuutil.a: $(util-obj-y)
libqemutrace.a: $(trace-obj-y)

######################################################################

COMMON_LDADDS =3D libqemuutil.a libqemustub.a libqemutrace.a

This eliminates the maintenance burden with Anthony's patch.

Stefan

--yK/6QRnH3Zanb0EF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY04/MAAoJEJykq7OBq3PIMioH/i3CrOREVUa72WA/6uP6yMFw
XO6VuM0I6NjHtOefRv1me2h30y8WkGqQpq1MJEu/ZW/yLZMwXDqwZ0tpucT+BGYy
dwGUlExk0jp7fuRbbgkrUzJOg4a2pRzeeUUa7uNz+CRUIyxcU4fMczY8Bva/FTCd
hsc1LYMdDrQsvKHKcuKbSYD7l8mScS8rtBEjGxPPo634q9XXIqbWnqk9JAWFGG59
PV9jx35uxG9k78/fhpehpd3Dm5roHQvsbu3jxS+etoBdYZUgNR/wMBMLm9UTbVSP
grDX8520/eE3t1GZLSfMGqlGMEQyHzsHT0AsCihsxS62HG1FXS2L4TDIhxDuhwM=
=jVHq
-----END PGP SIGNATURE-----

--yK/6QRnH3Zanb0EF--
