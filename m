Received: from eggs.gnu.org ([209.51.188.92]:34330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1wcv-0007ft-A1
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1wct-0006Ah-N7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:16:12 -0500
References: <20190307140312.28072-1-slp@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <93b48e49-87dd-9a05-49eb-09bbd7452154@redhat.com>
Date: Thu, 7 Mar 2019 11:15:48 -0600
MIME-Version: 1.0
In-Reply-To: <20190307140312.28072-1-slp@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hQnnB8DA7vKKNhhIe4BfquVleXTOBBYd1"
Subject: Re: [Qemu-devel] [PATCH] mirror: Confirm we're quiesced only if the
 job is paused or cancelled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hQnnB8DA7vKKNhhIe4BfquVleXTOBBYd1
From: Eric Blake <eblake@redhat.com>
To: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Message-ID: <93b48e49-87dd-9a05-49eb-09bbd7452154@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] mirror: Confirm we're quiesced only if the
 job is paused or cancelled
References: <20190307140312.28072-1-slp@redhat.com>
In-Reply-To: <20190307140312.28072-1-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 8:03 AM, Sergio Lopez wrote:
> While child_job_drained_begin() calls to job_pause(), the job doesn't
> actually transition between states until it runs again and reaches a
> pause point. This means bdrv_drained_begin() may return with some jobs
> using the node still having 'busy =3D=3D true'.
>=20
> As a consequence, block_job_detach_aio_context() may get into a
> deadlock, waiting for the job to be actually paused, while the coroutin=
e
> servicing the job is yielding and doesn't get the opportunity to get
> scheduled again. This situation can be reproduced by issuing a
> 'block-commit' immediately followed by a 'device_del'.
>=20
> To ensure bdrv_drained_begin() only returns when the jobs have been
> paused, we change mirror_drained_poll() to only confirm it's quiesced
> when job->paused =3D=3D true and there aren't any in-flight requests, e=
xcept
> if we reached that point by a drained section initiated by the
> mirror/commit job itself.
>=20
> The other block jobs shouldn't need any changes, as the default
> drained_poll() behavior is to only confirm it's quiesced if the job is
> not busy or completed.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  block/mirror.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20

> @@ -1119,6 +1126,16 @@ static void coroutine_fn mirror_pause(Job *job)
>  static bool mirror_drained_poll(BlockJob *job)
>  {
>      MirrorBlockJob *s =3D container_of(job, MirrorBlockJob, common);
> +
> +    /* If the job isn't paused nor cancelled, we can't be sure that it=
 won't
> +     * issue more requets. We make an exception if we've reached this =
point

requests

> +     * from one of our own drain sections, to avoid a deadlock waiting=
 for
> +     * ourselves.
> +     */
> +    if (!s->common.job.paused && !s->common.job.cancelled && !s->in_dr=
ain) {
> +        return true;
> +    }
> +
>      return !!s->in_flight;
>  }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--hQnnB8DA7vKKNhhIe4BfquVleXTOBBYd1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBUcQACgkQp6FrSiUn
Q2qZ4ggAgrRW22w7rL0Kzx7bbvy/7OmQwcU8ZFctMshLGKXPmMv19TCArAohgy+6
BPplrBTO9anlX2y5gBSZvKKUVRYi1kXiQhw1OhjwuPbnJasYNUjhOp7tEEVMbjhp
zZxFbkPacZiBdyUT55+rXJ1AFNLrT3wMPH1m/b5iwqQR25QH1s9Gn8QtzxsNs2g1
HIBJHlhTsKtK1WFee2/hAHlfFehm6R6y7SVGaKbkcMbi6j5vR98ZmkOKgNXAKdqo
KZvXZCqzFGXNs9i9jn32YIWLTyrEPfobszSahDNyQGlPi6KDARNokup5HCMlctvi
jlx6uQsbbwGzTw4qa2lmSsKk//M1Iw==
=nudE
-----END PGP SIGNATURE-----

--hQnnB8DA7vKKNhhIe4BfquVleXTOBBYd1--
