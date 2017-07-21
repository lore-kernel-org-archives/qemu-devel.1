Received: from eggs.gnu.org ([2001:4830:134:3::10]:57780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYa9B-0007MP-SV
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYa96-0000IC-OY
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:47:21 -0400
Date: Fri, 21 Jul 2017 16:47:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721154712.GM18014@stefanha-x1.localdomain>
References: <20170711170821.24669-1-ppandit@redhat.com>
	<29e5dd08-80e7-ae0d-7179-73f5d34c3485@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kc9HNjpzOXVc7FFU"
Content-Disposition: inline
In-Reply-To: <29e5dd08-80e7-ae0d-7179-73f5d34c3485@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: check BlockDriverState
 object before dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Kieron Shorrock <kshorrock@paloaltonetworks.com>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>


--Kc9HNjpzOXVc7FFU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 11:56:48AM -0400, John Snow wrote:
> On 07/11/2017 01:08 PM, P J P wrote:
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >=20
> > When processing ATA_CACHE_FLUSH ide controller command,
> > BlockDriverState object could be null. Add check to avoid
> > null pointer dereference.
> >=20
>=20
> This happens through 0xE7, what QEMU calls WIN_CACHE_FLUSH and described
> in ATA8 ACS3 as "FLUSH CACHE"
>=20
> The core of the matter here is that any ATA device associated with a
> BlockBackend that has no media inserted will accept the command and call
> blk_aio_flush, which will later fail because blk_aio_prwv assumes that
> the BlockBackend it was given definitely has a BlockDriverState attached.
>=20
> The associated bdrv_inc_in_flight causes the null pointer dereference.
>=20
> It's not immediately clear to me what the right fix is here:
>=20
> (1) Should blk_ functions not assume they will have a BlockDriverState?
> (i.e. should an attempted blk_flush on an empty blk just succeed
> quietly, or is that inherently an error?)

Hmm...BlockDriverState still has bdrv_is_inserted() even though
BlockBackend->root can be NULL?  CCing Markus in case he has thoughts on
the BB/BDS split.

I find it weird that block-backend.c calls bdrv_inc_in_flight() and then
bdrv_co_flush() will call it again.  Perhaps we need to do this so that
blk_drain() works correctly but it's odd that they share the same
counter variable.

--Kc9HNjpzOXVc7FFU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZciIAAAoJEJykq7OBq3PIXuQH/1r6tWxHlVBYvpjrfiMOqEKu
hNuDLjl7nCHRkGbFdJNmWFR3la0bDplCgSdEherUA9jR8U5o8FwSoonfuBferH1+
igQIbjmLqVaQhjUl/x/JCTQ0kTE5zQntbKY7u+G6JKum+8IstTwgnY4GEj6UfTBN
6bNxlg2ZhVSz6oxeGAdWtLXbJFMG/HZfLV8ECXosVAA+J2barbgOk5utVkyqv94G
ju185VkwU181mmN0w6b87TPZt+cdjdxld7ibSZyilJ8yikEOgn3N+QMqFGqYGy62
l878vQUWJEQRRNdPOGU7LnOZQxMrblDbKhlnDYoow0GwTNV9uxnxyX3wBnr7zXI=
=3wYK
-----END PGP SIGNATURE-----

--Kc9HNjpzOXVc7FFU--
