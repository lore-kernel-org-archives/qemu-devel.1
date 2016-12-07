Received: from eggs.gnu.org ([2001:4830:134:3::10]:56031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEfBf-0006GS-1E
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEfBe-00074R-2A
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:35:19 -0500
Date: Wed, 7 Dec 2016 17:35:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161207163508.GJ4773@noname.str.redhat.com>
References: <20161205234235.5728-1-eblake@redhat.com>
	<20161206092523.GA4990@noname.str.redhat.com>
	<871488c7-b870-da8f-1a71-c2462214e650@redhat.com>
	<20161207104425.GC4773@noname.str.redhat.com>
	<12602b60-df5f-b365-c34a-80c37610a1fc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <12602b60-df5f-b365-c34a-80c37610a1fc@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: nbd-general@lists.sourceforge.net, xieyingtai@huawei.com, subo7@huawei.com, qemu-block@nongnu.org, eric.fangyi@huawei.com, qemu-devel@nongnu.org, pbonzini@redhat.com


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.12.2016 um 16:50 hat Eric Blake geschrieben:
> On 12/07/2016 04:44 AM, Kevin Wolf wrote:
> >> Just because the NBD spec describes the bit does NOT require that
> >> servers HAVE to set the bit on all images that are all zeroes.  It is
> >> perfectly compliant if the server never advertises the bit.
> >=20
> > True, but if no server exists that would actually make use of the
> > feature, it's kind of useless to include it in the spec.
>=20
> No server, or no client?

Well, you need both to make use of the feature.

> I think qemu can be a client fairly easily: if the server advertises
> the bit, then the client can set .bdrv_has_zero_init() and avoid
> rewriting any sector of a file that is already known to be zero.

Yes, the client part makes sense to me and should be easy. Are you going
to write the patches yourself?

> > The interesting case is probably where the image is
> > created externally with qemu-img before it's exported either with
> > qemu-nbd or the builtin server, and then we use it as a mirror target.
> >=20
> > Even in the rare cases where both image creation and the NBD server are
> > in the same process, bdrv_create() doesn't work on a BlockDriverState,
> > but just on a filename. So even then you would have to do hacks like
> > remembering file names between create and the first open or something
> > like that.
>=20
> Or add in a driver-specific callback that checks if a file is provably
> all-zeroes; for the raw file driver, check if lseek(SEEK_DATA) finds
> nothing, for the qcow2 driver, check for no backing files, and no L1
> table entries.

In theory, there should be a common efficient abstraction for these two:

    bool bs_is_zeroed(BlockDriverState *bs)
    {
        int pum;
        ret =3D bdrv_get_block_status(bs, 0, bs->total_sectors, *pnum, NULL=
);
        return (ret =3D=3D 0 && pnum =3D=3D bs->total_sectors);
    }

For raw this does the lseek() you mentioned, and for qcow2 it will look
at the L1 table and one L2 table (the first one that exists). This is a
bit more expensive than just looking at the L1 table, but so minimally
that it's far from justifying a new command or flag in a protocol.

Now, in practice, this doesn't work because bdrv_get_block_status() can
return early even if the contiguous area is longer that what it
returns. This is something that we should possibly fix sometime in qemu,
but it's also independent from NBD (we can loop in the NBD server to
give the desired semantics).

So we are already going to export a block status querying interface to
NBD. If we require there that the whole contiguous area of the same
status is described and the server can't just shorten it, then we
get the very same thing without a new flag.

> >> Another option on the NBD server side is to create a server option -
> >> when firing up a server to serve a particular file as an export, the
> >> user can explicitly tell the server to advertise the bit because the
> >> user has side knowledge that the file was just created (and then the
> >> burden of misbehavior is on the user if they mistakenly request the
> >> advertisement when it is not true).
> >=20
> > Maybe that's the only practical approach.
>=20
> But it's still a viable approach, and therefore this bit definition in
> the NBD protocol is worthwhile.

If it adds something that we can't easily get otherwise, and if someone
volunteers to write the patches, then yes. I'm not completely convinced
yet on that.

Kevin

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYSDo8AAoJEH8JsnLIjy/WjnwP/iV/cXLiLHOfmdEAh47Ec7y4
2qAtUyhzBxN3vmj7a+HnQJUe/yHWWiD2rcs7czfFTUmP6dnp8Gvfp4ybyC5yj0aI
/V3xP2yKrOfGstpHTnL7LjcJKB8nM00fWLefOwIoi2VdmQ33jLBBqyzVKMnZWtl7
shNuBOPCa1MjrIIbp0iZELNmiQPNu1dl62/oaqgRnjTqcT3WOly2PcmWrXKWT/gm
VqLhplzy2lQJJkuxuA4/NrqpZGbrrlqx+X/vaBcotVuZEpqxDdCuSKOBDhe3vScL
cBSM5hJvJIYMYPP48QTTDgPDbB3DiJ8+243ckJi0+ezThZEGNsP6ezWJOVa24n6S
oWFaCIppvNrNJj3Ou5uM6eBB0tsU/GPaVcwvUgXTigLO2dcoBV5r6nOsL1CC2IwX
xbBBjJNflrVaWNvoQZU+rZ9rAC6qaQhPolHEeVSBT0EgmZ8cDfGNx7o/B7gV0qQT
XTyA/OT2c1rzGRaYcvMRD30mNMoG60iFksiAcjr48MbGPRM2h7f4NZ+IiXSX7Ar/
S2+V92l5gqWSKxyU6pL88yP6/xuEuaWsmUi+2iAVg9p05eONkXVxvpGIVKnyxOB4
+uMW8bLczAH3i3RlhgD9r6voe78NKJzqJx/PbEg9i5VFmIXhth+Qt8lH6/+ttghi
mQFkhTiQT7eSzyV0BE5c
=ZFj+
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
