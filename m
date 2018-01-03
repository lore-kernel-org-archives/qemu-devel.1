Received: from eggs.gnu.org ([2001:4830:134:3::10]:46916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWest-0004L8-LB
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWesp-0001pI-Q0
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:58:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWesp-0001oz-Jm
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 03:58:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1F0AC00C905
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 08:58:46 +0000 (UTC)
Date: Wed, 3 Jan 2018 16:58:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180103085842.GD2557@xz-mi>
References: <20180103054043.25719-1-peterx@redhat.com>
	<20180103054043.25719-2-peterx@redhat.com>
	<87a7xv49r7.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a7xv49r7.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH 01/11] migration: assert colo instead of
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jan 03, 2018 at 09:38:52AM +0100, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > When reaching here if we are still "active" it means we must be in colo
> > state.  Assert it instead of check it in if condition.
> 
> I don't think so.
> 
> > Finally I want to use "switch" here rather than lots of complicated if
> > clauses.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 4de3b551fe..0ee4b4c27c 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2309,7 +2309,8 @@ static void *migration_thread(void *opaque)
> >          }
> >          runstate_set(RUN_STATE_POSTMIGRATE);
> >      } else {
> > -        if (s->state == MIGRATION_STATUS_ACTIVE && enable_colo) {
> > +        if (s->state == MIGRATION_STATUS_ACTIVE) {
> 
> We want to run this code iff:
> - we are in ACTIVE state
> - we are using colo
> 
> We can be doing a normal migration, with colo compliled in, but not
> enabled, no?

If COLO is not enabled (even if it is compiled in), IMHO we won't
reach this state.  Note that we have this in migration_completion():

    if (!migrate_colo_enabled()) {
        migrate_set_state(&s->state, current_active_state,
                          MIGRATION_STATUS_COMPLETED);
    }

That's where we kept the ACTIVE state, and that should be the only
place. And, this is exactly what this patch is going to do - I want to
remove COLO hacks if possible.

Thanks,

-- 
Peter Xu
