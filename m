Received: from eggs.gnu.org ([2001:4830:134:3::10]:50655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QCY-0006pe-6y
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QCX-00028n-CS
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:11:22 -0400
Date: Fri, 20 Apr 2018 15:11:12 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420071112.GC15181@stefanha-x1.localdomain>
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <20180411163940.2523-5-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 04/19] block: Don't manually
 poll in bdrv_drain_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 06:39:25PM +0200, Kevin Wolf wrote:
> All involved nodes are already idle, we called bdrv_do_draine_begin() on
> them.
>=20
> The comment in the code suggested that this were not correct because the
> completion of a request on one node could spawn a new request on a
> different node (which might have been drained before, so we wouldn't
> drain the new request). In reality, new requests to different nodes
> aren't spawned out of nothing, but only in the context of a parent
> request, and they aren't submitted to random nodes, but only to child
> nodes. As long as we still poll for the completion of the parent request
> (which we do), draining each root node separately is good enough.
>=20
> Remove the additional polling code from bdrv_drain_all_begin() and
> replace it with an assertion that all nodes are already idle after we
> drained them separately.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 41 ++++++++++++-----------------------------
>  1 file changed, 12 insertions(+), 29 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2ZKQAAoJEJykq7OBq3PIAnQIAIGIERTw5sI6SyXjervwa9ul
yltOpfXXhOcRMnhKu8ve3J8l5dshxcPD7NQmLik9cRh8E2VAo4vLYvtKGoouBlBB
Hk+YwZQ1rIvKIpFRaJHZwZqFjXQ36beHJanumcAKfPR5EErj1CRTAQo279P+7Thk
fjIX9Qj+JvVB/ufSlrTkqmLmDUfrXPOWbqTRPcVXCwxkTj/wn6VfCsLs1hzS0Dk1
g1J5VaMI+1AnZIAD3iPQ4tr+zL9HTjZ88JrON+WdVhuekztx5U6yVIx+oCNVUzKL
KUhr3K8cLg4+5xbaKI0pIkaq4S2M4npjAMKHfpWQxENX0rZWWLBR6+lNGTQ5J5w=
=4bbA
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
