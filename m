Received: from eggs.gnu.org ([2001:4830:134:3::10]:45032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUbU3-0003p0-RT
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUbU2-0007NH-Oq
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:24:27 -0400
Date: Mon, 10 Jul 2017 17:24:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710162419.GS14195@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aJ74fq0Y6SrIeKCM"
Content-Disposition: inline
In-Reply-To: <20170706163828.24082-12-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/11] block/snapshot: do not take
 AioContext lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--aJ74fq0Y6SrIeKCM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 06:38:28PM +0200, Paolo Bonzini wrote:
> Snapshots are only created/destroyed/loaded under the BQL, while no
> other I/O is happening.  Snapshot information could be accessed while
> other I/O is happening, but also under the BQL so they cannot be
> modified concurrently.  The AioContext lock is overkill.  If needed,
> in the future the BQL could be split to a separate lock covering all
> snapshot operations, and the create/destroy/goto callbacks changed
> to run in a coroutine (so the driver can do mutual exclusion as usual).
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/snapshot.c          | 28 +---------------------------
>  blockdev.c                | 43 ++++++++++++-----------------------------=
--
>  hmp.c                     |  7 -------
>  include/block/block_int.h |  5 +++++
>  include/block/snapshot.h  |  4 +---
>  migration/savevm.c        | 22 ----------------------
>  monitor.c                 | 10 ++--------
>  7 files changed, 21 insertions(+), 98 deletions(-)
>=20
> diff --git a/block/snapshot.c b/block/snapshot.c
> index a46564e7b7..08c59d6166 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -384,9 +384,7 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverS=
tate *bs,
>  }
> =20
> =20
> -/* Group operations. All block drivers are involved.
> - * These functions will properly handle dataplane (take aio_context_acqu=
ire
> - * when appropriate for appropriate block drivers) */
> +/* Group operations. All block drivers are involved.  */

Perhaps "These functions must be called under the BQL"?

My concern with this patch series in general is that it will lead to
bugs due to inconsistencies and lack of locking documentation:

bdrv_all_delete_snapshot() is called by hmp_delvm() outside a
bdrv_drained_begin() region.  That's okay because internally
bdrv_snapshot_delete() will call bdrv_drained_begin() for the crucial
operations that require a quiesced BDS.

Compare that with bdrv_all_goto_snapshot(), which is called inside a
bdrv_drained_begin() region by load_snapshot().  Internally it doesn't
drain.

Previously the bdrv_all_*() functions behaved consistently.  We could
say that they will acquire AioContexts themselves.  Now they behave
inconsistently and while the code currently happens to work, there is no
structure that will keep it working as it is modified.

I think we're reaching a point where every BlockDriver callback and
every bdrv_*() function needs the following information:

1. Must be called under BQL?
2. Can I/O requests be in flight?
3. Is it thread-safe?

Otherwise it will be a nightmare to modify the code since these
constraints are not enforced by the compiler and undocumented.

--aJ74fq0Y6SrIeKCM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY6ozAAoJEJykq7OBq3PIk/kH/iMFHGaQH10WCj828tgM4omu
dywDYDCZrO0LLk2395iKBeq6fwoZ0NJfz8phqjp9uwJa+Ngr+3zr5nFp925yPXHl
kHBJwkx7bER/1v+NeWGPNwQep/jyOvHmFLWYis8hMEV8Czep1EmLqobSTaqScnpS
RYiI9Ldo9pPhS/UI5q6kT7X1JSQbQ8FnkOimwrGDnctqDUkqbhUvcsMy67Cf2rzD
mT2ezS/ZMxQ8m8+jIpm/lcDYErnbmnfKkSEwxTjpUTBdJQAwZakwatuOP37yXlnp
Yacd5uRskhHU982VOMTRnu3x8Jr54BvnFDPF0UcW0NGKYhhuoHUP4SR2xeS05wo=
=oSG+
-----END PGP SIGNATURE-----

--aJ74fq0Y6SrIeKCM--
