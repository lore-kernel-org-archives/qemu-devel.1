Received: from eggs.gnu.org ([2001:4830:134:3::10]:58991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gBDcE-0002Dm-UR
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gBDcD-00004w-S3
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:41:34 -0400
Date: Sat, 13 Oct 2018 17:25:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181013062520.GD16167@umbus.fritz.box>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-3-david@gibson.dropbear.id.au>
	<0ea22284-a019-4d6b-9951-976174248d5a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <0ea22284-a019-4d6b-9951-976174248d5a@redhat.com>
Subject: Re: [Qemu-devel] [RFC 2/5] virtio-balloon: Corrections to address
 verification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 09:44:25AM +0200, David Hildenbrand wrote:
> On 12/10/2018 05:24, David Gibson wrote:
> > The virtio-balloon device's verification of the address given to it by =
the
> > guest has a number of faults:
> >     * The addresses here are guest physical addresses, which should be
> >       'hwaddr' rather than 'ram_addr_t' (the distinction is admittedly
> >       pretty subtle and confusing)
> >     * We don't check for section.mr being NULL, which is the main way t=
hat
> >       memory_region_find() reports basic failures.  We really need to c=
heck
> >       that before looking at any other section fields, because
> >       memory_region_find() doesn't initialize them on the failure path
> >     * We're passing a length of '1' to memory_region_find(), but really=
 the
> >       guest is requesting that we put the entire page into the balloon,
> >       so it makes more sense to call it with BALLOON_PAGE_SIZE
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/virtio/virtio-balloon.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index 6ec4bcf4e1..e8611aab0e 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -221,17 +221,20 @@ static void virtio_balloon_handle_output(VirtIODe=
vice *vdev, VirtQueue *vq)
> >          }
> > =20
> >          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4=
) =3D=3D 4) {
> > -            ram_addr_t pa;
> > -            ram_addr_t addr;
> > +            hwaddr pa;
> > +            hwaddr addr;
> >              int p =3D virtio_ldl_p(vdev, &pfn);
> > =20
> > -            pa =3D (ram_addr_t) p << VIRTIO_BALLOON_PFN_SHIFT;
> > +            pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
> >              offset +=3D 4;
> > =20
> > -            /* FIXME: remove get_system_memory(), but how? */
>=20
> Should we leave that fixme? (on the other hand, virtio-balloon operates
> on all system mamory, so I also don't really see a way around this ...)

Yeah, I took that out deliberately.  Given what this is supposed to be
doing, I can't really see how removing get_system_memory() is either
possible or desirable.

> > -            section =3D memory_region_find(get_system_memory(), pa, 1);
> > -            if (!int128_nz(section.size) ||
> > -                !memory_region_is_ram(section.mr) ||
> > +            section =3D memory_region_find(get_system_memory(), pa,
> > +                                         BALLOON_PAGE_SIZE);
> > +            if (!section.mr) {
> > +                trace_virtio_balloon_bad_addr(pa);
> > +                continue;
> > +            }
> > +            if (!memory_region_is_ram(section.mr) ||
> >                  memory_region_is_rom(section.mr) ||
> >                  memory_region_is_romd(section.mr)) {
> >                  trace_virtio_balloon_bad_addr(pa);
> >=20
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvBj9AACgkQbDjKyiDZ
s5LDvg//RfnuAwWHd6iuwRZQapzMR3W/eliwiGSLuFWq7uDrk31d7/22d4MRuP2p
buxaXU8q2+Oqnb2stn5revr+8seO/+83qsxSMQRvukc79q+Z30zYOV0haWCSGwf8
BeIH/kclecY2sDKzYZExdkwTn9v1g8Q20MlfXktT6Y0i4XNdBxG72dgJVNzwfqTG
xiaL+TM+pvWNcybOMPbBNP/2OggB/8bOGOLSQbQZVJHSwtysg6UuQ1M4sJcCA5H/
bcnKQfBqf4RTEOq4RjcpHZZDSMazCGaEV7g1rz3KkYZEGm2p2Ltd+/dt+mwh3NQN
STn8XWaPPd2hQrKGroerNgrBi8+nd12tFQ8Qw2yi9iNeSHbUfckj2WeCupGVx/PX
icGI0ypNF8NVdV6VUwEZ098CPQxmH1aDQnf1F1Ar2TyS12He2hfXo38UQE7JGs7/
U3yA3qFlAe/qHkTKFxL59lVRCwaF5QcrB0OTjVjJv5ebcwAox979dGttOxQWHA6k
u4QIPes4F+MUiQg+X0clwIj3tNoWcxtedZ5WklFK5uWHFAYgWtXrwV5DKyF7ZoTK
sr57VHekYd/VWmsSjpNIHUBxkpATf/R5f4nA4AvlByKn2uhYCqMjZdE8qNr7xlnq
P5GX6aLYSdEAXPbpO5dSjYaZX2BcCsOiISSb23Gui7cslexuXS0=
=UIDa
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
