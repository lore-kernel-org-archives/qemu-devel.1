Received: from eggs.gnu.org ([2001:4830:134:3::10]:56268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIM0F-0007zD-NZ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIM0E-0001XT-KL
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:31:35 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-40-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1212f284-2af7-e586-ec95-18e77a53d13a@redhat.com>
Date: Tue, 15 May 2018 00:31:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-40-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="naCl9WoirR2PCoIf06D8i3rCXGfee8Bdk"
Subject: Re: [Qemu-devel] [PATCH 39/42] job: Add lifecycle QMP commands
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
--naCl9WoirR2PCoIf06D8i3rCXGfee8Bdk
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <1212f284-2af7-e586-ec95-18e77a53d13a@redhat.com>
Subject: Re: [PATCH 39/42] job: Add lifecycle QMP commands
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-40-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-40-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This adds QMP commands that control the transition between states of th=
e
> job lifecycle.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/job.json | 112 ++++++++++++++++++++++++++++++++++++++++++++++
>  job-qmp.c     | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  MAINTAINERS   |   1 +
>  Makefile.objs |   2 +-
>  trace-events  |   9 ++++
>  5 files changed, 263 insertions(+), 1 deletion(-)
>  create mode 100644 job-qmp.c
>=20
> diff --git a/qapi/job.json b/qapi/job.json
> index bd88a358d0..7b84158292 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json
> @@ -63,3 +63,115 @@
>  { 'event': 'JOB_STATUS_CHANGE',
>    'data': { 'id': 'str',
>              'status': 'JobStatus' } }
> +
> +##
> +# @job-pause:
> +#
> +# Pause an active job.
> +#
> +# This command returns immediately after marking the active job for pa=
using.
> +# Pausing an already paused job has no cumulative effect; a single job=
-resume
> +# command will resume the job.

Pausing an already paused job is, in fact, an error.

(Which should be noted here instead of making it appear like it'd be
idempotent.)

> +#
> +# The job will pause as soon as possible, which means transitioning in=
to the
> +# PAUSED state if it was RUNNING, or into STANDBY if it was READY. The=

> +# corresponding JOB_STATUS_CHANGE event will be emitted.
> +#
> +# Cancelling a paused job automatically resumes it.
> +#
> +# @id: The job identifier.
> +#
> +# Since: 2.13
> +##
> +{ 'command': 'job-pause', 'data': { 'id': 'str' } }

[...]

> +##
> +# @job-cancel:
> +#
> +# Instruct an active background job to cancel at the next opportunity.=

> +# This command returns immediately after marking the active job for
> +# cancellation.
> +#
> +# The job will cancel as soon as possible and then emit a JOB_STATUS_C=
HANGE
> +# event. Usually, the status will change to ABORTING, but it is possib=
le that
> +# a job successfully completes (e.g. because it was almost done and th=
ere was
> +# no opportunity to cancel earlier than completing the job) and transi=
tions to
> +# PENDING instead.
> +#
> +# Note that if you issue 'job-cancel' after a mirror block job has ind=
icated
> +# (via the event BLOCK_JOB_READY, and by transitioning into the READY =
state)
> +# that the source and destination are synchronized, then the job alway=
s
> +# completes successfully and transitions to PENDING as well as trigger=
ing the
> +# event BLOCK_JOB_COMPLETED, to indicate that the mirroring has ended =
and the
> +# destination now has a point-in-time copy tied to the time of the
> +# cancellation.
> +#
> +# @id: The job identifier.
> +#
> +# @force: If true, and the job is already in the READY state, abandon =
the job
> +#         immediately (even if it is paused) instead of waiting for th=
e
> +#         destination to complete its final synchronization

The note on "final synchronization" is extremely mirror-specific.  I see
three choices here:

(1) If mirror stays the only job with this special cancel semantics,
then we are free to note that this is a mirror-specific flag here.

(2) Even if some other job might come along at some point where use of
@force may make sense, that doesn't stop us from now noting that only
mirror supports this, which helps readers understand what "destination"
and "final synchronization" mean.

(Yes, so (1) and (2) are basically the same.)

(3) We try to find some general description and drop the last part.
Like "If a job would normally decide to complete instead of actually
aborting, this flag can be used to convince it otherwise."  But that's
so handwavy, I'd rather just mark it as a special mirror flag for now.

> +#
> +# Since: 2.13
> +##
> +{ 'command': 'job-cancel', 'data': { 'id': 'str', '*force': 'bool' } }=


[...]

> diff --git a/Makefile.objs b/Makefile.objs
> index 3df8d58e49..253e0356f3 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -66,7 +66,7 @@ chardev-obj-y =3D chardev/
>  # block-obj-y is code used by both qemu system emulation and qemu-img
> =20
>  block-obj-y +=3D nbd/
> -block-obj-y +=3D block.o blockjob.o job.o
> +block-obj-y +=3D block.o blockjob.o job.o job-qmp.o

Shouldn't this be in common-obj-y like blockdev?

Max

>  block-obj-y +=3D block/ scsi/
>  block-obj-y +=3D qemu-io-cmds.o
>  block-obj-$(CONFIG_REPLICATION) +=3D replication.o


--naCl9WoirR2PCoIf06D8i3rCXGfee8Bdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr6DjwACgkQ9AfbAGHV
z0D9IQgAoIoQoNBCFAMSSn1ubWdB4j0CYon17x+CgB1TzUv8qz2I9OXq0Y8UXQ0p
xyCcORDb1bhoKceUTMKhHdpxRjFcAzxYfaJWdBrXGGwgYMGsZPzmqLz1IlZrthKi
7Xtf/BYV6ePCfr8z8x0bm347LKjPUzQl3mz+y9Ze919Dip8MPfxDb3fGnXRQoyIj
2D3H0KtEx9L/++yO34RADvFugEYJO/H9uU6DIUrrV58JA1XmP5Hocg5bJ2j12Ifi
wezIp7SCI2kkwDDz4UHf61XAt/Kh9SI3RsJdweN7TtLPLmF88PZw7izbnUbRTP5F
Ns+G6+jTTfEVsrxU5miFuB5F3T2tqQ==
=05HK
-----END PGP SIGNATURE-----

--naCl9WoirR2PCoIf06D8i3rCXGfee8Bdk--
