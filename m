Received: from eggs.gnu.org ([2001:4830:134:3::10]:40670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIN9G-0002lU-Ja
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIN9D-0002Bq-8F
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:44:58 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-43-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <49ee7d19-779d-cc1b-12a4-e4be14dc0a0f@redhat.com>
Date: Tue, 15 May 2018 01:44:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-43-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uahR3Ng3ufcAYjEOHMnSPXUOJDQMX8zyS"
Subject: Re: [Qemu-devel] [PATCH 42/42] qemu-iotests: Test job-* with block
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
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uahR3Ng3ufcAYjEOHMnSPXUOJDQMX8zyS
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <49ee7d19-779d-cc1b-12a4-e4be14dc0a0f@redhat.com>
Subject: Re: [PATCH 42/42] qemu-iotests: Test job-* with block jobs
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-43-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-43-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This adds a test case that tests the new job-* QMP commands with
> mirror and backup block jobs.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/219     | 201 ++++++++++++++++++++++++++++
>  tests/qemu-iotests/219.out | 327 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 529 insertions(+)
>  create mode 100755 tests/qemu-iotests/219
>  create mode 100644 tests/qemu-iotests/219.out

Test looks good, but it fails (for me) on tmpfs because at the point of
the first query-jobs, they already have an offset of 65536.

> diff --git a/tests/qemu-iotests/219 b/tests/qemu-iotests/219
> new file mode 100755
> index 0000000000..6cfe54b4db
> --- /dev/null
> +++ b/tests/qemu-iotests/219
> @@ -0,0 +1,201 @@

[...]

> +with iotests.FilePath('disk.img') as disk_path, \
> +     iotests.FilePath('copy.img') as copy_path, \
> +     iotests.VM() as vm:
> +
> +    img_size =3D '4M'
> +    iotests.qemu_img_create('-f', iotests.imgfmt, disk_path, img_size)=

> +    iotests.qemu_io('-c', 'write 0 %s' % (img_size),
> +                    '-f', iotests.imgfmt, disk_path)
> +
> +    iotests.log('Launching VM...')
> +    vm.add_blockdev(vm.qmp_to_opts({
> +        'driver': iotests.imgfmt,
> +        'node-name': 'drive0-node',
> +        'file': {
> +            'driver': 'file',
> +            'filename': disk_path,
> +        },
> +    }))
> +    vm.launch()
> +
> +    # In order to keep things deterministic (especially progress in qu=
ery-job,
> +    # but related to this also automatic state transitions like job
> +    # completion), but still get pause points often enough to avoid ma=
king this
> +    # test veey slow, it's important to have the right ratio between s=
peed and

s/veey/very/

(Although "veey" does have its charm.)

> +    # buf_size.
> +    #
> +    # For backup, buf_size is hard-coded to the source image cluser si=
ze (64k),

s/cluser/cluster/

> +    # so we'll pick the same for mirror. The slice time, i.e. the gran=
ularity
> +    # of the rate limiting is 100ms. With a speed of 256k per second, =
we can
> +    # get four pause points per second. This gives us 250ms per iterat=
ion,
> +    # which should be enough to stay deterministic.
> +
> +    test_job_lifecycle(vm, 'drive-mirror', has_ready=3DTrue, job_args=3D=
{
> +        'device': 'drive0-node',
> +        'target': copy_path,
> +        'sync': 'full',
> +        'speed': 262144,
> +        'buf_size': 65536,
> +    })
> +
> +    for auto_finalize in [True, False]:
> +        for auto_dismiss in [True, False]:
> +            test_job_lifecycle(vm, 'drive-backup', job_args=3D{
> +                'device': 'drive0-node',
> +                'target': copy_path,
> +                'sync': 'full',
> +                'speed': 262144,
> +                'auto-finalize': auto_finalize,
> +                'auto-dismiss': auto_dismiss,
> +            })
> +
> +    vm.shutdown()
> diff --git a/tests/qemu-iotests/219.out b/tests/qemu-iotests/219.out
> new file mode 100644
> index 0000000000..e244be9ce8
> --- /dev/null
> +++ b/tests/qemu-iotests/219.out
> @@ -0,0 +1,327 @@

[...]

> +Pause/resume in READY
> +=3D=3D=3D Testing block-job-pause/block-job-resume =3D=3D=3D
> +{u'return': {}}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'=
}
> +{u'return': [{u'status': u'standby', u'current-progress': 4194304, u't=
otal-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> +{u'return': {}}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> +{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'tot=
al-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> +=3D=3D=3D Testing block-job-pause/job-resume =3D=3D=3D
> +{u'return': {}}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'=
}
> +{u'return': [{u'status': u'standby', u'current-progress': 4194304, u't=
otal-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> +{u'return': {}}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> +{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'tot=
al-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> +=3D=3D=3D Testing job-pause/block-job-resume =3D=3D=3D
> +{u'return': {}}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'=
}
> +{u'return': [{u'status': u'standby', u'current-progress': 4194304, u't=
otal-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> +{u'return': {}}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> +{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'tot=
al-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> +=3D=3D=3D Testing job-pause/job-resume =3D=3D=3D
> +{u'return': {}}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'=
}
> +{u'return': [{u'status': u'standby', u'current-progress': 4194304, u't=
otal-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> +{u'return': {}}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> +{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'tot=
al-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}

This is really, really mean.  Don't you have any compassion with the
poor little job that just wants to have Feierabend?

It worked so hard and it's always on standby and instantly ready when
you need it.  Yet, you keep it hanging.  That's not nice.

Max

> +{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state =
'ready' cannot accept command verb 'finalize'"}}
> +{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state =
'ready' cannot accept command verb 'dismiss'"}}
> +{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state =
'ready' cannot accept command verb 'finalize'"}}
> +{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state =
'ready' cannot accept command verb 'dismiss'"}}
> +{u'return': {}}
> +
> +Waiting for PENDING state...
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'waiting', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'=
}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'pending', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'=
}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'concluded', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANG=
E'}
> +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'null', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> +{u'return': []}



--uahR3Ng3ufcAYjEOHMnSPXUOJDQMX8zyS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr6H2kACgkQ9AfbAGHV
z0DVOwf7B/8vE5U8UM4puc1/gkbqm9KQaTs1/3qG37oATvwZgzFjpEL2b1TTGj28
IDUd/pu2Htf+trNtyW/Ty0L/R+JvcQ/weK+/ppQJ961XLD27uE/AHe5sHxS6OUcv
FR5mLrq3ETaaf/e+C+zfEBWo6+ijHtDBpbNbs49xn6bO/GZEs7xrDHU1st+DWWOi
3oI0vhTUIQ1RdYXK3Gd1P74IUq7xCWeZdk9L+HBubZFPQnQedgysXAXPFQ5QvyGx
Gm20qi2As3vMNHpxllyLQAwzort9lxR+2RLc7doD/bCKdwW05Zn958jENVRtE3eg
DybJlG/wfVh43CL7iaLPuxHQAF3qdA==
=hjy4
-----END PGP SIGNATURE-----

--uahR3Ng3ufcAYjEOHMnSPXUOJDQMX8zyS--
