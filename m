Received: from eggs.gnu.org ([2001:4830:134:3::10]:39366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNcNp-0002Hq-5F
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNcNo-0003J9-5u
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:01:41 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-4-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9a570754-d6a1-1d3a-b555-1833a7220860@redhat.com>
Date: Tue, 29 May 2018 13:01:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lfHZ1ui0MWDTmnKEwi6rChj0RrjcJytOF"
Subject: Re: [Qemu-devel] [PATCH 03/14] job: Add error message for failing
 jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lfHZ1ui0MWDTmnKEwi6rChj0RrjcJytOF
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <9a570754-d6a1-1d3a-b555-1833a7220860@redhat.com>
Subject: Re: [PATCH 03/14] job: Add error message for failing jobs
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-4-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> So far we relied on job->ret and strerror() to produce an error message=

> for failed jobs. Not surprisingly, this tends to result in completely
> useless messages.
>=20
> This adds a Job.error field that can contain an error string for a
> failing job, and a parameter to job_completed() that sets the field. As=

> a default, if NULL is passed, we continue to use strerror(job->ret).
>=20
> All existing callers are changed to pass NULL. They can be improved in
> separate patches.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/job.h |  7 ++++++-
>  block/backup.c     |  2 +-
>  block/commit.c     |  2 +-
>  block/mirror.c     |  2 +-
>  block/stream.c     |  2 +-
>  job-qmp.c          |  9 ++-------
>  job.c              | 15 +++++++++++++--
>  7 files changed, 25 insertions(+), 14 deletions(-)

There are some tests that call job_completed().  Those should be updated
as well.

> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index 8c8badf75e..b2e1dd00b9 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -124,6 +124,9 @@ typedef struct Job {
>      /** Estimated progress_current value at the completion of the job =
*/
>      int64_t progress_total;
> =20
> +    /** Error string for a failed job (NULL if job->ret =3D=3D 0) */
> +    char *error;
> +

I think we should bind this directly to job->ret, i.e. this is NULL if
and only if job->ret =3D=3D 0.  (Just because more constraints tend to ma=
ke
things nicer.  And also because if you don't, then qmp_job_dismiss()
cannot assume that job->error is set on error, which would be a change
in behavior.)

>      /** ret code passed to job_completed. */
>      int ret;
>=20
[...]

> diff --git a/job.c b/job.c
> index f026661b0f..fc39eaaa5e 100644
> --- a/job.c
> +++ b/job.c

job_prepare() (called by job_do_finalize() through job_txn_apply()) may
set job->ret.  If it does set it to a negative value, job_do_finalize()
will call job_completed_txn_abort(), which will eventually invoke
job_finalize_single(), which then runs job_update_rc() on the job.  This
is a bit too much code between setting job->ret and job->error for my
taste, I'd rather set job->error much sooner (e.g. by calling
job_update_rc() directly in job_prepare(), which I don't think would
change anything).

But if you think that this is just fine, then OK, because I don't think
the user can do QMP queries in between (it would still break the iff
relationship between job->ret and job->error, which I find desirable).

[...]

> @@ -661,6 +662,9 @@ static void job_update_rc(Job *job)
>      }
>      if (job->ret) {
>          job_state_transition(job, JOB_STATUS_ABORTING);
> +        if (!job->error) {
> +            job->error =3D g_strdup(strerror(-job->ret));
> +        }

If we do use an iff relationship between job->ret and job->error, this
should probably be inserted before job_state_transition().

Max

>      }
>  }


--lfHZ1ui0MWDTmnKEwi6rChj0RrjcJytOF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNMwcACgkQ9AfbAGHV
z0DHRgf/fAep11x+WsnJIkAjsGAvWeSkjDONX5dTvCeetaASss7WoQVs+u+mXrgK
NSlW5eRTiFaMFahjDJ53n6cSsz4HrDud/HGGH1HBbSGQqZINBgnRUziEGh4o/oQ2
awH5CV491RyR8nFfKs/Y+SFsdectMOXhcnnAcfi3zUQLFQpWEEn1KdeOvyPmvHGx
IZj8A6TDzXNO2RtLrM85JAWIO2wgHW23pzRt0DEVcXqnQZ7kS/mifwgyHh7fkYkS
7K/Q8xKwRkXVn27p6BbgtdBEwgv/6epw9Yyu6+YrHJv4dtU8mgtwLRVi+sKGpAKh
V41prWaGF6lD+cZCG2JlfEEL5z4yRQ==
=M9+T
-----END PGP SIGNATURE-----

--lfHZ1ui0MWDTmnKEwi6rChj0RrjcJytOF--
