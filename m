Received: from eggs.gnu.org ([2001:4830:134:3::10]:39607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d49V2-0006YK-2P
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d49Uy-0007No-1w
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:16:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d49Ux-0007NZ-PG
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:16:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E26C23DBC9
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 17:16:01 +0000 (UTC)
Date: Fri, 28 Apr 2017 18:15:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170428171555.GI3276@work-vm>
References: <20170425220451.6028-1-quintela@redhat.com>
	<20170425220451.6028-32-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425220451.6028-32-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 31/41] migration: Move postcopy stuff to
 postcopy-ram.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Yes, we don't have a good place to put that stuff.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/migration.h | 25 -------------------------
>  migration/migration.c         | 18 ------------------
>  migration/postcopy-ram.c      | 18 ++++++++++++++++++
>  migration/postcopy-ram.h      | 26 ++++++++++++++++++++++++++
>  4 files changed, 44 insertions(+), 43 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 9063c32..5c27fe7 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -54,28 +54,6 @@ enum mig_rp_message_type {
>  
>  typedef QLIST_HEAD(, LoadStateEntry) LoadStateEntry_Head;
>  
> -/* The current postcopy state is read/set by postcopy_state_get/set
> - * which update it atomically.
> - * The state is updated as postcopy messages are received, and
> - * in general only one thread should be writing to the state at any one
> - * time, initially the main thread and then the listen thread;
> - * Corner cases are where either thread finishes early and/or errors.
> - * The state is checked as messages are received to ensure that
> - * the source is sending us messages in the correct order.
> - * The state is also used by the RAM reception code to know if it
> - * has to place pages atomically, and the cleanup code at the end of
> - * the main thread to know if it has to delay cleanup until the end
> - * of postcopy.
> - */
> -typedef enum {
> -    POSTCOPY_INCOMING_NONE = 0,  /* Initial state - no postcopy */
> -    POSTCOPY_INCOMING_ADVISE,
> -    POSTCOPY_INCOMING_DISCARD,
> -    POSTCOPY_INCOMING_LISTENING,
> -    POSTCOPY_INCOMING_RUNNING,
> -    POSTCOPY_INCOMING_END
> -} PostcopyState;
> -
>  /* State for the incoming migration */
>  struct MigrationIncomingState {
>      QEMUFile *from_src_file;
> @@ -253,7 +231,4 @@ void savevm_skip_configuration(void);
>  int global_state_store(void);
>  void global_state_store_running(void);
>  
> -PostcopyState postcopy_state_get(void);
> -/* Set the state and return the old state */
> -PostcopyState postcopy_state_set(PostcopyState new_state);
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index ff32086..d2f3c5e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -85,13 +85,6 @@ static NotifierList migration_state_notifiers =
>  
>  static bool deferred_incoming;
>  
> -/*
> - * Current state of incoming postcopy; note this is not part of
> - * MigrationIncomingState since it's state is used during cleanup
> - * at the end as MIS is being freed.
> - */
> -static PostcopyState incoming_postcopy_state;
> -
>  /* When we add fault tolerance, we could have several
>     migrations at once.  For now we don't need to add
>     dynamic creation of migration */
> @@ -2085,14 +2078,3 @@ void migrate_fd_connect(MigrationState *s)
>      s->migration_thread_running = true;
>  }
>  
> -PostcopyState  postcopy_state_get(void)
> -{
> -    return atomic_mb_read(&incoming_postcopy_state);
> -}
> -
> -/* Set the state and return the old state */
> -PostcopyState postcopy_state_set(PostcopyState new_state)
> -{
> -    return atomic_xchg(&incoming_postcopy_state, new_state);
> -}
> -
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 3359224..cae5d48 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -787,3 +787,21 @@ void postcopy_discard_send_finish(MigrationState *ms, PostcopyDiscardState *pds)
>  
>      g_free(pds);
>  }
> +
> +/*
> + * Current state of incoming postcopy; note this is not part of
> + * MigrationIncomingState since it's state is used during cleanup
> + * at the end as MIS is being freed.
> + */
> +static PostcopyState incoming_postcopy_state;
> +
> +PostcopyState  postcopy_state_get(void)
> +{
> +    return atomic_mb_read(&incoming_postcopy_state);
> +}
> +
> +/* Set the state and return the old state */
> +PostcopyState postcopy_state_set(PostcopyState new_state)
> +{
> +    return atomic_xchg(&incoming_postcopy_state, new_state);
> +}
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index 4c25f03..52d51e8 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -81,6 +81,28 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>  int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>                               size_t pagesize);
>  
> +/* The current postcopy state is read/set by postcopy_state_get/set
> + * which update it atomically.
> + * The state is updated as postcopy messages are received, and
> + * in general only one thread should be writing to the state at any one
> + * time, initially the main thread and then the listen thread;
> + * Corner cases are where either thread finishes early and/or errors.
> + * The state is checked as messages are received to ensure that
> + * the source is sending us messages in the correct order.
> + * The state is also used by the RAM reception code to know if it
> + * has to place pages atomically, and the cleanup code at the end of
> + * the main thread to know if it has to delay cleanup until the end
> + * of postcopy.
> + */
> +typedef enum {
> +    POSTCOPY_INCOMING_NONE = 0,  /* Initial state - no postcopy */
> +    POSTCOPY_INCOMING_ADVISE,
> +    POSTCOPY_INCOMING_DISCARD,
> +    POSTCOPY_INCOMING_LISTENING,
> +    POSTCOPY_INCOMING_RUNNING,
> +    POSTCOPY_INCOMING_END
> +} PostcopyState;
> +
>  /*
>   * Allocate a page of memory that can be mapped at a later point in time
>   * using postcopy_place_page
> @@ -88,4 +110,8 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>   */
>  void *postcopy_get_tmp_page(MigrationIncomingState *mis);
>  
> +PostcopyState postcopy_state_get(void);
> +/* Set the state and return the old state */
> +PostcopyState postcopy_state_set(PostcopyState new_state);
> +
>  #endif
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
