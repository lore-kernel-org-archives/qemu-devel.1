Received: from eggs.gnu.org ([2001:4830:134:3::10]:53042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWf5t-0002M9-LD
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWf5s-0005Vl-LP
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:12:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWf5s-0005Uf-EE
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:12:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 978B1883D8
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 09:12:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103054043.25719-8-peterx@redhat.com> (Peter Xu's message of
	"Wed, 3 Jan 2018 13:40:39 +0800")
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-8-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 10:12:10 +0100
Message-ID: <87k1wz2tn9.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 07/11] migration: introduce
 migrate_calculate_complete
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
> Generalize the calculation part when migration complete into a
> function to simplify migration_thread().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>



> ---
>  migration/migration.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 2d8b47197e..acef54748b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2151,6 +2151,19 @@ bool migrate_colo_enabled(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_X_COLO];
>  }
>  
> +static void migration_calculate_complete(MigrationState *s)
> +{
> +    uint64_t bytes = qemu_ftell(s->to_dst_file);
> +    int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +
> +    s->mig_total_time = end_time - s->mig_start_time;

Why have you remove the if (!entered_postcopy) for the following line?

I like the rest/idea of the patch.

Later, Juan.

> +    s->downtime = end_time - s->vm_down_start_time;
> +
> +    if (s->mig_total_time) {
> +        s->mbps = ((double) bytes * 8.0) / s->mig_total_time / 1000;
> +    }
> +}
> +
>  /*
>   * Master migration thread on the source VM.
>   * It drives the migration and pumps the data down the outgoing channel.
> @@ -2168,7 +2181,6 @@ static void *migration_thread(void *opaque)
>       * measured bandwidth
>       */
>      int64_t threshold_size = 0;
> -    int64_t end_time;
>      bool entered_postcopy = false;
>      /* The active state we expect to be in; ACTIVE or POSTCOPY_ACTIVE */
>      enum MigrationStatus current_active_state = MIGRATION_STATUS_ACTIVE;
> @@ -2282,19 +2294,10 @@ static void *migration_thread(void *opaque)
>      trace_migration_thread_after_loop();
>      /* If we enabled cpu throttling for auto-converge, turn it off. */
>      cpu_throttle_stop();
> -    end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>  
>      qemu_mutex_lock_iothread();
>      if (s->state == MIGRATION_STATUS_COMPLETED) {
> -        uint64_t transferred_bytes = qemu_ftell(s->to_dst_file);
> -        s->mig_total_time = end_time - s->mig_start_time;
> -        if (!entered_postcopy) {
> -            s->downtime = end_time - s->vm_down_start_time;
> -        }
> -        if (s->mig_total_time) {
> -            s->mbps = (((double) transferred_bytes * 8.0) /
> -                       ((double) s->mig_total_time)) / 1000;
> -        }
> +        migration_calculate_complete(s);
>          runstate_set(RUN_STATE_POSTMIGRATE);
>      } else {
>          if (s->state == MIGRATION_STATUS_ACTIVE) {
