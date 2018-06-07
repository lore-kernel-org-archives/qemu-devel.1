Received: from eggs.gnu.org ([2001:4830:134:3::10]:44281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQsNJ-0005p4-FV
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQsNG-0005Sf-Al
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:42:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35630 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fQsNG-0005S9-5L
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:42:34 -0400
Date: Thu, 7 Jun 2018 11:42:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180607104222.GH2522@work-vm>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
	<1527840629-18648-8-git-send-email-junyan.he@gmx.com>
	<20180605114412.GE11888@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605114412.GE11888@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH V6 7/7] migration/ram: ensure write
 persistence on loading all data to PMEM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: junyan.he@gmx.com, qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Fri, Jun 01, 2018 at 04:10:29PM +0800, junyan.he@gmx.com wrote:
> > diff --git a/migration/ram.c b/migration/ram.c
> > index aa0c6f0..09525b2 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -33,6 +33,7 @@
> >  #include "qemu/bitops.h"
> >  #include "qemu/bitmap.h"
> >  #include "qemu/main-loop.h"
> > +#include "qemu/pmem.h"
> >  #include "xbzrle.h"
> >  #include "ram.h"
> >  #include "migration.h"
> > @@ -3046,6 +3047,13 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
> >  static int ram_load_cleanup(void *opaque)
> >  {
> >      RAMBlock *rb;
> > +
> > +    RAMBLOCK_FOREACH(rb) {
> > +        if (ramblock_is_pmem(rb)) {
> > +            pmem_persist(rb->host, rb->used_length);
> > +         }
> 
> Indentation is off.  This can be fixed by the maintainer who merges
> these patches.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


The other thing that needs a fixup for is RAMBLOCK_FOREACH_MIGRATABLE
that recently got merged.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
