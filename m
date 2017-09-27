Received: from eggs.gnu.org ([2001:4830:134:3::10]:37848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dx7TE-0006js-0i
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dx7T9-0001pl-Mi
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:13:27 -0400
Date: Wed, 27 Sep 2017 10:13:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170927101319.1e7cfd8a@nial.brq.redhat.com>
In-Reply-To: <20170927062143.GN12504@umbus>
References: <150633285374.14880.11614678065344980502.stgit@bahia.lan>
	<20170926025739.GF12504@umbus> <20170926091928.50e115ff@bahia.lan>
	<20170927062143.GN12504@umbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: move registration of "host" CPU
 core type to machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

On Wed, 27 Sep 2017 16:21:43 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Sep 26, 2017 at 09:19:28AM +0200, Greg Kurz wrote:
> > On Tue, 26 Sep 2017 12:57:39 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >   
> > > On Mon, Sep 25, 2017 at 11:47:33AM +0200, Greg Kurz wrote:  
> > > > The CPU core abstraction belongs to the machine code. This also gets
> > > > rid of some code duplication.
> > > > 
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > > 
> > > > hw/ppc/spapr_cpu_core.h is also included elsewhere in target/ppc/kvm.c
> > > > but this is already handled by the following cleanup patch:    
> > > 
> > > I don't really see what the advantage of this is.  As others have
> > > pointed out it leads to the host type being registered very late,
> > > which could cause problems.
> > >   
> > 
> > Well, the goal was to consolidate the code to register sPAPRCPUCore types in
> > the spapr code, instead of open-coding it in spapr_cpu_core.c and kvm.c... 
> > 
> > But now I realize that delaying the registration even more is a bad idea. And,
> > the other way round, registering a static type earlier as asked by Igor would
> > require all parent types to be already registered, which seems to be impossible
> > to guarantee with the current code.
> > 
> > Maybe we could at least have kvm_ppc_register_host_cpu_type() to call a
> > function in spapr_cpu_core.c instead of duplicating the registration
> > code ?  
> 
> I think that sounds like a better idea.  It's still a little bodgy
> with the abstraction boundaries, but I think that's unavoidable: this
> fundamentally depends on both KVM's presence and use of the PAPR
> machine type.  Whichever place we put it, you could argue it belongs
> better in the other one.
it looks like kvm_ppc_register_host_cpu_type() doesn't depend on
anything that requires KVM being present/initialized, so I'd
suggest to:

  - 1: revert commit 715d4b96 and do alias hiding another way
  - 2: move host core type registration into spapr_cpu_core.c and make it static like x86
  - 3: move host cpu type into target/ppc/translate_init.c where the rest
       of cpu types is initialized and make it static like x86
