Received: from eggs.gnu.org ([2001:4830:134:3::10]:60507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcFny-0005rD-R0
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcFnt-0001ef-Sq
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:52:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcFnt-0001eP-JZ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:52:33 -0400
Date: Mon, 31 Jul 2017 19:52:24 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170731185224.GB3095@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-11-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501229198-30588-11-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 10/29] migration: new property
 "x-postcopy-fast"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> This provides a way to start postcopy ASAP when migration starts. To do
> this, we need both:
> 
>   -global migration.x-postcopy-ram=on \
>   -global migration.x-postcopy-fast=on

Can you explain why this is necessary?  Both sides already know
they're doing a postcopy recovery don't they?

Dave

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 9 ++++++++-
>  migration/migration.h | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5b2602e..efee87e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1936,6 +1936,11 @@ bool migrate_colo_enabled(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_X_COLO];
>  }
>  
> +static bool postcopy_should_start(MigrationState *s)
> +{
> +    return atomic_read(&s->start_postcopy) || s->start_postcopy_fast;
> +}
> +
>  /*
>   * Master migration thread on the source VM.
>   * It drives the migration and pumps the data down the outgoing channel.
> @@ -2013,7 +2018,7 @@ static void *migration_thread(void *opaque)
>                  if (migrate_postcopy_ram() &&
>                      s->state != MIGRATION_STATUS_POSTCOPY_ACTIVE &&
>                      pend_nonpost <= threshold_size &&
> -                    atomic_read(&s->start_postcopy)) {
> +                    postcopy_should_start(s)) {
>  
>                      if (!postcopy_start(s, &old_vm_running)) {
>                          current_active_state = MIGRATION_STATUS_POSTCOPY_ACTIVE;
> @@ -2170,6 +2175,8 @@ static Property migration_properties[] = {
>                       send_configuration, true),
>      DEFINE_PROP_BOOL("send-section-footer", MigrationState,
>                       send_section_footer, true),
> +    DEFINE_PROP_BOOL("x-postcopy-fast", MigrationState,
> +                     start_postcopy_fast, false),
>  
>      /* Migration parameters */
>      DEFINE_PROP_INT64("x-compress-level", MigrationState,
> diff --git a/migration/migration.h b/migration/migration.h
> index 70e3094..e902bae 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -113,6 +113,8 @@ struct MigrationState
>  
>      /* Flag set once the migration has been asked to enter postcopy */
>      bool start_postcopy;
> +    /* Set the flag if we want to start postcopy ASAP when migration starts */
> +    bool start_postcopy_fast;
>      /* Flag set after postcopy has sent the device state */
>      bool postcopy_after_devices;
>  
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
