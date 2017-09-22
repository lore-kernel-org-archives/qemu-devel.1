Received: from eggs.gnu.org ([2001:4830:134:3::10]:41111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dvUhv-0004gd-33
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dvUhr-0003l0-V2
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:37:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dvUhr-0003kP-MH
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:37:51 -0400
Date: Fri, 22 Sep 2017 21:37:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170922203744.GQ2620@work-vm>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-34-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504081950-2528-34-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 33/33] migration: init dst in
 migration_object_init too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> Though we may not need it, now we init both the src/dst migration
> objects in migration_object_init() so that even incoming migration
> object would be thread safe (it was not).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5812478..7e9ccf0 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -103,6 +103,7 @@ enum mig_rp_message_type {
>     dynamic creation of migration */
>  
>  static MigrationState *current_migration;
> +static MigrationIncomingState *current_incoming;
>  
>  static bool migration_object_check(MigrationState *ms, Error **errp);
>  
> @@ -128,6 +129,17 @@ void migration_object_init(void)
>      if (ms->enforce_config_section) {
>          current_migration->send_configuration = true;
>      }
> +
> +    /*
> +     * Init the migrate incoming object as well no matter whether
> +     * we'll use it or not.
> +     */
> +    current_incoming = g_new0(MigrationIncomingState, 1);
> +    current_incoming->state = MIGRATION_STATUS_NONE;
> +    qemu_mutex_init(&current_incoming->rp_mutex);
> +    qemu_event_init(&current_incoming->main_thread_load_event, false);
> +    qemu_sem_init(&current_incoming->postcopy_pause_sem_dst, 0);
> +    qemu_sem_init(&current_incoming->postcopy_pause_sem_fault, 0);
>  }
>  
>  /* For outgoing */
> @@ -140,19 +152,8 @@ MigrationState *migrate_get_current(void)
>  
>  MigrationIncomingState *migration_incoming_get_current(void)
>  {
> -    static bool once;
> -    static MigrationIncomingState mis_current;
> -
> -    if (!once) {
> -        mis_current.state = MIGRATION_STATUS_NONE;
> -        memset(&mis_current, 0, sizeof(MigrationIncomingState));
> -        qemu_mutex_init(&mis_current.rp_mutex);
> -        qemu_event_init(&mis_current.main_thread_load_event, false);
> -        qemu_sem_init(&mis_current.postcopy_pause_sem_dst, 0);
> -        qemu_sem_init(&mis_current.postcopy_pause_sem_fault, 0);
> -        once = true;
> -    }
> -    return &mis_current;
> +    assert(current_incoming);
> +    return current_incoming;
>  }
>  
>  void migration_incoming_state_destroy(void)
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
