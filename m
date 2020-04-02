Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97734C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB8B206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB8B206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK1S3-0008JJ-JF
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 11:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <s.reiter@proxmox.com>) id 1jK1P0-0004TD-Lo
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <s.reiter@proxmox.com>) id 1jK1Oz-0006bq-3C
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:05:06 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:49071)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <s.reiter@proxmox.com>)
 id 1jK1Ov-0006RV-9G; Thu, 02 Apr 2020 11:05:01 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 10DEF45983;
 Thu,  2 Apr 2020 17:04:56 +0200 (CEST)
Subject: Re: [PATCH v4 1/3] job: take each job's lock individually in
 job_txn_apply
To: Max Reitz <mreitz@redhat.com>, kwolf@redhat.com
References: <20200401081504.200017-1-s.reiter@proxmox.com>
 <20200401081504.200017-2-s.reiter@proxmox.com>
 <e6319083-4ba0-9d30-3ecd-1c81bf7c20f9@redhat.com>
From: Stefan Reiter <s.reiter@proxmox.com>
Message-ID: <8029d1d8-2b95-ce4c-40ad-415db84be00b@proxmox.com>
Date: Thu, 2 Apr 2020 17:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e6319083-4ba0-9d30-3ecd-1c81bf7c20f9@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: vsementsov@virtuozzo.com, slp@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, stefanha@redhat.com, jsnow@redhat.com,
 dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/04/2020 14:33, Max Reitz wrote:
> On 01.04.20 10:15, Stefan Reiter wrote:
>> All callers of job_txn_apply hold a single job's lock, but different
>> jobs within a transaction can have different contexts, thus we need to
>> lock each one individually before applying the callback function.
>>
>> Similar to job_completed_txn_abort this also requires releasing the
>> caller's context before and reacquiring it after to avoid recursive
>> locks which might break AIO_WAIT_WHILE in the callback.
>>
>> This also brings to light a different issue: When a callback function =
in
>> job_txn_apply moves it's job to a different AIO context, job_exit will
>> try to release the wrong lock (now that we re-acquire the lock
>> correctly, previously it would just continue with the old lock, leavin=
g
>> the job unlocked for the rest of the codepath back to job_exit). Fix
>> this by not caching the job's context in job_exit and add a comment
>> about why this is done.
>>
>> One test needed adapting, since it calls job_finalize directly, so it
>> manually needs to acquire the correct context.
>>
>> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
>> ---
>>   job.c                 | 48 ++++++++++++++++++++++++++++++++++-------=
--
>>   tests/test-blockjob.c |  2 ++
>>   2 files changed, 40 insertions(+), 10 deletions(-)
>>
>> diff --git a/job.c b/job.c
>> index 134a07b92e..5fbaaabf78 100644
>> --- a/job.c
>> +++ b/job.c
>> @@ -136,17 +136,36 @@ static void job_txn_del_job(Job *job)
>>       }
>>   }
>>  =20
>> -static int job_txn_apply(JobTxn *txn, int fn(Job *))
>> +static int job_txn_apply(Job *job, int fn(Job *))
>>   {
>> -    Job *job, *next;
>> +    AioContext *inner_ctx;
>> +    Job *other_job, *next;
>> +    JobTxn *txn =3D job->txn;
>>       int rc =3D 0;
>>  =20
>> -    QLIST_FOREACH_SAFE(job, &txn->jobs, txn_list, next) {
>> -        rc =3D fn(job);
>> +    /*
>> +     * Similar to job_completed_txn_abort, we take each job's lock be=
fore
>> +     * applying fn, but since we assume that outer_ctx is held by the=
 caller,
>> +     * we need to release it here to avoid holding the lock twice - w=
hich would
>> +     * break AIO_WAIT_WHILE from within fn.
>> +     */
>> +    aio_context_release(job->aio_context);
>=20
> Hm, is it safe to drop the lock here and then reacquire it later?  I.e.=
,
> is the job in a consistent state in between?  I don=92t know.  Looks li=
ke
> it.  Maybe someone else knows better.
>

I would have said so too, but the iotest segfaults Kevin discovered (I=20
can reproduce them after a dozen or so cycles) seem to be triggered by=20
some kind of race, which I can only imagine being caused by it not being=20
safe to drop the lock.

It can be resolved by doing a job_ref/unref in job_txn_apply, but that=20
might be only fixing the symptoms and ignoring the problem.

> (I find the job code rather confusing.)
>=20

That seems to be common around here ;)

>> +
>> +    QLIST_FOREACH_SAFE(other_job, &txn->jobs, txn_list, next) {
>> +        inner_ctx =3D other_job->aio_context;
>> +        aio_context_acquire(inner_ctx);

Ignoring the fact that fn() can change a job's lock, one idea I had was=20
to do a

   if (inner_ctx !=3D job->aio_context) {
       aio_context_acquire(inner_ctx);
   }

instead of releasing the lock prior.
However, that gets complicated when the job's context does change in fn.

>> +        rc =3D fn(other_job);
>> +        aio_context_release(inner_ctx);
>>           if (rc) {
>>               break;
>>           }
>>       }
>> +
>> +    /*
>> +     * Note that job->aio_context might have been changed by calling =
fn, so we
>> +     * can't use a local variable to cache it.
>> +     */
>> +    aio_context_acquire(job->aio_context);
>=20
> But all callers of job_txn_apply() (but job_exit(), which you fix in
> this patch) cache it.  Won=92t they release the wrong context then?  Or=
 is
> a context change only possible when job_txn_apply() is called from
> job_exit()?
>=20

You're right that it can probably change for other callers as well=20
(though at least it doesn't seem to currently, since no other test cases=20
fail?). Looking at the analysis Vladimir did [0], there's a few places=20
where that would need fixing.

The issue is that all of these places would also need the job_ref/unref=20
part AFAICT, which would make this a bit unwieldy...

[0] https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07867.html

> Max
>=20


