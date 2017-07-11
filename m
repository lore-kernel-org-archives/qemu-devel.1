Received: from eggs.gnu.org ([2001:4830:134:3::10]:48216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrj6-0003h4-9M
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrj3-0004AF-5e
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:45:04 -0400
Date: Tue, 11 Jul 2017 10:43:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711094356.GI17792@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-12-pbonzini@redhat.com>
	<20170710162419.GS14195@stefanha-x1.localdomain>
	<c5efa0c6-92a1-76f6-c1ba-34b36ef93cbd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VkVuOCYP9O7H3CXI"
Content-Disposition: inline
In-Reply-To: <c5efa0c6-92a1-76f6-c1ba-34b36ef93cbd@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 11/11] block/snapshot: do not
 take AioContext lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 06:27:27PM +0200, Paolo Bonzini wrote:
> On 10/07/2017 18:24, Stefan Hajnoczi wrote:
> > On Thu, Jul 06, 2017 at 06:38:28PM +0200, Paolo Bonzini wrote:
> >> Snapshots are only created/destroyed/loaded under the BQL, while no
> >> other I/O is happening.  Snapshot information could be accessed while
> >> other I/O is happening, but also under the BQL so they cannot be
> >> modified concurrently.  The AioContext lock is overkill.  If needed,
> >> in the future the BQL could be split to a separate lock covering all
> >> snapshot operations, and the create/destroy/goto callbacks changed
> >> to run in a coroutine (so the driver can do mutual exclusion as usual).
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>  block/snapshot.c          | 28 +---------------------------
> >>  blockdev.c                | 43 ++++++++++++--------------------------=
-----
> >>  hmp.c                     |  7 -------
> >>  include/block/block_int.h |  5 +++++
> >>  include/block/snapshot.h  |  4 +---
> >>  migration/savevm.c        | 22 ----------------------
> >>  monitor.c                 | 10 ++--------
> >>  7 files changed, 21 insertions(+), 98 deletions(-)
> >>
> >> diff --git a/block/snapshot.c b/block/snapshot.c
> >> index a46564e7b7..08c59d6166 100644
> >> --- a/block/snapshot.c
> >> +++ b/block/snapshot.c
> >> @@ -384,9 +384,7 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriv=
erState *bs,
> >>  }
> >> =20
> >> =20
> >> -/* Group operations. All block drivers are involved.
> >> - * These functions will properly handle dataplane (take aio_context_a=
cquire
> >> - * when appropriate for appropriate block drivers) */
> >> +/* Group operations. All block drivers are involved.  */
> >=20
> > Perhaps "These functions must be called under the BQL"?
> >=20
> > My concern with this patch series in general is that it will lead to
> > bugs due to inconsistencies and lack of locking documentation:
> >=20
> > bdrv_all_delete_snapshot() is called by hmp_delvm() outside a
> > bdrv_drained_begin() region.  That's okay because internally
> > bdrv_snapshot_delete() will call bdrv_drained_begin() for the crucial
> > operations that require a quiesced BDS.
> >=20
> > Compare that with bdrv_all_goto_snapshot(), which is called inside a
> > bdrv_drained_begin() region by load_snapshot().  Internally it doesn't
> > drain.
>=20
> I think generally we should move bdrv_drained_begin/end calls _out_ of
> block.c and into qmp_*.  If you agree, I can add this before this patch.

Yes, I think drained regions should be in callers.  That way callers can
perform multiple operations in sequence and the result is atomic.

> > Previously the bdrv_all_*() functions behaved consistently.  We could
> > say that they will acquire AioContexts themselves.  Now they behave
> > inconsistently and while the code currently happens to work, there is no
> > structure that will keep it working as it is modified.
> >=20
> > I think we're reaching a point where every BlockDriver callback and
> > every bdrv_*() function needs the following information:
> >=20
> > 1. Must be called under BQL?
> > 2. Can I/O requests be in flight?
> > 3. Is it thread-safe?
> >=20
> > Otherwise it will be a nightmare to modify the code since these
> > constraints are not enforced by the compiler and undocumented.
>=20
> Good point.  Are (1) and (3) different ways to say the same thing or do
> you have other differences in mind?

There is a difference between (1) and (3).  If a function is thread-safe
then callers can invoke it without any constraints.  If a function
requires a specific lock to be held then that it puts a constraint on
the caller.

We do have thread-safe functions in the block layer: simple functions
that fetch a BDS field atomically.  There is no need to hold the BQL for
them.

--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZJ3cAAoJEJykq7OBq3PIISAH+wfKPnatrjS444AYlG+R/J7j
FK+bs5Z6Tq+HoTn34LlvUHfKrBSTE159mZ3YS4Ty9j9KSfAv39m9r+0YMxMbYmn0
gPRjzZRgzvP7O6DsdqweDZ+G7hs5k3ceSNH49Ev0mOmJaAuot+JijAwIWXvKmMtq
/1Qst+NquD1DO+vCw0JzlUZkFgacSKBfwBxFX6/0Bv93EeymG3ZKxT3TlpCpGCW6
lMXwjzPDw14L3Q/IRmtQU/eWcAPN3EhWxreiaGXjeLfEZLifkkExKhtSZhLjSyvA
WbCE8gMPsBjzY8h029dbmhWLqYTjc9za7bcAVKAXF/Gb4D8VwTEAiTedD/RN6V0=
=OdF9
-----END PGP SIGNATURE-----

--VkVuOCYP9O7H3CXI--
