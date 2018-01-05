Received: from eggs.gnu.org ([2001:4830:134:3::10]:49651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sathnaga@linux.vnet.ibm.com>) id 1eXRRU-0003oY-Ol
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sathnaga@linux.vnet.ibm.com>) id 1eXRRR-0000cC-LL
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:49:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54452
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sathnaga@linux.vnet.ibm.com>)
	id 1eXRRR-0000bc-Ee
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:49:45 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w05CmuCs124610
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 07:49:44 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fa8da3cbe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 07:49:43 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sathnaga@linux.vnet.ibm.com>;
	Fri, 5 Jan 2018 05:49:43 -0700
Date: Fri, 5 Jan 2018 18:19:31 +0530
From: satheesh rajendran <sathnaga@linux.vnet.ibm.com>
References: <20180105033806.14678-1-david@gibson.dropbear.id.au>
	<20180105121914.43064fe3@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105121914.43064fe3@bahia.lan>
Message-Id: <20180105124931.GA15610@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCHv2] spapr: Correct compatibility mode
 setting for hotplugged CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, surajjs@au1.ibm.com, satheera@in.ibm.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

On Fri, Jan 05, 2018 at 12:19:14PM +0100, Greg Kurz wrote:
> On Fri,  5 Jan 2018 14:38:06 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > Currently the pseries machine sets the compatibility mode for the
> > guest's cpus in two places: 1) at machine reset and 2) after CAS
> > negotiation.
> > 
> > This means that if we set or negotiate a compatiblity mode, then
> > hotplug a cpu, the hotplugged cpu doesn't get the right mode set and
> > will incorrectly have the full native features.
> > 
> > To correct this, we set the compatibility mode on a cpu when it is
> > brought online with the 'start-cpu' RTAS call.  Given that we no
> > longer need to set the compatibility mode on all CPUs at machine
> > reset, so we change that to only set the mode for the boot cpu.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---

Tested in upstream with this patch and found fixed.
./ppc64-softmmu/qemu-system-ppc64 -M pseries,max-cpu-compat=power8,accel=kvm \
                                  -smp 1,cores=1,threads=1,sockets=1,maxcpus=2 \
                                  -m 2048 -nographic -enable-kvm /home/sath/images/hostos-ppc64le.qcow2 \
                                  -monitor stdio -serial /dev/pts/7
QEMU 2.11.50 monitor - type 'help' for more information
(qemu) device_add host-spapr-cpu-core,id=core1,core-id=1
(qemu) 

inside guest:
# taskset -c 1 ./a.out 
Illegal instruction


Reported-and-tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Regards,
-Satheesh


> > 
> > Changes since v1:
> >  * Add an error_report_err() to display and free the error from
> >    ppc_set_compat() in rtas_start_cpu().
> >  
> 
> It looks like this change wasn't committed when git-send-email was
> invoked, and you missed Daniel's comment (typo in commit message)
> and R-b...
> 
> > 
> >  hw/ppc/spapr.c      | 2 +-
> >  hw/ppc/spapr_rtas.c | 8 ++++++++
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index e22888ba06..d1acfe8858 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1510,7 +1510,7 @@ static void spapr_machine_reset(void)
> >          spapr_ovec_cleanup(spapr->ov5_cas);
> >          spapr->ov5_cas = spapr_ovec_new();
> >  
> > -        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
> > +        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fatal);
> >      }
> >  
> >      fdt = spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index 4bb939d3d1..2ed00548c1 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -163,6 +163,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
> >          CPUState *cs = CPU(cpu);
> >          CPUPPCState *env = &cpu->env;
> >          PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> > +        Error *local_err = NULL;
> >  
> >          if (!cs->halted) {
> >              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > @@ -174,6 +175,13 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
> >           * new cpu enters */
> >          kvm_cpu_synchronize_state(cs);
> >  
> > +        /* Set compatibility mode to match existing cpus */
> > +        ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &local_err);
> > +        if (local_err) {
> 
> With a call to error_report_err() here, you can add:
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> > +            rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > +            return;
> > +        }
> > +
> >          env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
> >  
> >          /* Enable Power-saving mode Exit Cause exceptions for the new CPU */
> 
> 
