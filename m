Received: from eggs.gnu.org ([2001:4830:134:3::10]:48690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f0uvU-0003VK-AZ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 16:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f0uvT-00043Q-6V
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 16:10:36 -0400
Date: Tue, 27 Mar 2018 16:10:17 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180327201017.GT12302@localhost.localdomain>
References: <20180327160736.24309-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180327160736.24309-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] blockjob: leak fix,
 remove from txn when failing early
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

On Tue, Mar 27, 2018 at 06:07:36PM +0200, Marc-Andr=E9 Lureau wrote:
> This fixes leaks found by ASAN such as:
>   GTESTER tests/test-blockjob
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D31442=3D=3DERROR: LeakSanitizer: detected memory leaks
>=20
> Direct leak of 24 byte(s) in 1 object(s) allocated from:
>     #0 0x7f88483cba38 in __interceptor_calloc (/lib64/libasan.so.4+0xde=
a38)
>     #1 0x7f8845e1bd77 in g_malloc0 ../glib/gmem.c:129
>     #2 0x7f8845e1c04b in g_malloc0_n ../glib/gmem.c:360
>     #3 0x5584d2732498 in block_job_txn_new /home/elmarco/src/qemu/block=
job.c:172
>     #4 0x5584d2739b28 in block_job_create /home/elmarco/src/qemu/blockj=
ob.c:973
>     #5 0x5584d270ae31 in mk_job /home/elmarco/src/qemu/tests/test-block=
job.c:34
>     #6 0x5584d270b1c1 in do_test_id /home/elmarco/src/qemu/tests/test-b=
lockjob.c:57
>     #7 0x5584d270b65c in test_job_ids /home/elmarco/src/qemu/tests/test=
-blockjob.c:118
>     #8 0x7f8845e40b69 in test_case_run ../glib/gtestutils.c:2255
>     #9 0x7f8845e40f29 in g_test_run_suite_internal ../glib/gtestutils.c=
:2339
>     #10 0x7f8845e40fd2 in g_test_run_suite_internal ../glib/gtestutils.=
c:2351
>     #11 0x7f8845e411e9 in g_test_run_suite ../glib/gtestutils.c:2426
>     #12 0x7f8845e3fe72 in g_test_run ../glib/gtestutils.c:1692
>     #13 0x5584d270d6e2 in main /home/elmarco/src/qemu/tests/test-blockj=
ob.c:377
>     #14 0x7f8843641f29 in __libc_start_main (/lib64/libc.so.6+0x20f29)
>=20
> Add an assert to make sure that the job doesn't have associated txn bef=
ore free().
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  blockjob.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/blockjob.c b/blockjob.c
> index 11c9ce124d..bb75386515 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -228,6 +228,7 @@ void block_job_unref(BlockJob *job)
>  {
>      if (--job->refcnt =3D=3D 0) {
>          assert(job->status =3D=3D BLOCK_JOB_STATUS_NULL);
> +        assert(!job->txn);
>          BlockDriverState *bs =3D blk_bs(job->blk);
>          QLIST_REMOVE(job, job_list);
>          bs->job =3D NULL;
> @@ -479,6 +480,7 @@ static int block_job_finalize_single(BlockJob *job)
> =20
>      QLIST_REMOVE(job, txn_list);
>      block_job_txn_unref(job->txn);
> +    job->txn =3D NULL;
>      block_job_conclude(job);
>      return 0;
>  }
> @@ -994,6 +996,9 @@ void block_job_pause_all(void)
>  void block_job_early_fail(BlockJob *job)
>  {
>      assert(job->status =3D=3D BLOCK_JOB_STATUS_CREATED);
> +    QLIST_REMOVE(job, txn_list);
> +    block_job_txn_unref(job->txn);
> +    job->txn =3D NULL;
>      block_job_decommission(job);
>  }
> =20
> --=20
> 2.17.0.rc1.1.g4c4f2b46a3
>=20

This patch causes a segfault/assert in iotests 031 041 055:

e.g., from 031:

test_set_speed_invalid (__main__.TestSetSpeed) ... DEBUG:QMP:>>> {'execut=
e': 'qmp_capabilities'}
DEBUG:QMP:<<< {u'return': {}}
DEBUG:QMP:>>> {'execute': 'query-block-jobs'}
DEBUG:QMP:<<< {u'return': []}
DEBUG:QMP:>>> {'execute': 'block-stream', 'arguments': {'device': 'drive0=
', 'speed': -1}}
DEBUG:QMP:<<< None
WARNING:qemu:qemu received signal -11: [...]
