Received: from eggs.gnu.org ([2001:4830:134:3::10]:52409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYbZW-0006v0-87
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYbZV-0006vo-C4
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:46:22 -0500
Date: Tue, 31 Jan 2017 16:46:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131164613.GX18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-19-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z3PcgjD2qOzdkXVS"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-19-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 18/21] backup: new async architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--z3PcgjD2qOzdkXVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:29:01PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:

Just a few comments.  I need to resume review of this series tomorrow.

> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> index 1acb256..7d24cf6 100644
> --- a/include/block/blockjob.h
> +++ b/include/block/blockjob.h
> @@ -248,6 +248,15 @@ void block_job_user_pause(BlockJob *job);
>  bool block_job_user_paused(BlockJob *job);
> =20
>  /**
> + * block_job_should_pause:
> + * @job: The job being queried.
> + *
> + * Returns whether the job is currently paused, or will pause
> + * as soon as it reaches a sleeping point.

s/sleeping point/pause point/

> + */
> +bool block_job_should_pause(BlockJob *job);
> +
> +/**
>   * block_job_resume:
>   * @job: The job to be resumed.
>   *
> @@ -309,7 +318,11 @@ int block_job_complete_sync(BlockJob *job, Error **e=
rrp);
>   */
>  void block_job_iostatus_reset(BlockJob *job);
> =20
> -/**
> +
> +BlockErrorAction block_job_get_error_action(BlockJob *job,
> +                                            BlockdevOnError on_err, int =
error);

Missing doc comment.

> +
> +/*
>   * block_job_txn_new:
>   *
>   * Allocate and return a new block job transaction.  Jobs can be added t=
o the
> diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
> index 388b7b2..e15905f 100755
> --- a/tests/qemu-iotests/055
> +++ b/tests/qemu-iotests/055
> @@ -553,4 +553,4 @@ class TestDriveCompression(iotests.QMPTestCase):
>              self.do_test_compress_pause('blockdev-backup', format, targe=
t=3D'drive1')
> =20
>  if __name__ =3D=3D '__main__':
> -    iotests.main(supported_fmts=3D['raw', 'qcow2'])
> +    iotests.main(supported_fmts=3D['raw', 'qcow2'], supported_cache_mode=
s=3D['none'])

The test has no real dependency on cache=3Dnone.  Did you just add this to
influence performance in the hope that the test runs more
deterministically?

> diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
> index 9e87e1c..3d5e137 100644
> --- a/tests/qemu-iotests/129
> +++ b/tests/qemu-iotests/129
> @@ -66,8 +66,10 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
>          result =3D self.vm.qmp("stop")
>          self.assert_qmp(result, 'return', {})
>          result =3D self.vm.qmp("query-block-jobs")
> -        self.assert_qmp(result, 'return[0]/busy', True)
> -        self.assert_qmp(result, 'return[0]/ready', False)
> +        if result['return']:
> +            # make additional check if block job is not released yet
> +            self.assert_qmp(result, 'return[0]/busy', True)
> +            self.assert_qmp(result, 'return[0]/ready', False)

This is silencing a failure rather than improving the test case.  Why
does the test case fail for you?  The rate limit is 1 KB/s, so the job
should have no chance of completing.

--z3PcgjD2qOzdkXVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkL9VAAoJEJykq7OBq3PIQboH/RGzUiRSBl4U3VlbnVvsPyUS
1SFjmCCXvdqukBwqjBFzelNEutvbNHU4e/23GB4eoamw/1eqXKCuKSfTYrrwCMN0
OdXNnQRzWd+d6zHETFsVGPNoWq+A2ghvL+7ywwdmYNUi9yTr6cR09Gm2abV2Fc+3
GbFCkgdQnWePS7b/4uYaatWai9Vip93Jl/+x8/hu5ujrVqKiUH1k+DjB1YdSXcCC
JtTc/pmd8F6V3cBomkcTveiqwzbIiolTpLC3NOykwmC+eeVQAwqDTcwf6iobkgO4
SKtB2HYLiu4PcfiSCnUOo7YWRWbk0gUfJqysFcUzQr6b43cC6bocNslzC1qSGD8=
=+lm0
-----END PGP SIGNATURE-----

--z3PcgjD2qOzdkXVS--
