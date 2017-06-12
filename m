Received: from eggs.gnu.org ([2001:4830:134:3::10]:50587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKHF5-00043m-99
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 00:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKHF2-00038m-6l
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 00:46:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dKHF1-00038R-UK
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 00:46:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B57C1C04B316
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 04:46:14 +0000 (UTC)
Date: Mon, 12 Jun 2017 12:46:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170612044609.GE25059@pxdev.xzpeter.org>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<1496980142-8986-3-git-send-email-peterx@redhat.com>
	<87lgp1i8kz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lgp1i8kz.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] migration: let MigrationState be a
 qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Fri, Jun 09, 2017 at 03:39:24PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Let the old man "MigrationState" join the object family. Direct benefit
> > is that we can start to use all the property features derived from
> > current QDev, like: HW_COMPAT_* bits, command line setup for migration
> > parameters (so will never need to set them up each time using HMP/QMP,
> > this is really, really attractive for test writters), etc.
> >
> > I see no reason to disallow this happen yet. So let's start from this
> > one, to see whether it would be anything good.
> >
> > No functional change at all.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/migration/migration.h | 19 ++++++++++++++
> >  migration/migration.c         | 61 ++++++++++++++++++++++++++++---------------
> >  2 files changed, 59 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/migration/migration.h b/include/migration/migration.h
> > index 79b5484..bd0186c 100644
> > --- a/include/migration/migration.h
> > +++ b/include/migration/migration.h
> > @@ -21,6 +21,7 @@
> >  #include "qapi-types.h"
> >  #include "exec/cpu-common.h"
> >  #include "qemu/coroutine_int.h"
> > +#include "hw/qdev.h"
> >  
> >  #define QEMU_VM_FILE_MAGIC           0x5145564d
> >  #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
> > @@ -49,6 +50,8 @@ enum mig_rp_message_type {
> >      MIG_RP_MSG_MAX
> >  };
> >  
> > +#define TYPE_MIGRATION "migration"
> > +
> >  /* State for the incoming migration */
> >  struct MigrationIncomingState {
> >      QEMUFile *from_src_file;
> > @@ -91,8 +94,24 @@ struct MigrationIncomingState {
> >  MigrationIncomingState *migration_incoming_get_current(void);
> >  void migration_incoming_state_destroy(void);
> >  
> > +#define MIGRATION_CLASS(klass) \
> > +    OBJECT_CLASS_CHECK(MigrationClass, (klass), TYPE_MIGRATION)
> > +#define MIGRATION_OBJ(obj) \
> > +    OBJECT_CHECK(MigrationState, (obj), TYPE_MIGRATION)
> > +#define MIGRATION_GET_CLASS(obj) \
> > +    OBJECT_GET_CLASS(MigrationClass, (obj), TYPE_MIGRATION)
> > +
> > +typedef struct MigrationClass {
> > +    /*< private >*/
> > +    DeviceClass parent_class;
> > +} MigrationClass;
> > +
> >  struct MigrationState
> >  {
> > +    /*< private >*/
> > +    DeviceState parent_obj;
> > +
> > +    /*< public >*/
> 
> Turning MigrationState into a QOM object so you can use QOM
> infrastructure makes sense.  But why turn it into a device?  It doesn't
> feel device-like to me.  Would ObjectClass and Object instead of
> DeviceClass and DeviceState do?

Yeah. That's the main reason for the series to be (was) RFC.

I was trying to use the HW_COMPAT_* bits and -global, and that's QDev
thing (IIUC you got that already :). I am just curious about why that
is not for QObject from the very beginning, then it'll be easier.

For now, IMHO QDev is okay as well for migration, as long as it's kept
internally inside QEMU. But sure at least I should turn user_creatable
to off. I'll investigate more to see how to make this a safer approach
in next post.

> 
> >      size_t bytes_xfer;
> >      size_t xfer_limit;
> >      QemuThread thread;
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 48c94c9..98b77e2 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -93,29 +93,13 @@ static bool deferred_incoming;
> >  /* For outgoing */
> >  MigrationState *migrate_get_current(void)
> >  {
> > -    static bool once;
> > -    static MigrationState current_migration = {
> > -        .state = MIGRATION_STATUS_NONE,
> > -        .xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE,
> > -        .mbps = -1,
> > -        .parameters = {
> > -            .compress_level = DEFAULT_MIGRATE_COMPRESS_LEVEL,
> > -            .compress_threads = DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT,
> > -            .decompress_threads = DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT,
> > -            .cpu_throttle_initial = DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL,
> > -            .cpu_throttle_increment = DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT,
> > -            .max_bandwidth = MAX_THROTTLE,
> > -            .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
> > -            .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
> > -        },
> > -    };
> > +    static MigrationState *current_migration;
> 
> You add an indirection...
> 
> >  
> > -    if (!once) {
> > -        current_migration.parameters.tls_creds = g_strdup("");
> > -        current_migration.parameters.tls_hostname = g_strdup("");
> > -        once = true;
> > +    if (!current_migration) {
> > +        current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
> 
> ... possibly just so you can use object_new().  Have you considered
> object_initialize()?

Yes, but even with object_initialize() I still need that indirection?

Or, I can put the init into main() in some way to avoid the
indirection.

Thanks!

-- 
Peter Xu
