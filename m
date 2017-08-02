Received: from eggs.gnu.org ([2001:4830:134:3::10]:39930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcmvo-0000uR-8Q
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 02:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcmvj-00075q-AO
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 02:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcmvj-000745-4K
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 02:14:51 -0400
Date: Wed, 2 Aug 2017 14:14:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170802061443.GB4475@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-18-git-send-email-peterx@redhat.com>
	<20170801105906.GJ2079@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170801105906.GJ2079@work-vm>
Subject: Re: [Qemu-devel] [RFC 17/29] migration: rebuild channel on source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Tue, Aug 01, 2017 at 11:59:07AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > This patch detects the "resume" flag of migration command, rebuild the
> > channels only if the flag is set.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 52 ++++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 41 insertions(+), 11 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 36ff8c3..64de0ee 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1244,6 +1244,15 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
> >      MigrationState *s = migrate_get_current();
> >      const char *p;
> >  
> > +    if (has_resume && resume) {
> > +        if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
> > +            error_setg(errp, "Cannot resume if there is no "
> > +                       "paused migration");
> > +            return;
> > +        }
> > +        goto do_resume;
> > +    }
> > +
> >      if (migration_is_setup_or_active(s->state) ||
> >          s->state == MIGRATION_STATUS_CANCELLING ||
> >          s->state == MIGRATION_STATUS_COLO) {
> > @@ -1279,6 +1288,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
> >  
> >      s = migrate_init();
> >  
> > +do_resume:
> 
> Can we find a way to avoid this label?
> Perhaps split the bottom half of this function out into a separate
> function?

Yes this label can indeed be avoided (sorry for my laziness). Will
take the suggestion.  Thanks,

-- 
Peter Xu
