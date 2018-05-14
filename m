Received: from eggs.gnu.org ([2001:4830:134:3::10]:52123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fILga-0007CE-5r
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fILgY-0004xj-Ts
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:11:16 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-39-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3b126693-5a80-9265-acd7-944ef0984a30@redhat.com>
Date: Tue, 15 May 2018 00:11:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-39-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="W2uTuL7OJv5eGppvH7dHPF43fzOkzbWnC"
Subject: Re: [Qemu-devel] [PATCH 38/42] job: Add JOB_STATUS_CHANGE QMP event
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
--W2uTuL7OJv5eGppvH7dHPF43fzOkzbWnC
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <3b126693-5a80-9265-acd7-944ef0984a30@redhat.com>
Subject: Re: [PATCH 38/42] job: Add JOB_STATUS_CHANGE QMP event
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-39-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-39-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This adds a QMP event that is emitted whenever a job transitions from
> one status to another. For the event, a new qapi/job.json schema file i=
s
> created which will contain all job-related definitions that aren't tied=

> to the block layer.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json       |  47 +-----------
>  qapi/job.json              |  65 +++++++++++++++++
>  qapi/qapi-schema.json      |   1 +
>  job.c                      |  10 +++
>  Makefile                   |   9 +++
>  Makefile.objs              |   4 +
>  tests/qemu-iotests/030     |   6 +-
>  tests/qemu-iotests/040     |   2 +
>  tests/qemu-iotests/041     |  17 ++++-
>  tests/qemu-iotests/095     |   2 +-
>  tests/qemu-iotests/095.out |   6 ++
>  tests/qemu-iotests/109     |   2 +-
>  tests/qemu-iotests/109.out | 178 +++++++++++++++++++++++++++++++++++++=
++------
>  tests/qemu-iotests/124     |   8 ++
>  tests/qemu-iotests/127.out |   7 ++
>  tests/qemu-iotests/141     |  10 +--
>  tests/qemu-iotests/141.out |  29 ++++++++
>  tests/qemu-iotests/144     |   2 +-
>  tests/qemu-iotests/144.out |   7 ++
>  tests/qemu-iotests/156     |   2 +-
>  tests/qemu-iotests/156.out |   7 ++
>  tests/qemu-iotests/185     |  12 +--
>  tests/qemu-iotests/185.out |  10 +++
>  tests/qemu-iotests/191     |   4 +-
>  tests/qemu-iotests/191.out | 132 +++++++++++++++++++++++++++++++++
>  25 files changed, 492 insertions(+), 87 deletions(-)
>  create mode 100644 qapi/job.json

Your effort to keep this series in 42 patches in Ehren, but I think it
would make sense to have a separate patch that creates qapi/job.json. ;-)=


[...]

> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index 640a6dfd10..03aea460c9 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -304,7 +304,7 @@ class TestParallelOps(iotests.QMPTestCase):
>          result =3D self.vm.qmp('block-stream', device=3D'node5', base=3D=
self.imgs[3], job_id=3D'stream-node6')
>          self.assert_qmp(result, 'error/class', 'GenericError')
> =20
> -        event =3D self.vm.get_qmp_event(wait=3DTrue)
> +        event =3D self.vm.event_wait(name=3D'BLOCK_JOB_READY')
>          self.assertEqual(event['event'], 'BLOCK_JOB_READY')

This assertion is a bit useless, now, but whatever.

>          self.assert_qmp(event, 'data/device', 'commit-drive0')
>          self.assert_qmp(event, 'data/type', 'commit')
> @@ -751,7 +751,9 @@ class TestStreamStop(iotests.QMPTestCase):
> =20
>          time.sleep(0.1)
>          events =3D self.vm.get_qmp_events(wait=3DFalse)
> -        self.assertEqual(events, [], 'unexpected QMP event: %s' % even=
ts)
> +        for e in events:
> +            if e['event'] !=3D 'JOB_STATUS_CHANGE':
> +                self.assertEqual(events, [], 'unexpected QMP event: %s=
' % events)

self.fail() would be nicer to read.

> =20
>          self.cancel_and_wait(resume=3DTrue)
> =20

[...]

> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index a860a31e9a..e94587950c 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -445,6 +445,8 @@ new_state =3D "1"
>                      self.assert_qmp(event, 'data/device', 'drive0')
>                      self.assert_qmp(event, 'data/error', 'Input/output=
 error')
>                      completed =3D True
> +                elif event['event'] =3D=3D 'JOB_STATUS_CHANGE':
> +                    self.assert_qmp(event, 'data/id', 'drive0')

There were plenty of such loops in 030.  Why did you leave them as they
are and add this check here?

(I can understand it in the previous hunk, because that one has an else
branch, but this one does not.)

((And if you decide to always do this check, iotests.py needs it, too.))

> =20
>          self.assert_no_active_block_jobs()
>          self.vm.shutdown()
> @@ -457,6 +459,10 @@ new_state =3D "1"
>          self.assert_qmp(result, 'return', {})
> =20
>          event =3D self.vm.get_qmp_event(wait=3DTrue)
> +        while event['event'] =3D=3D 'JOB_STATUS_CHANGE':
> +            self.assert_qmp(event, 'data/id', 'drive0')
> +            event =3D self.vm.get_qmp_event(wait=3DTrue)
> +
>          self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')

Wouldn't this be simpler with
event =3D self.vm.event_wait(name=3D'BLOCK_JOB_ERROR')?

Same in other hunks in this file.

(And technically in all cases (like 056) that use event_wait already.)

(Sure, if you want to check @id...  But then you'd have to do the same
in 030.  And I don't quite see the point of checking JOB_STATUS_CHANGE
just sporadically, and not even checking the target status.)

>          self.assert_qmp(event, 'data/device', 'drive0')
>          self.assert_qmp(event, 'data/operation', 'read')

[...]

> diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
> index 2f9d7b9bc2..9ae23a6c63 100755
> --- a/tests/qemu-iotests/141
> +++ b/tests/qemu-iotests/141

[...]

> @@ -179,7 +179,7 @@ test_blockjob \
>                      'device': 'drv0',
>                      'speed': 1}}" \
>      'return' \
> -    'BLOCK_JOB_CANCELLED'
> +    '"status": "null"'
> =20

The comment above this hunk says that "no event other than
BLOCK_JOB_CANCELLED will be emitted".  It would make sense to change it
to e.g. "no block job event other than [...]".

>  _cleanup_qemu
> =20

[...]

You forgot to adjust 094, and although I cannot prove it (I don't have
an nfs setup handy right now), I have a hunch that this patch breaks 173
as well.

Max


--W2uTuL7OJv5eGppvH7dHPF43fzOkzbWnC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr6CXoACgkQ9AfbAGHV
z0D5igf/ULPg1FQduisghulZOkEPIHDtB7uBpvMiVzi0/6Qm0E1QBgzo2Omlv0xi
jZn9w5yOhSH6kKXL+f6Dv5OOvFqd1nMG5fHvtr0E/VhsWXc8qGmgjrdyy6feXUGd
JlVTpSPUdXcaQ5oCx8HVDuQdRpvYxP1kTRdsF7Me17ofPE5vFRY62cPJst+/pAXn
KH3fgnP6jwb41vG7FGwGd9691StPvxO7+WO2lsDOxeHymVexJTvMWs1Guf5NvBoO
ghQ0uPXx+KKpAxcpww8k9WSn7XstmuTfr+6aeqNLUW480yVaZKRJS5yGPMUnbsMF
qcrIRKLwkEA8bMwNdOXcnSwDky3yNQ==
=dS6m
-----END PGP SIGNATURE-----

--W2uTuL7OJv5eGppvH7dHPF43fzOkzbWnC--
