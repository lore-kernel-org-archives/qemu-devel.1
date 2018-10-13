Received: from eggs.gnu.org ([2001:4830:134:3::10]:58989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gBDcE-0002Dl-Rp
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gBDcD-000058-UF
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:41:34 -0400
Date: Sat, 13 Oct 2018 17:29:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181013062924.GF16167@umbus.fritz.box>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-4-david@gibson.dropbear.id.au>
	<ecd2b2b6-38ea-8c0c-02b0-c35e9b72f4ae@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Content-Disposition: inline
In-Reply-To: <ecd2b2b6-38ea-8c0c-02b0-c35e9b72f4ae@redhat.com>
Subject: Re: [Qemu-devel] [RFC 3/5] virtio-balloon: Rework ballon_page()
 interface
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


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 09:46:16AM +0200, David Hildenbrand wrote:
> On 12/10/2018 05:24, David Gibson wrote:
> > This replaces the balloon_page() internal interface with
> > ballon_inflate_page(), with a slightly different interface.  The new
> > interface will make future alterations simpler.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/virtio/virtio-balloon.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index e8611aab0e..7229afad6e 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -33,11 +33,11 @@
> > =20
> >  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
> > =20
> > -static void balloon_page(void *addr, int deflate)
> > +static void balloon_inflate_page(VirtIOBalloon *balloon,
> > +                                 MemoryRegion *mr, hwaddr offset)
> >  {
> > -    if (!qemu_balloon_is_inhibited() && !deflate) {
> > -        qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
> > -    }
> > +    void *addr =3D memory_region_get_ram_ptr(mr) + offset;
>=20
> I prefer an empty line here

Ok.

> > +    qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
> >  }
> > =20
> >  static const char *balloon_stat_names[] =3D {
> > @@ -222,7 +222,6 @@ static void virtio_balloon_handle_output(VirtIODevi=
ce *vdev, VirtQueue *vq)
> > =20
> >          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4=
) =3D=3D 4) {
> >              hwaddr pa;
> > -            hwaddr addr;
> >              int p =3D virtio_ldl_p(vdev, &pfn);
> > =20
> >              pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
> > @@ -244,11 +243,9 @@ static void virtio_balloon_handle_output(VirtIODev=
ice *vdev, VirtQueue *vq)
> > =20
> >              trace_virtio_balloon_handle_output(memory_region_name(sect=
ion.mr),
> >                                                 pa);
> > -            /* Using memory_region_get_ram_ptr is bending the rules a =
bit, but
> > -               should be OK because we only want a single page.  */
> > -            addr =3D section.offset_within_region;
> > -            balloon_page(memory_region_get_ram_ptr(section.mr) + addr,
> > -                         !!(vq =3D=3D s->dvq));
> > +            if (!qemu_balloon_is_inhibited() && vq !=3D s->dvq) {
> > +                balloon_inflate_page(s, section.mr, section.offset_wit=
hin_region);
> > +            }
> >              memory_region_unref(section.mr);
> >          }
> > =20
> >=20
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvBkMQACgkQbDjKyiDZ
s5IFFQ//Vrf5IHtvwYGYLiZ97C2L8x1kuDhp0gmwt5pUVVS9Xp/bMyBwS3i1d+s8
dnK193EVyR/GERWe8sQD5xC27X0bDz8Yd1gCrSi+KgGWn4YWufDglTTqF2gCqxy0
LGmL0eS1f1kX3Dc96cFKik+rcicvG9T49pi9WRLiVjH0cS8i+h8MGKK04JJ8Q1k4
cxD3U6wNYiHCjBdwp3RrkkqCP5nESC/dNrsdH1WTHTBj3KNomGxdEX3oaeoMqCqB
SyVTfnKYs8fomT7iD3TSJ80qjyKU5WSW780oy+4mxl8PUaev7x9E/ioI/knsoceN
0CcLEW3r9U7Xasu/Jtg5n69mPIm/fpu/7maYD4CHtrdlXbrmVsO0GgGa9nWeaEcN
rKS9PaAZZdLzLXZLf8F36C/APdpBMfcQxK6I6ar1atm0Pr1wBCDIQAGYJS1MHwrA
EC8V4xAI/qJdjmZubVe1trAwa3Xq2E9tnBdWmOJVZ5c5+Ja8vPlzRzJn59184sEd
Epgyr11WLq2UUDXV83ik+VvN94yB9pCGCeccxgG4dx6Q1F9/gV3MQju1KTnMCzT5
s/TVDk4R7qnO0FE3WDbAhY2qy4v5mrhO/j+gKGN4s74wHu5d3brNyO5Nmwwdtmx/
oUDLZC1w5jo9o13tmt4FqdINT16au98n8WYTeW9NxlUVx7mUSvM=
=LH7s
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
