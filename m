Received: from eggs.gnu.org ([2001:4830:134:3::10]:58405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIusj-0000OP-9p
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIusg-0008MB-5H
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:41:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dIusf-0008M2-TM
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:41:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F301285A6
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 10:41:32 +0000 (UTC)
Date: Thu, 8 Jun 2017 18:41:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170608104127.GE3628@pxdev.xzpeter.org>
References: <1496745042-2379-1-git-send-email-peterx@redhat.com>
	<1496745042-2379-3-git-send-email-peterx@redhat.com>
	<87k24nd78e.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87k24nd78e.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 2/6] migration: move global_state.optional
 out
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jun 07, 2017 at 07:42:57PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > Put it into MigrationState then we can use the properties to specify
> > whether to enable storing global state.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/migration/migration.h |  6 ++++++
> >  migration/migration.c         | 21 +++++++++++++++++----
> >  2 files changed, 23 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/migration/migration.h b/include/migration/migration.h
> > index bd0186c..8aa1ea6 100644
> > --- a/include/migration/migration.h
> > +++ b/include/migration/migration.h
> > @@ -162,6 +162,12 @@ struct MigrationState
> >      /* Do we have to clean up -b/-i from old migrate parameters */
> >      /* This feature is deprecated and will be removed */
> >      bool must_remove_block_options;
> > +
> > +    /*
> > +     * Global switch on whether we need to store the global state
> > +     * during migration.
> > +     */
> > +    bool store_global_state;
> >  };
> >  
> >  void migrate_set_state(int *state, int old_state, int new_state);
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 483b027..0653f49 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -140,13 +140,13 @@ void migration_incoming_state_destroy(void)
> >  
> >  
> >  typedef struct {
> > -    bool optional;
> >      uint32_t size;
> >      uint8_t runstate[100];
> >      RunState state;
> >      bool received;
> >  } GlobalState;
> >  
> > +/* This is only used if MigrationState.store_global_state is set. */
> >  static GlobalState global_state;
> >  
> >  int global_state_store(void)
> > @@ -179,7 +179,7 @@ static RunState global_state_get_runstate(void)
> >  
> >  void global_state_set_optional(void)
> >  {
> > -    global_state.optional = true;
> > +    migrate_get_current()->store_global_state = false;
> 
> Part of the advantage (for me) of using qapi was not to have to export
> a function to set this.  I.e.  isn't a way to call
> 
> qemu_opt_get_bool(migration_opts, "store_global_state", true)
> 
> qapi_<magic>_set_bool(migration_opts, "store_global_state",false);
> ?

I didn't catch the comment here... Do you mean e.g.
qemu_opt_set_bool()? Here can we use it in some way?

(I thought we were using the "-global migration.store_global_state"
 parameter, then it'll setup MigrationState.store_global_state, isn't
 that the trick?)

> 
> So, I don't have to eport global_state_set_optional()?
> 

As mentioned in latter patch, xen_init() still uses it, so looks like
we still need it?

I can squash this patch with the next if you like it.

Thanks,

> 
> My goal would be that when I need to add a new propertly, I add it to
> migration_properties and to MigrationState and call it a day?
> 
> >  static bool global_state_needed(void *opaque)
> > @@ -188,8 +188,7 @@ static bool global_state_needed(void *opaque)
> >      char *runstate = (char *)s->runstate;
> >  
> >      /* If it is not optional, it is mandatory */
> > -
> > -    if (s->optional == false) {
> > +    if (migrate_get_current()->store_global_state) {
> 
> Being able to query without having a function would also be nice.
> 
> Later, Juan.
> 
> >          return true;
> >      }
> >  
> > @@ -2109,6 +2108,19 @@ void migrate_fd_connect(MigrationState *s)
> >      s->migration_thread_running = true;
> >  }
> >  
> > +static Property migration_properties[] = {
> > +    DEFINE_PROP_BOOL("store-global-state", MigrationState,
> > +                     store_global_state, true),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void migration_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->props = migration_properties;
> > +}
> > +
> >  static void migration_instance_init(Object *obj)
> >  {
> >      MigrationState *ms = MIGRATION_OBJ(obj);
> > @@ -2133,6 +2145,7 @@ static void migration_instance_init(Object *obj)
> >  static const TypeInfo migration_type = {
> >      .name = TYPE_MIGRATION,
> >      .parent = TYPE_DEVICE,
> > +    .class_init = migration_class_init,
> >      .class_size = sizeof(MigrationClass),
> >      .instance_size = sizeof(MigrationState),
> >      .instance_init = migration_instance_init,

-- 
Peter Xu
