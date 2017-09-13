Received: from eggs.gnu.org ([2001:4830:134:3::10]:49525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ds72Z-0005lm-RB
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ds72T-0000QQ-Vv
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:45:15 -0400
Date: Wed, 13 Sep 2017 13:44:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170913124456.GB2096@work-vm>
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912140149.7692-2-lvivier@redhat.com>
	<20170913053533.GF7550@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913053533.GF7550@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hmp: fix "dump-quest-memory"
 segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

* David Gibson (david@gibson.dropbear.id.au) wrote:
> On Tue, Sep 12, 2017 at 04:01:47PM +0200, Laurent Vivier wrote:
> > Running QEMU with
> >     qemu-system-ppc64 -M none -nographic -m 256
> > and executing
> >     dump-guest-memory /dev/null 0 8192
> > results in segfault
> > 
> > Fix by checking if we have CPU, and exit with
> > error if there is no CPU:
> > 
> >     (qemu) dump-guest-memory /dev/null
> >     this feature or command is not currently supported
> > 
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> Applied to ppc-for-2.11.  I'm not really sure what to do with the rest
> of the series though.

I can take the whole set through HMP.

Dave

> > ---
> >  target/ppc/arch_dump.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> > index 8e9397aa58..95b9ab6f29 100644
> > --- a/target/ppc/arch_dump.c
> > +++ b/target/ppc/arch_dump.c
> > @@ -224,8 +224,15 @@ typedef struct NoteFuncDescStruct NoteFuncDesc;
> >  int cpu_get_dump_info(ArchDumpInfo *info,
> >                        const struct GuestPhysBlockList *guest_phys_blocks)
> >  {
> > -    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> > -    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> > +    PowerPCCPU *cpu;
> > +    PowerPCCPUClass *pcc;
> > +
> > +    if (first_cpu == NULL) {
> > +        return -1;
> > +    }
> > +
> > +    cpu = POWERPC_CPU(first_cpu);
> > +    pcc = POWERPC_CPU_GET_CLASS(cpu);
> >  
> >      info->d_machine = PPC_ELF_MACHINE;
> >      info->d_class = ELFCLASS;
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
