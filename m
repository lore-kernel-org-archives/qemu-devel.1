Received: from eggs.gnu.org ([2001:4830:134:3::10]:37631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxxjb-0005w6-NK
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxxja-00034d-Qh
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:29:35 -0400
Date: Tue, 11 Apr 2017 17:29:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170411152922.GP4516@noname.str.redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
	<20170411144921.GN4516@noname.str.redhat.com>
	<b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
	<1bbcc4ba-e889-2242-cb44-c933eedfb212@redhat.com>
	<760cb82c-9bff-c289-c2b3-940319c66b5c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <760cb82c-9bff-c289-c2b3-940319c66b5c@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.04.2017 um 17:18 hat Max Reitz geschrieben:
> On 11.04.2017 17:08, Eric Blake wrote:
> > On 04/11/2017 09:59 AM, Max Reitz wrote:
> >=20
> >>
> >> Good point, but that also means that (with (2)) you can only use
> >> subcluster configurations where the L2 entry size increases by a power
> >> of two. Unfortunately, only one of those configurations itself is a
> >> power of two, and that is 32.
> >>
> >> (With 32 subclusters, you take up 64 bits, which means an L2 entry will
> >> take 128 bits; with any higher 2^n, you'd take up 2^{n+1} bits and the
> >> L2 entry would take 2^{n+1} + 64 which is impossible to be a power of =
two.)
> >=20
> > Or we add padding. If you want 64 subclusters, you burn 256 bits per> e=
ntry, even though only 192 of those bits are used.
>=20
> Hm, yeah, although you have to keep in mind that the padding is almost
> pretty much the same as the the data bits we need, effectively doubling
> the size of the L2 tables:
>=20
> padding =3D 2^{n+2} - 2^{n+1} - 64 (=3D2^6)
>         =3D 2^{n+1} - 64
>=20
> So that's not so nice, but if it's the only thing we can do...
>=20
> >> I don't know how useful non-power-of-two subcluster configurations are.
> >> Probably not at all.
> >>
> >> Since using subcluster would always result in the L2 table taking more
> >> than 512 bytes, you could therefore never guarantee that there is no
> >> entry overlapping a sector border (except with 32 subclusters).
> >=20
> > Yes, there's definite benefits to keeping whatever structure we end up
> > with aligned so that it naturally falls into sector boundaries, even if
> > it means more padding bits.
>=20
> Then again, I'm not even sure we really need atomicity for L2 entries +
> subcluster bits. I don't think you'd ever have to modify both at the
> same time (if you just say the subclusters are all unallocated when
> allocating the cluster itself, and then you write which subclusters are
> actually allocated afterwards)).
>=20
> (This also applies to your remark on caching, I think.)
>=20
> Atomicity certainly makes things easier, though.

Unless you want to deal with ordering (i.e. on cluster allocation, first
update the subcluster bitmap, then flush, then add the L2 entry), I
think you need atomicity.

Kevin

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY7PZSAAoJEH8JsnLIjy/WLPEQAK95nebuC6CnL9cGbcYW4v+/
CniABqOriUazxHzia0Hcs1jgOrCC1o5jOAn/IdhPOg47bg14b9wnrXQKNhkkfhbN
s0Vp4lFs1P99rWTSt3zToq1XLNGnLm9zgeU9JVUo06yzmBwe3rE9L/A9SoY5Ctzh
TFtGTpVKs+Ki02xZRmJvedtTF00TG3tmHO53Cdi8ZHaPRnmOOyfCK5tUeFUGNvCM
HekAR6MbvJozqMutBWgxxGAk4mSiTEdBTd2IQqr9zBU9iaypzSLThbTb4LQO4V4B
0kHlB6QCaUdDkGozr0iuCsjWhvVDrEDI9ZwdmKth5zV/S/q3TzIlWLW6t9H1J9Fw
4mWuIqs6CRgtS0tjLeKAPzS4OKWLqa/hyPlDQQ1OtW4e7V4S8ZXhYdu3vKhyFMci
A1SUFdCcv8FBnaL3OG0p1A16RZjKGeLoDKDImWx5qgHy90/piz1e1rR94/YG6euM
4aS0cBHCRlizWppwt+vx/ISpo7D/qdt1xx5FRKm9uKtC1o6BMp9X89oFPm5puWK6
V8WA34BAV4tUz0MOlCqj9liodbmiiWFgcUc3grwtC5yqR7WoQIWdjJchWBJBy3U4
zbmA42+7tqcO84d6VO++2YKhDCmW401eAau3ew55vR+JisFcZX7ijXGJeCB2pKKW
xkyMCCxRcH5E1Y81Y6n3
=36lH
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
