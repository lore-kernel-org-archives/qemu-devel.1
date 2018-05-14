Received: from eggs.gnu.org ([2001:4830:134:3::10]:35234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIMbU-0007qd-4z
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIMbS-0007ZY-LQ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:10:04 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-41-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <13ad0be2-6966-db50-3a84-31f4e890a6a1@redhat.com>
Date: Tue, 15 May 2018 01:09:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-41-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yxzxIMTl7kUNCLatSHnsgSbE7SWkHqpRB"
Subject: Re: [Qemu-devel] [PATCH 40/42] job: Add query-jobs QMP command
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
--yxzxIMTl7kUNCLatSHnsgSbE7SWkHqpRB
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <13ad0be2-6966-db50-3a84-31f4e890a6a1@redhat.com>
Subject: Re: [PATCH 40/42] job: Add query-jobs QMP command
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-41-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-41-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This adds a minimal query-jobs implementation that shouldn't pose many
> design questions. It can later be extended to expose more information,
> and especially job-specific information.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 18 ----------------
>  qapi/job.json        | 59 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  include/qemu/job.h   |  3 +++
>  job-qmp.c            | 54 ++++++++++++++++++++++++++++++++++++++++++++=
+++
>  job.c                |  2 +-
>  5 files changed, 117 insertions(+), 19 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f2da7d696d..d38dfa7836 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1051,24 +1051,6 @@
>    'data': ['top', 'full', 'none', 'incremental'] }
> =20
>  ##
> -# @JobType:
> -#
> -# Type of a background job.
> -#
> -# @commit: block commit job type, see "block-commit"
> -#
> -# @stream: block stream job type, see "block-stream"
> -#
> -# @mirror: drive mirror job type, see "drive-mirror"
> -#
> -# @backup: drive backup job type, see "drive-backup"
> -#
> -# Since: 1.7
> -##
> -{ 'enum': 'JobType',
> -  'data': ['commit', 'stream', 'mirror', 'backup'] }
> -
> -##
>  # @JobVerb:
>  #
>  # Represents command verbs that can be applied to a job.
> diff --git a/qapi/job.json b/qapi/job.json
> index 7b84158292..742fa97768 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json
> @@ -5,6 +5,24 @@
>  ##
> =20
>  ##
> +# @JobType:
> +#
> +# Type of a background job.
> +#
> +# @commit: block commit job type, see "block-commit"
> +#
> +# @stream: block stream job type, see "block-stream"
> +#
> +# @mirror: drive mirror job type, see "drive-mirror"
> +#
> +# @backup: drive backup job type, see "drive-backup"
> +#
> +# Since: 1.7
> +##
> +{ 'enum': 'JobType',
> +  'data': ['commit', 'stream', 'mirror', 'backup'] }
> +
> +##

FWIW, I'd put this code movement into the hypothetical commit which
specifically adds job.json.

(Same as JobVerb, which is not moved in this series, but which very
likely should be.)

>  # @JobStatus:
>  #
>  # Indicates the present state of a given job in its lifetime.
> @@ -175,3 +193,44 @@
>  # Since: 2.13
>  ##
>  { 'command': 'job-finalize', 'data': { 'id': 'str' } }
> +
> +##
> +# @JobInfo:
> +#
> +# Information about a job.
> +#
> +# @id:                  The job identifier
> +#
> +# @type:                The job type

I'm not really happy with this description that effectively provides no
information that one cannot already get from the field name, but I
cannot come up with something better, so I'd rather stop typing now.

(OK, my issue here is that "job type" can be anything.  That could mean
e.g. "Is this a block job?".   Maybe an explicit reference to JobType
might help here, although that is already part of the documentation.  On
that note, maybe a quote from the documentation might help make my point
that this description is not very useful:

       "type: JobType"
           The job type

Maybe "The kind of job that is being performed"?)

> +# @status:              Current job state/status

Why the "state/status"?  Forgive me my incompetence, but I don't see a
real difference here.  But in any case, one ought to be enough, no?

(OK, full disclosure: My gut tells me "status" is what we now call the
"progress", and this field should be called "state".  But it's called
"status" now and it doesn't really make a difference, so it's fine to
describe it as either.)

> +#
> +# @current-progress:    The current progress value
> +#
> +# @total-progress:      The maximum progress value

Hm, not really.  This makes it sound like at any point, this will be the
maximum even in the future, but that's not true.

Maybe "estimated progress maximum"?  Or be even more verbose (no, that
doesn't hurt): "This is an estimation of the value @current-progress
needs to reach for the job to complete."

(Actually, I find it important to note that it is an estimation, maybe
we event want to be really explicit about the fact that this value may
change all the time, in any direction.)

> +#
> +# @error:               If this field is present, the job failed; if i=
t is
> +#                       still missing in the CONCLUDED state, this ind=
icates
> +#                       successful completion.
> +#
> +#                       The value is a human-readable error message to=
 describe
> +#                       the reason for the job failure. It should not =
be parsed
> +#                       by applications.
> +#
> +# Since: 2.13
> +##
> +{ 'struct': 'JobInfo',
> +  'data': { 'id': 'str', 'type': 'JobType', 'status': 'JobStatus',
> +            'current-progress': 'int', 'total-progress': 'int',
> +            '*error': 'str' } }
> +
> +##
> +# @query-jobs:
> +#
> +# Return information about jobs.
> +#
> +# Returns: a list with a @JobInfo for each active job
> +#
> +# Since: 2.13
> +##
> +{ 'command': 'query-jobs', 'returns': ['JobInfo'] }

[...]

> diff --git a/job-qmp.c b/job-qmp.c
> index f32cb8b73e..7425a2a490 100644
> --- a/job-qmp.c
> +++ b/job-qmp.c
> @@ -138,3 +138,57 @@ void qmp_job_dismiss(const char *id, Error **errp)=

>      job_dismiss(&job, errp);
>      aio_context_release(aio_context);
>  }
> +
> +static JobInfo *job_query_single(Job *job, Error **errp)
> +{
> +    JobInfo *info;
> +    const char *errmsg =3D NULL;
> +
> +    assert (!job_is_internal(job));

One stray space.

Max

> +
> +    if (job->ret < 0) {
> +        errmsg =3D strerror(-job->ret);
> +    }
> +
> +    info =3D g_new(JobInfo, 1);
> +    *info =3D (JobInfo) {
> +        .id                 =3D g_strdup(job->id),
> +        .type               =3D job_type(job),
> +        .status             =3D job->status,
> +        .current_progress   =3D job->progress_current,
> +        .total_progress     =3D job->progress_total,
> +        .has_error          =3D !!errmsg,
> +        .error              =3D g_strdup(errmsg),
> +    };
> +
> +    return info;
> +}
> +
> +JobInfoList *qmp_query_jobs(Error **errp)
> +{
> +    JobInfoList *head =3D NULL, **p_next =3D &head;
> +    Job *job;
> +
> +    for (job =3D job_next(NULL); job; job =3D job_next(job)) {
> +        JobInfoList *elem;
> +        AioContext *aio_context;
> +
> +        if (job_is_internal(job)) {
> +            continue;
> +        }
> +        elem =3D g_new0(JobInfoList, 1);
> +        aio_context =3D job->aio_context;
> +        aio_context_acquire(aio_context);
> +        elem->value =3D job_query_single(job, errp);
> +        aio_context_release(aio_context);
> +        if (!elem->value) {
> +            g_free(elem);
> +            qapi_free_JobInfoList(head);
> +            return NULL;
> +        }
> +        *p_next =3D elem;
> +        p_next =3D &elem->next;
> +    }
> +
> +    return head;
> +}


--yxzxIMTl7kUNCLatSHnsgSbE7SWkHqpRB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr6F0AACgkQ9AfbAGHV
z0ANQQgAtLVF1HYs0C/LbrKqsiqZHl1kDv63eTqbmNRwXrlBhlQw1/I8BpFta7G0
q4LTV/LnXnUY3ym2dVZR4l+NKYuEWBGrxOEhm3TCDHyGdd6hUjYlzci481WJ0miA
O9C2FjSWRnKEy5YgqUr+LvvFAEMsrnjrhUo+D0EbGeXVxN8og7/3agjmqK2zRfXb
lCuqjxv2KUcaryx3UF4QufWbZAarEkv+w7qy6mkcgJaHyTbi++KV6mqklDeDjTeM
iuJFWhw4X/fUti2H7NukSzziJaAKo7KeLLFTGPyE3rVaOjnbfG4QxB2pYRQjMV9X
lC6II2pZK7NQQyhVQnmbyTsis1eeYw==
=8X4C
-----END PGP SIGNATURE-----

--yxzxIMTl7kUNCLatSHnsgSbE7SWkHqpRB--
