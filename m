Received: from eggs.gnu.org ([2001:4830:134:3::10]:43377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dBOZD-0007oH-Vp
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dBOZA-0000Fv-1A
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:46:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dBOZ9-0000EW-PE
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:46:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85F9780046
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 16:46:18 +0000 (UTC)
Date: Thu, 18 May 2017 17:46:13 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170518164612.GF13699@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170518161655.30311-1-quintela@redhat.com>
	<20170518161655.30311-3-quintela@redhat.com>
	<20170518164053.GH2079@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170518164053.GH2079@work-vm>
Subject: Re: [Qemu-devel] [PATCH 2/9] migration: Split migration/channel.c
 for channel operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

On Thu, May 18, 2017 at 05:40:54PM +0100, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
> > Create an include for its exported functions.
> > 
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > 
> > ---
> > Add proper header
> > ---
> >  include/migration/migration.h |  7 -----
> >  migration/Makefile.objs       |  2 +-
> >  migration/channel.c           | 69 +++++++++++++++++++++++++++++++++++++++++++
> >  migration/channel.h           | 27 +++++++++++++++++
> >  migration/exec.c              |  1 +
> >  migration/fd.c                |  1 +
> >  migration/migration.c         | 50 -------------------------------
> >  migration/socket.c            |  1 +
> >  migration/tls.c               |  1 +
> >  9 files changed, 101 insertions(+), 58 deletions(-)
> >  create mode 100644 migration/channel.c
> >  create mode 100644 migration/channel.h
> > 
> > diff --git a/include/migration/migration.h b/include/migration/migration.h
> > index 7d1eef7..e831259 100644
> > --- a/include/migration/migration.h
> > +++ b/include/migration/migration.h
> > @@ -157,17 +157,10 @@ void migration_fd_process_incoming(QEMUFile *f);
> >  
> >  void qemu_start_incoming_migration(const char *uri, Error **errp);
> >  
> > -void migration_channel_process_incoming(MigrationState *s,
> > -                                        QIOChannel *ioc);
> > -
> >  void migration_tls_channel_process_incoming(MigrationState *s,
> >                                              QIOChannel *ioc,
> >                                              Error **errp);
> >  
> > -void migration_channel_connect(MigrationState *s,
> > -                               QIOChannel *ioc,
> > -                               const char *hostname);
> > -
> >  void migration_tls_channel_connect(MigrationState *s,
> >                                     QIOChannel *ioc,
> >                                     const char *hostname,
> > diff --git a/migration/Makefile.objs b/migration/Makefile.objs
> > index 00a3f4a..4e8ab0a 100644
> > --- a/migration/Makefile.objs
> > +++ b/migration/Makefile.objs
> > @@ -1,5 +1,5 @@
> >  common-obj-y += migration.o socket.o fd.o exec.o
> > -common-obj-y += tls.o
> > +common-obj-y += tls.o channel.o
> >  common-obj-y += colo-comm.o colo.o colo-failover.o
> >  common-obj-y += vmstate.o page_cache.o
> >  common-obj-y += qemu-file.o
> > diff --git a/migration/channel.c b/migration/channel.c
> > new file mode 100644
> > index 0000000..f50267a
> > --- /dev/null
> > +++ b/migration/channel.c
> > @@ -0,0 +1,69 @@
> > +/*
> > + * QEMU live migration channel operations
> > + *
> > + * Copyright Red Hat, Inc. 2016
> > + *
> > + * Authors:
> > + *  Daniel P. Berrange <berrange@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.  See
> > + * the COPYING file in the top-level directory.
> > + *
> > + * Contributions after 2012-01-13 are licensed under the terms of the
> > + * GNU GPL, version 2 or (at your option) any later version.
> > + */
> 
> OK, better - but...  isn't all this after 2012?
> Since it is I think you need the header that says it's v2 or later
> (e.g. the one on migration/page_cache.c )

Yes, all the code that has been copied into these new files
post-dates that. So you can just mark the whole files (both .c and .h)
as v2 or later.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
