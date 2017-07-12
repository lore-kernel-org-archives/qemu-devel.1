Received: from eggs.gnu.org ([2001:4830:134:3::10]:51505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVJYj-0004ji-8W
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVJYi-0007eD-6P
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:28:13 -0400
Date: Wed, 12 Jul 2017 17:28:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170712152801.GH4917@noname.str.redhat.com>
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<87tw2iaydb.fsf@dusky.pond.sub.org>
	<20170712081022.fcvchnilcfcyt23j@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <20170712081022.fcvchnilcfcyt23j@postretch>
Subject: Re: [Qemu-devel] [PATCH v4 0/4] block: Block driver callbacks fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.07.2017 um 10:10 hat Manos Pitsidianakis geschrieben:
> On Wed, Jul 12, 2017 at 09:49:20AM +0200, Markus Armbruster wrote:
> >Manos Pitsidianakis <el13635@mail.ntua.gr> writes:
> >
> >>This series makes implementing some of the bdrv_* callbacks easier for =
block
> >>filters by passing requests to bs->file if bs->drv doesn't implement it=
 instead
> >>of failing, and adding default bdrv_co_get_block_status() implementatio=
ns.
> >>
> >>This is based against Kevin Wolf's block branch, commit
> >>da4bd74d2450ab72a7c26bbabb10c6a287dd043e
> >
> >Haven't seen BlockDriver member is_filter before.  Interesting.  It's
> >documentation
> >
> >   /* set to true if the BlockDriver is a block filter */
> >   bool is_filter;
> >
> >is seriously lacking.  What does it *mean* to be a block filter?  Which
> >block layer facilities are affected, and how?
>=20
> Currently it is only used in bdrv_recurse_is_first_non_filter.
>=20
> >Observation: driver "raw" is filter-like in the sense that all it does
> >is pass along method arguments and results.  Can't say whether that
> >makes it a filter in the sense of is_filter, because "the sense of
> >is_filter" is nebulous to me :)
>=20
> I'm not very acquainted with raw, so I can't really comment. But the
> drivers I'm working on, throttle and before write notifier have that
> exact semantic, ie they do something when IO is intercepted and pass
> everything to the BDSes below. There was a mini discussion about raw
> and filters in the previous version's thread.
>=20
> I might add documentation to block_int.h in the future. When I first
> read it it felt nebulous to me too.

Not something that should stop this series, but while you're adding some
implications of being a filter to block_int.h, we still don't have a
definition of which block drivers qualify as filters.

"do something when IO is intercepted and pass everything to the BDSes
below" is probably not enough, every driver does this unless it is a
protocol driver.

We could further qualify it such that reads/writes on filter always
result in reads/writes on the same offset in bs->file (this disqualifies
the raw format, which you seem to want) and the block status is always
taken from bs->file.

We could also add that the data read/written must be the same - it's not
quite clear to me yet if we want to require this or can make use of the
property.

I'm open for other suggestion of what makes a filter a filter in the
sense of this field. Ideally it would contain enough (or maybe better:
the right) conditions that you can use it to justify why for each of the
functions that you pass down by default, this is the right behaviour.

For example, passing through bdrv_probe_geometry() makes sense because
all I/O is passed through unmodified and the image size is the same,
etc.

Kevin

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZZkABAAoJEH8JsnLIjy/WrrIP/iSRg8QWjfQwjWRq/hr+rIgT
AR09S70I2/Q7AAiR/sKeR88M1EZ5zDft6LYFmVk41us8o98TKlLqDO35q+Mmjsjw
+dUuM+V7BWQLd4c7/bUFj6Bz2F6/uCJLwRSqCLmyvwYyhH60KD0t71856RnPu7mt
tj5ZxRmApOpIU4VRJdv9yQRTwqDetsuygXVaWGLBN7tc8LeYNQZoEUMms5JTHv62
dPnkoJJqRoYKCCHXi1qgmZGl/wc0uPJfrPu13KDSn89rAnF+8iQdS8kcnXByDrdi
Ll5ShgaWf9Mg///jYUIVLy1DULthe/ueCjDqvaW1gq5HsVA8KyV5sa64JMX9V4z0
aRkYNGUyzvBJrnpiMGEgGjKMlPtuh7g5SJW4F3OTiZ1FfrZNvvHndHj+exWgVdUz
zxYYq9Oxjsp/BMwZwShpazeSQYsoIzDu177aaU+Axro7HJRDUn0C6MVRCq4AjVPl
cUwUJyr6k+WN0bDwF5wF/VtVDh22OL79J/DUa7g93DIysSvpiPn2TrDAdnIfl/bd
RbMss59SqHQR3TdHglEDY1nmCpZ2gtktvmExXHc6gQyIDeZ78nUZUa/I5NKoikRU
K/AqBCtZatdUUQN7kdN1vKs/tU724YNGmjrQYZHy/ySjaj/ebWAOlyfPos6hBmdy
oes45JpR0vzlHdjQjTnd
=D1yR
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
