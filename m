Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6545BC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A8F2063A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A8F2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK1T6-0000vM-EX
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 11:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <s.reiter@proxmox.com>) id 1jK1P4-0004eW-Vd
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <s.reiter@proxmox.com>) id 1jK1P3-0006iJ-Jw
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:05:10 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:35186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <s.reiter@proxmox.com>)
 id 1jK1P0-0006df-PO; Thu, 02 Apr 2020 11:05:06 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B53764597C;
 Thu,  2 Apr 2020 17:05:05 +0200 (CEST)
Subject: Re: [PATCH v4 2/3] replication: acquire aio context before calling
 job_cancel_sync
To: Max Reitz <mreitz@redhat.com>
References: <20200401081504.200017-1-s.reiter@proxmox.com>
 <20200401081504.200017-3-s.reiter@proxmox.com>
 <7d231bb6-4b1c-1cd1-51a6-4bef97de65e0@redhat.com>
From: Stefan Reiter <s.reiter@proxmox.com>
Message-ID: <67ea19c5-077d-08b8-e1f8-9978e3e37fff@proxmox.com>
Date: Thu, 2 Apr 2020 17:05:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7d231bb6-4b1c-1cd1-51a6-4bef97de65e0@redhat.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, slp@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 jsnow@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/04/2020 14:41, Max Reitz wrote:
> On 01.04.20 10:15, Stefan Reiter wrote:
>> job_cancel_sync requires the job's lock to be held, all other callers
>> already do this (replication_stop, drive_backup_abort,
>> blockdev_backup_abort, job_cancel_sync_all, cancel_common).
>=20
> I think all other callers come directly from QMP, though, so they have
> no locks yet.  This OTOH is called from a block driver function, so I
> would assume the BDS context is locked already (or rather, this is
> executed in the BDS context).
>=20
> I also think that the commit job runs in the same context.  So I would
> assume that this would be a nested lock, which should be unnecessary an=
d
> might cause problems.  Maybe we should just assert that the job=92s
> context is the current context?
>=20
> (Or would that still be problematic because now job_txn_apply() wants t=
o
> release some context, and that isn=92t possible without this patch?  I
> would hope it=92s possible, because I think we shouldn=92t have to acqu=
ire
> the current context, and should be free to release it...?  I have no
> idea.  Maybe we are actually free to reacquire the current context here=
.)
>=20

You're right, this seems to be unnecessary. Adding an

   assert(commit_job->aio_context =3D=3D qemu_get_current_aio_context());

to make sure seems like a good idea though. bdrv_close appears to always=20
have the lock on its driver's context held.

>> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
>> ---
>>   block/replication.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/replication.c b/block/replication.c
>> index 413d95407d..17ddc31569 100644
>> --- a/block/replication.c
>> +++ b/block/replication.c
>> @@ -144,12 +144,18 @@ fail:
>>   static void replication_close(BlockDriverState *bs)
>>   {
>>       BDRVReplicationState *s =3D bs->opaque;
>> +    Job *commit_job;
>> +    AioContext *commit_ctx;
>>  =20
>>       if (s->stage =3D=3D BLOCK_REPLICATION_RUNNING) {
>>           replication_stop(s->rs, false, NULL);
>>       }
>>       if (s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
>> -        job_cancel_sync(&s->commit_job->job);
>> +        commit_job =3D &s->commit_job->job;
>> +        commit_ctx =3D commit_job->aio_context;
>> +        aio_context_acquire(commit_ctx);
>> +        job_cancel_sync(commit_job);
>> +        aio_context_release(commit_ctx);
>=20
> Anyway, there=92s also the problem that I would guess the
> job_cancel_sync() might move the job from its current context back into
> the main context.  Then we=92d release the wrong context here.
>  > Max
>=20
>>       }
>>  =20
>>       if (s->mode =3D=3D REPLICATION_MODE_SECONDARY) {
>>
>=20
>=20


