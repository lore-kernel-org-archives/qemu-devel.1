Received: from eggs.gnu.org ([2001:4830:134:3::10]:43518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eHUZC-0004YZ-1H
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eHUZ9-0004sd-0R
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:55:50 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <160cac7d-7dc6-2daf-5299-82a57bffe14c@virtuozzo.com>
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
	<w51inekzv59.fsf@maestria.local.igalia.com>
	<w518tff4dvi.fsf@maestria.local.igalia.com>
	<20171110030223.GA7303@lemon>
	<w518tf7k0ov.fsf@maestria.local.igalia.com>
	<14461b9b-d62d-3723-d2bb-c2fe873207c5@virtuozzo.com>
	<w51bmk2qkvv.fsf@maestria.local.igalia.com>
	<41e905e4-0c2a-fad3-09a6-4959f04fe546@virtuozzo.com>
	<w51zi7fbxrd.fsf@maestria.local.igalia.com>
	<160cac7d-7dc6-2daf-5299-82a57bffe14c@virtuozzo.com>
Date: Wed, 22 Nov 2017 13:55:17 +0100
Message-ID: <w51tvxmscay.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] segfault in parallel blockjobs
 (iotest 30)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

On Tue 21 Nov 2017 04:18:13 PM CET, Anton Nefedov wrote:
>  >> keep BlockJob referenced while it is
>  >> paused (by block_job_pause/resume_all()). That should prevent it from
>  >> deleting the BB.
>
> looks kind of hacky; maybe referencing in block_job_pause() (and not
> just pause_all) seems more correct? I think it didn't work for me
> right away though. But I can look more.

This fixes one crash for me (but only the test_stream_commit, it doesn't
fix iotest 030 completely), but I agree it looks kind of hacky.

Peharps replacing block_job_next() with QLIST_FOREACH_SAFE() is a good
idea, though, I guess resuming a block job can theoretically lead to its
destruction?

Berto

diff --git a/blockjob.c b/blockjob.c
index ff9a614531..53cffc7980 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -699,6 +699,7 @@ void block_job_pause_all(void)
         AioContext *aio_context = blk_get_aio_context(job->blk);
 
         aio_context_acquire(aio_context);
+        block_job_ref(job);
         block_job_pause(job);
         aio_context_release(aio_context);
     }
@@ -759,12 +760,14 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
 
 void block_job_resume_all(void)
 {
-    BlockJob *job = NULL;
-    while ((job = block_job_next(job))) {
+    BlockJob *job, *next;
+
+    QLIST_FOREACH_SAFE(job, &block_jobs, job_list, next) {
         AioContext *aio_context = blk_get_aio_context(job->blk);
 
         aio_context_acquire(aio_context);
         block_job_resume(job);
+        block_job_unref(job);
         aio_context_release(aio_context);
     }
 }
