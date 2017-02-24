Received: from eggs.gnu.org ([2001:4830:134:3::10]:33402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chHtt-0002Kr-Q0
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chHtp-000122-RJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:35:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1chHtp-00011a-Lt
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:35:13 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA9DD624D7
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 15:35:13 +0000 (UTC)
Date: Fri, 24 Feb 2017 15:35:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170224153508.GH8830@work-vm>
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-5-dgilbert@redhat.com>
	<f56e2f89-3d8a-3eca-607b-f0a8c60f9d94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f56e2f89-3d8a-3eca-607b-f0a8c60f9d94@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/16] exec: ram_block_discard_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, aarcange@redhat.com

* Laurent Vivier (lvivier@redhat.com) wrote:
> On 06/02/2017 18:32, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Create ram_block_discard_range in exec.c to replace
> > postcopy_ram_discard_range and most of ram_discard_range.
> > 
> > Those two routines are a bit of a weird combination, and
> > ram_discard_range is about to get more complex for hugepages.
> > It's OS dependent code (so shouldn't be in migration/ram.c) but
> > it needs quite a bit of the innards of RAMBlock so doesn't belong in
> > the os*.c.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  exec.c                    | 59 +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/exec/cpu-common.h |  1 +
> >  2 files changed, 60 insertions(+)
> > 
> > diff --git a/exec.c b/exec.c
> > index 8b9ed73..e040cdf 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -45,6 +45,12 @@
> >  #include "exec/address-spaces.h"
> >  #include "sysemu/xen-mapcache.h"
> >  #include "trace-root.h"
> > +
> > +#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> > +#include <fcntl.h>
> > +#include <linux/falloc.h>
> > +#endif
> 
> Should it be in PATCH 05/16 instead?

Ah, yes, it should.

Dave

> Laurent
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
