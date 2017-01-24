Received: from eggs.gnu.org ([2001:4830:134:3::10]:43090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVxhP-0004Yw-8r
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVxhO-0003Ez-Eg
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:47:35 -0500
Date: Tue, 24 Jan 2017 17:46:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170124094629.GB14811@lemon.Home>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-3-git-send-email-vsementsov@virtuozzo.com>
	<20170124070938.GB27126@lemon.Home>
	<ecdbc4c4-f908-9895-2ff8-0129dbaa41d4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecdbc4c4-f908-9895-2ff8-0129dbaa41d4@virtuozzo.com>
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com, jcody@redhat.com

On Tue, 01/24 12:00, Vladimir Sementsov-Ogievskiy wrote:
> > >   static void coroutine_fn backup_run(void *opaque)
> > >   {
> > >       BackupBlockJob *job = opaque;
> > > @@ -453,20 +481,22 @@ static void coroutine_fn backup_run(void *opaque)
> > >       end = DIV_ROUND_UP(job->common.len, job->cluster_size);
> > >       job->copy_bitmap = hbitmap_alloc(end, 0);
> > > -    hbitmap_set(job->copy_bitmap, 0, end);
> > >       job->before_write.notify = backup_before_write_notify;
> > >       bdrv_add_before_write_notifier(bs, &job->before_write);
> > >       if (job->sync_mode == MIRROR_SYNC_MODE_NONE) {
> > > +        hbitmap_set(job->copy_bitmap, 0, end);
> > This is confusing. It seems job->copy_bitmap is actually a superset of clusters
> > to copy instead of the exact one?  Because "none" mode doesn't need blanket copy
> > - only overwritten clusters are copied...
> 
> We can't guess, what clusters should be copied finally in none mode. None
> mode is done by allowing only notifier handling and no linear copying. But
> notifier handling will copy only clusters marked in copy_bitmap, so I set it
> from 0 to end.

Yes, that's how I understand it too, what I dislike is this bit of inconsistency
with it: "allowed to copy bitmap" here versus "planned to copy" in other modes.
I don't know how to improve that, but I think at least the specialty of none
mode could be mentioned in the comment of copy_bitmap.
