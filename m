Received: from eggs.gnu.org ([2001:4830:134:3::10]:37207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsm7w-0005Yp-AH
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsm7t-0000t5-8B
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:37:32 -0400
Date: Fri, 15 Sep 2017 16:37:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170915083721.GT3617@pxdev.xzpeter.org>
References: <20170915054404.19914-1-famz@redhat.com>
	<20170915054404.19914-3-famz@redhat.com>
	<20170915080350.GS3617@pxdev.xzpeter.org>
	<20170915082026.GG17199@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170915082026.GG17199@lemon>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Cancel migration at exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-stable@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Sep 15, 2017 at 04:20:26PM +0800, Fam Zheng wrote:

[...]

> > >  void qmp_migrate_set_cache_size(int64_t value, Error **errp)
> > >  {
> > >      MigrationState *s = migrate_get_current();
> > > diff --git a/vl.c b/vl.c
> > > index fb1f05b937..abbe61f40b 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -87,6 +87,7 @@ int main(int argc, char **argv)
> > >  #include "sysemu/blockdev.h"
> > >  #include "hw/block/block.h"
> > >  #include "migration/misc.h"
> > > +#include "migration/savevm.h"
> > >  #include "migration/snapshot.h"
> > >  #include "migration/global_state.h"
> > >  #include "sysemu/tpm.h"
> > > @@ -4799,6 +4800,8 @@ int main(int argc, char **argv, char **envp)
> > >      iothread_stop_all();
> > >  
> > >      pause_all_vcpus();
> > > +    migrate_cancel();
> > 
> > IIUC this is an async cancel, so when reach here the migration thread
> > can still be alive.  Then...
> > 
> > > +    qemu_savevm_state_cleanup();
> > 
> > ... Here calling qemu_savevm_state_cleanup() may be problematic if
> > migration thread has not yet quitted.
> > 
> > I'm thinking whether we should make migrate_fd_cancel() wait until the
> > migration thread finishes (state change to CANCELLED).  Then the
> > migration thread will do the cleanup, and here we can avoid calling
> > qemu_savevm_state_cleanup() as well.
> 
> But if the migration thread is stuck and CANCELLED is never reached, we'll hang
> here?

Maybe we can add timeout. Anyway, if it gets stuck, I do see it a
migration bug, and in that case I'm not sure force return after
timeout would be anything wiser.

Dave/Juan may have better idea though.

-- 
Peter Xu
