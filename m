Received: from eggs.gnu.org ([2001:4830:134:3::10]:53581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1erRYB-0000zN-R5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1erRYA-0003io-SB
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:59:23 -0500
Date: Thu, 1 Mar 2018 16:59:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180301165859.GJ2994@work-vm>
References: <20180227115651.30762-1-rpalethorpe@suse.com>
	<20180227115651.30762-2-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227115651.30762-2-rpalethorpe@suse.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] migrate: Allow incoming migration
 without defer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com, quintela@redhat.com, mreitz@redhat.com

* Richard Palethorpe (rpalethorpe@suse.com) wrote:
> Allow a QEMU instance which has been started and used without the "-incoming"
> flag to accept an incoming migration with the "migrate-incoming" QMP
> command. This allows the user to dump the VM state to an external file then
> revert to that state at a later time without restarting QEMU.
> ---
>  migration/migration.c | 12 +++++-------
>  vl.c                  |  2 ++
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 0aa596f867..05595a4cec 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1321,14 +1321,14 @@ void migrate_del_blocker(Error *reason)
>  void qmp_migrate_incoming(const char *uri, Error **errp)
>  {
>      Error *local_err = NULL;
> -    static bool once = true;
>  
> -    if (!deferred_incoming) {
> -        error_setg(errp, "For use with '-incoming defer'");
> +    if (runstate_check(RUN_STATE_INMIGRATE)) {
> +        error_setg(errp, "The incoming migration has already been started");
>          return;
>      }
> -    if (!once) {
> -        error_setg(errp, "The incoming migration has already been started");
> +
> +    if (!deferred_incoming) {
> +        vm_stop(RUN_STATE_INMIGRATE);
>      }
>  
>      qemu_start_incoming_migration(uri, &local_err);
> @@ -1337,8 +1337,6 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -
> -    once = false;
>  }

That's...interesting.  I think it will work, but I bet there's a whole
bunch of corner cases [many of which loadvm will hit as well!].
For starters there's probably devices that are active and still looking
at RAM, even though vm_stop is in place (hopefully none of them are
writing to it, but I wouldn't actually trust them).  Also, you probably
need to inactivate the block devices?

Also, I think this means there's no protection against this happening
during an outgoing migration (which has an existing check to make sure
you can't start an outgoing migration while an incoming one is waiting).

>  bool migration_is_blocked(Error **errp)
> diff --git a/vl.c b/vl.c
> index 9e7235df6d..a91eda039e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -634,6 +634,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },
>      { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_PAUSED, RUN_STATE_COLO},
> +    { RUN_STATE_PAUSED, RUN_STATE_INMIGRATE },
>  
>      { RUN_STATE_POSTMIGRATE, RUN_STATE_RUNNING },
>      { RUN_STATE_POSTMIGRATE, RUN_STATE_FINISH_MIGRATE },
> @@ -665,6 +666,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_RUNNING, RUN_STATE_WATCHDOG },
>      { RUN_STATE_RUNNING, RUN_STATE_GUEST_PANICKED },
>      { RUN_STATE_RUNNING, RUN_STATE_COLO},
> +    { RUN_STATE_RUNNING, RUN_STATE_INMIGRATE },

Experience suggests that you'll find out the hard way that there's other
states you'll need to allow or check for.
For example, do you want to be able to loadvm from a GUEST_PANICKED or
PRELAUNCH state?

Dave

>      { RUN_STATE_SAVE_VM, RUN_STATE_RUNNING },
>  
> -- 
> 2.16.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
