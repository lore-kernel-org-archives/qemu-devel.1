Received: from eggs.gnu.org ([2001:4830:134:3::10]:34926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dVUkf-0007n5-T1
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 23:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dVUka-00061A-Th
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 23:25:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dVUka-0005zs-J8
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 23:25:12 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6D3NZHY069371
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 23:25:09 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3wvyn1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 23:25:09 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 13:25:06 +1000
Date: Thu, 13 Jul 2017 08:54:58 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <149985291912.20899.12562819149683053534.stgit@bahia.lan>
	<20170712102237.GB5377@in.ibm.com>
	<20170712131130.05a248cd@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712131130.05a248cd@bahia.lan>
Message-Id: <20170713032458.GC5377@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix potential memory leak in
 spapr_core_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, Jul 12, 2017 at 01:11:30PM +0200, Greg Kurz wrote:
> On Wed, 12 Jul 2017 15:52:37 +0530
> Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> 
> > On Wed, Jul 12, 2017 at 11:48:39AM +0200, Greg Kurz wrote:
> > > Since commit 5c1da81215c7 ("spapr: Remove unnecessary differences between
> > > hotplug and coldplug paths"), the CPU DT for the DRC is always allocated.
> > > This causes a memory leak for pseries-2.6 and older machine types, that
> > > don't support CPU hotplug and don't allocate DRCs for CPUs.
> > > 
> > > Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/ppc/spapr.c |    9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 12b3f099d4c9..4a480e1c1dd9 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2993,8 +2993,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> > >      CPUState *cs = CPU(core->threads);
> > >      sPAPRDRConnector *drc;
> > >      Error *local_err = NULL;
> > > -    void *fdt = NULL;
> > > -    int fdt_offset = 0;
> > >      int smt = kvmppc_smt_threads();
> > >      CPUArchId *core_slot;
> > >      int index;
> > > @@ -3009,9 +3007,12 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> > > 
> > >      g_assert(drc || !mc->has_hotpluggable_cpus);
> > > 
> > > -    fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> > > -
> > >      if (drc) {
> > > +        void *fdt;
> > > +        int fdt_offset;
> > > +
> > > +        fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> > > +
> > >          spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> > >          if (local_err) {
> > >              g_free(fdt);  
> > 
> > You say this in the patch description already, but want to note explicitly
> > that this prevents double allocation for pseries-2.6 and ealier types and
> > not for newer machine types.
> > 
> 
> This DT node doesn't have the exact same use as the one allocated in
> spapr_populate_cpus_dt_node(). Here, it is needed by the DRC logic:

What I mean to say is that even after this fix, for machines types > 2.6, we
still allocate memory for FDT and go through the code that creates DT entries
for CPUs twice. What we create via spapr_populate_cpus_dt_node() is used
while the CPU DT entries created by spapr_populate_hotplug_cpu_dt() won't
be used and corresponding drc->fdt is never freed, afaics for boot time
and cold-plugged CPUs.

May be this can be fixed during DT code reorg effort that David is
planning.

Regards,
Bharata.
