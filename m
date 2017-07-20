Received: from eggs.gnu.org ([2001:4830:134:3::10]:40524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dY77t-0000iu-0B
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dY77p-00068N-7t
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:48:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dY77o-00068F-VF
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:48:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB2835BECD
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:47:59 +0000 (UTC)
Date: Thu, 20 Jul 2017 09:47:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170720084755.GB21566@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-2-quintela@redhat.com>
	<20170719150109.GN2103@work-vm>
	<20170720070023.GA23385@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170720070023.GA23385@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v5 01/17] migrate: Add gboolean return type
 to migrate_channel_process_incoming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com

On Thu, Jul 20, 2017 at 03:00:23PM +0800, Peter Xu wrote:
> On Wed, Jul 19, 2017 at 04:01:10PM +0100, Dr. David Alan Gilbert wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> > > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > > ---
> > >  migration/channel.c |  3 ++-
> > >  migration/channel.h |  2 +-
> > >  migration/exec.c    |  6 ++++--
> > >  migration/socket.c  | 12 ++++++++----
> > >  4 files changed, 15 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/migration/channel.c b/migration/channel.c
> > > index 3b7252f..719055d 100644
> > > --- a/migration/channel.c
> > > +++ b/migration/channel.c
> > > @@ -19,7 +19,7 @@
> > >  #include "qapi/error.h"
> > >  #include "io/channel-tls.h"
> > >  
> > > -void migration_channel_process_incoming(QIOChannel *ioc)
> > > +gboolean migration_channel_process_incoming(QIOChannel *ioc)
> > >  {
> > >      MigrationState *s = migrate_get_current();
> > >  
> > > @@ -39,6 +39,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
> > >          QEMUFile *f = qemu_fopen_channel_input(ioc);
> > >          migration_fd_process_incoming(f);
> > >      }
> > > +    return FALSE; /* unregister */
> > >  }
> > >  
> > >  
> > > diff --git a/migration/channel.h b/migration/channel.h
> > > index e4b4057..72cbc9f 100644
> > > --- a/migration/channel.h
> > > +++ b/migration/channel.h
> > > @@ -18,7 +18,7 @@
> > >  
> > >  #include "io/channel.h"
> > >  
> > > -void migration_channel_process_incoming(QIOChannel *ioc);
> > > +gboolean migration_channel_process_incoming(QIOChannel *ioc);
> > 
> > Can you add a comment here that says what the return value means.
> 
> And, looks like we have G_SOURCE_CONTINUE and G_SOURCE_REMOVE:
> 
> https://developer.gnome.org/glib/stable/glib-The-Main-Event-Loop.html#G-SOURCE-CONTINUE:CAPS
> 
> Maybe we can use them as well?

Those are newer than our min required glib version, though we could
add compat defines for them

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
