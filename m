Received: from eggs.gnu.org ([2001:4830:134:3::10]:54327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWf9I-0004yq-TN
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWf9F-0001HD-M7
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:15:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWf9F-0001G4-G6
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:15:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3F49C0568F9
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 09:15:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103054043.25719-3-peterx@redhat.com> (Peter Xu's message of
	"Wed, 3 Jan 2018 13:40:34 +0800")
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-3-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 10:15:41 +0100
Message-ID: <87efn72the.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/11] migration:
 qemu_savevm_state_cleanup() in cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Moving existing callers all into migrate_fd_cleanup().  It simplifies
> migration_thread() a bit.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I am trying to see if we can call migrate_fd_cleanup() twice.  As far as
I can see, we are not doing it.  But, and it is a big but, we are not
checking that we are not calling qemu_savevm_state_cleanup() twice.  If
that happens, we can get double frees and similar.

I put the reviewed-by anyways, because I *think* that we are doing it
right now, and otherwise, we should make sure that we are not calling it
twice, not papering over it.

Once here, I have notice that we call block_cleanup_parameters() in
*three* places.  We call notifier_list_notify() on two of this places (I
can't see any good reason *why* we don't call the notifier for
migrate_fd_cancel).

So, still more review/cleanups to do on this arera.

Later, Juan.

> ---
>  migration/migration.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 0ee4b4c27c..edbda43246 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1077,6 +1077,8 @@ static void migrate_fd_cleanup(void *opaque)
>      qemu_bh_delete(s->cleanup_bh);
>      s->cleanup_bh = NULL;
>  
> +    qemu_savevm_state_cleanup();
> +
>      if (s->to_dst_file) {
>          Error *local_err = NULL;
>  
> @@ -2290,13 +2292,6 @@ static void *migration_thread(void *opaque)
>      end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>  
>      qemu_mutex_lock_iothread();
> -    /*
> -     * The resource has been allocated by migration will be reused in COLO
> -     * process, so don't release them.
> -     */
> -    if (!enable_colo) {
> -        qemu_savevm_state_cleanup();
> -    }
>      if (s->state == MIGRATION_STATUS_COMPLETED) {
>          uint64_t transferred_bytes = qemu_ftell(s->to_dst_file);
>          s->total_time = end_time - s->total_time;
> @@ -2312,7 +2307,6 @@ static void *migration_thread(void *opaque)
>          if (s->state == MIGRATION_STATUS_ACTIVE) {
>              assert(enable_colo);
>              migrate_start_colo_process(s);
> -            qemu_savevm_state_cleanup();
>              /*
>              * Fixme: we will run VM in COLO no matter its old running state.
>              * After exited COLO, we will keep running.
