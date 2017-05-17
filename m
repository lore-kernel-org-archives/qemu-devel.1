Received: from eggs.gnu.org ([2001:4830:134:3::10]:39766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dAtF3-0001mz-1w
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dAtEu-0003Ih-1h
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:19:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dAtEt-0003I3-OQ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:19:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4H7Ilvo124582
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 03:19:18 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2agfgbebry-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 03:19:18 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 17 May 2017 17:19:15 +1000
Date: Wed, 17 May 2017 12:48:21 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494992962-6929-6-git-send-email-bharata@linux.vnet.ibm.com>
	<20170517065933.GM15596@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517065933.GM15596@umbus.fritz.box>
Message-Id: <20170517071821.GC3446@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 5/6] spapr: Unregister HPT savevm
 handlers for radix guests
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

On Wed, May 17, 2017 at 04:59:33PM +1000, David Gibson wrote:
> On Wed, May 17, 2017 at 09:19:21AM +0530, Bharata B Rao wrote:
> > HPT gets created by default and later when the guest turns out to be
> > a radix guest, the HPT is destroyed when guest does H_REGISTER_PROC_TBL
> > hcall.
> 
> I don't think that's entirely accurate.  At least in some KVM
> configurations, we assume radix first, and only allocate the HPT once
> the guest confirms it is doing hash.

Right, that statement is true for TCG radix guests, will rephrase it.

> 
> > Let HTAB savevm handlers registration and unregistration follow
> > the same model so that we don't end up having unrequired HTAB savevm
> > handlers for radix guests.
> > 
> > This also ensures that HTAB savevm handlers seemlessly get destroyed and
> > recreated like HTAB itself when hash guest reboots.
> > 
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > ---
> >  hw/ppc/spapr.c         | 15 +++++++++++++--
> >  hw/ppc/spapr_hcall.c   |  1 +
> >  include/hw/ppc/spapr.h |  2 ++
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 521eef1..05abfc1 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1237,6 +1237,7 @@ static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
> >  
> >      /* Clean up any HPT info from a previous boot */
> >      spapr_free_hpt(spapr);
> > +    spapr_htab_savevm_unregister(spapr);
> 
> I'd prefer that the unregister be folded into spapr_free_hpt().
> Basically we want calls that create or remove the HPT and handle
> everything - allocation/freeing if necessary, informing KVM if
> necessary, and registering/deregistering the savevm handlers if
> necesary.
> 
> I think that will also remove the need for the trivial
> spapr_htab_savevm_{un,}register() wrappers.

Sure, will consolidate this in the next version.

Regards,
Bharata.
