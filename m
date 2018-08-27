Received: from eggs.gnu.org ([2001:4830:134:3::10]:38382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuDtM-0007jv-Eu
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuDqi-0003JM-6o
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:30:16 -0400
References: <20180823220856.10094-1-jsnow@redhat.com>
	<20180823220856.10094-2-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <86874359-e26c-4974-c2ec-bbc4e8ade264@redhat.com>
Date: Mon, 27 Aug 2018 11:30:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180823220856.10094-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JNNGtBsmvprbAUTtajiAaZNlDYQauo6Rt"
Subject: Re: [Qemu-devel] [PATCH v2 1/9] jobs: change start callback to run
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JNNGtBsmvprbAUTtajiAaZNlDYQauo6Rt
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>
Message-ID: <86874359-e26c-4974-c2ec-bbc4e8ade264@redhat.com>
Subject: Re: [PATCH v2 1/9] jobs: change start callback to run callback
References: <20180823220856.10094-1-jsnow@redhat.com>
 <20180823220856.10094-2-jsnow@redhat.com>
In-Reply-To: <20180823220856.10094-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:08, John Snow wrote:
> Presently we codify the entry point for a job as the "start" callback,
> but a more apt name would be "run" to clarify the idea that when this
> function returns we consider the job to have "finished," except for
> any cleanup which occurs in separate callbacks later.
>=20
> As part of this clarification, change the signature to include an error=

> object and a return code. The error ptr is not yet used, and the return=

> code while captured, will be overwritten by actions in the job_complete=
d
> function.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c            |  7 ++++---
>  block/commit.c            |  7 ++++---
>  block/create.c            |  8 +++++---
>  block/mirror.c            | 10 ++++++----
>  block/stream.c            |  7 ++++---
>  include/qemu/job.h        |  2 +-
>  job.c                     |  6 +++---
>  tests/test-bdrv-drain.c   |  7 ++++---
>  tests/test-blockjob-txn.c | 16 ++++++++--------
>  tests/test-blockjob.c     |  7 ++++---
>  10 files changed, 43 insertions(+), 34 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

But I see a discrepancy in the upcoming s->ret <=3D> s->err relationship
now.  And that is if .run() doesn't return an Error *...

That could be remedied immediately in job_co_entry(), though, either by
calling job_update_rc(), or by inlining its "if (!job->err)" part.

Max


--JNNGtBsmvprbAUTtajiAaZNlDYQauo6Rt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluDxJgACgkQ9AfbAGHV
z0C6RggAsP9BcZ/wtts4CWt645L5T7qR1Oh+ekur3hCbTETVK535HR5M9RubnYtR
QoVdEh9z6lfcH6Y/owK9aeXw7IMI6Jwpa8jXYMNqzK9UDmMosdvlF1CgFh/04BYb
JnBcaOSJriRWkJjgU+juCOUAdgiNxlxUr2aNnHyyCHwGtmkxY/8QE/pIOgq4YUwe
XfKAY9pMdYZ3A0y/ZUiPkAosiW+z5VviVo30GBXVCcCcBLF+n0TuE+DNeCGsUTB4
TXvZ9Mx9Kcze3Tf1bNy7sOGUGD6xdpmmJaIAK3eqR8Wso5n3jZJ27WYRL6YNfxkF
Uwqqo6h4HtTuIch7EZUE2cyxZhoLNQ==
=Ru1E
-----END PGP SIGNATURE-----

--JNNGtBsmvprbAUTtajiAaZNlDYQauo6Rt--
