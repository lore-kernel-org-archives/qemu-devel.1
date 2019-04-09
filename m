Received: from eggs.gnu.org ([209.51.188.92]:33238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDoxa-0000eL-Rc
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDoxZ-0003mt-P8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:30:38 -0400
Date: Tue, 9 Apr 2019 12:26:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190409112608.GD16944@stefanha-x1.localdomain>
References: <20190402121908.44081-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <20190402121908.44081-1-slp@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] aio: Add a knob to always
 poll if there are in-flight requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 02:19:08PM +0200, Sergio Lopez wrote:
> The polling mode in aio_poll is able to trim down ~20us on the average
> request latency, but it needs manual fine tuning to adjust it to the
> characteristics of the storage.
>=20
> Here we add a new knob to the IOThread object, "poll-inflight". When
> this knob is enabled, aio_poll will always use polling if there are
> in-flight requests, ignoring the rest of poll-* parameters. If there
> aren't any in-flight requests, the usual polling rules apply, which is
> useful given that the default poll-max-ns value of 32us is usually
> enough to catch a new request in the VQ when the Guest is putting
> pressure on us.
>=20
> To keep track of the number of in-flight requests, AioContext has a
> new counter which is increased/decreased by thread-pool.c and
> linux-aio.c on request submission/completion.
>=20
> With poll-inflight, users willing to spend more Host CPU resources in
> exchange for a lower latency just need to enable a single knob.
>=20
> This is just an initial version of this feature and I'm just sharing
> it to get some early feedback. As such, managing this property through
> QAPI is not yet implemented.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  block/linux-aio.c         |  7 +++++++
>  include/block/aio.h       |  9 ++++++++-
>  include/sysemu/iothread.h |  1 +
>  iothread.c                | 33 +++++++++++++++++++++++++++++++++
>  util/aio-posix.c          | 32 +++++++++++++++++++++++++++++++-
>  util/thread-pool.c        |  3 +++
>  6 files changed, 83 insertions(+), 2 deletions(-)

Hi Sergio,
More polling modes are useful for benchmarking and performance analysis.
=46rom this perspective I think poll-inflight is worthwhile.

Like most performance optimizations, the effectiveness of this new
polling mode depends on the workload.  It could waste CPU, especially on
a queue depth 1 workload with a slow disk.

Do you think better self-tuning is possible?  Then users don't need to
set tunables like this one.

Stefan

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrIFQAAoJEJykq7OBq3PI8qEH/iryfV2vz33+lmOKyk29N+b+
qk05411mD/cl8TAmQm05SIKmr9A0CNgdI0zCb8vLPtEadtV/yQA9wwFubTxcGKGS
fZwQljUFVApmcARAIBRgZRQVXmGVGZ1+n5NbsPN1m4bchjpS1JslVLRFJrybSJ3z
Xva4M4oQf/IL4OqDmhrJKQpFwPG/zBalvQEkQHPlsXdyR/ijpNl/hxA0uNW6ZCkp
a4g7s8by5i43v5xCuK8Eb41hmGa3vpnpTatU7hm6WlguvVZKFpFGgQEBFVM7kh7O
8kV5pJWbVKUACaf/C8mTeU12GIPiua6dXeijTya9x6kgmncJipeFMhtlx9T6N94=
=L82Y
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
