Received: from eggs.gnu.org ([2001:4830:134:3::10]:59174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1elC1J-0000JT-9k
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 06:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1elC1F-0001NI-V8
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 06:11:37 -0500
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:49547)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1elC1F-0001Ln-Or
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 06:11:33 -0500
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 09B9CA192F
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 12:11:31 +0100 (CET)
Date: Mon, 12 Feb 2018 12:11:27 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180212120830.38b1470e@bahia.lan>
In-Reply-To: <20180210092307.GQ11634@umbus.fritz.box>
References: <20180209081858.27013-1-lvivier@redhat.com>
	<20180209150649.7f557ff9@bahia.lan>
	<20180210092307.GQ11634@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] spapr: set vsmt to MAX(8, smp_threads)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Sat, 10 Feb 2018 20:23:07 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Feb 09, 2018 at 03:06:49PM +0100, Greg Kurz wrote:
> > On Fri,  9 Feb 2018 09:18:58 +0100
> > Laurent Vivier <lvivier@redhat.com> wrote:
> >   
> > > We ignore silently the value of smp_threads when we set
> > > the default VSMT value, and if smp_threads is greater than VSMT
> > > kernel is going into trouble later.
> > >   
> > 
> > Hi Laurent,
> > 
> > I've looked a bit more and I'm not sure what kernel troubles you're referring to,
> > but several places in QEMU where we use kvm_ppc_smt() later on do assume that
> > smp_threads > kvm_ppc_smt(). Basically, everywhere we compute a vCPU id:
> > 
> > In spapr_init_cpus() when creating DRC connectors:
> > 
> >         int core_id = i * smp_threads;
> > 
> >         if (mc->has_hotpluggable_cpus) {
> >             spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
> >                                    (core_id / smp_threads) * smt);
> >         }
> > 
> > or in spapr_cpu_core_realize() when creating vCPUs:
> > 
> >         cpu->vcpu_id = (cc->core_id * spapr->vsmt / smp_threads) + i;
> > 
> > It is visible by adding some printfs in the current code base. This is what
> > happens when passing -smp cores=2,threads=16 without your patch:
> > 
> > DRC connector to vcpu_id 0
> > CPU vcpu_id 0
> > CPU vcpu_id 1
> > CPU vcpu_id 2
> > CPU vcpu_id 3
> > CPU vcpu_id 4
> > CPU vcpu_id 5
> > CPU vcpu_id 6
> > CPU vcpu_id 7
> > CPU vcpu_id 8
> > CPU vcpu_id 9
> > CPU vcpu_id 10
> > CPU vcpu_id 11
> > CPU vcpu_id 12
> > CPU vcpu_id 13
> > CPU vcpu_id 14
> > CPU vcpu_id 15
> > DRC connector to vcpu_id 8
> >                         ^^^
> >                      should be 16
> > CPU vcpu_id 8
> >            ^^^
> >    should start numbering at 16
> > CPU vcpu_id 9
> > CPU vcpu_id 10
> > CPU vcpu_id 11
> > CPU vcpu_id 12
> > CPU vcpu_id 13
> > CPU vcpu_id 14
> > CPU vcpu_id 15
> > CPU vcpu_id 16
> > CPU vcpu_id 17
> > CPU vcpu_id 18
> > CPU vcpu_id 19
> > CPU vcpu_id 20
> > CPU vcpu_id 21
> > CPU vcpu_id 22
> > CPU vcpu_id 23
> > qemu-system-ppc64: kvm_init_vcpu failed: File exists
> >                                               ^^^^
> >                                  CPU 8 already created by the first core
> > 
> > I'm not feeling comfortable with the rest of the code silently depending on
> > the fact that spapr_set_vsmt_mode() terminates QEMU if it cannot enforce
> > smp_threads <= kvm_ppc_smt().  
> 
> I'm not quite sure what you're suggesting as an alternative, though.
> 

I haven't suggested anything yet :)

But I was thinking of:
- having a single function to compute the vcpu_id, instead of open-coding
  the formula in several places like the current code does,
- this function should ensure all pre-requisites to compute the vcpu_id are
  met (including trying to set VSMT) or return an error

> > 
> > Anyway, with your patch, the same command line as above gives:
> > 
> > qemu-system-ppc64: Failed to set KVM's VSMT mode to 16 (errno -22)
> > On PPC, a VM with 16 threads/core on a host with 8 threads/core requires
> >  the use of VSMT mode 16.
> > This KVM seems to be too old to support VSMT.
> > 
> > This hammer is big enough to fix the vCPU ids miscalculations, so:
> > 
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >   
> > > Fixes: 8904e5a750
> > > ("spapr: Adjust default VSMT value for better migration compatibility")
> > > 
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > ---
> > > 
> > > Notes:
> > >     v3: use MAX(8, smp_threads) and let KVM to return an error
> > >         if nb_threads is too big
> > >         update subject to reflect the change
> > >     
> > >     v2: display a specific error message when the default VSMT is used
> > >         fix subject
> > > 
> > >  hw/ppc/spapr.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 32a876be56..c8a1eefa17 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2310,7 +2310,7 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
> > >           * the value that we'd get with KVM on POWER8, the
> > >           * overwhelmingly common case in production systems.
> > >           */
> > > -        spapr->vsmt = 8;
> > > +        spapr->vsmt = MAX(8, smp_threads);
> > >      }
> > >  
> > >      /* KVM: If necessary, set the SMT mode: */  
> >   
> 
