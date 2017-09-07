Received: from eggs.gnu.org ([2001:4830:134:3::10]:39634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dpsKi-0005HQ-KW
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dpsKd-0006Cu-LN
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:38:44 -0400
Date: Thu, 7 Sep 2017 10:38:29 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20170907083829.GB2441@vader>
References: <20170901110332.32650-1-otubo@redhat.com>
	<20170901143016.GK7570@localhost.localdomain>
	<87lglyzb3p.fsf@dusky.pond.sub.org>
	<20170901154430.GN7570@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170901154430.GN7570@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, mst@redhat.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>

On Fri, Sep 01, 2017 at 12:44:30PM -0300, Eduardo Habkost wrote:
> On Fri, Sep 01, 2017 at 05:34:34PM +0200, Markus Armbruster wrote:
> > Eduardo Habkost <ehabkost@redhat.com> writes:
> > 
> > > i82374 is compiled in only on ppc and sh4, so I'm CCing the
> > > maintainers for those architectures.
> > >
> > > On Fri, Sep 01, 2017 at 01:03:32PM +0200, Eduardo Otubo wrote:
> > >> When used with the following command line:
> > >> 
> > >>  ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=tcg -device i82374
> > >> 
> > >> QEMU with machine type 40p already creates the device i82374. If
> > >> specified in the command line, it will try to create it again, hence
> > >> generating the error.

Well pointed, forgot to describe the actual error. I may inlcude for
the next version of the patch. For for correctness sake, here it is:

 ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=tcg -device i82374
 qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!bus->dma[0] && !bus->dma[1]' failed.
 Aborted (core dumped)

> > >
> > > Which error?
> > >
> > >
> > >>                       One way to avoid this problem is to set
> > >> user_creatable=false.
> > >> 
> > >> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> > >
> > > The patch does more than just avoiding double creation: it
> > > prevents usage of "-device i82374" completely.
> > >
> > > Maybe nobody needs it to work with -device today (would the
> > > device even work?) and it is OK to set user_creatable=false until
> > > we fix the crash.  But we need to be sure of that.
> > >
> > >> ---
> > >>  hw/dma/i82374.c | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >> 
> > >> diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
> > >> index 6c0f975df0..5275d822e0 100644
> > >> --- a/hw/dma/i82374.c
> > >> +++ b/hw/dma/i82374.c
> > >> @@ -139,6 +139,7 @@ static void i82374_class_init(ObjectClass *klass, void *data)
> > >>      dc->realize = i82374_realize;
> > >>      dc->vmsd = &vmstate_i82374;
> > >>      dc->props = i82374_properties;
> > >> +    dc->user_creatable = false;
> > >
> > > A "Reason:" comment explaining why user_creatable=false is
> > > mandatory.  See the comment above user_creatable declaration in
> > > qdev-core.h for reference.
> > >
> > > I suggest the following:
> > >
> > >     /*
> > >      * Reason: i82374_realize() crashes (assertion failure inside isa_bus_dma()
> > >      *         if the device is instantiated twice.
> > >      */

I agree with the comment above. If there's nothing left to fix/add
I'll just send a v2 for this shortly.

> > 
> > We need to find out *why* it crashes.  Once we know, we can likely write
> > a better comment.
> 
> It crashes because isa_bus_dma() isn't supposed to be called
> twice for the same bus.
> 
> Making isa_bus_dma()/DMA_init()/i82374_realize() return an error
> instead of asserting would be even better than setting
> user_creatable=false.
> 
> -- 
> Eduardo
> 

-- 
Eduardo Otubo
Senior Software Engineer @ RedHat
