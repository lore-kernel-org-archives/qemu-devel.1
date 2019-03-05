Received: from eggs.gnu.org ([209.51.188.92]:42434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Jpx-0003Ts-Ue
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Jpw-0005zd-Ts
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:51:05 -0500
Date: Wed, 6 Mar 2019 10:42:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190305234209.GD19715@umbus.fritz.box>
References: <20190305051134.27930-1-david@gibson.dropbear.id.au>
	<20190305051134.27930-3-david@gibson.dropbear.id.au>
	<00e325d4-b23c-7239-46e6-a55fd1f9d5f4@redhat.com>
	<20190305110201-mutt-send-email-mst@kernel.org>
	<921c1cde-59bc-09d0-c026-26e939e7b6ee@redhat.com>
	<20190305120131-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <20190305120131-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2019 at 12:02:30PM -0500, Michael S. Tsirkin wrote:
> On Tue, Mar 05, 2019 at 05:10:42PM +0100, David Hildenbrand wrote:
> > On 05.03.19 17:03, Michael S. Tsirkin wrote:
> > > On Tue, Mar 05, 2019 at 03:15:38PM +0100, David Hildenbrand wrote:
> > >> On 05.03.19 06:11, David Gibson wrote:
> > >>> Prior to f6deb6d9 "virtio-balloon: Remove unnecessary MADV_WILLNEED=
 on
> > >>> deflate", the balloon device issued an madvise() MADV_WILLNEED on
> > >>> pages removed from the balloon.  That would hint to the host kernel
> > >>> that the pages were likely to be needed by the guest in the near
> > >>> future.
> > >>>
> > >>> It's unclear if this is actually valuable or not, and so f6deb6d9
> > >>> removed this, essentially ignoring balloon deflate requests.  Howev=
er,
> > >>> concerns have been raised that this might cause a performance
> > >>> regression by causing extra latency for the guest in certain
> > >>> configurations.
> > >>
> > >> I mean, it will mainly create page tables as far as I know. Any writ=
e to
> > >> a page will have an overhead either way (COW zero page). Reads *migh=
t*
> > >> be faster.
> > >>
> > >> As we are working on 4k granularity in the balloon (and doing
> > >> MADV_DONTNEED on 4k granularity!), there will most probably be page
> > >> tables already either way. A page table could only be zapped if all
> > >> pages of that page table are MADV_DONTNEED'ed (or I assume never were
> > >> touched), and I am not sure if "random MADV_DONTNEED'ing of 4k pages"
> > >> will actually get rid of page tables (my assumption would be: only i=
f a
> > >> complete range is zapped at once). I haven't looked into the details,
> > >> though (plenty of other stuff to do).
> > >>
> > >> I am not sure if I share the concerns. Real-time workload should nev=
er
> > >> use the virtio-balloon in a way that anything like that would be pos=
sible.
> > >>
> > >>>
> > >>> So, until we can get actual benchmark data to see if that's the cas=
e,
> > >>> this restores (by default) the old behaviour, issuing a MADV_WILLNE=
ED
> > >>> when a page is removed from the balloon.  A new property on the
> > >>> balloon device "hint-on-deflate" can be set to false to remove this
> > >>> behaviour for testing.
> > >>
> > >> This is certainly a good approach for you to finally be able to leave
> > >> the ugly land of virtio-balloon :)
> > >>
> > >> But at least to me, this looks completely useless. I'll be happy to =
be
> > >> proven wrong as always :)
> > >=20
> > > Point is if we don't intend to extend balloon any further then let's
> > > not make random untested changes to its behaviour.
> >=20
> > Agreed, but than I'd much rather want to avoid the original change
> > instead of adding a new property that most probably nobody will ever us=
e.
>=20
> OK, I don't mind either way.

Ok, I'll take the property out.  Or at least, move the new property to
a private experimental patch to make it easier to try to benchmark.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx/CVEACgkQbDjKyiDZ
s5J6Aw/9GLlcWEH3U5yBlowNAgDJHElUbOp3F3K0Gu/OcaoYkx4pEFyVpe1/B8JB
Xh/aS6P59sdoEwSpDYS1jLef1QsrRgQX24e9eOAL4DUzPUIxm0ts6WipKyMb9hFk
TutZHUIQniPEJFTwpV2eczqZxdBgYNo1C7dpo8Jn16idQ+vNmAxB90qqCXElyUc2
IV0PNAHtvFmMRZLvb7YUQxFUstGYjnVphqwpciS0CF6qCB+JAsmQbVluPtKv4FrD
wymRcv6QpE2YHGn14sH1bSrlTRnJg1iIVhjd8sVHrmpLuFqQbtsqwEQNBwswd7h1
4fMKYO2pbwHEg2duuDmai7oj2aoSYx1FNbBGBkLM8QpyxQelYLdZrbo6uQVg/1WH
qmZA328dDuLPAM20L1QO67XkYXGwTgYn50eax9BuBZyatzr9g57e1X7zR/dXLSLS
z2Kw9y5mG4QSrQMRMCenRRZMDYpPXruxgcD/Q1lBaCgy1CKgMsWexfyLsUOPFgFA
M18+jQiB6OhwUHjU4xg3qZ1SkvarQX5lbhCNynRwfAopq3HWeA5ipmGiPlm1X1AU
S3rRz9zoq3cnT59dme6UPXhMEwGjkgePiU6d3c18MeHuu4NRhBpb58YeL1fZc485
1P6vQOLjgkvXrTC4kJeqliq6WkyOsSqh5ny+/A1OIlp07pvL0y0=
=yyOC
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
