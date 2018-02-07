Received: from eggs.gnu.org ([2001:4830:134:3::10]:35736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYUL-0001VY-Op
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejYUH-0007it-Rd
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:46:49 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
	<20180119205847.7141-12-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <98b08bf5-6ac1-a1df-e92d-046b7975e3de@redhat.com>
Date: Wed, 7 Feb 2018 23:46:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180119205847.7141-12-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l2r90CunybCAKTmfXbrpVaYiiWzXwbjYc"
Subject: Re: [Qemu-devel] [PATCH v2 11/13] block/mirror: remove
 block_job_sleep_ns calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l2r90CunybCAKTmfXbrpVaYiiWzXwbjYc
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <98b08bf5-6ac1-a1df-e92d-046b7975e3de@redhat.com>
Subject: Re: [PATCH v2 11/13] block/mirror: remove block_job_sleep_ns calls
References: <20180119205847.7141-1-jsnow@redhat.com>
 <20180119205847.7141-12-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-12-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-19 21:58, John Snow wrote:
> We're attempting to slacken the mirror loop in three different places,
> but we can combine these three attempts. Combine the early loop call to=

> block_job_pause_point with the two late-loop calls to block_job_sleep_n=
s.
>=20
> When delay_ns is 0 and it has not been SLICE_TIME since the last yield,=

> block_job_relax is merely a call to block_job_pause_point, so this shou=
ld
> be equivalent with the exception that if we have managed to not yield a=
t
> all in the last SLICE_TIME ns, we will now do so.
>=20
> I am not sure that condition was possible,
> so this loop should be equivalent.

Well, to me it even sounds like a positive change if it was a change.
We want the job to yield after SLICE_TIME ns, after all, and I don't
think it matters where that happens, exactly.

>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c     | 22 +++++++++++-----------
>  block/trace-events |  2 +-
>  2 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index a0e0044de2..192e03694f 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -761,7 +761,7 @@ static void coroutine_fn mirror_run(void *opaque)
>      assert(!s->dbi);
>      s->dbi =3D bdrv_dirty_iter_new(s->dirty_bitmap);
>      for (;;) {
> -        uint64_t delay_ns =3D 0;
> +        static uint64_t delay_ns =3D 0;

Errr.  Are you sure about that?

Now every mirror job in the qeny process will share this single
variable.  Was that your intention?

>          int64_t cnt, delta;
>          bool should_complete;
> =20
> @@ -770,9 +770,16 @@ static void coroutine_fn mirror_run(void *opaque)
>              goto immediate_exit;
>          }
> =20
> -        block_job_pause_point(&s->common);
> -
>          cnt =3D bdrv_get_dirty_count(s->dirty_bitmap);
> +
> +        trace_mirror_before_relax(s, cnt, s->synced, delay_ns);
> +        if (block_job_relax(&s->common, delay_ns)) {

See the reply to <a href=3D"HEAD^^">that patch</a>.

> +            if (!s->synced) {
> +                goto immediate_exit;
> +            }
> +        }
> +        delay_ns =3D 0;
> +
>          /* s->common.offset contains the number of bytes already proce=
ssed so
>           * far, cnt is the number of dirty bytes remaining and
>           * s->bytes_in_flight is the number of bytes currently being
> @@ -849,15 +856,8 @@ static void coroutine_fn mirror_run(void *opaque)
>          }
> =20
>          ret =3D 0;
> -        trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
> -        if (!s->synced) {
> -            block_job_sleep_ns(&s->common, delay_ns);
> -            if (block_job_is_cancelled(&s->common)) {
> -                break;
> -            }
> -        } else if (!should_complete) {
> +        if (s->synced && !should_complete) {
>              delay_ns =3D (s->in_flight =3D=3D 0 && cnt =3D=3D 0 ? SLIC=
E_TIME : 0);
> -            block_job_sleep_ns(&s->common, delay_ns);
>          }
>      }

Basic idea looks good to me (apart from the static delay_ns), but, well,
block-job-cancel on a busy job still breaks.

Max


--l2r90CunybCAKTmfXbrpVaYiiWzXwbjYc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp7gcESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7p8H/2cwN6eQRzbFnihCxb21ed3IiIoNTNGK
Ui0NppvwlokeYUm9QYsWKlQTk1gHmHDwDS4eZUZSebt2blCX9Bet8nlNJOMTs0NY
Pn1LnP2x6tVQ/OaIF+3qraq5b/9hMuKGwH2KiPBiSlrfF6RUdMh8tQhr/fIFliWV
O3ZKowiYpYjYKWo9sOetNyntVnDu4WkNyS/khRP/kK7tnmU9Tlc4+y0SWAomEfwk
+P/0Itcr23Vav2pj0hSk8pTRqsSbdvJR1M7602j1hRxI6qJBPESn2FtW8uko9x0Q
PTCKGhnX9rC+LyPmSruB6JcnUjlRyMqwFUG8dAGllFnZkTsmptg8vyw=
=qXpj
-----END PGP SIGNATURE-----

--l2r90CunybCAKTmfXbrpVaYiiWzXwbjYc--
