Received: from eggs.gnu.org ([2001:4830:134:3::10]:59043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gBDcH-0002EJ-98
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gBDcD-00004r-Rz
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 02:41:37 -0400
Date: Sat, 13 Oct 2018 17:26:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181013062648.GE16167@umbus.fritz.box>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-2-david@gibson.dropbear.id.au>
	<964b7f71-3fc9-83b4-3d5d-4cae592eef7d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
In-Reply-To: <964b7f71-3fc9-83b4-3d5d-4cae592eef7d@redhat.com>
Subject: Re: [Qemu-devel] [RFC 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
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


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 09:40:24AM +0200, David Hildenbrand wrote:
> On 12/10/2018 05:24, David Gibson wrote:
> > When the balloon is inflated, we discard memory place in it using madvi=
se()
> > with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, which
> > sounds like it makes sense but is actually unnecessary.
> >=20
> > The misleadingly named MADV_DONTNEED just discards the memory in questi=
on,
> > it doesn't set any persistent state on it in-kernel; all that's necessa=
ry
> > to bring the memory back is to touch it.  MADV_WILLNEED in contrast
> > specifically says that the memory will be used soon and faults it in.
> >=20
> > Memory that's being given back to the guest by deflating the balloon
> > *might* be used soon, but it equally could just sit around in the guest=
's
> > pools until it actually needs it.  And, over the general timescale that
> > memory ballooning operates, it seems unlikely that one extra fault for =
the
> > guest will be a vast performance issue.
> >=20
> > So, simplify the balloon's operation by dropping the madvise() on defla=
te.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/virtio/virtio-balloon.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index 1728e4f83a..6ec4bcf4e1 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -35,9 +35,8 @@
> > =20
> >  static void balloon_page(void *addr, int deflate)
> >  {
> > -    if (!qemu_balloon_is_inhibited()) {
> > -        qemu_madvise(addr, BALLOON_PAGE_SIZE,
> > -                deflate ? QEMU_MADV_WILLNEED : QEMU_MADV_DONTNEED);
> > +    if (!qemu_balloon_is_inhibited() && !deflate) {
> > +        qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
> >      }
> >  }
> > =20
> >=20
>=20
> Care to rename the function and drop the deflate parameter?
> (call it only when actually inflating)

As you probably found, I do that in a later patch.

> apart from that
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvBkCgACgkQbDjKyiDZ
s5L7HQ/8CXsWGl3ty8YSBr5PUd72VSz2a0rFbYxDyUN6rdIz2wNtFi/xUPjMUG5w
9rU0AtEpYynrOhaVRaW+6sX9XekFBplukyumU1iZZ0TuyK3Nihg8Dqmduf+NNwfx
ERqxfI7NHjv8VMkpxvOxFap4bVinwj8hN9YzsnSeXOXjQC1XhtmId1irarSWLXBP
gi3Lk0reqygiklAK7hW9s1f2EKA/1w7PNouQBE0grLbH2X4tIfbgUGnQGPZ//RtC
4DOk8S7/Az4G/GTejDRuLo+TJb9rZTwYezk6pbv3ZIF2uSEY/+unOjblwTtljspQ
SgSCZ3NZug0pNBw23WT9VpZ+Sfdea9Bd+fT7Z7LVyOqISMq/NpfcZL3BZRn883In
cKlDBxDD9qkC236N6vZh1yGHOt41Hv8nm/GdxhCCZN+UwhqrPJAQsSNZLJZB3rSu
zg/HeWvXvingnYQ9rsX1nV/+MHMcFWHXee9kIOUqA8J7gvw/Is22JKYy8GetZxOU
ICyizWS3AtsM4hs9XpKSXWOn+9kxZMvhIe+XHur2yJc/ng///tkX3BDs5czTAgLu
xKLCBoOjqHO11yMRPDJhkHjuU5n7KrRIHRXoe0TGmNEZ+FEGwHi/+f7oxEMYalOL
Ob76A5Q37xyyejhR1UdMc8TBQ11RSL9sOmek9wHvpSfBIfknTSE=
=EWxe
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
