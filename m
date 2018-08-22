Received: from eggs.gnu.org ([2001:4830:134:3::10]:52624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsR1Q-0000fP-0k
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsR1P-0001lY-2c
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:09:55 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-3-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a60390d5-b104-cbe1-c3f6-79012ce1f45c@redhat.com>
Date: Wed, 22 Aug 2018 13:09:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2KWRn58Uy7X6Q8e2Pt4S8mA2Hf8XshfiM"
Subject: Re: [Qemu-devel] [PATCH 2/7] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2KWRn58Uy7X6Q8e2Pt4S8mA2Hf8XshfiM
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com
Message-ID: <a60390d5-b104-cbe1-c3f6-79012ce1f45c@redhat.com>
Subject: Re: [PATCH 2/7] jobs: canonize Error object
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-3-jsnow@redhat.com>
In-Reply-To: <20180817190457.8292-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-17 21:04, John Snow wrote:
> Jobs presently use both an Error object in the case of the create job,
> and char strings in the case of generic errors elsewhere.
>=20
> Unify the two paths as just j->err, and remove the extra argument from
> job_completed. The integer error code for job_completed is kept for now=

> for use by pre-emptive cancellation.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c            |  2 +-
>  block/commit.c            |  2 +-
>  block/create.c            |  5 ++---
>  block/mirror.c            |  2 +-
>  block/stream.c            |  2 +-
>  include/qemu/job.h        | 10 ++++------
>  job-qmp.c                 |  5 +++--
>  job.c                     | 19 ++++++-------------
>  tests/test-bdrv-drain.c   |  2 +-
>  tests/test-blockjob-txn.c |  2 +-
>  tests/test-blockjob.c     |  2 +-
>  11 files changed, 22 insertions(+), 31 deletions(-)

So...  Why does this patch come before removing the @ret parameter from
job_completed()?

[...]

> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index 9cf463d228..5c92c53ef0 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -124,12 +124,12 @@ typedef struct Job {
>      /** Estimated progress_current value at the completion of the job =
*/
>      int64_t progress_total;
> =20
> -    /** Error string for a failed job (NULL if, and only if, job->ret =
=3D=3D 0) */
> -    char *error;
> -
>      /** ret code passed to job_completed. */
>      int ret;
> =20
> +    /** Error object for a failed job **/
> +    Error *err;
> +

Is there a reason why you remove the iff relationship?

(Maybe because job_completed() still receives @ret? :-))

Max

>      /** The completion function that will be called when the job compl=
etes.  */
>      BlockCompletionFunc *cb;
> =20


--2KWRn58Uy7X6Q8e2Pt4S8mA2Hf8XshfiM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9RHMACgkQ9AfbAGHV
z0CtlwgAs5IMWuj4P4j+vVxS6muQu8DrtNX3jN4qdOV7tQ9y/6g+7FloGeMEu/Ti
hctpf/ZF0f6IDYA1QeA1Nql96tivTcWV7lBSxMtnYHWNHVTsTzfKjEFEij1S4DSU
p47lgc+nh/+rVgQ1DA2jMpsduORMDi2okOYgzm1aPEVIcdXDIvU5HG+E/t0L/x5M
UJthIdbnd4a5QsTSHo64SrFftKDDzRJv9xjaU4uzI98BvyiLEQTW50QhNHuTxNKI
JVAifTqEZdUTqmx7cr3HWnc5Ip9L3TGz1yNlQxVxykfqvRqYsk3u7m5ESV3CsC2b
egOdCwq/uBXIFXGH5m7qUCifdHeEsA==
=EaQi
-----END PGP SIGNATURE-----

--2KWRn58Uy7X6Q8e2Pt4S8mA2Hf8XshfiM--
