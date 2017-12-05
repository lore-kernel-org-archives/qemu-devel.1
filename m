Received: from eggs.gnu.org ([2001:4830:134:3::10]:42060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMD3y-00022d-4v
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMD3u-00082V-Tc
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:15:06 -0500
Date: Tue, 5 Dec 2017 13:14:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171205131455.GC2405@work-vm>
References: <20171205122740.15005-1-lvivier@redhat.com>
	<20171205124439.GB2405@work-vm>
	<20171205130420.GM3057@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205130420.GM3057@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH] migration: fix analyze-migration.py script
 with radix table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Greg Kurz <groug@kaod.org>

* David Gibson (david@gibson.dropbear.id.au) wrote:
> On Tue, Dec 05, 2017 at 12:44:40PM +0000, Dr. David Alan Gilbert wrote:
> > * Laurent Vivier (lvivier@redhat.com) wrote:
> > > Since commit 3a38429748 ("Add a "no HPT" encoding to HTAB migration stream")
> > > the HTAB migration stream contains a header set to "-1", meaning there
> > > is no HPT. Teach analyze-migration.py to ignore the section in this case.
> > > 
> > > Without this fix, the script fails with a dump from a POWER9 guest:
> > > 
> > > Traceback (most recent call last):
> > >   File "./qemu/scripts/analyze-migration.py", line 602, in <module>
> > >     dump.read(dump_memory = args.memory)
> > >   File "./qemu/scripts/analyze-migration.py", line 539, in read
> > >     section.read()
> > >   File "./qemu/scripts/analyze-migration.py", line 250, in read
> > >     self.file.readvar(n_valid * self.HASH_PTE_SIZE_64)
> > >   File "./qemu/scripts/analyze-migration.py", line 64, in readvar
> > >     raise Exception("Unexpected end of %s at 0x%x" % (self.filename, self.file.tell()))
> > > Exception: Unexpected end of migrate.dump at 0x1d4763ba
> > > 
> > > Fixes: 3a38429748 ("Add a "no HPT" encoding to HTAB migration stream")
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Should I queue this (for 2.12), or do you want to take it via the
> migration tree?

We can take it via migration.

Dave

> > 
> > > ---
> > >  scripts/analyze-migration.py | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> > > index 14553876a2..88ff4adb30 100755
> > > --- a/scripts/analyze-migration.py
> > > +++ b/scripts/analyze-migration.py
> > > @@ -234,6 +234,10 @@ class HTABSection(object):
> > >  
> > >          header = self.file.read32()
> > >  
> > > +        if (header == -1):
> > > +            # "no HPT" encoding
> > > +            return
> > > +
> > >          if (header > 0):
> > >              # First section, just the hash shift
> > >              return
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
