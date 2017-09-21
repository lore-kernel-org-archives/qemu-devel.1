Received: from eggs.gnu.org ([2001:4830:134:3::10]:33533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv4aj-00066q-HW
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv4ag-0006og-4S
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:44:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dv4af-0006lp-Rg
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:44:42 -0400
Date: Thu, 21 Sep 2017 17:44:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170921164431.GK2717@work-vm>
References: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170919164827eucas1p231a5b9afd8e81427db114e57a0b6fbbe@eucas1p2.samsung.com>
	<1505839684-10046-11-git-send-email-a.perevalov@samsung.com>
	<20170921124228.GG2717@work-vm>
	<288ce5a4-ece0-1754-c7df-0a6be5af1f2a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288ce5a4-ece0-1754-c7df-0a6be5af1f2a@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v10 10/10] migration: add postcopy total
 blocktime into query-migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, quintela@redhat.com, heetae82.ahn@samsung.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> On 09/21/2017 03:42 PM, Dr. David Alan Gilbert wrote:
> > * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > > Postcopy total blocktime is available on destination side only.
> > > But query-migrate was possible only for source. This patch
> > > adds ability to call query-migrate on destination.
> > > To be able to see postcopy blocktime, need to request postcopy-blocktime
> > > capability.
> > > 
> > > The query-migrate command will show following sample result:
> > > {"return":
> > >      "postcopy-vcpu-blocktime": [115, 100],
> > >      "status": "completed",
> > >      "postcopy-blocktime": 100
> > > }}
> > > 
> > > postcopy_vcpu_blocktime contains list, where the first item is the first
> > > vCPU in QEMU.
> > > 
> > > This patch has a drawback, it combines states of incoming and
> > > outgoing migration. Ongoing migration state will overwrite incoming
> > > state. Looks like better to separate query-migrate for incoming and
> > > outgoing migration or add parameter to indicate type of migration.
> > > 
> > > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > > ---
> > >   hmp.c                    | 15 +++++++++++++
> > >   migration/migration.c    | 42 +++++++++++++++++++++++++++++++----
> > >   migration/migration.h    |  4 ++++
> > >   migration/postcopy-ram.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >   migration/trace-events   |  1 +
> > >   qapi/migration.json      | 11 +++++++++-
> > >   6 files changed, 125 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/hmp.c b/hmp.c
> > > index 0fb2bc7..142f76e 100644
> > > --- a/hmp.c
> > > +++ b/hmp.c
> > > @@ -264,6 +264,21 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
> > >                          info->cpu_throttle_percentage);
> > >       }
> > > +    if (info->has_postcopy_blocktime) {
> > > +        monitor_printf(mon, "postcopy blocktime: %" PRId64 "\n",
> > > +                       info->postcopy_blocktime);
> > > +    }
> > > +
> > > +    if (info->has_postcopy_vcpu_blocktime) {
> > > +        Visitor *v;
> > > +        char *str;
> > > +        v = string_output_visitor_new(false, &str);
> > > +        visit_type_int64List(v, NULL, &info->postcopy_vcpu_blocktime, NULL);
> > > +        visit_complete(v, &str);
> > > +        monitor_printf(mon, "postcopy vcpu blocktime: %s\n", str);
> > > +        g_free(str);
> > > +        visit_free(v);
> > > +    }
> > >       qapi_free_MigrationInfo(info);
> > >       qapi_free_MigrationCapabilityStatusList(caps);
> > >   }
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 4f029e8..e1d3248 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -528,14 +528,15 @@ static void populate_disk_info(MigrationInfo *info)
> > >       }
> > >   }
> > > -MigrationInfo *qmp_query_migrate(Error **errp)
> > > +static void fill_source_migration_info(MigrationInfo *info)
> > >   {
> > > -    MigrationInfo *info = g_malloc0(sizeof(*info));
> > >       MigrationState *s = migrate_get_current();
> > >       switch (s->state) {
> > >       case MIGRATION_STATUS_NONE:
> > >           /* no migration has happened ever */
> > > +        /* do not overwrite destination migration status */
> > > +        return;
> > >           break;
> > >       case MIGRATION_STATUS_SETUP:
> > >           info->has_status = true;
> > > @@ -584,8 +585,6 @@ MigrationInfo *qmp_query_migrate(Error **errp)
> > >           break;
> > >       }
> > >       info->status = s->state;
> > > -
> > > -    return info;
> > >   }
> > >   /**
> > > @@ -649,6 +648,41 @@ static bool migrate_caps_check(bool *cap_list,
> > >       return true;
> > >   }
> > > +static void fill_destination_migration_info(MigrationInfo *info)
> > > +{
> > > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > > +
> > > +    switch (mis->state) {
> > > +    case MIGRATION_STATUS_NONE:
> > > +        return;
> > > +        break;
> > > +    case MIGRATION_STATUS_SETUP:
> > > +    case MIGRATION_STATUS_CANCELLING:
> > > +    case MIGRATION_STATUS_CANCELLED:
> > > +    case MIGRATION_STATUS_ACTIVE:
> > > +    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> > > +    case MIGRATION_STATUS_FAILED:
> > > +    case MIGRATION_STATUS_COLO:
> > > +        info->has_status = true;
> > > +        break;
> > > +    case MIGRATION_STATUS_COMPLETED:
> > > +        info->has_status = true;
> > > +        fill_destination_postcopy_migration_info(info);
> > > +        break;
> > > +    }
> > > +    info->status = mis->state;
> > > +}
> > > +
> > > +MigrationInfo *qmp_query_migrate(Error **errp)
> > > +{
> > > +    MigrationInfo *info = g_malloc0(sizeof(*info));
> > > +
> > > +    fill_destination_migration_info(info);
> > > +    fill_source_migration_info(info);
> > > +
> > > +    return info;
> > > +}
> > > +
> > >   void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
> > >                                     Error **errp)
> > >   {
> > > diff --git a/migration/migration.h b/migration/migration.h
> > > index 770466b..882a59b 100644
> > > --- a/migration/migration.h
> > > +++ b/migration/migration.h
> > > @@ -70,6 +70,10 @@ struct MigrationIncomingState {
> > >   MigrationIncomingState *migration_incoming_get_current(void);
> > >   void migration_incoming_state_destroy(void);
> > > +/*
> > > + * Functions to work with blocktime context
> > > + */
> > > +void fill_destination_postcopy_migration_info(MigrationInfo *info);
> > >   #define TYPE_MIGRATION "migration"
> > > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > > index 9a5133f..5fdbf1e 100644
> > > --- a/migration/postcopy-ram.c
> > > +++ b/migration/postcopy-ram.c
> > > @@ -113,6 +113,55 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
> > >       return ctx;
> > >   }
> > > +static int64List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
> > > +{
> > > +    int64List *list = NULL, *entry = NULL;
> > > +    int i;
> > > +
> > > +    for (i = smp_cpus - 1; i >= 0; i--) {
> > > +        entry = g_new0(int64List, 1);
> > > +        entry->value = ctx->vcpu_blocktime[i];
> > > +        entry->next = list;
> > > +        list = entry;
> > > +    }
> > > +
> > > +    return list;
> > > +}
> > > +
> > > +/*
> > > + * This function just populates MigrationInfo from postcopy's
> > > + * blocktime context. It will not populate MigrationInfo,
> > > + * unless postcopy-blocktime capability was set.
> > > + *
> > > + * @info: pointer to MigrationInfo to populate
> > > + */
> > > +void fill_destination_postcopy_migration_info(MigrationInfo *info)
> > > +{
> > > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > > +    PostcopyBlocktimeContext *bc = mis->blocktime_ctx;
> > > +
> > > +    if (!bc) {
> > > +        return;
> > > +    }
> > > +
> > > +    info->has_postcopy_blocktime = true;
> > > +    info->postcopy_blocktime = bc->total_blocktime;
> > > +    info->has_postcopy_vcpu_blocktime = true;
> > > +    info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(bc);
> > > +}
> > > +
> > > +static uint64_t get_postcopy_total_blocktime(void)
> > > +{
> > > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > > +    PostcopyBlocktimeContext *bc = mis->blocktime_ctx;
> > > +
> > > +    if (!bc) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    return bc->total_blocktime;
> > > +}
> > > +
> > >   /**
> > >    * receive_ufd_features: check userfault fd features, to request only supported
> > >    * features in the future.
> > > @@ -487,6 +536,9 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
> > >           munmap(mis->postcopy_tmp_zero_page, mis->largest_page_size);
> > >           mis->postcopy_tmp_zero_page = NULL;
> > >       }
> > > +    trace_postcopy_ram_incoming_cleanup_blocktime(
> > > +            get_postcopy_total_blocktime());
> > > +
> > >       trace_postcopy_ram_incoming_cleanup_exit();
> > >       return 0;
> > >   }
> > > @@ -958,6 +1010,11 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
> > >   #else
> > >   /* No target OS support, stubs just fail */
> > > +void fill_destination_postcopy_migration_info(MigrationInfo *info)
> > > +{
> > > +    error_report("%s: No OS support", __func__);
> > > +}
> > > +
> > Do we want that error_report? info migrate shouldn't give an error on a
> > non-postcopy host.
> > 
> > Also, don't you fancy just checking for the presence of this new info in
> > the test?
> I'll add assert, like that
> g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));

Yes, that seems reasonable.

> when host supports UFFD_FEATURE_THREAD_ID

Great;  note that needs to be runtime, not the ifdef.

Dave

> -- 
> Best regards,
> Alexey Perevalov
> > 
> > Dave
> > 
> > >   bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
> > >   {
> > >       error_report("%s: No OS support", __func__);
> > > diff --git a/migration/trace-events b/migration/trace-events
> > > index 01f30fe..741f2ae 100644
> > > --- a/migration/trace-events
> > > +++ b/migration/trace-events
> > > @@ -197,6 +197,7 @@ postcopy_ram_incoming_cleanup_closeuf(void) ""
> > >   postcopy_ram_incoming_cleanup_entry(void) ""
> > >   postcopy_ram_incoming_cleanup_exit(void) ""
> > >   postcopy_ram_incoming_cleanup_join(void) ""
> > > +postcopy_ram_incoming_cleanup_blocktime(uint64_t total) "total blocktime %" PRIu64
> > >   save_xbzrle_page_skipping(void) ""
> > >   save_xbzrle_page_overflow(void) ""
> > >   ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 2e4a15d..55b055e 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -150,6 +150,13 @@
> > >   #              @status is 'failed'. Clients should not attempt to parse the
> > >   #              error strings. (Since 2.7)
> > >   #
> > > +# @postcopy-blocktime: total time when all vCPU were blocked during postcopy
> > > +#           live migration (Since 2.11)
> > > +#
> > > +# @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU (Since 2.10)
> > > +#
> > > +
> > > +#
> > >   # Since: 0.14.0
> > >   ##
> > >   { 'struct': 'MigrationInfo',
> > > @@ -161,7 +168,9 @@
> > >              '*downtime': 'int',
> > >              '*setup-time': 'int',
> > >              '*cpu-throttle-percentage': 'int',
> > > -           '*error-desc': 'str'} }
> > > +           '*error-desc': 'str',
> > > +           '*postcopy-blocktime' : 'int64',
> > > +           '*postcopy-vcpu-blocktime': ['int64']} }
> > >   ##
> > >   # @query-migrate:
> > > -- 
> > > 1.9.1
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> > 
> > 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
