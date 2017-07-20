Received: from eggs.gnu.org ([2001:4830:134:3::10]:44095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dY5X2-00027T-NB
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dY5Wz-0004rF-C0
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dY5Wz-0004py-5V
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7A85461FE
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 07:00:28 +0000 (UTC)
Date: Thu, 20 Jul 2017 15:00:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170720070023.GA23385@pxdev.xzpeter.org>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-2-quintela@redhat.com>
	<20170719150109.GN2103@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170719150109.GN2103@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, berrange@redhat.com

On Wed, Jul 19, 2017 at 04:01:10PM +0100, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  migration/channel.c |  3 ++-
> >  migration/channel.h |  2 +-
> >  migration/exec.c    |  6 ++++--
> >  migration/socket.c  | 12 ++++++++----
> >  4 files changed, 15 insertions(+), 8 deletions(-)
> > 
> > diff --git a/migration/channel.c b/migration/channel.c
> > index 3b7252f..719055d 100644
> > --- a/migration/channel.c
> > +++ b/migration/channel.c
> > @@ -19,7 +19,7 @@
> >  #include "qapi/error.h"
> >  #include "io/channel-tls.h"
> >  
> > -void migration_channel_process_incoming(QIOChannel *ioc)
> > +gboolean migration_channel_process_incoming(QIOChannel *ioc)
> >  {
> >      MigrationState *s = migrate_get_current();
> >  
> > @@ -39,6 +39,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
> >          QEMUFile *f = qemu_fopen_channel_input(ioc);
> >          migration_fd_process_incoming(f);
> >      }
> > +    return FALSE; /* unregister */
> >  }
> >  
> >  
> > diff --git a/migration/channel.h b/migration/channel.h
> > index e4b4057..72cbc9f 100644
> > --- a/migration/channel.h
> > +++ b/migration/channel.h
> > @@ -18,7 +18,7 @@
> >  
> >  #include "io/channel.h"
> >  
> > -void migration_channel_process_incoming(QIOChannel *ioc);
> > +gboolean migration_channel_process_incoming(QIOChannel *ioc);
> 
> Can you add a comment here that says what the return value means.

And, looks like we have G_SOURCE_CONTINUE and G_SOURCE_REMOVE:

https://developer.gnome.org/glib/stable/glib-The-Main-Event-Loop.html#G-SOURCE-CONTINUE:CAPS

Maybe we can use them as well?

I think the problem is that GSourceFunc's return code (which is a
gboolean) is not clear enough.

-- 
Peter Xu
