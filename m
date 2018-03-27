Received: from eggs.gnu.org ([2001:4830:134:3::10]:53539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f0rgH-0001j9-5N
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f0rgG-0003Um-95
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:42:41 -0400
References: <20180327153011.29569-1-marcandre.lureau@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <93eeb364-6521-784f-b02b-c3c7e960461b@redhat.com>
Date: Tue, 27 Mar 2018 12:42:32 -0400
MIME-Version: 1.0
In-Reply-To: <20180327153011.29569-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockjob: use qapi enum
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, jtc@redhat.com



On 03/27/2018 11:30 AM, Marc-Andr=C3=A9 Lureau wrote:
> QAPI generator provide #define helpers for looking up enum string.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  blockjob.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/blockjob.c b/blockjob.c
> index ef3ed69ff1..11c9ce124d 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -75,10 +75,8 @@ static void block_job_state_transition(BlockJob *job=
, BlockJobStatus s1)
>      assert(s1 >=3D 0 && s1 <=3D BLOCK_JOB_STATUS__MAX);
>      trace_block_job_state_transition(job, job->ret, BlockJobSTT[s0][s1=
] ?
>                                       "allowed" : "disallowed",
> -                                     qapi_enum_lookup(&BlockJobStatus_=
lookup,
> -                                                      s0),
> -                                     qapi_enum_lookup(&BlockJobStatus_=
lookup,
> -                                                      s1));
> +                                     BlockJobStatus_str(s0),
> +                                     BlockJobStatus_str(s1));
>      assert(BlockJobSTT[s0][s1]);
>      job->status =3D s1;
>  }
> @@ -86,17 +84,15 @@ static void block_job_state_transition(BlockJob *jo=
b, BlockJobStatus s1)
>  static int block_job_apply_verb(BlockJob *job, BlockJobVerb bv, Error =
**errp)
>  {
>      assert(bv >=3D 0 && bv <=3D BLOCK_JOB_VERB__MAX);
> -    trace_block_job_apply_verb(job, qapi_enum_lookup(&BlockJobStatus_l=
ookup,
> -                                                     job->status),
> -                               qapi_enum_lookup(&BlockJobVerb_lookup, =
bv),
> +    trace_block_job_apply_verb(job, BlockJobStatus_str(job->status),
> +                               BlockJobVerb_str(bv),
>                                 BlockJobVerbTable[bv][job->status] ?
>                                 "allowed" : "prohibited");
>      if (BlockJobVerbTable[bv][job->status]) {
>          return 0;
>      }
>      error_setg(errp, "Job '%s' in state '%s' cannot accept command ver=
b '%s'",
> -               job->id, qapi_enum_lookup(&BlockJobStatus_lookup, job->=
status),
> -               qapi_enum_lookup(&BlockJobVerb_lookup, bv));
> +               job->id, BlockJobStatus_str(job->status), BlockJobVerb_=
str(bv));
>      return -EPERM;
>  }
> =20
>=20

Oh, whoops. I knew you added functions, but I didn't realize we got
per-enum functions. Thanks.

Reviewed-by: John Snow <jsnow@redhat.com>

and forwarded to Jeff Cody.

--js
