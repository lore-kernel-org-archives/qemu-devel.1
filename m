Received: from eggs.gnu.org ([2001:4830:134:3::10]:32785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr73m-0001Rf-Dq
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr73g-0002sx-I0
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:02:06 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cr73g-0002sP-84
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:02:00 -0400
Received: by mail-wr0-x241.google.com with SMTP id u108so32332025wrb.2
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 11:02:00 -0700 (PDT)
Date: Thu, 23 Mar 2017 18:01:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323180149.GI12560@stefanha-x1.localdomain>
References: <20170322111608.31230-1-stefanha@redhat.com>
	<CAMRbyysE0+GPze8mFZyaWqTywGMW67t+JKV1xX_CvX_dcu5q7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
Content-Disposition: inline
In-Reply-To: <CAMRbyysE0+GPze8mFZyaWqTywGMW67t+JKV1xX_CvX_dcu5q7A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/8] qemu-img: add measure sub-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>


--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 07:29:07PM +0000, Nir Soffer wrote:
> On Wed, Mar 22, 2017 at 2:28 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
>=20
> > v3:
> >  * Drop RFC, this is ready to go for QEMU 2.10
> >  * Use "required size" instead of "required bytes" in qemu-img output f=
or
> >    consistency [Nir]
> >  * Clarify BlockMeasureInfo semantics [Max]
> >  * Clarify bdrv_measure() opts argument and error handling [Nir]
> >  * Handle -o backing_file=3D for qcow2 [Max]
> >  * Handle snapshot options in qemu-img measure
> >  * Probe input image for allocated data clusters for qcow2.  Didn't
> > centralize
> >    this because there are format-specific aspects such as the
> > cluster_size.  It
> >    may make sense to centralize it later (with a bit more complexity) if
> >    support is added to more formats.
> >  * Add qemu-img(1) man page section for 'measure' sub-command [Max]
> >  * Extend test case to cover additional scenarios [Nir]
> >
> > RFCv2:
> >  * Publishing RFC again to discuss the new user-visible interfaces.  Co=
de
> > has
> >    changed quite a bit, I have not kept any Reviewed-by tags.
> >  * Rename qemu-img sub-command "measure" and API bdrv_measure() [Nir]
> >  * Report both "required bytes" and "fully allocated bytes" to handle t=
he
> > empty
> >    image file and prealloc use cases [Nir and Dan]
> >  * Use bdrv_getlength() instead of bdrv_nb_sectors() [Berto]
> >  * Rename "err" label "out" in qemu-img-cmds.c [Nir]
> >  * Add basic qcow2 support, doesn't support qemu-img convert from exist=
ing
> > files yet
> >
> > RFCv1:
> >  * Publishing patch series with just raw support, no qcow2 yet.  Please
> > review
> >    the command-line interface and let me know if you are happy with this
> >    approach.
> >
> > Users and management tools sometimes need to know the size required for=
 a
> > new
> > disk image so that an LVM volume, SAN LUN, etc can be allocated ahead of
> > time.
> > Image formats like qcow2 have non-trivial metadata that makes it hard to
> > estimate the exact size without knowledge of file format internals.
> >
> > This patch series introduces a new qemu-img sub-command that calculates=
 the
> > required size for both image creation and conversion scenarios.
> >
> > The conversion scenario is:
> >
> >   $ qemu-img measure -f raw -O qcow2 input.img
> >   required size: 1327680
> >   fully allocated size: 1074069504
> >
> > Here an existing image file is taken and the output includes the space
> > required
> > for data from the input image file.
> >
> > The creation scenario is:
> >
> >   $ qemu-img measure -O qcow2 --size 5G
> >   required size: 327680
> >   fully allocated size: 1074069504
> >
> > Stefan Hajnoczi (8):
> >   block: add bdrv_measure() API
> >   raw-format: add bdrv_measure() support
> >   qcow2: extract preallocation calculation function
> >   qcow2: extract image creation option parsing
> >   qcow2: add bdrv_measure() support
> >   qemu-img: add measure subcommand
> >   qemu-iotests: support per-format golden output files
> >   iotests: add test 178 for qemu-img measure
> >
> >  qapi/block-core.json             |  25 +++
> >  include/block/block.h            |   4 +
> >  include/block/block_int.h        |   2 +
> >  block.c                          |  35 ++++
> >  block/qcow2.c                    | 362
> > +++++++++++++++++++++++++++++----------
> >  block/raw-format.c               |  22 +++
> >  qemu-img.c                       | 227 ++++++++++++++++++++++++
> >  qemu-img-cmds.hx                 |   6 +
> >  qemu-img.texi                    |  25 +++
> >  tests/qemu-iotests/178           | 144 ++++++++++++++++
> >  tests/qemu-iotests/178.out.qcow2 | 242 ++++++++++++++++++++++++++
> >  tests/qemu-iotests/178.out.raw   | 130 ++++++++++++++
> >  tests/qemu-iotests/check         |   5 +
> >  tests/qemu-iotests/group         |   1 +
> >  14 files changed, 1136 insertions(+), 94 deletions(-)
> >  create mode 100755 tests/qemu-iotests/178
> >  create mode 100644 tests/qemu-iotests/178.out.qcow2
> >  create mode 100644 tests/qemu-iotests/178.out.raw
> >
> > --
> > 2.9.3
> >
>=20
> Stefan, is this available in some public git repo?
>=20
> I would like to test it,  and downloading and applying 8 patches is lot of
> work.
> (I'm probably not using the right tools for this).

I've pushed the branch here:
https://github.com/stefanha/qemu/tree/qemu-img-query-max-size

In mutt you can tag multiple emails ('t') and then pipe them to git am
in one go (';|git am').  Many other email clients offer no support for
processing patches by default.

Stefan

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY1A2NAAoJEJykq7OBq3PIvLwH/jOXEHfNEs9S5WXW+GlrugTK
ArSQQ2kjKR2svu4Kpzb2t4QifNmv7Lt0ec0iDalvrUlq/OIJDEz+1GfQlKEK0Hkn
6ughfXDmwFtaMq5yLqXIroMo4eLHlTTrxR1R/qaQssRKsUDypxsFARXPg/aKBwwL
A7qUIf8u+yao8DZCWHHeF8Ygwh0dIe2xrK0Oq7Sl2hTxyKwGdMWHLWeCaiWp4Ucc
wh8QQuGfTeC16rhqbqR3msoGzaGE2qjoeKC3vvbkJfP1KqQk4h82vmMalnIVDmkf
kmdmlVq0RRFOtB5kCRaGQUTNE6LBoiyrdHhonePEmRWWoMcpEDf3heuGHvWg+xc=
=XsnR
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--
