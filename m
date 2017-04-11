Received: from eggs.gnu.org ([2001:4830:134:3::10]:46167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxzC2-0007bK-AT
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxzBy-00077X-EF
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:03:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cxzBy-00077D-8O
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:02:58 -0400
Date: Tue, 11 Apr 2017 18:02:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170411170250.GF5940@stefanha-x1.localdomain>
References: <20170411131733.27542-1-lvivier@redhat.com>
	<20170411131733.27542-3-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
Content-Disposition: inline
In-Reply-To: <20170411131733.27542-3-lvivier@redhat.com>
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


--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 03:17:33PM +0200, Laurent Vivier wrote:
> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> index 9639f4e..d270d56 100644
> --- a/hw/virtio/virtio-rng.c
> +++ b/hw/virtio/virtio-rng.c
> @@ -53,6 +53,15 @@ static void chr_read(void *opaque, const void *buf, si=
ze_t size)
>          return;
>      }
> =20
> +    /* we can't modify the virtqueue until
> +     * our state is fully synced
> +     */
> +
> +    if (!runstate_check(RUN_STATE_RUNNING)) {
> +        trace_virtio_rng_cpu_is_stopped(vrng);
> +        return;
> +    }
> +

I'm concerned about what happens when the guest is stopped and resumed
(e.g. 'stop' and 'cont' monitor commands).  Since we throw away the
chr_read() callback the device will hang unless the guest kicks it
again?

It's not clear to me that the rate limit timer will help us...

Stefan

--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY7Qw6AAoJEJykq7OBq3PI8/cH/iQ3w+snk0JxdolkMgKPqcKu
8HwL06vpt3xPIECO4j6NcNtiqevITPZq8PWSTWbK081KxoBlEQHTyGXCu5hI+jsD
8vAI74Gc4rrzzxhAVrXNP2izH6JEgO9PCNYm1YsZgBpr8i/DceRjmEo/6kEQnlw9
poBRnNLb4Nsws+2MWBGFBF6Ui+WfyDDmHF1HInmMJqUz3JZAGvdrdMFSiMpwhklF
6KF2AujYFyIduLL6vAcjZuIFi4JLpFAA5ebESYbZ3jLZ+Ki4VqOFhIDhfsXjx2IK
hgETq+quGbtBWV0sOpRepMsBl0zIxMQhb3gW1420v0BJkEvkpb0GXrnjlwXfyoA=
=oNhU
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--
