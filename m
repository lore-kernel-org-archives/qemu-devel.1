Received: from eggs.gnu.org ([2001:4830:134:3::10]:40225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzvD-00007L-Rq
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzv9-0007Rj-TK
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:32:39 -0400
Date: Tue, 8 May 2018 11:32:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508103232.GI19710@stefanha-x1.localdomain>
References: <20180427162312.18583-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline
In-Reply-To: <20180427162312.18583-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/2] block/file-posix:
 allow -drive cache.direct=off live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Fam Zheng <famz@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>


--ev7mvGV+3JQuI2Eo
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

Kevin: Are you happy with this series?

Stefan

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJa8XzAAAoJEJykq7OBq3PIafIH9iFmxcARD/BtBv3jfju/eSav
MlSgxXjLfPicHeJaQxvganz6TJU4eOYbFcGXnycGhGeokagfuL9wKfFyN/yn9oQD
5CN9RvG8Y4Ne5Up7O6EZsNZ0qh8Jn6YIAIj5nQr1JbnShaHyIf8YcCeWXVJENrg+
RmqPUrCRSKX+VKXgBEBUzVI+NP0EzLa7RBHfrUU1M71gWXjkBZO8AzKOz7Md2xGY
vkIdynCS7p7gNnJprqz8pcmJRKtGNCSvOipP2j7y+3ngN/FCq9vtvt6+f3n3Nx/K
I2blkXFU8lwLFl/J9Uo+lChixjTGNboppm/IyJBKfzhvZ/2F8axccjocDsGewg==
=MArC
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--
