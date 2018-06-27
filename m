Received: from eggs.gnu.org ([2001:4830:134:3::10]:34096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY92Q-00047L-8S
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY92P-0005zU-9U
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:55:06 -0400
Date: Wed, 27 Jun 2018 12:54:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627115458.GG5955@stefanha-x1.localdomain>
References: <20180626142434.22090-1-kwolf@redhat.com>
	<20180626142434.22090-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline
In-Reply-To: <20180626142434.22090-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] block: Convert .bdrv_truncate
 callback to coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 04:24:30PM +0200, Kevin Wolf wrote:
> bdrv_truncate() is an operation that can block (even for a quite long
> time, depending on the PreallocMode) in I/O paths that shouldn't block.
> Convert it to a coroutine_fn so that we have the infrastructure for
> drivers to make their .bdrv_co_truncate implementation asynchronous.
>=20
> This change could potentially introduce new race conditions because
> bdrv_truncate() isn't necessarily executed atomically any more. Whether
> this is a problem needs to be evaluated for each block driver that
> supports truncate:
>=20
> * file-posix/win32, gluster, iscsi, nfs, rbd, ssh, sheepdog: The
>   protocol drivers are trivially safe because they don't actually yield
>   yet, so there is no change in behaviour.
>=20
> * copy-on-read, crypto, raw-format: Essentially just filter drivers that
>   pass the request to a child node, no problem.
>=20
> * qcow2: The implementation modifies metadata, so it needs to hold
>   s->lock to be safe with concurrent I/O requests. In order to avoid
>   double locking, this requires pulling the locking out into
>   preallocate_co() and using qcow2_write_caches() instead of
>   bdrv_flush().
>=20
> * qed: Does a single header update, this is fine without locking.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h     |  4 +++
>  include/block/block_int.h |  4 +--
>  block.c                   | 63 ++++++++++++++++++++++++++++++++++------
>  block/copy-on-read.c      |  8 +++---
>  block/crypto.c            |  9 +++---
>  block/file-posix.c        | 12 ++++----
>  block/file-win32.c        |  6 ++--
>  block/gluster.c           | 14 +++++----
>  block/iscsi.c             |  8 +++---
>  block/nfs.c               |  7 +++--
>  block/qcow2.c             | 73 ++++++++++++++++++++++++++++-------------=
------
>  block/qed.c               |  8 ++++--
>  block/raw-format.c        |  8 +++---
>  block/rbd.c               |  8 ++++--
>  block/sheepdog.c          | 12 ++++----
>  block/ssh.c               |  6 ++--
>  16 files changed, 161 insertions(+), 89 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM3sSAAoJEJykq7OBq3PIoVAH+QEql1+q84CxGgVjy1NoXiT5
H0z2Ya0JAMXU1SQIJ5OORmWcJkL4XaLXJx7elz2y9pcv/ONvmRT1zZeuHC9xLy06
l7ueRxhkPoepOYvusmMQSt929HLfi3E28hv2a7MpM3kSEbbctCCxSpVnm3OtHufg
EAr1L0ZmcyUM/7iTSegiHbkhNudSXUHe9coLu052pgx+ozsXZ8h1UbsNK/EjGTHX
Hk94Z7ro88uXN/tsUIXV0j0ox/ScJMHatjFt2A03l8ex17XMzdX8TyAlO7VbTB57
npR/Myb3ILEJ6Pv1JlT4gTLR15aR2DQdW1LuOscedfVX3y3dyfc7GZKbpwxoiNQ=
=MKrd
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
