Received: from eggs.gnu.org ([2001:4830:134:3::10]:60091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7It-0001Xb-Ge
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7Ip-00004v-HU
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:27 -0500
Date: Tue, 21 Nov 2017 10:59:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171121105935.GB25265@stefanha-x1.localdomain>
References: <cover.1511230683.git.jcody@redhat.com>
	<1f0fd95c2096688add2c7b3cfcd7016756ef19fb.1511230683.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <1f0fd95c2096688add2c7b3cfcd7016756ef19fb.1511230683.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 2/4] coroutine: abort if we try
 to schedule or enter a pending coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, kwolf@redhat.com


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 20, 2017 at 09:23:24PM -0500, Jeff Cody wrote:
> @@ -438,6 +439,16 @@ fail:
>  void aio_co_schedule(AioContext *ctx, Coroutine *co)
>  {
>      trace_aio_co_schedule(ctx, co);
> +    const char *scheduled = atomic_read(&co->scheduled);
> +
> +    if (scheduled) {
> +        fprintf(stderr,
> +                "%s: Co-routine was already scheduled in '%s'\n",
> +                __func__, scheduled);
> +        abort();
> +    }
> +    atomic_set(&co->scheduled, __func__);

According to docs/devel/atomics.txt atomic_set()/atomic_read() are
weakly ordered.  They require memory barriers to provide guarantees
about ordering.  Your patch doesn't include barriers or comments about
where the implicit barriers are.

The docs recommend using the following instead of
atomic_read()/atomic_set() to get ordering:

  typeof(*ptr) atomic_mb_read(ptr)
  void         atomic_mb_set(ptr, val)

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaFAcXAAoJEJykq7OBq3PI/l8H/j5QX1ahaddl7AE5LprLzbzB
xrAEukFDB7sNwK/AeoB7dQaTPbpWQ5jma7dCVIlBtwVUS7d8VgFnl7sj7cSrEl4f
njzZenilKU/9GTthH6us2vGslCyi/huSVZKIiPZ9Yk2op8Umg+lDJyMWue//9hg7
9qLCBwkTbtrcZ2AxeNCjhptepJ9Uwur1lLMlIuZPXUIdY145pT2aR+CR4thoDyvG
3+K5humjaaCV6NTylk0NIQlASgtiI2yssFGFBA1b223DPffn8GWxdtfuIil+fm0J
yTce5SjRnkCcc3j0FN6B77US45PKlydAEzwxjAllNalgxshRisDf26CultelthI=
=F61X
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
