Received: from eggs.gnu.org ([2001:4830:134:3::10]:53402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyF1x-0001Ur-Lo
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyF1u-0006Wq-La
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:57:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cyF1u-0006V6-Dj
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:57:38 -0400
Date: Wed, 12 Apr 2017 10:57:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170412095731.GA26272@stefanha-x1.localdomain>
References: <20170411131733.27542-1-lvivier@redhat.com>
	<20170411131733.27542-3-lvivier@redhat.com>
	<20170411170250.GF5940@stefanha-x1.localdomain>
	<560dec08-1b57-9850-ff30-5f326130a59d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <560dec08-1b57-9850-ff30-5f326130a59d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-rng: stop virtqueue while the
 CPU is stopped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 07:42:02PM +0200, Laurent Vivier wrote:
> On 11/04/2017 19:02, Stefan Hajnoczi wrote:
> > On Tue, Apr 11, 2017 at 03:17:33PM +0200, Laurent Vivier wrote:
> >> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> >> index 9639f4e..d270d56 100644
> >> --- a/hw/virtio/virtio-rng.c
> >> +++ b/hw/virtio/virtio-rng.c
> >> @@ -53,6 +53,15 @@ static void chr_read(void *opaque, const void *buf,=
 size_t size)
> >>          return;
> >>      }
> >> =20
> >> +    /* we can't modify the virtqueue until
> >> +     * our state is fully synced
> >> +     */
> >> +
> >> +    if (!runstate_check(RUN_STATE_RUNNING)) {
> >> +        trace_virtio_rng_cpu_is_stopped(vrng);
> >> +        return;
> >> +    }
> >> +
> >=20
> > I'm concerned about what happens when the guest is stopped and resumed
> > (e.g. 'stop' and 'cont' monitor commands).  Since we throw away the
> > chr_read() callback the device will hang unless the guest kicks it
> > again?
> >=20
> > It's not clear to me that the rate limit timer will help us...
>=20
> I think you're right (even if it seems hard to generate this case)
>=20
> What is the best solution:
>=20
> - re-arming the timer/the backend request by calling
> virtio_rng_process() before the "return;"

This would waste CPU and throw away entropy bits.

> or
>=20
> - adding a vmstate change handler to call virtio_rng_process()?

Yes, I think vm change handlers solve the problem.

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY7foLAAoJEJykq7OBq3PIOGoH/1PH5xA87Jp8VSBS+JP16OQg
/LcAoWlJFgQcLzU6uyNCo/Jr7FQXPeCBlkOh5LqVNFYuzI5W4pqRi6GhFrWSXLfP
BxqnvixSNpL/Wy4E1vmSW2C2S6L/JuNq5Jlo7q4xTRGTGm+axMD74Hlz7wn4fzjZ
dK2B/4VVitoDkOEvdbqB1xf9D5FC+mXPOdLHn7B7D+aoBSBwbGIFd3zMBUvDZ2eq
0R81TBVL8Ezp/QIIPZSzg7kWXtDUSJfRh5ijhKM1uNH0+coU7bw+5AsO4p1MfPUr
fgo5ZjSv71ui1h8bhc6UgWef0mxa17d2QJga5EGNNWpfNEl9e/FT1zh/lM9+qts=
=UpRm
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
