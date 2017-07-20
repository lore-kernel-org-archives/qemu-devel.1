Received: from eggs.gnu.org ([2001:4830:134:3::10]:39934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dYCGb-0006FO-4w
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dYCGa-000590-5g
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:17:25 -0400
Date: Thu, 20 Jul 2017 16:17:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170720141713.GB4963@noname.redhat.com>
References: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
	<b94821ce-476f-42b7-7fc5-fcff1b83fe7d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <b94821ce-476f-42b7-7fc5-fcff1b83fe7d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v3] block: Skip implicit nodes in
 query-block/blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com, nsoffer@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org, qemu-stable@nongnu.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.07.2017 um 16:06 hat Max Reitz geschrieben:
> On 2017-07-20 15:11, Kevin Wolf wrote:
> > @@ -133,13 +133,21 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBack=
end *blk,
> >              qapi_free_BlockDeviceInfo(info);
> >              return NULL;
> >          }
> > +
> >          if (bs0->drv && bs0->backing) {
> > +            info->backing_file_depth++;
> >              bs0 =3D bs0->backing->bs;
> >              (*p_image_info)->has_backing_image =3D true;
> >              p_image_info =3D &((*p_image_info)->backing_image);
> >          } else {
> >              break;
> >          }
> > +
> > +        /* Skip automatically inserted nodes that the user isn't aware=
 of for
> > +         * query-block (blk !=3D NULL), but not for query-named-block-=
nodes */
> > +        while (blk && bs0 && bs0->drv && bs0->implicit) {
> > +            bs0 =3D backing_bs(bs0);
> > +        }
>=20
> If the bottom-most backing file is implicit, this will leave bs0 to be
> NULL. The surrounding loop does not look like it could cope well with
> that. (And even if it could, we would have to reset has_backing_image to
> false, wouldn't we?)
>=20
> Not necessarily an issue here because all of our implicit nodes are
> somewhere in between, but still...
>=20
> (And I just saw you're even asserting this in another place...)
>=20
> >      }
> > =20
> >      return info;
>=20
> [...]
>=20
> > @@ -446,6 +459,14 @@ static BlockStats *bdrv_query_bds_stats(const Bloc=
kDriverState *bs,
> >          return s;
> >      }
> > =20
> > +    /* Skip automatically inserted nodes that the user isn't aware of =
in
> > +     * a BlockBackend-level command. Stay at the exact node for a node=
-level
> > +     * command. */
> > +    while (blk_level && bs->drv && bs->implicit) {
> > +        bs =3D backing_bs(bs);
> > +        assert(bs);
>=20
> (...namely here.)
>=20
> I extremely doubt this assertion will hold in the future, but well, it's
> good enough for now.
>=20
> So, I've always wanted "file" to be the default child for block filters.
> This patch very much establishes that "backing" is the default child, rig=
ht?

Manos is going to address this when he uses an I/O throttling filter
node to implement the legacy options. The plan there is to replace it
with some function that asserts that there is only one child (because
only filter nodes are supposed to be implicit) and then uses that child,
no matter whether it's bs->file, bs->backing or something else.

I just tried to keep things simple for 2.10.

Kevin

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZcLtpAAoJEH8JsnLIjy/WNxIQALyBsAGH5wSU80vZcQZsYqTl
YcoGbNglKbUomuY94JmyltTYdB7UmetIg7rmG0K0VNxmkhIjWm9PTnfwAOnM9/w2
HCwniGQtYMXoCtLKUKX68P8WpPMde1kzoCzuaSRTsJt+OvVgc4kA8zHqEXudx3jw
M7ZIZ7o66Z7SUKReeFehK8id6Ij8KHGzRrVSsDKZEk18QTG6V8dlovjKCb0jE5hT
WHDkq4ubI8ZnqSLZJIegxH4UTow0SiZDTbzTSleP/ZkvFoEYMei8+Z2J797B+xsB
2NOPL5aDdfZ67KqzXlnFJBs4nOXxuHm0JVvbKdafpG2I+v5tjmceXSc16LgG/Pk2
nFp5CaHEd4/tgN6RHhorwXO+1hHTTbIm5CpPcRn09zVsCefVFw3R+VL/FRSC8tRi
0dUSs1AqxVhsB3gixQXjlHGFEy4eCulLLJF7HmR2qAEV0uVLFIGWxFWMMqNdQl1e
Er1BjZmtf7alwKkOCSqR6Mw2m33Y9lyiXYjvEARd5XrefhuGwNtROKLH0DobM/Hh
6ywEm03D58/u8QICMQ/QBLB4vtWeWWRaE/XuEv3Loo3jJ+XCVHNaoxuZ1Zp4KIGW
kT+shNz/b6PvHE5CWb4bq80qiOfgnYtUsbPcPiaOt/n1ZR+CxIGTPWqO06TIeytC
VBy9PVNQLJvQj6aApARP
=kCW4
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
