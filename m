Received: from eggs.gnu.org ([209.51.188.92]:42456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Jpz-0003UV-4x
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Jpy-00061s-3U
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:51:07 -0500
Date: Wed, 6 Mar 2019 10:40:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190305234033.GC19715@umbus.fritz.box>
References: <20190305051134.27930-1-david@gibson.dropbear.id.au>
	<20190305051134.27930-3-david@gibson.dropbear.id.au>
	<00e325d4-b23c-7239-46e6-a55fd1f9d5f4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <00e325d4-b23c-7239-46e6-a55fd1f9d5f4@redhat.com>
Subject: Re: [Qemu-devel] [RFC 2/2] virtio-balloon: Restore MADV_WILLNEED
 hint on balloon deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: mst@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2019 at 03:15:38PM +0100, David Hildenbrand wrote:
> On 05.03.19 06:11, David Gibson wrote:
> > Prior to f6deb6d9 "virtio-balloon: Remove unnecessary MADV_WILLNEED on
> > deflate", the balloon device issued an madvise() MADV_WILLNEED on
> > pages removed from the balloon.  That would hint to the host kernel
> > that the pages were likely to be needed by the guest in the near
> > future.
> >=20
> > It's unclear if this is actually valuable or not, and so f6deb6d9
> > removed this, essentially ignoring balloon deflate requests.  However,
> > concerns have been raised that this might cause a performance
> > regression by causing extra latency for the guest in certain
> > configurations.
>=20
> I mean, it will mainly create page tables as far as I know. Any write to
> a page will have an overhead either way (COW zero page). Reads *might*
> be faster.
>=20
> As we are working on 4k granularity in the balloon (and doing
> MADV_DONTNEED on 4k granularity!), there will most probably be page
> tables already either way. A page table could only be zapped if all
> pages of that page table are MADV_DONTNEED'ed (or I assume never were
> touched), and I am not sure if "random MADV_DONTNEED'ing of 4k pages"
> will actually get rid of page tables (my assumption would be: only if a
> complete range is zapped at once). I haven't looked into the details,
> though (plenty of other stuff to do).
>=20
> I am not sure if I share the concerns. Real-time workload should never
> use the virtio-balloon in a way that anything like that would be possible.
>=20
> >=20
> > So, until we can get actual benchmark data to see if that's the case,
> > this restores (by default) the old behaviour, issuing a MADV_WILLNEED
> > when a page is removed from the balloon.  A new property on the
> > balloon device "hint-on-deflate" can be set to false to remove this
> > behaviour for testing.
>=20
> This is certainly a good approach for you to finally be able to leave
> the ugly land of virtio-balloon :)
>=20
> But at least to me, this looks completely useless. I'll be happy to be
> proven wrong as always :)

Frankly, I agree.  But mst was nervous about us making that change to
the balloon's previous behaviour.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx/CPAACgkQbDjKyiDZ
s5K0WQ/8CmvTnRS3Wfg5nPrkCFd6p+Mz3PGN9DA6VfjorCyn9fuobvhMnLe50jvg
MiPAoDdWLevBRCCybEW+5xBxzOtcLeN97YGrbJ+mXJP/fF6jSAlI+INid+dumoLk
KTT0LYg+zN5QkHeZF6zRG4TELanHuB9mkyAwrPxnMKDKgvj5vUDv0ZaISfkyaF2Q
6Qnovn7JeS4asRz7iPnbIlE+oAVSeyqm0HxsP6A5X+/p4oLb+nLIPmeSEPEdXpEH
O2NTnO5kEd64SkoVwVetxO1mroEIs8+sN+YYo1AMl3e8yBoHyxQIB4lgCbBJRxQ3
eEDaqgg0wsRi6HNhHuBZVjAWKhC9KY5xlGdJxXgWedbpfo1t/reTwex5NaDUL4e4
W1NgM81RQm7uml8pl1IIwYESz7gqAtOekuKMm0huyMlIZgWV8sQtSgzHbEBoHu6W
Sy+KR4GBISedhZoEUjJNwnhLM84D4o9Ke9B0FIqfuHL1DsehUi5o+r+Ux73cy+K9
DLxD2n+Do4VIwdXanwKnBNUsH4QoPmyuCLVXGnmcin5qZ276hRCBjcBD2K+ZlHuv
kzVtKxp7JlYaSXnFS8H0jxcmvZdFIN0IGPGKy65Ffa1Qa/5BAKYV7ryyj928RY0s
pyhcvrbRkQMqDOALVW3kL5Agp0dhcjil+fj9CnL0w9ZtQpVJh+4=
=zO7M
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
