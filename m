Received: from eggs.gnu.org ([2001:4830:134:3::10]:46210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOhnB-0005jO-Qy
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fOhnA-0004KN-Jb
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:00:21 -0400
References: <20180509215336.31304-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3c07cbb8-f20c-a808-e4b9-c79b51e061b7@redhat.com>
Date: Fri, 1 Jun 2018 13:00:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180509215336.31304-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2KhhmrSqs0XSpaHm5HUsTj3jIECHcQzAz"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] block/file-posix: File locking
 during creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2KhhmrSqs0XSpaHm5HUsTj3jIECHcQzAz
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <3c07cbb8-f20c-a808-e4b9-c79b51e061b7@redhat.com>
Subject: Re: [PATCH v2 0/3] block/file-posix: File locking during creation
References: <20180509215336.31304-1-mreitz@redhat.com>
In-Reply-To: <20180509215336.31304-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 23:53, Max Reitz wrote:
> [Unchanged text from v1 ahead]
>=20
> Currently we do not take permissions on a file while it is being
> created.  That is a bit sad.  The simplest way to test this is the
> following:
>=20
>     $ qemu-img create -f qcow2 foo.qcow2 64M
>     Formatting 'foo.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
65536 lazy_refcounts=3Doff refcount_bits=3D16
>     $ qemu-img convert -f qcow2 -O qcow2 foo.qcow2 foo.qcow2
>     qemu-img: foo.qcow2: error while converting qcow2: Failed to get "w=
rite" lock
>     Is another process using the image?
>     $ qemu-img info foo.qcow2
>     image: foo.qcow2
>     file format: raw
>     virtual size: 0 (0 bytes)
>     disk size: 0
>=20
> (See also https://bugzilla.redhat.com/show_bug.cgi?id=3D1519144)
>=20
> Here is what's happening: file-posix opens the file with
> O_CREAT | O_TRUNC, thus truncating the file to 0.  Then qcow2 tries to
> format it, but fails because it needs the WRITE permission to do so.  S=
o
> it cannot format it and the file stays empty.
>=20
> We should actually take a WRITE and a RESIZE permission before we
> truncate the file, and this is what this series does.
>=20
> I personally consider the solution taken here a bit of a hack, but it
> works and we don't have any locking in any drivers but file-posix
> anyway, so it isn't lacking anything in that regard.  Integrating it in=

> blockdev-create might be possible, but there are two issues:
> (1) It would be harder.
> (2) What would we do anyway?  We'd advise protocol drivers to take WRIT=
E
>     and RESIZE permissions before they truncate a file to be empty...
>     Well, and then they'd do exactly what file-posix is made to do in
>     this series.
>=20
> So basically what I consider a hack could be seen as exactly the right
> way to tackle the issue: Protocol drivers have to ensure the correct
> permissions (and they have to choose what those are) are applied before=

> changing any file -- which is what this series implements.
>=20
>=20
> v2:
> - Patch 2: [Fam]
>   - Add a note that while not sharing the RESIZE permission does protec=
t
>     us from other block-layer-infused programs resizing the file while
>     raw_co_create() is active; it does not protect against anyone
>     resizing the file afterwards.
>   - Drop the unnecessary second raw_apply_lock_bytes()
>=20
>=20
> git-backport-diff against v1:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/3:[----] [--] 'block/file-posix: Pass FD to locking helpers'
> 002/3:[0016] [FC] 'block/file-posix: File locking during creation'
> 003/3:[----] [--] 'iotests: Add creation test to 153'
>=20
>=20
> Max Reitz (3):
>   block/file-posix: Pass FD to locking helpers
>   block/file-posix: File locking during creation
>   iotests: Add creation test to 153
>=20
>  block/file-posix.c         | 64 +++++++++++++++++++++++++++++++++++---=
--------
>  tests/qemu-iotests/153     | 18 +++++++++++++
>  tests/qemu-iotests/153.out | 13 ++++++++++
>  3 files changed, 80 insertions(+), 15 deletions(-)

Applied to my block branch.

Max


--2KhhmrSqs0XSpaHm5HUsTj3jIECHcQzAz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsRJzIACgkQ9AfbAGHV
z0BN1wgAw3/5DFlwAwrb6nY/1qnAcvLtkdNP3RLgNaKkHNaFPsrga7DkIS/sVJVD
4WYsgjBQPH6d3uoGTt+s+5IinnpnleZOAdb31MGaakDn7s8/kS02NmfEEGZ/2/e1
gJrB8tPtfoDJ7KC0MCFz4VySXDpV1RNxw2pmJ4BMNDMG7CGzxI77JdlBybOcqihd
iPqfLBr9kuPlmq4+1zx9qJDfuNv06ZJFRmb3yJFOxD+4gueqopfYl3WayKGQP1Bd
0lSMb+FPqPnKi0R8Oym2hSJy/uJDM+FpmEI9w+pRNGAfDfQc1uFE64qWvL/RrMZ1
UF0Zrq5neMmQcWzmW/IwOPtgPOuaPA==
=DGs8
-----END PGP SIGNATURE-----

--2KhhmrSqs0XSpaHm5HUsTj3jIECHcQzAz--
