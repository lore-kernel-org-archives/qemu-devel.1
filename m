Received: from eggs.gnu.org ([2001:4830:134:3::10]:43737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctmna-0005zI-V9
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 23:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctmnX-0003Zv-TV
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 23:00:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ctmnX-0003ZZ-MA
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 23:00:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C7B2C04B951
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 03:00:22 +0000 (UTC)
Date: Fri, 31 Mar 2017 11:00:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170331030015.GD3981@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-30-quintela@redhat.com>
	<20170330064934.GG20667@pxdev.xzpeter.org>
	<87d1cyn3w2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d1cyn3w2.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 29/51] ram: Move last_req_rb to RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On Thu, Mar 30, 2017 at 06:08:45PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Thu, Mar 23, 2017 at 09:45:22PM +0100, Juan Quintela wrote:
> >> It was on MigrationState when it is only used inside ram.c for
> >> postcopy.  Problem is that we need to access it without being able to
> >> pass it RAMState directly.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  include/migration/migration.h | 2 --
> >>  migration/migration.c         | 1 -
> >>  migration/ram.c               | 7 +++++--
> >>  3 files changed, 5 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/include/migration/migration.h b/include/migration/migration.h
> >> index 84cef4b..e032fb0 100644
> >> --- a/include/migration/migration.h
> >> +++ b/include/migration/migration.h
> >> @@ -189,8 +189,6 @@ struct MigrationState
> >>      /* Queue of outstanding page requests from the destination */
> >>      QemuMutex src_page_req_mutex;
> >>      QSIMPLEQ_HEAD(src_page_requests, MigrationSrcPageRequest) src_page_requests;
> >> -    /* The RAMBlock used in the last src_page_request */
> >> -    RAMBlock *last_req_rb;
> >>      /* The semaphore is used to notify COLO thread that failover is finished */
> >>      QemuSemaphore colo_exit_sem;
> >>  
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index e532430..b220941 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -1118,7 +1118,6 @@ MigrationState *migrate_init(const MigrationParams *params)
> >>      s->postcopy_after_devices = false;
> >>      s->postcopy_requests = 0;
> >>      s->migration_thread_running = false;
> >> -    s->last_req_rb = NULL;
> >>      error_free(s->error);
> >>      s->error = NULL;
> >>  
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index dd5a453..325a0f3 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -203,6 +203,8 @@ struct RAMState {
> >>      QemuMutex bitmap_mutex;
> >>      /* Ram Bitmap protected by RCU */
> >>      RAMBitmap *ram_bitmap;
> >> +    /* The RAMBlock used in the last src_page_request */
> >                                                         ^ "s" missing
> >
> > Besides:
> 
> The important one is only the last one, we don't really care about the
> previous here, no?

I preferred "src_page_requests" since that's the variable name (so
then people can do symbol search on that). Anyway, that's trivial, so
please feel free to ignore it. :-)

-- peterx
