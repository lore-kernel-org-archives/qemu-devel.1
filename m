Received: from eggs.gnu.org ([2001:4830:134:3::10]:52866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dBNfF-0000mD-OQ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dBNfC-0004hg-25
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dBNfB-0004hX-PA
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:48:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C318572470
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 15:48:27 +0000 (UTC)
Date: Thu, 18 May 2017 16:48:20 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170518154820.GC13699@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170517154756.22079-1-quintela@redhat.com>
	<20170517154756.22079-4-quintela@redhat.com>
	<20170518154407.GG2467@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170518154407.GG2467@work-vm>
Subject: Re: [Qemu-devel] [PATCH 3/9] migration: Export qemu-file-channel.c
 functions in its own file
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

On Thu, May 18, 2017 at 04:44:08PM +0100, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  include/migration/migration.h |  1 +
> >  include/migration/qemu-file.h |  4 ----
> >  migration/channel.c           |  1 +
> >  migration/colo.c              |  1 +
> >  migration/migration.c         |  1 +
> >  migration/qemu-file-channel.c |  1 +
> >  migration/qemu-file-channel.h | 21 +++++++++++++++++++++
> >  migration/rdma.c              |  1 +
> >  migration/savevm.c            |  1 +
> >  tests/test-vmstate.c          |  1 +
> >  10 files changed, 29 insertions(+), 4 deletions(-)
> >  create mode 100644 migration/qemu-file-channel.h
> > 
> > diff --git a/include/migration/migration.h b/include/migration/migration.h
> > index e831259..8280df1 100644
> > --- a/include/migration/migration.h
> > +++ b/include/migration/migration.h
> > @@ -19,6 +19,7 @@
> >  #include "qemu/thread.h"
> >  #include "qemu/notify.h"
> >  #include "migration/vmstate.h"
> > +#include "io/channel.h"
> >  #include "qapi-types.h"
> >  #include "exec/cpu-common.h"
> >  #include "qemu/coroutine_int.h"
> > diff --git a/include/migration/qemu-file.h b/include/migration/qemu-file.h
> > index 0cd648a..b5ac800 100644
> > --- a/include/migration/qemu-file.h
> > +++ b/include/migration/qemu-file.h
> > @@ -27,8 +27,6 @@
> >  
> >  #include "qemu-common.h"
> >  #include "exec/cpu-common.h"
> > -#include "io/channel.h"
> > -
> >  
> >  /* Read a chunk of data from a file at the given position.  The pos argument
> >   * can be ignored if the file is only be used for streaming.  The number of
> > @@ -119,8 +117,6 @@ typedef struct QEMUFileHooks {
> >  } QEMUFileHooks;
> >  
> >  QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops);
> > -QEMUFile *qemu_fopen_channel_input(QIOChannel *ioc);
> > -QEMUFile *qemu_fopen_channel_output(QIOChannel *ioc);
> >  void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks);
> >  int qemu_get_fd(QEMUFile *f);
> >  int qemu_fclose(QEMUFile *f);
> > diff --git a/migration/channel.c b/migration/channel.c
> > index 6104de5..fed8563 100644
> > --- a/migration/channel.c
> > +++ b/migration/channel.c
> > @@ -16,6 +16,7 @@
> >  #include "qemu/osdep.h"
> >  #include "channel.h"
> >  #include "migration/migration.h"
> > +#include "qemu-file-channel.h"
> >  #include "trace.h"
> >  #include "qapi/error.h"
> >  #include "io/channel-tls.h"
> > diff --git a/migration/colo.c b/migration/colo.c
> > index dd38fed..9cd0250 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -13,6 +13,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/timer.h"
> >  #include "sysemu/sysemu.h"
> > +#include "qemu-file-channel.h"
> >  #include "migration/colo.h"
> >  #include "migration/block.h"
> >  #include "io/channel-buffer.h"
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 3ba32eb..ff3f7aa 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -19,6 +19,7 @@
> >  #include "qemu/main-loop.h"
> >  #include "migration/blocker.h"
> >  #include "migration/migration.h"
> > +#include "qemu-file-channel.h"
> >  #include "migration/qemu-file.h"
> >  #include "sysemu/sysemu.h"
> >  #include "block/block.h"
> > diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
> > index 45c13f1..dc991c9 100644
> > --- a/migration/qemu-file-channel.c
> > +++ b/migration/qemu-file-channel.c
> > @@ -23,6 +23,7 @@
> >   */
> >  
> >  #include "qemu/osdep.h"
> > +#include "qemu-file-channel.h"
> >  #include "migration/qemu-file.h"
> >  #include "io/channel-socket.h"
> >  #include "qemu/iov.h"
> > diff --git a/migration/qemu-file-channel.h b/migration/qemu-file-channel.h
> > new file mode 100644
> > index 0000000..d1bd5ff
> > --- /dev/null
> > +++ b/migration/qemu-file-channel.h
> > @@ -0,0 +1,21 @@
> > +/*
> > + * QEMU migration file channel operations
> > + *
> > + * Copyright IBM, Corp. 2008
> > + *
> > + * Authors:
> > + *  Anthony Liguori   <aliguori@us.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.  See
> > + * the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#ifndef QEMU_FILE_CHANNEL_H
> > +#define QEMU_FILE_CHANNEL_H
> > +
> > +#include "io/channel.h"
> > +
> > +QEMUFile *qemu_fopen_channel_input(QIOChannel *ioc);
> > +QEMUFile *qemu_fopen_channel_output(QIOChannel *ioc);
> > +#endif
> 
> OK, similar copyright - but slightly different problem.
> These two lines come from include/migration/qemu-file.h;
> they were both added by Daniel in a9cfeb33bb23a81.
> The qemu-file.h header however has the old Fabrice copyright
> with a 3 paragraph copyright rather than the GPLv2.
> 
> So, Authors, and copyright need changing - not sure what the
> right way to do the copyright is.  Personally I'd ask Dan really
> nicely to let it be GPL v2 or newer, but the quicker answer I think
> is to take the header from qemu-file.h

That is of course fine. Anything I contribute is under Red Hat copyright,
and so as another Red Hat employee, you're free to change the license on
any code I wrote [1]

Regards,
Daniel

[1] unless I put a comment about having copied the code from another source
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
