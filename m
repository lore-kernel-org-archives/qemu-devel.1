Received: from eggs.gnu.org ([2001:4830:134:3::10]:58549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dqngP-0008Ci-6q
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 17:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dqngK-000093-BO
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 17:52:57 -0400
Date: Sat, 9 Sep 2017 18:52:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170909215243.GK7570@localhost.localdomain>
References: <20170901110332.32650-1-otubo@redhat.com>
	<20170901143016.GK7570@localhost.localdomain>
	<87lglyzb3p.fsf@dusky.pond.sub.org>
	<20170901154430.GN7570@localhost.localdomain>
	<20170907083829.GB2441@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170907083829.GB2441@vader>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] dma/i82374: avoid double
 creation of i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, mst@redhat.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>

On Thu, Sep 07, 2017 at 10:38:29AM +0200, Eduardo Otubo wrote:
> On Fri, Sep 01, 2017 at 12:44:30PM -0300, Eduardo Habkost wrote:
> > On Fri, Sep 01, 2017 at 05:34:34PM +0200, Markus Armbruster wrote:
> > > Eduardo Habkost <ehabkost@redhat.com> writes:
> > > > On Fri, Sep 01, 2017 at 01:03:32PM +0200, Eduardo Otubo wrote:
[...]
> > > >> diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
> > > >> index 6c0f975df0..5275d822e0 100644
> > > >> --- a/hw/dma/i82374.c
> > > >> +++ b/hw/dma/i82374.c
> > > >> @@ -139,6 +139,7 @@ static void i82374_class_init(ObjectClass *klass, void *data)
> > > >>      dc->realize = i82374_realize;
> > > >>      dc->vmsd = &vmstate_i82374;
> > > >>      dc->props = i82374_properties;
> > > >> +    dc->user_creatable = false;
> > > >
> > > > A "Reason:" comment explaining why user_creatable=false is
> > > > mandatory.  See the comment above user_creatable declaration in
> > > > qdev-core.h for reference.
> > > >
> > > > I suggest the following:
> > > >
> > > >     /*
> > > >      * Reason: i82374_realize() crashes (assertion failure inside isa_bus_dma()
> > > >      *         if the device is instantiated twice.
> > > >      */
> 
> I agree with the comment above. If there's nothing left to fix/add
> I'll just send a v2 for this shortly.

I suggest amending it with the additional info below, explaining
that isa_bus_dma() isn't supposed to be called twice, and that we
need to make isa_bus_dma()/DMA_init()/i82374_realize() return an
appropriate error if the device is instantiated twice.


> 
> > > 
> > > We need to find out *why* it crashes.  Once we know, we can likely write
> > > a better comment.
> > 
> > It crashes because isa_bus_dma() isn't supposed to be called
> > twice for the same bus.
> > 
> > Making isa_bus_dma()/DMA_init()/i82374_realize() return an error
> > instead of asserting would be even better than setting
> > user_creatable=false.
> > 
> > -- 
> > Eduardo
> > 
> 
> -- 
> Eduardo Otubo
> Senior Software Engineer @ RedHat

-- 
Eduardo
