Received: from eggs.gnu.org ([2001:4830:134:3::10]:52785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHAJi-0004GQ-AW
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHAJh-0005I8-C5
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:50:46 -0400
Date: Fri, 11 May 2018 16:50:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180511155030.GA26169@stefanha-x1.localdomain>
References: <20180427162312.18583-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20180427162312.18583-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block/file-posix: allow -drive
 cache.direct=off live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Sergio Lopez <slp@redhat.com>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2018 at 05:23:10PM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Add comment on !__linux__ situation [Fam]
>  * Add file-posix.c x-check-cache-dropped=3Don|off option [DaveG, Kevin]
>=20
> file-posix.c only supports shared storage live migration with -drive
> cache.direct=3Doff due to cache consistency issues.  There are two main s=
hared
> storage configurations: files on NFS and host block devices on SAN LUNs.
>=20
> The problem is that QEMU starts on the destination host before the source=
 host
> has written everything out to the disk.  The page cache on the destinatio=
n host
> may contain stale data read when QEMU opened the image file (before migra=
tion
> handover).  Using O_DIRECT avoids this problem but prevents users from ta=
king
> advantage of the host page cache.
>=20
> Although cache=3Dnone is the recommended setting for virtualization use c=
ases,
> there are scenarios where cache=3Dwriteback makes sense.  If the guest ha=
s much
> less RAM than the host or many guests share the same backing file, then t=
he
> host page cache can significantly improve disk I/O performance.
>=20
> This patch series implements .bdrv_co_invalidate_cache() for block/file-p=
osix.c
> on Linux so that shared storage live migration works.  I have sent it as =
an RFC
> because cache consistency is not binary, there are corner cases which I've
> described in the actual patch, and this may require more discussion.
>=20
> Regarding NFS, QEMU relies on O_DIRECT rather than the close-to-open
> consistency model (see nfs(5)), which is the basic guarantee provided by =
NFS.
> After this patch cache consistency is no longer provided by O_DIRECT.
>=20
> This patch series relies on fdatasync(2) (source) +
> posix_fadvise(POSIX_FADV_DONTNEED) (destination) instead.  I believe it i=
s safe
> for both NFS and SAN LUNs.  Maybe we should use fsync(2) instead of
> fdatasync(2) so that NFS has up-to-date inode metadata?
>=20
> Stefan Hajnoczi (2):
>   block/file-posix: implement bdrv_co_invalidate_cache() on Linux
>   block/file-posix: add x-check-page-cache=3Don|off option
>=20
>  qapi/block-core.json |   7 ++-
>  block/file-posix.c   | 146 +++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 150 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.14.3
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9bvGAAoJEJykq7OBq3PIHN4IAIvFiNkHkt1NUOgGN3Cz3tWu
epyphppJVYwUcs+0dKSe2LHta8jywKt70DJQ0oivGUF3Yg2RD+vex+pZDsNpGrrq
Z+9gRZM1zL1NPrdr6InR4UTWgbJksc+CXWctcqGp8OAInwsrFizFeXQlBvyW1Phd
eIN+rTVitqEgzTz/5/ZIzPaWJVCG9FpIyzHS0GbZqwupwktH/coBIDXStg+NtbZh
RAGUrTQ2grI03qTc9stkZDEWaBAhZKj1DvRomFYzOaTIdBhdXH8LmhRDk+heaMuI
2wSPn53X1P+apducxPo9+M2k5J5n4923CSwb1syzU1+SE6AA3TBfUcV5wwbF5qM=
=bPNJ
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
