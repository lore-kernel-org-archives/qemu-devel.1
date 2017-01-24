Received: from eggs.gnu.org ([2001:4830:134:3::10]:51165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVy9D-00040k-Mk
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVy9C-0003CW-QZ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:16:19 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:41426 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVy9C-0003BR-FZ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:16:18 -0500
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-3-git-send-email-vsementsov@virtuozzo.com>
	<20170124070938.GB27126@lemon.Home>
	<ecdbc4c4-f908-9895-2ff8-0129dbaa41d4@virtuozzo.com>
	<20170124094629.GB14811@lemon.Home>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <823237d8-5b9f-74f8-5029-287227756e59@virtuozzo.com>
Date: Tue, 24 Jan 2017 13:16:05 +0300
MIME-Version: 1.0
In-Reply-To: <20170124094629.GB14811@lemon.Home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/21] backup: init copy_bitmap from
 sync_bitmap for incremental
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com, jcody@redhat.com

24.01.2017 12:46, Fam Zheng wrote:
> On Tue, 01/24 12:00, Vladimir Sementsov-Ogievskiy wrote:
>>>>    static void coroutine_fn backup_run(void *opaque)
>>>>    {
>>>>        BackupBlockJob *job = opaque;
>>>> @@ -453,20 +481,22 @@ static void coroutine_fn backup_run(void *opaque)
>>>>        end = DIV_ROUND_UP(job->common.len, job->cluster_size);
>>>>        job->copy_bitmap = hbitmap_alloc(end, 0);
>>>> -    hbitmap_set(job->copy_bitmap, 0, end);
>>>>        job->before_write.notify = backup_before_write_notify;
>>>>        bdrv_add_before_write_notifier(bs, &job->before_write);
>>>>        if (job->sync_mode == MIRROR_SYNC_MODE_NONE) {
>>>> +        hbitmap_set(job->copy_bitmap, 0, end);
>>> This is confusing. It seems job->copy_bitmap is actually a superset of clusters
>>> to copy instead of the exact one?  Because "none" mode doesn't need blanket copy
>>> - only overwritten clusters are copied...
>> We can't guess, what clusters should be copied finally in none mode. None
>> mode is done by allowing only notifier handling and no linear copying. But
>> notifier handling will copy only clusters marked in copy_bitmap, so I set it
>> from 0 to end.
> Yes, that's how I understand it too, what I dislike is this bit of inconsistency
> with it: "allowed to copy bitmap" here versus "planned to copy" in other modes.
> I don't know how to improve that, but I think at least the specialty of none
> mode could be mentioned in the comment of copy_bitmap.

Ok, comment will be good. I'll add it.


-- 
Best regards,
Vladimir
