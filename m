Received: from eggs.gnu.org ([2001:4830:134:3::10]:32850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIyKP-0004Lq-2p
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIyKL-0004QI-Ui
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:22:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dIyKL-0004Pv-P2
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:22:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEB687F7DB
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 14:22:20 +0000 (UTC)
Date: Thu, 8 Jun 2017 15:22:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170608142216.GD2082@work-vm>
References: <20170608133906.12737-1-ehabkost@redhat.com>
	<20170608133906.12737-5-ehabkost@redhat.com>
	<20170608142140.GC2082@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608142140.GC2082@work-vm>
Subject: Re: [Qemu-devel] [PATCH 4/5] migration: Don't try to set *errp
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Eduardo Habkost (ehabkost@redhat.com) wrote:
> > Assigning directly to *errp is not valid, as errp may be NULL,
> > &error_fatal, or &error_abort.  Use error_propagate() instead.
> > 
> > Cc: Juan Quintela <quintela@redhat.com>
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  migration/migration.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 48c94c9ca1..5a8bef3ef5 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1188,7 +1188,7 @@ bool migration_is_blocked(Error **errp)
> >      }
> >  
> >      if (migration_blockers) {
> > -        *errp = error_copy(migration_blockers->data);
> > +        error_propagate(errp, error_copy(migration_blockers->data));
> >          return true;
> >      }
> 
> if errp is NULL doesn't that leak the error_copy ?

To answer myself, no it doesn't - error_propagate free's it in that
case.

Dave

> Dave
> 
> >  
> > -- 
> > 2.11.0.259.g40922b1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
