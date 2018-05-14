Received: from eggs.gnu.org ([2001:4830:134:3::10]:34642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIK5c-0000Pi-By
	for qemu-devel@nongnu.org; Mon, 14 May 2018 16:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIK5b-0002oN-FF
	for qemu-devel@nongnu.org; Mon, 14 May 2018 16:29:00 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-32-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2afadd60-4f27-ff47-6174-2a2b71ac739d@redhat.com>
Date: Mon, 14 May 2018 22:28:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-32-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EJM7QaLW0IglLJlDtb3dHbzFMCeudw4ZY"
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
--EJM7QaLW0IglLJlDtb3dHbzFMCeudw4ZY
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <2afadd60-4f27-ff47-6174-2a2b71ac739d@redhat.com>
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

> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index 614a2dea92..84a9eb7980 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h

[...]

> @@ -227,20 +242,52 @@ typedef enum JobCreateFlags {

[...]

> +/**
> + * @txn: The transaction (may be NULL)
> + * @job: Job to add to the transaction
> + *
> + * Add @job to the transaction.  The @job must not already be in a tra=
nsaction.
> + * The caller must call either block_job_txn_unref() or block_job_comp=
leted()

*job_txn_unref()

(and maybe even job_completed() in preparation for the next patches)

> + * to release the reference that is automatically grabbed here.
> + *
> + * If @txn is NULL, the function does nothing.
> + */
> +void job_txn_add_job(JobTxn *txn, Job *job);

[...]

> diff --git a/job.c b/job.c
> index 49dce57c9e..2d782859ac 100644
> --- a/job.c
> +++ b/job.c

[...]

> @@ -80,6 +93,71 @@ static void __attribute__((__constructor__)) job_ini=
t(void)

[...]

> +static int job_txn_apply(JobTxn *txn, int fn(Job *), bool lock)

(=E2=80=9C6.7.6.3. (8) A declaration of a parameter as =E2=80=98function =
returning type=E2=80=99
shall be adjusted to =E2=80=98pointer to function returning type=E2=80=99=
, as in 6.3.2.1.=E2=80=9D

Interesting.  Didn't know that worked.)

[...]

> @@ -542,12 +632,141 @@ int job_finalize_single(Job *job)

[...]

> +static int job_prepare(Job *job)
> +{
> +    if (job->ret =3D=3D 0 && job->driver->prepare) {
> +        job->ret =3D job->driver->prepare(job);
> +    }
> +    return job->ret;
> +}

I'd have put this above job_commit() and the like, but it's not like it
matters functionally...

Well, you know me.  With the comment fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--EJM7QaLW0IglLJlDtb3dHbzFMCeudw4ZY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr58YIACgkQ9AfbAGHV
z0CLwQf+Jk4MQRqer1muU1RWyvQ3R6EQ0J1Sr0SKlf21klXCGxTWAcooKMFnovev
S6KtJu0LxlFq42+bbgTuiYL36HqzDlCnFtaq9dVo6mfuByeoZ7Pi9Xu0ouoKK1YP
ML+d6cRPeO4o0I06r8cP9PbNg150PO1R1mNLLtr67h0JTt90paED7hhHjDGy7+fb
kGoS+WLlGM4qloVD54cqlzVfb7fp6FqQR5/y4tuc1fKGPIGy/sMOkNwm5irPo+ZD
FV/NUK6NaMrRXurUKbw0S5q9kx2cM4oBksOXUuVr9Jtpj/QxIbyv0/gkK1FevAZT
AWV9ojqTqk3B83XcMHiSFbjfaxoqdQ==
=ow4m
-----END PGP SIGNATURE-----

--EJM7QaLW0IglLJlDtb3dHbzFMCeudw4ZY--
