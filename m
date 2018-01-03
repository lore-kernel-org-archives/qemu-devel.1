Received: from eggs.gnu.org ([2001:4830:134:3::10]:53996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWf8F-00046m-QQ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWf8C-0008S3-GU
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:14:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWf8C-0008Ps-A5
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:14:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C8C66A7CB
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 09:14:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103054043.25719-9-peterx@redhat.com> (Peter Xu's message of
	"Wed, 3 Jan 2018 13:40:40 +0800")
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-9-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 10:14:33 +0100
Message-ID: <87fu7n2tja.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/11] migration: use switch at the end of
 migration
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
> It converts the old if clauses into switch, explicitly mentions the
> possible migration states.  The old nested "if"s are not clear on what
> we do on different states.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index acef54748b..bfcba24caa 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2296,19 +2296,23 @@ static void *migration_thread(void *opaque)
>      cpu_throttle_stop();
>  
>      qemu_mutex_lock_iothread();
> -    if (s->state == MIGRATION_STATUS_COMPLETED) {
> +    switch (s->state) {
> +    case MIGRATION_STATUS_COMPLETED:
>          migration_calculate_complete(s);
>          runstate_set(RUN_STATE_POSTMIGRATE);
> -    } else {
> -        if (s->state == MIGRATION_STATUS_ACTIVE) {
> -            assert(migrate_colo_enabled());
> -            migrate_start_colo_process(s);
> -            /*
> -            * Fixme: we will run VM in COLO no matter its old running state.
> -            * After exited COLO, we will keep running.
> -            */
> -            s->old_vm_running = true;
> -        }
> +        break;
> +
> +    case MIGRATION_STATUS_ACTIVE:
> +        assert(migrate_colo_enabled());
> +        migrate_start_colo_process(s);

I think this line is wrong, you still have to proctect it with the if
(migrate_cole_enabled).

Rest of cleanup, is something that I like.

Later, Juan.


> +        /*
> +         * Fixme: we will run VM in COLO no matter its old running state.
> +         * After exited COLO, we will keep running.
> +         */
> +        s->old_vm_running = true;
> +        /* Fallthrough */

Actually, I don't like Fallthrought on C, but well, problem is C O:-)

> +    case MIGRATION_STATUS_FAILED:
> +    case MIGRATION_STATUS_CANCELLED:
>          if (s->old_vm_running) {
>              vm_start();
>          } else {
> @@ -2316,6 +2320,12 @@ static void *migration_thread(void *opaque)
>                  runstate_set(RUN_STATE_POSTMIGRATE);
>              }
>          }
> +        break;
> +
> +    default:
> +        /* Should not reach here, but if so, forgive the VM. */
> +        error_report("%s: Unknown ending state %d", __func__, s->state);
> +        break;
>      }
>      qemu_bh_schedule(s->cleanup_bh);
>      qemu_mutex_unlock_iothread();
