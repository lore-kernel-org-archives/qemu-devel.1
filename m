Received: from eggs.gnu.org ([2001:4830:134:3::10]:51081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKjyx-00020X-6F
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKjyu-0003P4-0a
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:27:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKjyt-0003Oj-OM
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CBCCA680FC
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 11:27:30 +0000 (UTC)
Date: Tue, 13 Jun 2017 08:27:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170613112726.GV5016@thinpad.lan.raisama.net>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<1496980142-8986-3-git-send-email-peterx@redhat.com>
	<87lgp1i8kz.fsf@dusky.pond.sub.org>
	<20170612044609.GE25059@pxdev.xzpeter.org>
	<20170612161349.GL22043@thinpad.lan.raisama.net>
	<20170613035215.GB11751@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613035215.GB11751@pxdev.xzpeter.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 13, 2017 at 11:52:15AM +0800, Peter Xu wrote:
> On Mon, Jun 12, 2017 at 01:13:49PM -0300, Eduardo Habkost wrote:
> > On Mon, Jun 12, 2017 at 12:46:09PM +0800, Peter Xu wrote:
> > > On Fri, Jun 09, 2017 at 03:39:24PM +0200, Markus Armbruster wrote:
> > > > Peter Xu <peterx@redhat.com> writes:
> > > > 
> > > > > Let the old man "MigrationState" join the object family. Direct benefit
> > > > > is that we can start to use all the property features derived from
> > > > > current QDev, like: HW_COMPAT_* bits, command line setup for migration
> > > > > parameters (so will never need to set them up each time using HMP/QMP,
> > > > > this is really, really attractive for test writters), etc.
> > > > >
> > > > > I see no reason to disallow this happen yet. So let's start from this
> > > > > one, to see whether it would be anything good.
> > > > >
> > > > > No functional change at all.
> > > > >
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > >  include/migration/migration.h | 19 ++++++++++++++
> > > > >  migration/migration.c         | 61 ++++++++++++++++++++++++++++---------------
> > > > >  2 files changed, 59 insertions(+), 21 deletions(-)
> > > > >
> > > > > diff --git a/include/migration/migration.h b/include/migration/migration.h
> > > > > index 79b5484..bd0186c 100644
> > > > > --- a/include/migration/migration.h
> > > > > +++ b/include/migration/migration.h
> > > > > @@ -21,6 +21,7 @@
> > > > >  #include "qapi-types.h"
> > > > >  #include "exec/cpu-common.h"
> > > > >  #include "qemu/coroutine_int.h"
> > > > > +#include "hw/qdev.h"
> > > > >  
> > > > >  #define QEMU_VM_FILE_MAGIC           0x5145564d
> > > > >  #define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
> > > > > @@ -49,6 +50,8 @@ enum mig_rp_message_type {
> > > > >      MIG_RP_MSG_MAX
> > > > >  };
> > > > >  
> > > > > +#define TYPE_MIGRATION "migration"
> > > > > +
> > > > >  /* State for the incoming migration */
> > > > >  struct MigrationIncomingState {
> > > > >      QEMUFile *from_src_file;
> > > > > @@ -91,8 +94,24 @@ struct MigrationIncomingState {
> > > > >  MigrationIncomingState *migration_incoming_get_current(void);
> > > > >  void migration_incoming_state_destroy(void);
> > > > >  
> > > > > +#define MIGRATION_CLASS(klass) \
> > > > > +    OBJECT_CLASS_CHECK(MigrationClass, (klass), TYPE_MIGRATION)
> > > > > +#define MIGRATION_OBJ(obj) \
> > > > > +    OBJECT_CHECK(MigrationState, (obj), TYPE_MIGRATION)
> > > > > +#define MIGRATION_GET_CLASS(obj) \
> > > > > +    OBJECT_GET_CLASS(MigrationClass, (obj), TYPE_MIGRATION)
> > > > > +
> > > > > +typedef struct MigrationClass {
> > > > > +    /*< private >*/
> > > > > +    DeviceClass parent_class;
> > > > > +} MigrationClass;
> > > > > +
> > > > >  struct MigrationState
> > > > >  {
> > > > > +    /*< private >*/
> > > > > +    DeviceState parent_obj;
> > > > > +
> > > > > +    /*< public >*/
> > > > 
> > > > Turning MigrationState into a QOM object so you can use QOM
> > > > infrastructure makes sense.  But why turn it into a device?  It doesn't
> > > > feel device-like to me.  Would ObjectClass and Object instead of
> > > > DeviceClass and DeviceState do?
> > > 
> > > Yeah. That's the main reason for the series to be (was) RFC.
> > > 
> > > I was trying to use the HW_COMPAT_* bits and -global, and that's QDev
> > > thing (IIUC you got that already :). I am just curious about why that
> > > is not for QObject from the very beginning, then it'll be easier.
> > > 
> > > For now, IMHO QDev is okay as well for migration, as long as it's kept
> > > internally inside QEMU. But sure at least I should turn user_creatable
> > > to off. I'll investigate more to see how to make this a safer approach
> > > in next post.
> > 
> > We could allow non-device QOM objects use the global property
> > system optionally.
> > 
> > We could make qdev_prop_set_globals() work on any Object*, and
> > let QOM classes call it on post_init if they want to be
> > configurable by global properties too.
> > 
> > Note that this would break qdev_prop_check_globals(), because it
> > expects globals to work only on TYPE_DEVICE.  We could address
> > that by introducing a new interface type to indicate the type
> > works with -global (something like
> > INTERFACE_CONFIGURABLE_BY_GLOBAL_PROPERTIES, but shorter?).
> > 
> > Such a system would probably allow us to replace
> > default_machine_opts, default_boot_order, default_display,
> > default_ram_size (and probably many other compat fields) on
> > MachineClass.  It could also be used to implement -machine and
> > -accel options by simply translating them to global properties
> > (like we already do for -cpu).
> > 
> > (This sounds like reinventing a QemuOpts-like system on top of
> > global properties.  Maybe that's a bad thing, maybe that's a good
> > thing.  I'm not sure.)
> 
> Thanks Eduardo for the reviews and suggestions. 
> 
> It'll obviously benefit us a lot if all the objects can use the global
> properties and the *_COMPAT_* legacy magic, while the tricky point is
> that, QObject will then depend on QDev?

I don't think the dependency would be the main problem.  The qdev
global-property code would be moved outside qdev, to common code.

The main problem I see is: it would make global properties too
powerful and dangerous.  Enabling global properties for all QOM
types unconditionally would expose QEMU internals that are not
supposed to be touched by the user.

> 
> Generally speaking this sounds good to me.  Before I do anything else,
> I believe I should wait to see how other QOM developers think about
> it.  Thanks,
> 
> -- 
> Peter Xu

-- 
Eduardo
