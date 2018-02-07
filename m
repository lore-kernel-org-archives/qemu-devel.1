Received: from eggs.gnu.org ([2001:4830:134:3::10]:56022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejXr2-0003WW-L8
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejXr1-0004HO-Aj
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:06:12 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
	<20180119205847.7141-2-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <24fc02c2-cf2a-4a62-8828-80cb14a8ecdc@redhat.com>
Date: Wed, 7 Feb 2018 23:05:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180119205847.7141-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yeftwnRoNHo2EgOCgodgRUupCfxRT1p0G"
Subject: Re: [Qemu-devel] [PATCH v2 01/13] blockjob: record time of last
 entrance
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
--yeftwnRoNHo2EgOCgodgRUupCfxRT1p0G
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <24fc02c2-cf2a-4a62-8828-80cb14a8ecdc@redhat.com>
Subject: Re: [PATCH v2 01/13] blockjob: record time of last entrance
References: <20180119205847.7141-1-jsnow@redhat.com>
 <20180119205847.7141-2-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-19 21:58, John Snow wrote:
> The mirror job makes a semi-inaccurate record of the last time we yield=
ed
> by recording the last time we left a "pause", but this doesn't always
> correlate to the time we actually last successfully ceded control.
>=20
> Record the time we last *exited* a yield centrally. In other words, rec=
ord
> the time we began execution of this job to know how long we have been
> selfish for.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c           | 8 ++------
>  blockjob.c               | 2 ++
>  include/block/blockjob.h | 5 +++++
>  3 files changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index c9badc1203..88f4e8964d 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -63,7 +63,6 @@ typedef struct MirrorBlockJob {
>      QSIMPLEQ_HEAD(, MirrorBuffer) buf_free;
>      int buf_free_count;
> =20
> -    uint64_t last_pause_ns;
>      unsigned long *in_flight_bitmap;
>      int in_flight;
>      int64_t bytes_in_flight;
> @@ -596,8 +595,7 @@ static void mirror_throttle(MirrorBlockJob *s)
>  {
>      int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> =20
> -    if (now - s->last_pause_ns > SLICE_TIME) {
> -        s->last_pause_ns =3D now;
> +    if (now - s->common.last_enter_ns > SLICE_TIME) {
>          block_job_sleep_ns(&s->common, 0);
>      } else {
>          block_job_pause_point(&s->common);
> @@ -769,7 +767,6 @@ static void coroutine_fn mirror_run(void *opaque)
> =20
>      mirror_free_init(s);
> =20
> -    s->last_pause_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>      if (!s->is_none_mode) {
>          ret =3D mirror_dirty_init(s);
>          if (ret < 0 || block_job_is_cancelled(&s->common)) {
> @@ -803,7 +800,7 @@ static void coroutine_fn mirror_run(void *opaque)
>           * We do so every SLICE_TIME nanoseconds, or when there is an =
error,
>           * or when the source is clean, whichever comes first.
>           */
> -        delta =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - s->last_pau=
se_ns;
> +        delta =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - s->common.l=
ast_enter_ns;

The horror.

>          if (delta < SLICE_TIME &&
>              s->common.iostatus =3D=3D BLOCK_DEVICE_IO_STATUS_OK) {
>              if (s->in_flight >=3D MAX_IN_FLIGHT || s->buf_free_count =3D=
=3D 0 ||
> @@ -878,7 +875,6 @@ static void coroutine_fn mirror_run(void *opaque)
>              delay_ns =3D (s->in_flight =3D=3D 0 && cnt =3D=3D 0 ? SLIC=
E_TIME : 0);
>              block_job_sleep_ns(&s->common, delay_ns);
>          }
> -        s->last_pause_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>      }

Hmmm.  So you're now relying on block_job_sleep_ns() updating
last_enter_ns.  But it will only do so if we actually do sleep, which we
will not if the block job has been cancelled.

Then, last_enter_ns will stay at its current value indefinitely because
neither block_job_sleep_ns() nor block_job_pause_point() will yield.
OK, so at this point we should leave the mirror loop.  There are three
points where this is done:

(1) If s->ret < 0.  OK, let's hope it isn't.
(2) If cnt =3D=3D 0 && should_complete.  We'll come back to that.
(3) If !s->synced && block_job_is_cancelled(...).  So basically now, if
the job has not emitted a READY event yet.

But if we have emitted the READY, we have to wait for cnt =3D=3D 0 &&
should_complete (note that should_complete in turn will only be set if
s->in_flight =3D=3D 0 && cnt =3D=3D 0).  But unless delta < SLICE_TIME, w=
e will
never do another mirror_iteration(), so unless we have already started
the necessary requests, they will never be started and we will loop forev=
er.

So try this on master (I prefixed the QMP lines with in/out depending on
the direction -- note that it's important to have the block-job-cancel
on the same line the human-monitor-command finishes on so they are
executed right after each other!):

$ ./qemu-img create -f qcow2 foo.qcow2 64M
$ x86_64-softmmu/qemu-system-x86_64 -qmp stdio
In: {"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2},
"package": " (v2.9.0-632-g4a52d43-dirty)"}, "capabilities": []}}
Out: {"execute":"qmp_capabilities"}
In: {"return": {}}
Out: {"execute":"object-add","arguments":
      {"qom-type":"throttle-group","id":"tg0","props":{"limits":
=C2=A0        {"bps-total":16777216}}}}
In: {"return": {}}
Out: {"execute":"blockdev-add","arguments":
      {"node-name":"source","driver":"qcow2","file":
       {"driver":"file","filename":"foo.qcow2"}}}
In: {"return": {}}
Out: {"execute":"blockdev-add","arguments":
      {"node-name":"target","driver":"throttle",
       "throttle-group":"tg0","file":
       {"driver":"null-co","size":67108864}}}
In: {"return": {}}
Out: {"execute":"blockdev-mirror","arguments":
     {"job-id":"mirror","device":"source","target":"target",
      "sync":"full"}}
In: {"return": {}}
In: {"timestamp": {"seconds": 1518040566, "microseconds": 658111},
     "event": "BLOCK_JOB_READY", "data":
     {"device": "mirror", "len": 67108864, "offset": 67108864,
      "speed": 0, "type": "mirror"}}
Out: {"execute":"human-monitor-command","arguments":
      {"command-line":"qemu-io source \"write 0 64M\""}
     }{"execute":"block-job-cancel","arguments":{"device":"mirror"}}
In: wrote 67108864/67108864 bytes at offset 0
In: 64 MiB, 1 ops; 0.0310 sec (2.011 GiB/sec and 32.1823 ops/sec)
In: {"return": ""}
In: {"return": {}}
In: {"timestamp": {"seconds": 1518040578, "microseconds": 626669},
     "event": "BLOCK_JOB_COMPLETED", "data":
     {"device": "mirror", "len": 134217728, "offset": 134217728,
      "speed": 0, "type": "mirror"}}

But with your patch, the BLOCK_JOB_COMPLETED never appears (it should
take four seconds).

> =20
>  immediate_exit:
> diff --git a/blockjob.c b/blockjob.c
> index f5cea84e73..2a9ff66b95 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -321,6 +321,7 @@ void block_job_start(BlockJob *job)
>      job->pause_count--;
>      job->busy =3D true;
>      job->paused =3D false;
> +    job->last_enter_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>      bdrv_coroutine_enter(blk_bs(job->blk), job->co);
>  }
> =20
> @@ -786,6 +787,7 @@ static void block_job_do_yield(BlockJob *job, uint6=
4_t ns)
>      job->busy =3D false;
>      block_job_unlock();
>      qemu_coroutine_yield();
> +    job->last_enter_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> =20
>      /* Set by block_job_enter before re-entering the coroutine.  */
>      assert(job->busy);
> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> index 00403d9482..e965845c94 100644
> --- a/include/block/blockjob.h
> +++ b/include/block/blockjob.h
> @@ -141,6 +141,11 @@ typedef struct BlockJob {
>       */
>      QEMUTimer sleep_timer;
> =20
> +    /**
> +     * Timestamp of the last yield

A yield has two timestamps, one pre-yield, one post-yield.  Maybe it
should be noted that this records the post-yield one because that's not
what I'd assume just based on the comment, but OTOH the name of the
variable should be enough to clear that up.

Max

> +     */
> +    uint64_t last_enter_ns;
> +
>      /** Non-NULL if this job is part of a transaction */
>      BlockJobTxn *txn;
>      QLIST_ENTRY(BlockJob) txn_list;
>=20



--yeftwnRoNHo2EgOCgodgRUupCfxRT1p0G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp7eDQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/wYH/RhJzW3rgXK9uS3/END70sWy3aMPNzEj
/lHX9QYut0idzxL/CY4E6VTyOQLM0JlwBnIDl2I/zOKo0i6GEs3b1yGBXMYorIa+
1y2oG555QgoHCbCIKI6nPc4IWFhfB5L/HFHLkqRpAIhS5lmbc/1CUs1h9tS1U1W5
I5V5dQO5lJLLtmkaCWgd9u1iqLpQR4e7Hktgzgvem/q0Hw0hyTJKESu1FIKCe7C5
gPDnUbLi5/kNW1l++h5ysNwK8ZwGC8fGnfM4hlOVlhIFXc/cbewn/5SjAyeF9gO2
3fcEHmBRElKHwYJPt+nNqIyetBdTv7d9rHhGJso2aP1RPaP/uhQ1LQE=
=kQcE
-----END PGP SIGNATURE-----

--yeftwnRoNHo2EgOCgodgRUupCfxRT1p0G--
