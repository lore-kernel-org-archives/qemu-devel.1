Received: from eggs.gnu.org ([209.51.188.92]:48265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hE86f-0000YC-3h
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hE86e-0005Un-2a
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:57:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1hE86d-0005TJ-Np
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 03:57:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so1725027wrd.3
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 00:57:14 -0700 (PDT)
References: <20190409122823.12416-1-pbonzini@redhat.com>
From: Sergio Lopez <slp@redhat.com>
In-reply-to: <20190409122823.12416-1-pbonzini@redhat.com>
Date: Wed, 10 Apr 2019 09:56:57 +0200
Message-ID: <87k1g2i986.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0?] aio-posix: ensure poll mode is
 left when aio_notify is called
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Paolo Bonzini <pbonzini@redhat.com> writes:

> With aio=3Dthread, adaptive polling makes latency worse rather than
> better, because it delays the execution of the ThreadPool's
> completion bottom half.
>
> event_notifier_poll() does run while polling, detecting that
> a bottom half was scheduled by a worker thread, but because
> ctx->notifier is explicitly ignored in run_poll_handlers_once(),
> scheduling the BH does not count as making progress and
> run_poll_handlers() keeps running.  Fix this by recomputing
> the deadline after *timeout could have changed.
>
> With this change, ThreadPool still cannot participate in polling
> but at least it does not suffer from extra latency.
>
> Reported-by: Sergio Lopez <slp@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <1553692145-86728-1-git-send-email-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: use qemu_soonest_timeout to handle timeout =3D=3D -1
>  util/aio-posix.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 6fbfa7924f..db11021287 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -519,6 +519,10 @@ static bool run_poll_handlers_once(AioContext *ctx, =
int64_t *timeout)
>          if (!node->deleted && node->io_poll &&
>              aio_node_check(ctx, node->is_external) &&
>              node->io_poll(node->opaque)) {
> +            /*
> +             * Polling was successful, exit try_poll_mode immediately
> +             * to adjust the next polling time.
> +             */
>              *timeout =3D 0;
>              if (node->opaque !=3D &ctx->notifier) {
>                  progress =3D true;
> @@ -558,8 +562,9 @@ static bool run_poll_handlers(AioContext *ctx, int64_=
t max_ns, int64_t *timeout)
>      do {
>          progress =3D run_poll_handlers_once(ctx, timeout);
>          elapsed_time =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_=
time;
> -    } while (!progress && elapsed_time < max_ns
> -             && !atomic_read(&ctx->poll_disable_cnt));
> +        max_ns =3D qemu_soonest_timeout(*timeout, max_ns);
> +        assert(!(max_ns && progress));
> +    } while (elapsed_time < max_ns && !atomic_read(&ctx->poll_disable_cn=
t));
>=20=20
>      /* If time has passed with no successful polling, adjust *timeout to
>       * keep the same ending time.
> @@ -585,8 +590,7 @@ static bool run_poll_handlers(AioContext *ctx, int64_=
t max_ns, int64_t *timeout)
>   */
>  static bool try_poll_mode(AioContext *ctx, int64_t *timeout)
>  {
> -    /* See qemu_soonest_timeout() uint64_t hack */
> -    int64_t max_ns =3D MIN((uint64_t)*timeout, (uint64_t)ctx->poll_ns);
> +    int64_t max_ns =3D qemu_soonest_timeout(*timeout, ctx->poll_ns);
>=20=20
>      if (max_ns && !atomic_read(&ctx->poll_disable_cnt)) {
>          poll_set_started(ctx, true);

Thanks, this one does the trick.

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAlytockACgkQ9GknjS8M
AjWsuA/+MB7HiJgUqJbaMu1asj8/3LtHotIOJmK+DZv1Sa7J7AVwoaCwU626npVi
beEkN9XfnPZBUS3sRrK+mg7VxOjYDNyK28tmjtga8QLmJ8A39hNKaIoaR1QY9j8c
kr3HxOVzi5pFOZIGNF0Nm91TnxPai6cYO4vEZ4PAjW014ROfBGnEqaqNqtOeVbJA
PgAvjGEe0Qw9HMGeAVNA/Cinhcps06N+hvSDgELsg0vmRvSWihOtPXNPpLkVAWbD
FO9oCrBTVcyVwoDWAnXIKUR0dS5br7pdsA9S/UiYGlsAa/MeRXMhV5ulTN8y7nq8
Ly3Okc1TYfzXblTiMC1N4owu3ldMdV5H5F+TUtEeit8czdK0+wZvsmpQKeE2ALA4
hOhkpW5ws+L7ZDhnOiiQG3NGjeYv5m425H2XtsowbALb6ABDqCy0GPJiqm57OZh6
l6WFL/sJx9KWIHc9OhqTGh+mmJYq9dtALVLPfYa+8Uc1O1115LQ1GYAP29PtERId
SK2e3kZAD6F8c1wL/FuRW3hAKr8XcFjJlVoZRcIPgq/UH8BElCRivLzCSdDLzVu5
CY/pjiEvjf21yOsaFtGB69b1s9aYEIWHUI+pPC4ls0umZjOgxKPo2lvvg/Ae274T
hn2vlg0E+FfO5b25iJRTCNYwgWMPszOQ6jLBpy+ZKyvKjuqh7EI=
=O1vw
-----END PGP SIGNATURE-----
--=-=-=--
