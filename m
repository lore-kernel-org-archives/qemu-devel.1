Received: from eggs.gnu.org ([2001:4830:134:3::10]:50033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLQ1-0001Uf-IF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciLQ0-0006o1-De
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:32:49 -0500
Date: Mon, 27 Feb 2017 13:32:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227133245.GT28403@stefanha-x1.localdomain>
References: <1488193394-28453-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lh1tzOZp3jg2TtWy"
Content-Disposition: inline
In-Reply-To: <1488193394-28453-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V2] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, ct@flyingcircus.io, mreitz@redhat.com, famz@redhat.com, eblake@redhat.com


--Lh1tzOZp3jg2TtWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 12:03:14PM +0100, Peter Lieven wrote:
> the convert process is currently completely implemented with sync operati=
ons.
> That means it reads one buffer and then writes it. No parallelism and eac=
h sync
> request takes as long as it takes until it is completed.
>=20
> This can be a big performance hit when the convert process reads and writ=
es
> to devices which do not benefit from kernel readahead or pagecache.
> In our environment we heavily have the following two use cases when using
> qemu-img convert.
>=20
> a) reading from NFS and writing to iSCSI for deploying templates
> b) reading from iSCSI and writing to NFS for backups
>=20
> In both processes we use libiscsi and libnfs so we have no kernel cache.
>=20
> This patch changes the convert process to work with parallel running coro=
utines
> which can significantly improve performance for network storage devices:
>=20
> qemu-img (master)
>  nfs -> iscsi 22.8 secs
>  nfs -> ram   11.7 secs
>  ram -> iscsi 12.3 secs
>=20
> qemu-img-async (8 coroutines, in-order write disabled)
>  nfs -> iscsi 11.0 secs
>  nfs -> ram   10.4 secs
>  ram -> iscsi  9.0 secs
>=20
> This patches introduces 2 new cmdline parameters. The -m parameter to spe=
cify
> the number of coroutines running in parallel (defaults to 8). And the -W =
paremeter to
> allow qemu-img to write to the target out of order rather than sequential=
=2E This improves
> performance as the writes do not have to wait for each other to complete.
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>     V1->V2: - do not calculate source partition globally [Kevin]
>             - don't use s->status outside the global lock [Kevin]
>             - remove accidently left bracket in qemu-img.texi [Kevin]
>             - reworkd -W parageaph in documentation [Stefan]
>=20
>    RFC->V1: - add documentation
>             - add missing coroutine_fn annotation [Stefan]
>             - add a comment why it is safe to call coroutine_enter [Stefa=
n]
>             - check -m paramater for values < 1 [Stefan]
>             - disallow -W parameter with compression [Stefan]
>=20
> RFC V3->V4: - avoid to prepare a request queue upfront [Kevin]
>             - do not ignore the BLK_BACKING_FILE status [Kevin]
>             - redesign the interface to the read and write routines [Kevi=
n]
>=20
> RFC V2->V3: - updated stats in the commit msg from a host with a better n=
etwork card
>             - only wake up the coroutine that is acutally waiting for a w=
rite to complete.
>               this was not only overhead, but also breaking at least linu=
x AIO.
>             - fix coding style complaints
>             - rename some variables and structs
>=20
> RFC V1->V2: - using coroutine as worker "threads". [Max]
>             - keeping the request queue as otherwise it happens
>               that we wait on BLK_ZERO chunks while keeping the write ord=
er.
>               it also avoids redundant calls to get_block_status and helps
>               to skip some conditions for fully allocated imaged (!s->min=
_sparse)
>=20
> ---
>  qemu-img-cmds.hx |   4 +-
>  qemu-img.c       | 322 ++++++++++++++++++++++++++++++++++++++-----------=
------
>  qemu-img.texi    |  16 ++-
>  3 files changed, 243 insertions(+), 99 deletions(-)

I haven't checked the locking issues that Kevin pointed out, but I'm
happy on the other aspects:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Lh1tzOZp3jg2TtWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCp9AAoJEJykq7OBq3PIeGAH/RJMEX/k7kYIIMJE4ONn71hc
QpHRNLUft0wHeRzc+VcM55WUxKNwWWfT8odAL0d2SpU+vhPiwV8lUqaCV1o/5eIL
BcBk3/5HNUlceGSEpuTDkOgVT7upZwtPQnc9QQyc4+ifj1+IbpIhEaWC7KxmTFVI
eK/ZLcXvVx4/BMLRK/hGpZCVcjLZjK82qBk0vXB2rqvUnpIOE3Tb33gCzIpO3mwk
e6A8hJ1lcag8egqOd0yyZrm7HnD9wbFlGHOk+dfs28NGtB9RWLIGiJNFNOX7rp30
+g5Sc1URvqL7+OtLUGX9pjEm2/UQ+DlZmyvqjgwEgZ4GnzL+0bvokcY8mht/w/U=
=dXFd
-----END PGP SIGNATURE-----

--Lh1tzOZp3jg2TtWy--
