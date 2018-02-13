Received: from eggs.gnu.org ([2001:4830:134:3::10]:32779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elflQ-00058g-Jn
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elflN-0003q3-HR
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:57:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elflN-0003pn-An
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:57:09 -0500
Date: Tue, 13 Feb 2018 18:56:51 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180213185650.GR2378@work-vm>
References: <20180208103132.28452-1-peterx@redhat.com>
	<20180208103132.28452-26-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208103132.28452-26-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 25/28] qmp/migration: new command
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
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> The first allow-oob=true command.  It's used on destination side when
> the postcopy migration is paused and ready for a recovery.  After
> execution, a new migration channel will be established for postcopy to
> continue.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 26 ++++++++++++++++++++++++++
>  migration/migration.h |  1 +
>  migration/savevm.c    |  3 +++
>  qapi/migration.json   | 20 ++++++++++++++++++++
>  4 files changed, 50 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index cf3a3f416c..bb57ed9ade 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1422,6 +1422,32 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
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

OK, if it did come back as Paused I don't think it can leave it again
except this way, so I'm not too worried it being thread safe.

> +    if (mis->postcopy_recover_triggered) {
> +        error_setg(errp, "Migrate recovery is triggered already");
> +        return;
> +    }
> +
> +    /* This will make sure we'll only allow one recover for one pause */
> +    mis->postcopy_recover_triggered = true;

However, does that need to be done with a :
   if (atomic_cmpxchg(mis->postcopy_recovery_triggered, false, true) ==
       true) {
      error_setg(errp, "Migrate recovery is triggered already");
   }

for the slim chance that someone did this command on the main and the
oob monitor?

Dave

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
> index 88f5614b90..581bf4668b 100644
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
> index d40092a2b6..5f41b062ba 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2182,6 +2182,9 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
>      /* Notify the fault thread for the invalidated file handle */
>      postcopy_fault_thread_notify(mis);
>  
> +    /* Clear the triggered bit to allow one recovery */
> +    mis->postcopy_recover_triggered = false;
> +
>      error_report("Detected IO failure for postcopy. "
>                   "Migration paused.");
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 055130314d..dfbcb02d4c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1172,3 +1172,23 @@
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
