Received: from eggs.gnu.org ([2001:4830:134:3::10]:38545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dCelW-0004iF-9T
	for qemu-devel@nongnu.org; Mon, 22 May 2017 00:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dCelS-0007ya-BD
	for qemu-devel@nongnu.org; Mon, 22 May 2017 00:16:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57501
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dCelS-0007x0-5p
	for qemu-devel@nongnu.org; Mon, 22 May 2017 00:16:14 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4M48ouN123634
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 00:16:12 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2akkgc8us4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 00:16:12 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Mon, 22 May 2017 14:16:09 +1000
Date: Mon, 22 May 2017 09:45:15 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-5-git-send-email-bharata@linux.vnet.ibm.com>
	<20170519063614.GG3446@in.ibm.com>
	<20170522024448.GL30246@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170522024448.GL30246@umbus.fritz.box>
Message-Id: <20170522041515.GH3446@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/4] spapr: Fix migration of Radix
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com

On Mon, May 22, 2017 at 12:44:48PM +1000, David Gibson wrote:
> On Fri, May 19, 2017 at 12:06:14PM +0530, Bharata B Rao wrote:
> > On Fri, May 19, 2017 at 11:10:39AM +0530, Bharata B Rao wrote:
> > > Fix migration of radix guests by ensuring that we issue
> > > KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
> > > 
> > > Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> > > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > ---
> > >  hw/ppc/spapr.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index daf335c..8f20f14 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1400,6 +1400,18 @@ static int spapr_post_load(void *opaque, int version_id)
> > >          err = spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
> > >      }
> > > 
> > > +    if (spapr->patb_entry) {
> > > +        PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> > > +        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
> > > +            err = kvmppc_configure_v3_mmu(cpu, SPAPR_PROC_TABLE_RADIX,
> > > +                ((cpu->env.spr[SPR_LPCR] & LPCR_GTSE) ? SPAPR_PROC_TABLE_GTSE :
> > > +                0), spapr->patb_entry);
> > 
> > Better to use explicit 'true' and 'false' in the above call. Here is
> > the updated patch:
> 
> Or just !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE) and avoid the ?:
> entirely.
> 
> With this version you no longer need patch 3/4 AFAICT.

Ah yes, will send the updated version next.

Regards,
Bharata.
