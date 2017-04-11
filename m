Received: from eggs.gnu.org ([2001:4830:134:3::10]:40727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cxrbp-000719-3D
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cxrbj-000592-6q
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:57:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cxrbi-00058f-Tq
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:57:03 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D12E475EA8
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 08:57:01 +0000 (UTC)
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-10-pbonzini@redhat.com>
	<9a383fa0-040f-c90e-23ca-df32636786b3@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7fdbf44b-24af-aa94-d1b7-c8d7e82af1c4@redhat.com>
Date: Tue, 11 Apr 2017 12:11:08 +0800
MIME-Version: 1.0
In-Reply-To: <9a383fa0-040f-c90e-23ca-df32636786b3@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/10] blockjob: reorganize
 block_job_completed_txn_abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com



On 11/04/2017 03:17, John Snow wrote:
> One thing that I wonder about a little is the push-down of whether or
> not to reset iostatus falling to block_job_cancel_async; it seemed to m=
e
> as if txn_abort really had the best knowledge as to whether or not we
> wanted to reset iostatus, but as it stands it doesn't really make a
> difference.

Actually, there was no iostatus reset in txn_abort; it was done in
block_job_cancel only.  But the BLOCK_JOB_CANCELLED event doesn't
publish the iostatus actually, so I could have also done the opposite:
remove the reset in block_job_cancel---it shouldn't make a difference in
theory.

On the other hand, I like respecting the invariant then the coroutine
always runs with BLOCK_DEVICE_IO_STATUS_OK iostatus, so I think that
it's right for cancel_async to reset the iostatus.  Speaking about
iostatus and invariants, probably we should also set "job->user_paused =3D
false" in block_job_cancel_async.

> ACK for now, because it's still not perfectly obvious to me how this
> will wind up helping, though I do believe you :)

It just helps me making sure that the locking is correct later.  Maybe
it will help you too!

Paolo

>>  static void block_job_completed_txn_success(BlockJob *job)
>> @@ -502,37 +577,6 @@ void block_job_cancel(BlockJob *job)
>>      }
>>  }
>> =20
>> -static int block_job_finish_sync(BlockJob *job,
>> -                                 void (*finish)(BlockJob *, Error **e=
rrp),
>> -                                 Error **errp)
>> -{
>> -    Error *local_err =3D NULL;
>> -    int ret;
>> -
>> -    assert(blk_bs(job->blk)->job =3D=3D job);
>> -
>> -    block_job_ref(job);
>> -
>> -    finish(job, &local_err);
>> -    if (local_err) {
>> -        error_propagate(errp, local_err);
>> -        block_job_unref(job);
>> -        return -EBUSY;
>> -    }
>> -    /* block_job_drain calls block_job_enter, and it should be enough=
 to
>> -     * induce progress until the job completes or moves to the main t=
hread.
>> -    */
>> -    while (!job->deferred_to_main_loop && !job->completed) {
>> -        block_job_drain(job);
>> -    }
>> -    while (!job->completed) {
>> -        aio_poll(qemu_get_aio_context(), true);
>> -    }
>> -    ret =3D (job->cancelled && job->ret =3D=3D 0) ? -ECANCELED : job-=
>ret;
>> -    block_job_unref(job);
>> -    return ret;
>> -}
>> -
>>  /* A wrapper around block_job_cancel() taking an Error ** parameter s=
o it may be
>>   * used with block_job_finish_sync() without the need for (rather nas=
ty)
>>   * function pointer casts there. */
>> @@ -856,36 +900,3 @@ void block_job_defer_to_main_loop(BlockJob *job,
>>      aio_bh_schedule_oneshot(qemu_get_aio_context(),
>>                              block_job_defer_to_main_loop_bh, data);
>>  }
>=20
> And everything following is pure movement.
>=20
>> -
>> -BlockJobTxn *block_job_txn_new(void)
>> -{
>> -    BlockJobTxn *txn =3D g_new0(BlockJobTxn, 1);
>> -    QLIST_INIT(&txn->jobs);
>> -    txn->refcnt =3D 1;
>> -    return txn;
>> -}
>> -
>> -static void block_job_txn_ref(BlockJobTxn *txn)
>> -{
>> -    txn->refcnt++;
>> -}
>> -
>> -void block_job_txn_unref(BlockJobTxn *txn)
>> -{
>> -    if (txn && --txn->refcnt =3D=3D 0) {
>> -        g_free(txn);
>> -    }
>> -}
>> -
>> -void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job)
>> -{
>> -    if (!txn) {
>> -        return;
>> -    }
>> -
>> -    assert(!job->txn);
>> -    job->txn =3D txn;
>> -
>> -    QLIST_INSERT_HEAD(&txn->jobs, job, txn_list);
>> -    block_job_txn_ref(txn);
>> -}
>>
