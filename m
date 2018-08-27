Received: from eggs.gnu.org ([2001:4830:134:3::10]:40277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuH6a-0003Zp-8F
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuGvO-00010i-Ku
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 08:47:19 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-6-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <95d4818c-0116-270a-0353-3dc6789e0a45@redhat.com>
Date: Mon, 27 Aug 2018 14:47:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-6-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tcwo1ttIqzRnpJ6aazuWBmFY6QQNJ9bir"
Subject: Re: [Qemu-devel] [PATCH v2 05/13] block/mirror: conservative
 mirror_exit refactor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tcwo1ttIqzRnpJ6aazuWBmFY6QQNJ9bir
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <95d4818c-0116-270a-0353-3dc6789e0a45@redhat.com>
Subject: Re: [PATCH v2 05/13] block/mirror: conservative mirror_exit refactor
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-6-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:22, John Snow wrote:
> For purposes of minimum code movement, refactor the mirror_exit
> callback to use the post-finalization callbacks in a trivial way.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 837279e979..f5b504406d 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -79,6 +79,7 @@ typedef struct MirrorBlockJob {
>      int max_iov;
>      bool initial_zeroing_ongoing;
>      int in_active_write_counter;
> +    bool prepared;
>  } MirrorBlockJob;
> =20
>  typedef struct MirrorBDSOpaque {
> @@ -607,7 +608,7 @@ static void mirror_wait_for_all_io(MirrorBlockJob *=
s)
>      }
>  }
> =20
> -static void mirror_exit(Job *job)
> +static int mirror_exit_common(Job *job)
>  {
>      MirrorBlockJob *s =3D container_of(job, MirrorBlockJob, common.job=
);
>      BlockJob *bjob =3D &s->common;
> @@ -619,6 +620,11 @@ static void mirror_exit(Job *job)
>      Error *local_err =3D NULL;
>      int ret =3D job->ret;
> =20
> +    if (s->prepared) {
> +        return ret;

I'd prefer "return 0".  We only get here from mirror_abort(), and
mirror_abort() cannot fail, so this function should not report failure th=
en.

Also, the error has already been reported (as evidenced by the fact that
job->ret < 0), so there is no need to report it again.  The function is
supposed to be a no-op on its second call, and it was successful in
doing so.

> +    }
> +    s->prepared =3D true;
> +
>      bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
> =20
>      /* Make sure that the source BDS doesn't go away before we called
> @@ -711,7 +717,17 @@ static void mirror_exit(Job *job)
>      bdrv_unref(mirror_top_bs);
>      bdrv_unref(src);
> =20
> -    job->ret =3D ret;
> +    return ret;
> +}
> +
> +static int mirror_prepare(Job *job)
> +{
> +    return mirror_exit_common(job);
> +}
> +
> +static void mirror_abort(Job *job)
> +{
> +    mirror_exit_common(job);

Hm.  If we cannot assert that this always returns 0 (given that job->ret
is negative before, which it is here), then something is off.

The first thing obviously is the "return ret" you add in this patch, but
that's easy to get rid off.

The second thing is the ret =3D -EPERM in the "if (s->backing_mode =3D=3D=

MIRROR_SOURCE_BACKING_CHAIN)" path.  Now the first question is, can we
skip that on error?

The answer is "nobody would notice, but not really?".  First, we
probably usually want a working target node for mirror even on failure.
Now, this backing_mode here is used only for drive-mirror, so usually
when that job fails, the target just goes aways (and it wouldn't matter
what backing chain it had).

But you can give the target a node-name and then at least theoretically
reference it while the job is running.  Then the backing chain after
failure would matter.

Though OTOH, we do not share CONSISTENT_READ on the target, so if you do
that, it's not like we ever promised you you'd get the right backing
chain at any point...  (And not sharing CONSISTENT_READ means that you
really cannot attach the node to anything while the job is running.)

So we could just not attach the target backing chain if job->ret < 0.
At least we could ignore errors.   But it'd need an explanation (namely
"We didn't share CONSISTENT_READ, so we can ignore errors here").


The second idea would be: We only need a valid target when the job was
actually completed.  Looking it up unveils that cancelling a mirror
(post-READY) does not make it abort; job->ret is still 0.  So I suppose
when we ever get to mirror_abort() without mirror_prepare() having been
called before, that is not a point where the target needs to be made
consistent.  So that also means we can just ignore the error then.


All in all, I would say that if we are in .abort() (job->ret < 0), it
should ignore this specific error (i.e. not overwrite @ret, which is
already negative), because

(1) The target never shared CONSISTENT_READ anyway, so if there are
other parents already, they won't be surprised that the backing chain is
still missing; and if there are no other parents, it doesn't matter what
we do because the target is going to bdrv_delete()'d after the job anyway=
=2E
(2) While we can make an effort to get a half-consistent target even
when the job has failed, chances are that it will be inconsistent
anyway.  Also, nobody expects mirror to leave behind a consistent target
when failing.  (Note: Post-READY cancel (to complete) does not count as
failure.)


The basic chance looks good, but I'd really like a working assertion
here that mirror_exit_common() has returned 0.

Max

>  }
> =20
>  static void mirror_throttle(MirrorBlockJob *s)
> @@ -1132,7 +1148,8 @@ static const BlockJobDriver mirror_job_driver =3D=
 {
>          .user_resume            =3D block_job_user_resume,
>          .drain                  =3D block_job_drain,
>          .run                    =3D mirror_run,
> -        .exit                   =3D mirror_exit,
> +        .prepare                =3D mirror_prepare,
> +        .abort                  =3D mirror_abort,
>          .pause                  =3D mirror_pause,
>          .complete               =3D mirror_complete,
>      },
> @@ -1149,7 +1166,8 @@ static const BlockJobDriver commit_active_job_dri=
ver =3D {
>          .user_resume            =3D block_job_user_resume,
>          .drain                  =3D block_job_drain,
>          .run                    =3D mirror_run,
> -        .exit                   =3D mirror_exit,
> +        .prepare                =3D mirror_prepare,
> +        .abort                  =3D mirror_abort,
>          .pause                  =3D mirror_pause,
>          .complete               =3D mirror_complete,
>      },
>=20



--tcwo1ttIqzRnpJ6aazuWBmFY6QQNJ9bir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD8skACgkQ9AfbAGHV
z0AIXwgAo8Z2wkYFkObOnXvUVBKc5YenUFRucgPn0hlbsLdn6Vj9uPVOkmxG9MM0
LRcVi8WdDqTcaLEb6e/wnEpxKLKgPdFqx/EJnhXJzxl4nCJIfb1M0vgwo3oq6eLl
U5zFFH/kWuPNZyR0YTc0tY8qnWkzgEC3DbJOaAQf/Wz434gNKAWYsVqHks/7ZrPE
rxzb1WQkFzhgqr8Ijbx76s59ZmHDmph/Ow2RyG9f+VnHxfOG4pSxI9taak8Iu4Ar
UISHMUnHI8rxCKdkdtURmP/NT3tMQfaUeGCSlDSrEEYCPFOoYG8HkFAojx5i12Tm
g1gHSAE9vyxSeZyDpL/DZl/rZ0m82A==
=D2Rj
-----END PGP SIGNATURE-----

--tcwo1ttIqzRnpJ6aazuWBmFY6QQNJ9bir--
