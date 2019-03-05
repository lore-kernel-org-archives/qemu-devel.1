Received: from eggs.gnu.org ([209.51.188.92]:42610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0yMb-00066q-PN
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 19:55:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0yLF-0002Yy-6o
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 19:53:58 -0500
Date: Tue, 5 Mar 2019 11:52:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190305005207.GA7877@umbus.fritz.box>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190214043916.22128-2-david@gibson.dropbear.id.au>
	<20190228083317-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20190228083317-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 08:36:58AM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 14, 2019 at 03:39:12PM +1100, David Gibson wrote:
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
> > This patch simplify's the balloon operation by dropping the madvise()
> > on deflate.  This might have an impact on performance - it will move a
> > delay at deflate time until that memory is actually touched, which
> > might be more latency sensitive.  However:
> >=20
> >   * Memory that's being given back to the guest by deflating the
> >     balloon *might* be used soon, but it equally could just sit around
> >     in the guest's pools until needed (or even be faulted out again if
> >     the host is under memory pressure).
> >=20
> >   * Usually, the timescale over which you'll be adjusting the balloon
> >     is long enough that a few extra faults after deflation aren't
> >     going to make a difference.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> I'm having second thoughts about this. It might affect performance but
> probably won't but we have no idea.  Might cause latency jitter after
> deflate where it previously didn't happen.  This kind of patch should
> really be accompanied by benchmarking results, not philosophy.

I guess I see your point, much as it's annoying to spend time
benchmarking a device that's basically broken by design.

That said.. I don't really know how I'd go about benchmarking it.  Any
guesses at a suitable workload which would be most likely to show a
performance degradation here?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx9yDMACgkQbDjKyiDZ
s5JROA//dWEye1jFb+Y0iOO8pHrBMQIB317BXtfAsvqZWB5e0OENHXCQr2FkZr2q
22tATXMfokZLgvv6UByR6YBViP7QoSOpXAhLfuZzJQ4kK8JJ5SAMAMWHFJhpKfbQ
u2JW1coz7cf3f2r1T6fsKhy7tyTD7ytVZ2GVp3QMbanz1MQnte+YxnLpaBAgWVEt
UI2jHqq1Vt+ENFO/VvrOcAsHSja+M6HDbpfGuNj0X1E10A4mdjXpV8N175oSRs1M
DMKciqrzKAN+aRUB4e1+oETq2i6kVVMhkkfmeN1tdj5SDwVL72XsGnpYsuZJGQVa
R+UUrrTZGMh5ruY15DlqA5isXDhZjw3kGDI2kyPtcSD2SqJbaHcQshFYIMjNjVAy
VRqH8J0ooZWlZ4bwdLZLrXVgAut4oXp3eY3rV5vuhGCc+Cu4aPf1R9jT84mqlWJs
cO+ANVmA9UKnOC/oWkAMKSyWeLd8JwYfa0+ZPucp8bWVkliVMMJrhaoYLsTSUVU0
mm/2KsI4/Zla6PsaR2dCOMNzLgoAvLz1KXEgw/fhJjhQDilSlsqjHaTHX6odzypB
g3w2Rb/kzfxplISNFpfItU8HBbj9A3QUIEe19J2jUQZHQPphYx/o74va+gq652sm
gmnA/y1M/6Qb+KTWtrgOeAiuf3IU0/RBYruwpRKUkowGdr5H1d0=
=mXrS
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
