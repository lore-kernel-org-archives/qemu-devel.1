Received: from eggs.gnu.org ([2001:4830:134:3::10]:38959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAcw4-0006Qe-EA
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAcw3-0003wL-Kf
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:54:48 -0400
Date: Tue, 16 May 2017 14:54:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516135425.GG8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/18] throttle-groups: only start one
 coroutine from drained_begin
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


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:41:57PM +0200, Paolo Bonzini wrote:
> Starting all waiting coroutines from bdrv_drain_all is unnecessary;
> throttle_group_co_io_limits_intercept calls schedule_next_request as
> soon as the coroutine restarts, which in turn will restart the next
> request if possible.
>=20
> If we only start the first request and let the coroutines dance from
> there the code is simpler and there is more reuse between
> throttle_group_config, throttle_group_restart_blk and timer_cb.  The
> next patch will benefit from this.
>=20
> We also stop accessing from throttle_group_restart_blk the
> blkp->throttled_reqs CoQueues even when there was no
> attached throttling group.  This worked but is not pretty.
>=20
> The only thing that can interrupt the dance is the QEMU_CLOCK_VIRTUAL
> timer when switching from one block device to the next, because the
> timer is set to "now + 1" but QEMU_CLOCK_VIRTUAL might not be running.
> Set that timer to point in the present ("now") rather than the future
> and things work.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: new
>=20
>  block/throttle-groups.c | 45 +++++++++++++++++++++++++------------------=
--
>  1 file changed, 25 insertions(+), 20 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGwSRAAoJEJykq7OBq3PIeC8IAIwW9otGwgLF3XniFx9HI/0y
khxNpApZ0hYy0SORnuJ2UAWk+MOKONMndssTqljuAxva7bbXAEjhua20qiDUI8cr
10/9JyyQRTmPQcKGtfNP8rODXvFoI1RODN2o36ovrhSBeJ8XN+AlzHusouc+5g7Q
8PcqqQbDuMVWClu7st3TcFR+3Tzr5aN4u4vclymIpVK555X9dAZ6BQj5hKAnaJuo
dardNUUiEz/tA2buGcOWObj7U/SJYIB5oMuCyJ4BfLg7LoNvHA+ltGU8d3IaQ3zx
Xmtquau1VRA8xZ6UXIo6T/vba2ez2kiQl0BAhZ6EzckNlP5VcbOXtmriJcPKYTA=
=GGa8
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
