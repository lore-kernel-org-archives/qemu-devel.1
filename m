Received: from eggs.gnu.org ([209.51.188.92]:48830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goaXK-0008D1-0r
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goaXJ-0004AI-5R
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:03:13 -0500
References: <20190124141731.21509-1-kwolf@redhat.com>
	<f314a45b-72d4-bc00-07a4-1437c58d286a@redhat.com>
	<20190129105648.GC4467@dhcp-200-176.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae9f2c89-d38c-01b7-429c-6caa655c3068@redhat.com>
Date: Tue, 29 Jan 2019 15:03:07 -0600
MIME-Version: 1.0
In-Reply-To: <20190129105648.GC4467@dhcp-200-176.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aYi81CZZ5Smj9EDUlclHncv3wRJrIuNwD"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aYi81CZZ5Smj9EDUlclHncv3wRJrIuNwD
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, mreitz@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <ae9f2c89-d38c-01b7-429c-6caa655c3068@redhat.com>
Subject: Re: [PATCH] file-posix: Cache lseek result for data regions
References: <20190124141731.21509-1-kwolf@redhat.com>
 <f314a45b-72d4-bc00-07a4-1437c58d286a@redhat.com>
 <20190129105648.GC4467@dhcp-200-176.str.redhat.com>
In-Reply-To: <20190129105648.GC4467@dhcp-200-176.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 1/29/19 4:56 AM, Kevin Wolf wrote:

>> gluster copies heavily from file-posix's implementation; should it als=
o
>> copy this cache of known-data?  Should NBD also cache known-data when
>> NBD_CMD_BLOCK_STATUS is available?
>=20
> This almost suggests that we should do the caching in generic block
> layer code.
>=20
> It would require that we can return a *pnum from the block driver that
> is larger than the requested bytes from, but it looks like
> raw_co_block_status() already handles this? We just don't seem to do
> this yet in the block drivers.

The code in io.c bdrv_co_block_status() currently does one final
clamp-down to limit the answer to the caller's maximum request, but I
don't know if any drivers actually take advantage of passing back larger
than the request. I _do_ know that the NBD protocol took pains to ensure
that NBD_CMD_BLOCK_STATUS is permitted to return a value beyond the
caller's request if such information was easily obtained, precisely
because the idea of letting the caller cache the knowledge of a data
section that extends beyond the current query's area of interest may be
useful to minimize the need to make future block status calls.

>=20
> If we want to cache for all drivers, however, the question is whether
> there are drivers that can transition a block from data to hole without=

> a discard operation, so that we would have to invalidate the cache in
> more places. One thing that comes to mind is loading an internal
> snapshot for qcow2.

Oh, good point - switching to a different L1 table (due to loading an
internal snapshot) can indeed make a hole appear that used to read as
data, so if the block layer caches data ranges, it also needs to provide
a hook for drivers to invalidate the cache when doing unusual actions.
Still, I can't think of any place where a hole spontaneously appears
unless a specific driver action is taken (so the driver should have the
opportunity to invalidate the cache during that action), or if an image
is in active use by more than just the qemu process.  And if the driver
knows that an image might be shared with external processes modifying
the image, then yes, maybe having a way to opt out of caching altogether
is also appropriate.

>=20
> Or maybe we need to make this opt-in for drivers, with a bool flag in
> BlockDriver?
>=20
> Kevin
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--aYi81CZZ5Smj9EDUlclHncv3wRJrIuNwD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxQv4sACgkQp6FrSiUn
Q2rFHQf+OsWnkWxWuepCsY7YnwdeLDDyU3Qz+OmsZUzqw/FDuZIGfZNDGVaNMfvn
ytC4zt5di/+i2+qvmQ3VXA1MIaS5jc5fLNc/12nxkWsvLrsGuOi3fV8dfTbAOYOE
5o4IQEdKZDWnBdozh6UneWlZ6k4HPIV49klFacsMR05tTZp98/WT/5+frXalQpuT
2HymwN+31KxTTftECDmeNUZfWBhIgDAe0NLiDXsL5dDyRIyYvKBxHLG7bUacxCTg
9tC9nf1i/3v2azxZOQtIzQpezo4PA/tE4G2bEANLNxiBV9QFr8uOSFzNY+vzHGCz
vt5k4zR32/vDo4qUdce8HDjpadF3SA==
=MIzq
-----END PGP SIGNATURE-----

--aYi81CZZ5Smj9EDUlclHncv3wRJrIuNwD--
