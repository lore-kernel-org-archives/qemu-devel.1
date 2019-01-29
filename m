Received: from eggs.gnu.org ([209.51.188.92]:59124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goR4Z-0003vz-6q
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goR4Y-0007gC-Dy
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:56:55 -0500
Date: Tue, 29 Jan 2019 11:56:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190129105648.GC4467@dhcp-200-176.str.redhat.com>
References: <20190124141731.21509-1-kwolf@redhat.com>
	<f314a45b-72d4-bc00-07a4-1437c58d286a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <f314a45b-72d4-bc00-07a4-1437c58d286a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Cache lseek result for data
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, mreitz@redhat.com, qemu-devel@nongnu.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 24.01.2019 um 16:56 hat Eric Blake geschrieben:
> On 1/24/19 8:17 AM, Kevin Wolf wrote:
> > Depending on the exact image layout and the storage backend (tmpfs is
> > konwn to have very slow SEEK_HOLE/SEEK_DATA), caching lseek results can
> > save us a lot of time e.g. during a mirror block job or qemu-img convert
> > with a fragmented source image (.bdrv_co_block_status on the protocol
> > layer can be called for every single cluster in the extreme case).
> >=20
> > We may only cache data regions because of possible concurrent writers.
> > This means that we can later treat a recently punched hole as data, but
> > this is safe. We can't cache holes because then we might treat recently
> > written data as holes, which can cause corruption.
>=20
> gluster copies heavily from file-posix's implementation; should it also
> copy this cache of known-data?  Should NBD also cache known-data when
> NBD_CMD_BLOCK_STATUS is available?

This almost suggests that we should do the caching in generic block
layer code.

It would require that we can return a *pnum from the block driver that
is larger than the requested bytes from, but it looks like
raw_co_block_status() already handles this? We just don't seem to do
this yet in the block drivers.

If we want to cache for all drivers, however, the question is whether
there are drivers that can transition a block from data to hole without
a discard operation, so that we would have to invalidate the cache in
more places. One thing that comes to mind is loading an internal
snapshot for qcow2.

Or maybe we need to make this opt-in for drivers, with a bool flag in
BlockDriver?

Kevin

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcUDFwAAoJEH8JsnLIjy/WSAEP/AoqquViMvHYDHlKSGuhLnKF
1Zpby/tt4MvM56nGGYLJ7ApPntjAR638Skc3hTGSiLRN6RJK1GKS6AEqn1h90zAk
tdOj43CE3qhQvK5iRjNp+ElX1Y2XipT3u5b6nT2ZhBABA7gyLyytv46kgw0REhfv
dHYD0lI2xbwE7yaA2wai0xfhAhx/4UI72RgsiP4gWDLVjbBC81pXbef17zeK4MFS
DYPrP8EL3eTa9AQQ3pK8rIbRnWdjHzxvTthMrDNyR0UGXag5mECqRtNxJ1o37Bzu
166vw6LmdxRebHNTCijmuApKjELlG+xsfahmmQdr/GypnC7sozt3wVhNlrLKPMTR
HQa0aTMoRBPJFVaQN+7913KIDdLOugjNylpr4M0wg5VaYvDU5Z8SvjK0FCrgGATY
cqZQOwuCMMMjg9BDH22LrOApUEkuYiw3Qk2JQJ6GLekpLwz5s3OGdlp4lNx6Eiyj
9PUC4yN118S3W4auEbqRIp4y+W7v04bwSj6EKSxkKbV2HNgtLv8ZFpEnRypiUfLM
a8qhMTOURMOiyp6m4dLvSUJgMXYyYb4yGTF4L1udeRtntOK4IBpSL7Gsv8wuUNC5
9wXy8UkvjaDSH0cRIzmdGMGEJsgtBfweAoVlKDnoh6tjr0j6uDKcH06XCNzBVkhg
BINZf8JsbdPpsradN7G7
=EfA/
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
