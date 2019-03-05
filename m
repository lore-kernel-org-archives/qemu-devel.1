Received: from eggs.gnu.org ([209.51.188.92]:34064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1A1h-00018K-4i
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1A1g-0004qS-AY
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:22:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1A1g-0004nr-3j
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:22:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AEB381DF3
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 13:22:30 +0000 (UTC)
Date: Tue, 5 Mar 2019 13:22:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190305132224.GA9811@work-vm>
References: <20190219195928.12289-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219195928.12289-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Fix cancel state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> During a cancelled migration there's a race where the fd can
> go into an error state before we get back around the migration loop
> and migration_detect_error transitions from cancelling->failed.
> 
> Check for cancelled/cancelling and don't change the state.
> 
> Red Hat bug: https://bugzilla.redhat.com/show_bug.cgi?id=1608649
> 
> Fixes: b23c2ade250
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued

> ---
>  migration/migration.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index c39d3054ec..e44f77af02 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2911,6 +2911,13 @@ static MigThrError postcopy_pause(MigrationState *s)
>  static MigThrError migration_detect_error(MigrationState *s)
>  {
>      int ret;
> +    int state = s->state;
> +
> +    if (state == MIGRATION_STATUS_CANCELLING ||
> +        state == MIGRATION_STATUS_CANCELLED) {
> +        /* End the migration, but don't set the state to failed */
> +        return MIG_THR_ERR_FATAL;
> +    }
>  
>      /* Try to detect any file errors */
>      ret = qemu_file_get_error(s->to_dst_file);
> @@ -2920,7 +2927,7 @@ static MigThrError migration_detect_error(MigrationState *s)
>          return MIG_THR_ERR_NONE;
>      }
>  
> -    if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret == -EIO) {
> +    if (state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret == -EIO) {
>          /*
>           * For postcopy, we allow the network to be down for a
>           * while. After that, it can be continued by a
> @@ -2932,7 +2939,7 @@ static MigThrError migration_detect_error(MigrationState *s)
>           * For precopy (or postcopy with error outside IO), we fail
>           * with no time.
>           */
> -        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
>          trace_migration_thread_file_err();
>  
>          /* Time to stop the migration, now. */
> -- 
> 2.20.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
