Received: from eggs.gnu.org ([2001:4830:134:3::10]:49180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1drTuf-0004qz-11
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1drTub-0006Ye-Qf
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:58:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1drTub-0006YS-K2
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:58:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 803D2347A50
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 18:58:24 +0000 (UTC)
Date: Mon, 11 Sep 2017 19:58:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170911185818.GG2857@work-vm>
References: <20170906115143.27451-1-quintela@redhat.com>
	<20170906115143.27451-8-quintela@redhat.com>
	<265f10bb-5718-aaac-d0fe-595a78acdf46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265f10bb-5718-aaac-d0fe-595a78acdf46@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 07/22] migration: Make
 migrate_fd_error() the owner of the Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Eric Blake (eblake@redhat.com) wrote:
> On 09/06/2017 06:51 AM, Juan Quintela wrote:
> > So far, we had to free the error after each caller, so just do it
> > here.  Once there, tls.c was leaking the error.
> 
> You mention tls.c,
> 
> > 
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  migration/channel.c   |  1 -
> >  migration/migration.c | 10 ++++------
> >  migration/migration.h |  4 ++--
> >  migration/socket.c    |  1 -
> >  4 files changed, 6 insertions(+), 10 deletions(-)
> 
> but don't touch it.  Am I missing something?


hmm well I see in migration/tls.c:

    if (qio_task_propagate_error(task, &err)) {
        trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
        migrate_fd_error(s, err);
        error_free(err);
    } else {
        trace_migration_tls_outgoing_handshake_complete();
        migration_channel_connect(s, ioc, NULL);
    }

so I think that error_free has to go?

Dave

> >  
> > -void migrate_fd_error(MigrationState *s, const Error *error)
> > +void migrate_fd_error(MigrationState *s, Error *error)
> >  {
> 
> No comments at definition,
> 
> > +++ b/migration/migration.h
> > @@ -163,8 +163,8 @@ bool  migration_has_all_channels(void);
> >  
> >  uint64_t migrate_max_downtime(void);
> >  
> > -void migrate_set_error(MigrationState *s, const Error *error);
> > -void migrate_fd_error(MigrationState *s, const Error *error);
> > +void migrate_set_error(MigrationState *s, Error *error);
> > +void migrate_fd_error(MigrationState *s, Error *error);
> 
> or at declaration. That would be worth adding at some point, but this
> patch isn't making it worse.
> 
> The code looks okay in isolation, so if it is only the commit message
> that needs fixing,
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
