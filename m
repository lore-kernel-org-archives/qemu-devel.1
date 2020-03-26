Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517AEC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C7820714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C7820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHP43-0006cS-C1
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 05:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <s.reiter@proxmox.com>) id 1jHP3N-0005nO-CW
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <s.reiter@proxmox.com>) id 1jHP3L-0004qh-Pq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:43:57 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:30800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <s.reiter@proxmox.com>)
 id 1jHP3I-0004n9-D6; Thu, 26 Mar 2020 05:43:52 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 50BC6428C9;
 Thu, 26 Mar 2020 10:43:49 +0100 (CET)
Subject: Re: [PATCH] backup: don't acquire aio_context in backup_clean
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <76edbead-7ccf-833b-a3f2-15dff7f0748c@virtuozzo.com>
 <20200325155055.730633-1-s.reiter@proxmox.com>
 <2b288000-7c09-ba31-82a7-02c5ed55f4e7@virtuozzo.com>
From: Stefan Reiter <s.reiter@proxmox.com>
Message-ID: <1d1984b3-14f5-5a17-b477-d70561f75e8f@proxmox.com>
Date: Thu, 26 Mar 2020 10:43:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2b288000-7c09-ba31-82a7-02c5ed55f4e7@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: kwolf@redhat.com, slp@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 jsnow@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/03/2020 06:54, Vladimir Sementsov-Ogievskiy wrote:
> 25.03.2020 18:50, Stefan Reiter wrote:
>> backup_clean is only ever called as a handler via job_exit, which
>=20
> Hmm.. I'm afraid it's not quite correct.
>=20
> job_clean
>=20
>  =C2=A0 job_finalize_single
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0 job_completed_txn_abort (lock aio context)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0 job_do_finalize
>=20
>=20
> Hmm. job_do_finalize calls job_completed_txn_abort, which cares to lock=
=20
> aio context..
> And on the same time, it directaly calls job_txn_apply(job->txn,=20
> job_finalize_single)
> without locking. Is it a bug?
>=20

I think, as you say, the idea is that job_do_finalize is always called=20
with the lock acquired. That's why job_completed_txn_abort takes care to=20
release the lock (at least of the "outer_ctx" as it calls it) before=20
reacquiring it.

> And, even if job_do_finalize called always with locked context, where i=
s=20
> guarantee that all
> context of all jobs in txn are locked?
>=20

I also don't see anything that guarantees that... I guess it could be=20
adapted to handle locks like job_completed_txn_abort does?

Haven't looked into transactions too much, but does it even make sense=20
to have jobs in different contexts in one transaction?

> Still, let's look through its callers.
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_finalize
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 qmp_block_job_finalize (lock aio context)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 qmp_job_finalize (lock aio context)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 test_cancel_concluded (doesn't lock, but it's a test)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_completed_t=
xn_success
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 job_completed
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_exit (lock aio context)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_cancel
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
blockdev_mark_auto_del (lock aio context)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
job_user_cancel
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 qmp_block_job_cancel (locks context)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 qmp_job_cancel=C2=A0 (locks context)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
job_cancel_err
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_cancel_sync (return=20
> job_finish_sync(job, &job_cancel_err, NULL);, job_finish_sync just call=
s=20
> callback)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replication_clo=
se (it's=20
> .bdrv_close.. Hmm, I don't see context locking, where is it ?)
Hm, don't see it either. This might indeed be a way to get to job_clean=20
without a lock held.

I don't have any testing set up for replication atm, but if you believe=20
this would be correct I can send a patch for that as well (just acquire=20
the lock in replication_close before job_cancel_async?).

>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replication_sto=
p (locks context)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drive_backup_ab=
ort (locks context)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blockdev_backup=
_abort (locks context)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_cancel_sync=
_all (locks context)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cancel_common (=
locks context)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
test_* (I don't care)
>=20

To clarify, aside from the commit message the patch itself does not=20
appear to be wrong? All paths (aside from replication_close mentioned=20
above) guarantee the job lock to be held.

>> already acquires the job's context. The job's context is guaranteed to
>> be the same as the one used by backup_top via backup_job_create.
>>
>> Since the previous logic effectively acquired the lock twice, this
>> broke cleanup of backups for disks using IO threads, since the=20
>> BDRV_POLL_WHILE
>> in bdrv_backup_top_drop -> bdrv_do_drained_begin would only release=20
>> the lock
>> once, thus deadlocking with the IO thread.
>>
>> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
>=20
> Just note, that this thing were recently touched by 0abf2581717a19 , so=
=20
> add Sergio (its author) to CC.
>=20
>> ---
>>
>> This is a fix for the issue discussed in this part of the thread:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07639.html
>> ...not the original problem (core dump) posted by Dietmar.
>>
>> I've still seen it occasionally hang during a backup abort. I'm trying=
=20
>> to figure
>> out why that happens, stack trace indicates a similar problem with the=
=20
>> main
>> thread hanging at bdrv_do_drained_begin, though I have no clue why as=20
>> of yet.
>>
>> =C2=A0 block/backup.c | 4 ----
>> =C2=A0 1 file changed, 4 deletions(-)
>>
>> diff --git a/block/backup.c b/block/backup.c
>> index 7430ca5883..a7a7dcaf4c 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -126,11 +126,7 @@ static void backup_abort(Job *job)
>> =C2=A0 static void backup_clean(Job *job)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BackupBlockJob *s =3D container_of(job,=
 BackupBlockJob, common.job);
>> -=C2=A0=C2=A0=C2=A0 AioContext *aio_context =3D bdrv_get_aio_context(s=
->backup_top);
>> -
>> -=C2=A0=C2=A0=C2=A0 aio_context_acquire(aio_context);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_backup_top_drop(s->backup_top);
>> -=C2=A0=C2=A0=C2=A0 aio_context_release(aio_context);
>> =C2=A0 }
>> =C2=A0 void backup_do_checkpoint(BlockJob *job, Error **errp)
>>
>=20
>=20


