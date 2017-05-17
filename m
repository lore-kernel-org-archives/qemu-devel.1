Received: from eggs.gnu.org ([2001:4830:134:3::10]:54668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dAprr-0002l9-C5
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApro-0006hj-9Q
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:43:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dAprn-0006gy-VW
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:43:16 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4H3Y5R5026024
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:43:14 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2agcfmdk8t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:43:13 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 17 May 2017 13:43:11 +1000
Date: Wed, 17 May 2017 09:12:15 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1494234377-1773-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494234377-1773-3-git-send-email-bharata@linux.vnet.ibm.com>
	<20170511010220.GE14408@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511010220.GE14408@umbus.fritz.box>
Message-Id: <20170517034215.GA3446@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] spapr: Fix migration of Radix
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

On Thu, May 11, 2017 at 11:02:20AM +1000, David Gibson wrote:
> On Mon, May 08, 2017 at 02:36:17PM +0530, Bharata B Rao wrote:
> > Currently HTAB savevm handlers get registered by default and migration
> > of radix guest will fail.
> > 
> > - Ensure that HTAB savevm handlers are not registered for radix case.
> > - Ensure that we issue KVM_PPC_CONFIGURE_V3_MMU for radix case post
> >   migration.
> > 
> > TODO: Right now I have delayed the HTAB savevm handler registration
> > to CAS call where we know if the guest is radix or hash. Another approach
> > is to let the HTAB handlers to be registered by default (as it is being
> > done currently, but unregister them from CAS when we discover radix
> > capability).
> 
> Option 2 there sounds messy.  I also suspect it could break if you try
> to migrate an (eventually) radix guest before it's done CAS.
> 
> Strictly speaking only registering at CAS time will break old hash
> guests that don't do CAS at all.  However such guests are really,
> really ancient, and I suspect we don't work with them already.
> 
> You do, however, need to deregister (and allow the choice to be made
> again) on guest reset.  On KVM we can only (for now) support either
> hash or radix guests.  Under TCG, however, we could run a radix guest
> then reboot to a hash guest or vice versa.

Took care of this in v1.

> 
> 
> > 
> > Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > ---
> >  hw/ppc/spapr.c         | 18 +++++++++++++++---
> >  hw/ppc/spapr_hcall.c   |  5 +++++
> >  include/hw/ppc/spapr.h |  3 +++
> >  3 files changed, 23 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index e2dc77c..e14f55c 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1436,6 +1436,14 @@ static int spapr_post_load(void *opaque, int version_id)
> >          err = spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
> >      }
> >  
> > +    if (spapr->patb_entry && (spapr->patb_flags & SPAPR_PROC_TABLE_RADIX) &&
> 
> patb_entry already tells you whether the guest is radix or not
> (PATBE1_GR), you shouldn't need extra flags.
> 
> > +        kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
> 
> You should also fail the migration if you have an incoming radix
> guest, but the your new KVM host can't do radix.  Or the reverse, for
> that matter.

I have checks in v1 to fail migration of radix guest to a host that doesn't
support radix. But I don't see how we can detect and fail the migration
of hash guests into hosts that don't support hash from here (i,e., from
spapr_post_load). The hash guest's migration stream would have htab
savevm entries and the target will fail as it knows not about htab
savevm entries.

Regards,
Bharata.
