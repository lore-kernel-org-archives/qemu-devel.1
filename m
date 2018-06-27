Received: from eggs.gnu.org ([2001:4830:134:3::10]:40777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY7cH-0006j6-LQ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY7cG-00053Y-PO
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:24:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fY7cG-000524-Jf
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:24:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DBC8401EF06
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 10:23:59 +0000 (UTC)
Date: Wed, 27 Jun 2018 18:23:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180627102354.GA2516@xz-mi>
References: <20180611060228.2998-1-peterx@redhat.com>
	<20180611060228.2998-2-peterx@redhat.com>
	<87po0clffg.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87po0clffg.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: unbreak postcopy recovery
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

On Wed, Jun 27, 2018 at 11:57:55AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > It was broken due to recent changes in two parts:
> >
> > - migration_incoming_process() will be called now even for postcopy
> >   recovery sessions (while we shouldn't)
> >
> > - Now we don't call migrate_fd_process_incoming() any more (unless in
> >   RDMA code), so actually the postcopy recovery logic is fully bypassed
> >
> > Fix this up to make sure we only call migration_incoming_process() when
> > necessary, and move the postcopy recovery logic far earlier to the entry
> > point of incoming migration.  Renaming migration_fd_process_incoming()
> > into postcopy_try_recover() since it's mostly for the recovery process,
> > then touch up RDMA code to suite it.
> >
> > Since at it, refactor the imcoming port handling to only have one singe
> > entry point for incoming migration.  Then we can avoid calling
> > migration_ioc_process_incoming() everywhere, which is really error
> > prone.
> 
> Perhaps splitting some of this bits?

Actually I tried a bit but failed, but of course I can try harder. :)

> 
> > diff --git a/migration/ram.h b/migration/ram.h
> > index d386f4d641..457bf54b8c 100644
> > --- a/migration/ram.h
> > +++ b/migration/ram.h
> > @@ -46,7 +46,7 @@ int multifd_save_cleanup(Error **errp);
> >  int multifd_load_setup(void);
> >  int multifd_load_cleanup(Error **errp);
> >  bool multifd_recv_all_channels_created(void);
> > -void multifd_recv_new_channel(QIOChannel *ioc);
> > +bool multifd_recv_new_channel(QIOChannel *ioc);
> 
> I am ok with this type change.
> 
> >  void migration_ioc_process_incoming(QIOChannel *ioc)
> >  {
> >      MigrationIncomingState *mis = migration_incoming_get_current();
> > +    QEMUFile *f = qemu_fopen_channel_input(ioc);
> 
> We are creating a QEMUFile here.
> 
> > +    bool start_migration;
> > +
> > +    /* If it's a recovery attempt, we're done */
> > +    if (postcopy_try_recover(f)) {
> 
> Here we use it.
> 
> > +        return;
> > +    }
> >  
> >      if (!mis->from_src_file) {
> > -        QEMUFile *f = qemu_fopen_channel_input(ioc);
> > +        /* The first connection (multifd may have multiple) */
> >          migration_incoming_setup(f);
> 
>             Here we use it.
> 
> > -        return;
> > +        /*
> > +         * Common migration only needs one channel, so we can start
> > +         * right now.  Multifd needs more than one channel, we wait.
> > +         */
> > +        start_migration = !migrate_use_multifd();
> > +    } else {
> > +        /* Multiple connections */
> > +        assert(migrate_use_multifd());
> > +        start_migration = multifd_recv_new_channel(ioc);
> 
>        But here we don't use it.  We are lecking it.
> 
>        So, we need to fix the leak.  No clue about how to convince
>        postcopy_try_recover() without the QEMUFile

Indeed!  Thanks for spotting that!  I'll prepare a new version.

-- 
Peter Xu
