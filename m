Received: from eggs.gnu.org ([2001:4830:134:3::10]:42920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIKqE-0003US-TX
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIKqE-00023X-1O
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:17:10 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-32-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1d5b987a-e72e-0c2a-7c96-6bd430072fe1@redhat.com>
Date: Mon, 14 May 2018 23:17:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-32-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="umD2kA3vBXGP5hZ8JryX6gXr9ASuQKfgI"
Subject: Re: [Qemu-devel] [PATCH 31/42] job: Move transactions to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--umD2kA3vBXGP5hZ8JryX6gXr9ASuQKfgI
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <1d5b987a-e72e-0c2a-7c96-6bd430072fe1@redhat.com>
Subject: Re: [PATCH 31/42] job: Move transactions to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-32-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-32-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This moves the logic that implements job transactions from BlockJob to
> Job.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     |  54 ----------
>  include/block/blockjob_int.h |  10 --
>  include/qemu/job.h           |  71 +++++++++++--
>  blockdev.c                   |   6 +-
>  blockjob.c                   | 238 +----------------------------------=
--------
>  job.c                        | 235 +++++++++++++++++++++++++++++++++++=
+++++--
>  tests/test-blockjob-txn.c    |  12 +--
>  tests/test-blockjob.c        |   2 +-
>  8 files changed, 304 insertions(+), 324 deletions(-)

[...]

> diff --git a/job.c b/job.c
> index 49dce57c9e..2d782859ac 100644
> --- a/job.c
> +++ b/job.c

[...]

> @@ -263,9 +353,10 @@ void job_event_completed(Job *job)
>      notifier_list_notify(&job->on_finalize_completed, job);
>  }
> =20
> -void job_event_pending(Job *job)
> +static int job_event_pending(Job *job)
>  {
>      notifier_list_notify(&job->on_pending, job);
> +    return 0;
>  }
> =20
>  void job_enter_cond(Job *job, bool(*fn)(Job *job))

On second thought, I don't know why this hunk is necessary.

Max


--umD2kA3vBXGP5hZ8JryX6gXr9ASuQKfgI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5/M0ACgkQ9AfbAGHV
z0Bgtgf+MhUV25qDwJcEFte1daUoXX3Te6/QEmBtjDIoZS3HQ+d5V8+rAfalvWTF
HcrDvab4wvIOtgY/S/DPb5xSKX+LJcxD6f1l+CS0juh+OnRqbZes/GJdale1SgCF
IHgRmE7bRbjYFAhzEyokf4PlHyXlIkennDxloBSXtDiDJTWScqp/O4YiGjWn/W9f
iJM6iR186/WiSuJQbkqT33YvlPCdsY13ngFPFxJnP10/voyE6Qxc//HbKEeKjUiI
mPe25Gm1HC8Ms+Zo3SKN9cga3jo1wj7htZy0ZlAKp2eEK5CrcQefSGeRmK1h0tPr
61chcgx7OPTe2MIBuY2gOfcbWXp6PA==
=SzBj
-----END PGP SIGNATURE-----

--umD2kA3vBXGP5hZ8JryX6gXr9ASuQKfgI--
