Received: from eggs.gnu.org ([2001:4830:134:3::10]:44033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dFycO-0004L0-Fr
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dFycL-000632-7q
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:04:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dFycL-00062H-02
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:04:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC69A37E65
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 08:04:31 +0000 (UTC)
Date: Wed, 31 May 2017 16:04:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170531080427.GI14845@pxdev.xzpeter.org>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-7-git-send-email-peterx@redhat.com>
	<87shjme3ox.fsf@secure.mitica>
	<20170531073841.GH14845@pxdev.xzpeter.org>
	<87r2z5cvza.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2z5cvza.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH RFC 6/6] migration: enable return path for
 precopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, May 31, 2017 at 09:43:21AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Tue, May 30, 2017 at 05:59:10PM +0200, Juan Quintela wrote:
> >> Peter Xu <peterx@redhat.com> wrote:
> >> > Let this be a flag, default to on. Turn it off for <=2.9 versions.
> >> >
> >> > After this patch, return path will be on even for pre-copy migration as
> >> > long as the transport support, e.g., for socket typed transport
> >> > including "tcp|udp|unix" typed.
> >> >
> >> > This will naturally fix the bug mentioned below, when destination failed
> >> > on migration but source assumed it was successful - since now even for
> >> > precopy, source will wait for destination's MIG_RP_MSG_SHUT signal,
> >> > which will carry the final migration status of destination. Then, when
> >> > destination failed at any point of migration, source will know it, and
> >> > it'll resume the VM instead of a data lost.
> >> >
> >> > Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1439147
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > ---
> >> >  include/hw/compat.h           |  4 ++++
> >> >  include/migration/migration.h |  3 +++
> >> >  migration/migration.c         | 15 ++++++++++++++-
> >> >  3 files changed, 21 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/include/hw/compat.h b/include/hw/compat.h
> >> > index 55b1765..049457b 100644
> >> > --- a/include/hw/compat.h
> >> > +++ b/include/hw/compat.h
> >> > @@ -6,6 +6,10 @@
> >> >          .driver   = "pci-bridge",\
> >> >          .property = "shpc",\
> >> >          .value    = "off",\
> >> > +    },{\
> >> > +        .driver   = "migration",\
> >> > +        .property = "return-path",\
> >> > +        .value    = "off",\
> >> >      },
> >> >  
> >> >  #define HW_COMPAT_2_8 \
> >> > diff --git a/include/migration/migration.h b/include/migration/migration.h
> >> > index 70710de..e44119c 100644
> >> > --- a/include/migration/migration.h
> >> > +++ b/include/migration/migration.h
> >> > @@ -169,6 +169,9 @@ typedef struct MigrationState {
> >> >      int64_t colo_checkpoint_time;
> >> >      QEMUTimer *colo_delay_timer;
> >> >  
> >> > +    /* Whether to try to enable return-path even for pre-copy */
> >> > +    bool enable_return_path;
> >> > +
> >> >      /* The last error that occurred */
> >> >      Error *error;
> >> >  } MigrationState ;
> >> > diff --git a/migration/migration.c b/migration/migration.c
> >> > index 6df3483..16a856a 100644
> >> > --- a/migration/migration.c
> >> > +++ b/migration/migration.c
> >> > @@ -2046,7 +2046,7 @@ static void *migration_thread(void *opaque)
> >> >  static bool migrate_return_path_create(MigrationState *s)
> >> >  {
> >> >      /* Whether we should enable return path */
> >> > -    bool enable_return_path = false;
> >> > +    bool enable_return_path = s->enable_return_path;
> >> 
> >> As you can see on my suggestion for this piece of code, just add the
> >> ()s->enable_return_path &&) to the right place on the call?
> >> 
> >> Thanks, Juan.
> >
> > Do you mean this?
> >
> >     /*
> >      * Open the return path
> >      */
> >     if (migrate_postcopy_ram() || s->enable_return_path) {
> >         if (!migrate_return_path_create(s)) {
> >             migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> >                               MIGRATION_STATUS_FAILED);
> >             migrate_fd_cleanup(s);
> >             return;
> >         }
> >     }
> 
> Yeap.
> 
> > Here what I wanted to achieve is that:
> >
> > a. for postcopy, we should try to enable return path, and it must
> >    succeed
> >
> > b. for the case when enable_return_path is set, we try to enable return
> >    path, but even if it failed, we can still continue
> >
> > Could we really achieve (b) if with above code? Or anything I missed?
> 
> if we enable_return_path -> it should success, otherwise it makes no
> sense, no?  We can try to remove the return path for some transports if
> needed, but it makes no sense to enable a property that means:
> "please, pretty please, enable it if you can"

(Indeed this is awkward... :)

> 
> if we are going to do it that way, then it is better to change the
> property the other way around:
> 
> - disable_return_path: set for all old machine types
> 
> And not set for newer machine types, meaning that we just try.
> 
> What do you think?

Both namings work for me.

The problem is that we cannot really force this as long as there is
any type of transports that does not support return path. E.g., when
migrating to an "exec:" typed transport with single-out IO stream. In
that case, if we fail the migration, it'll break the old behavior,
right? Then for exec: typed users they need to manually provide
enable_return_path=false to finally allow them to migrate.

(I think that's the most tricky point of this series...)

Thanks,

-- 
Peter Xu
