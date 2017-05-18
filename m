Received: from eggs.gnu.org ([2001:4830:134:3::10]:39439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dBDbc-0007qV-Op
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dBDbZ-0000ZT-Jl
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:04:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57233
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dBDbZ-0000ZI-Dx
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:04:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4I4wuo3058365
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 01:04:04 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2agyb24d37-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 01:04:04 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 18 May 2017 15:03:59 +1000
Date: Thu, 18 May 2017 10:33:05 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494992962-6929-7-git-send-email-bharata@linux.vnet.ibm.com>
	<20170517070049.GN15596@umbus.fritz.box>
	<20170517071539.GB3446@in.ibm.com>
	<20170517072031.GO15596@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517072031.GO15596@umbus.fritz.box>
Message-Id: <20170518050305.GF3446@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 6/6] spapr: Fix migration of Radix
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

On Wed, May 17, 2017 at 05:20:31PM +1000, David Gibson wrote:
> On Wed, May 17, 2017 at 12:45:39PM +0530, Bharata B Rao wrote:
> > On Wed, May 17, 2017 at 05:00:49PM +1000, David Gibson wrote:
> > > On Wed, May 17, 2017 at 09:19:22AM +0530, Bharata B Rao wrote:
> > > > Fix migration of radix guests by ensuring that we issue
> > > > KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
> > > > 
> > > > Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> > > > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > > ---
> > > >  hw/ppc/spapr.c         | 15 +++++++++++++++
> > > >  hw/ppc/spapr_hcall.c   |  1 +
> > > >  include/hw/ppc/spapr.h |  1 +
> > > >  3 files changed, 17 insertions(+)
> > > > 
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 05abfc1..dd1d687 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -1443,6 +1443,20 @@ static int spapr_post_load(void *opaque, int version_id)
> > > >          err = spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
> > > >      }
> > > >  
> > > > +    if (spapr->patb_entry) {
> > > > +        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
> > > > +            err = kvmppc_configure_v3_mmu(POWERPC_CPU(first_cpu),
> > > > +                                          spapr->patb_flags &
> > > > +                                          SPAPR_PROC_TABLE_RADIX,
> > > > +                                          spapr->patb_flags &
> > > > +                                          SPAPR_PROC_TABLE_GTSE,
> > > 
> > > You should be able to work out the things you need here from
> > > patb_entry without adding the new patb_flags field.
> > 
> > kvmppc_configure_v3_mmu() needs two bools: radix and gtse. The radix
> > bit can be implied from patb_entry, I needed patb_flags to get the
> > gtse value. Not immediately obvious of how to get gtse bit from patb_entry,
> > but let me take a relook.
> 
> Oh, sorry, you can't get GTSE from the patb_entry, but you can get it
> from the LPCR.

So I need to get GTSE from LPCR at the target after the LPCR has been updated
from the incoming stream (via vmstate_ppc_cpu vmsd). However we are also
in the middle of processing the incoming stream here (via spapr_post_load).
Can we be sure that spapr_post_load() processing happens after all
SPRs (and hence LPCR) have been updated via vmstate_ppc_cpu vmsd handlers ?

Also, in addition to issuing KVM_PPC_CONFIGURE_V3_MMU, should we be
walking all the CPUs and setting the LPCR_UPRT and LPCR_GTSE bits like how
H_REGISTER_PROC_TBL does ?

Regards,
Bharata.
