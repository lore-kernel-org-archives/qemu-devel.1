Received: from eggs.gnu.org ([2001:4830:134:3::10]:34069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f0xMv-0001i4-E2
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 18:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f0xMu-00072y-9P
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 18:47:05 -0400
References: <20180327160736.24309-1-marcandre.lureau@redhat.com>
	<20180327201017.GT12302@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <f7cdb4cc-b614-5d43-ee98-7d678631a652@redhat.com>
Date: Tue, 27 Mar 2018 18:46:48 -0400
MIME-Version: 1.0
In-Reply-To: <20180327201017.GT12302@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockjob: leak fix,
 remove from txn when failing early
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com



On 03/27/2018 04:10 PM, Jeff Cody wrote:
> On Tue, Mar 27, 2018 at 06:07:36PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> This fixes leaks found by ASAN such as:
>>   GTESTER tests/test-blockjob
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D31442=3D=3DERROR: LeakSanitizer: detected memory leaks
>>
>> Direct leak of 24 byte(s) in 1 object(s) allocated from:
>>     #0 0x7f88483cba38 in __interceptor_calloc (/lib64/libasan.so.4+0xd=
ea38)
>>     #1 0x7f8845e1bd77 in g_malloc0 ../glib/gmem.c:129
>>     #2 0x7f8845e1c04b in g_malloc0_n ../glib/gmem.c:360
>>     #3 0x5584d2732498 in block_job_txn_new /home/elmarco/src/qemu/bloc=
kjob.c:172
>>     #4 0x5584d2739b28 in block_job_create /home/elmarco/src/qemu/block=
job.c:973
>>     #5 0x5584d270ae31 in mk_job /home/elmarco/src/qemu/tests/test-bloc=
kjob.c:34
>>     #6 0x5584d270b1c1 in do_test_id /home/elmarco/src/qemu/tests/test-=
blockjob.c:57
>>     #7 0x5584d270b65c in test_job_ids /home/elmarco/src/qemu/tests/tes=
t-blockjob.c:118
>>     #8 0x7f8845e40b69 in test_case_run ../glib/gtestutils.c:2255
>>     #9 0x7f8845e40f29 in g_test_run_suite_internal ../glib/gtestutils.=
c:2339
>>     #10 0x7f8845e40fd2 in g_test_run_suite_internal ../glib/gtestutils=
.c:2351
>>     #11 0x7f8845e411e9 in g_test_run_suite ../glib/gtestutils.c:2426
>>     #12 0x7f8845e3fe72 in g_test_run ../glib/gtestutils.c:1692
>>     #13 0x5584d270d6e2 in main /home/elmarco/src/qemu/tests/test-block=
job.c:377
>>     #14 0x7f8843641f29 in __libc_start_main (/lib64/libc.so.6+0x20f29)
>>
>> Add an assert to make sure that the job doesn't have associated txn be=
fore free().
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  blockjob.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/blockjob.c b/blockjob.c
>> index 11c9ce124d..bb75386515 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -228,6 +228,7 @@ void block_job_unref(BlockJob *job)
>>  {
>>      if (--job->refcnt =3D=3D 0) {
>>          assert(job->status =3D=3D BLOCK_JOB_STATUS_NULL);
>> +        assert(!job->txn);
>>          BlockDriverState *bs =3D blk_bs(job->blk);
>>          QLIST_REMOVE(job, job_list);
>>          bs->job =3D NULL;
>> @@ -479,6 +480,7 @@ static int block_job_finalize_single(BlockJob *job=
)
>> =20
>>      QLIST_REMOVE(job, txn_list);
>>      block_job_txn_unref(job->txn);
>> +    job->txn =3D NULL;
>>      block_job_conclude(job);
>>      return 0;
>>  }
>> @@ -994,6 +996,9 @@ void block_job_pause_all(void)
>>  void block_job_early_fail(BlockJob *job)
>>  {
>>      assert(job->status =3D=3D BLOCK_JOB_STATUS_CREATED);
>> +    QLIST_REMOVE(job, txn_list);
>> +    block_job_txn_unref(job->txn);
>> +    job->txn =3D NULL;
>>      block_job_decommission(job);
>>  }
>> =20
>> --=20
>> 2.17.0.rc1.1.g4c4f2b46a3
>>
>=20
> This patch causes a segfault/assert in iotests 031 041 055:
>=20
> e.g., from 031:
>=20
> test_set_speed_invalid (__main__.TestSetSpeed) ... DEBUG:QMP:>>> {'exec=
ute': 'qmp_capabilities'}
> DEBUG:QMP:<<< {u'return': {}}
> DEBUG:QMP:>>> {'execute': 'query-block-jobs'}
> DEBUG:QMP:<<< {u'return': []}
> DEBUG:QMP:>>> {'execute': 'block-stream', 'arguments': {'device': 'driv=
e0', 'speed': -1}}
> DEBUG:QMP:<<< None
> WARNING:qemu:qemu received signal -11: [...]
>=20
>=20

Oh, because block_job_early_fail can be called from block_job_create
before we've established a transaction (even if it's the dummy transactio=
n.)

It's a *really* early failure.

I patched it out like this; JTC: take whichever one, credit Marc-Andre
regardless of which you choose.

--js


diff --git a/blockjob.c b/blockjob.c
index ef3ed69ff1..c510a9fde5 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -204,6 +204,15 @@ void block_job_txn_add_job(BlockJobTxn *txn,
BlockJob *job)
     block_job_txn_ref(txn);
 }

+static void block_job_txn_del_job(BlockJob *job)
+{
+    if (job->txn) {
+        QLIST_REMOVE(job, txn_list);
+        block_job_txn_unref(job->txn);
+        job->txn =3D NULL;
+    }
+}
+
 static void block_job_pause(BlockJob *job)
 {
     job->pause_count++;
@@ -232,6 +241,7 @@ void block_job_unref(BlockJob *job)
 {
     if (--job->refcnt =3D=3D 0) {
         assert(job->status =3D=3D BLOCK_JOB_STATUS_NULL);
+        assert(!job->txn);
         BlockDriverState *bs =3D blk_bs(job->blk);
         QLIST_REMOVE(job, job_list);
         bs->job =3D NULL;
@@ -392,6 +402,7 @@ static void block_job_decommission(BlockJob *job)
     job->busy =3D false;
     job->paused =3D false;
     job->deferred_to_main_loop =3D true;
+    block_job_txn_del_job(job);
     block_job_state_transition(job, BLOCK_JOB_STATUS_NULL);
     block_job_unref(job);
 }
@@ -481,8 +492,7 @@ static int block_job_finalize_single(BlockJob *job)
         }
     }

-    QLIST_REMOVE(job, txn_list);
-    block_job_txn_unref(job->txn);
+    block_job_txn_del_job(job);
     block_job_conclude(job);
     return 0;
 }
