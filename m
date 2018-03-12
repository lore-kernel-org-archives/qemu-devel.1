Received: from eggs.gnu.org ([2001:4830:134:3::10]:56389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evRKc-0002MB-V2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evRKZ-0006fE-O3
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:33:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evRKZ-0006eI-Is
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:33:51 -0400
Date: Mon, 12 Mar 2018 17:33:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180312173331.GU3219@work-vm>
References: <20180309091535.13315-1-peterx@redhat.com>
	<20180309091535.13315-21-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309091535.13315-21-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 20/23] qmp/migration: new command
 migrate-recover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>

* Peter Xu (peterx@redhat.com) wrote:
> The first allow-oob=true command.  It's used on destination side when
> the postcopy migration is paused and ready for a recovery.  After
> execution, a new migration channel will be established for postcopy to
> continue.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 24 ++++++++++++++++++++++++
>  migration/migration.h |  1 +
>  migration/savevm.c    |  3 +++
>  qapi/migration.json   | 20 ++++++++++++++++++++
>  4 files changed, 48 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index af00cfe04f..180552329c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1424,6 +1424,30 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
>      once = false;
>  }
>  
> +void qmp_migrate_recover(const char *uri, Error **errp)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    if (mis->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
> +        error_setg(errp, "Migrate recover can only be run "
> +                   "when postcopy is paused.");
> +        return;
> +    }
> +
> +    if (atomic_cmpxchg(&mis->postcopy_recover_triggered,
> +                       false, true) == true) {
> +        error_setg(errp, "Migrate recovery is triggered already");
> +        return;
> +    }
> +
> +    /*
> +     * Note that this call will never start a real migration; it will
> +     * only re-setup the migration stream and poke existing migration
> +     * to continue using that newly established channel.
> +     */
> +    qemu_start_incoming_migration(uri, errp);
> +}
> +
>  bool migration_is_blocked(Error **errp)
>  {
>      if (qemu_savevm_state_blocked(errp)) {
> diff --git a/migration/migration.h b/migration/migration.h
> index 8f64b43584..c549859cc3 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -65,6 +65,7 @@ struct MigrationIncomingState {
>      QemuSemaphore colo_incoming_sem;
>  
>      /* notify PAUSED postcopy incoming migrations to try to continue */
> +    bool postcopy_recover_triggered;
>      QemuSemaphore postcopy_pause_sem_dst;
>      QemuSemaphore postcopy_pause_sem_fault;
>  };
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7f4899ae9c..3e660dfca6 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2166,6 +2166,9 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
>  {
>      trace_postcopy_pause_incoming();
>  
> +    /* Clear the triggered bit to allow one recovery */
> +    mis->postcopy_recover_triggered = false;
> +
>      migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>                        MIGRATION_STATUS_POSTCOPY_PAUSED);
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 152fb8e51e..451d8c572b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1174,3 +1174,23 @@
>  # Since: 2.9
>  ##
>  { 'command': 'xen-colo-do-checkpoint' }
> +
> +##
> +# @migrate-recover:
> +#
> +# Provide a recovery migration stream URI.
> +#
> +# @uri: the URI to be used for the recovery of migration stream.
> +#
> +# Returns: nothing.
> +#
> +# Example:
> +#
> +# -> { "execute": "migrate-recover",
> +#      "arguments": { "uri": "tcp:192.168.1.200:12345" } }
> +# <- { "return": {} }
> +#
> +# Since: 2.12
> +##
> +{ 'command': 'migrate-recover', 'data': { 'uri': 'str' },
> +  'allow-oob': true }
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
