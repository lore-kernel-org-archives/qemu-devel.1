Received: from eggs.gnu.org ([2001:4830:134:3::10]:37257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ds7aG-0001CK-Jy
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ds7aB-0007CV-I3
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:20:04 -0400
Date: Wed, 13 Sep 2017 14:19:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170913131948.GD2096@work-vm>
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912140149.7692-2-lvivier@redhat.com>
	<20170913053533.GF7550@umbus.fritz.box>
	<20170913124456.GB2096@work-vm>
	<770fc286-a566-920a-9aba-16c3b5264806@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770fc286-a566-920a-9aba-16c3b5264806@redhat.com>
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
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

* Laurent Vivier (lvivier@redhat.com) wrote:
> On 13/09/2017 14:44, Dr. David Alan Gilbert wrote:
> > * David Gibson (david@gibson.dropbear.id.au) wrote:
> >> On Tue, Sep 12, 2017 at 04:01:47PM +0200, Laurent Vivier wrote:
> >>> Running QEMU with
> >>>     qemu-system-ppc64 -M none -nographic -m 256
> >>> and executing
> >>>     dump-guest-memory /dev/null 0 8192
> >>> results in segfault
> >>>
> >>> Fix by checking if we have CPU, and exit with
> >>> error if there is no CPU:
> >>>
> >>>     (qemu) dump-guest-memory /dev/null
> >>>     this feature or command is not currently supported
> >>>
> >>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >>
> >> Applied to ppc-for-2.11.  I'm not really sure what to do with the rest
> >> of the series though.
> > 
> > I can take the whole set through HMP.
> 
> Could you update the comment in last patch as asked by Cornelia?
> (PATCH v3 3/3] tests/hmp: test "none" machine with memory)

Sure, do we understand what the error that patchew caught was?

Dave

> Thanks,
> Laurent
> 
> > 
> > Dave
> > 
> >>> ---
> >>>  target/ppc/arch_dump.c | 11 +++++++++--
> >>>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> >>> index 8e9397aa58..95b9ab6f29 100644
> >>> --- a/target/ppc/arch_dump.c
> >>> +++ b/target/ppc/arch_dump.c
> >>> @@ -224,8 +224,15 @@ typedef struct NoteFuncDescStruct NoteFuncDesc;
> >>>  int cpu_get_dump_info(ArchDumpInfo *info,
> >>>                        const struct GuestPhysBlockList *guest_phys_blocks)
> >>>  {
> >>> -    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> >>> -    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> >>> +    PowerPCCPU *cpu;
> >>> +    PowerPCCPUClass *pcc;
> >>> +
> >>> +    if (first_cpu == NULL) {
> >>> +        return -1;
> >>> +    }
> >>> +
> >>> +    cpu = POWERPC_CPU(first_cpu);
> >>> +    pcc = POWERPC_CPU_GET_CLASS(cpu);
> >>>  
> >>>      info->d_machine = PPC_ELF_MACHINE;
> >>>      info->d_class = ELFCLASS;
> >>
> >> -- 
> >> David Gibson			| I'll have my music baroque, and my code
> >> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> >> 				| _way_ _around_!
> >> http://www.ozlabs.org/~dgibson
> > 
> > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
