Received: from eggs.gnu.org ([2001:4830:134:3::10]:59130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dIVnZ-0001r8-L5
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dIVnV-0000we-Na
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:54:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45434
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dIVnV-0000wV-Gx
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:54:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v577sRNK050028
	for <qemu-devel@nongnu.org>; Wed, 7 Jun 2017 03:54:31 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2axd91gn9h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 03:54:31 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 7 Jun 2017 17:54:28 +1000
Date: Wed, 7 Jun 2017 13:23:32 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1496230005-12265-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1496230005-12265-2-git-send-email-bharata@linux.vnet.ibm.com>
	<20170601045448.GB13397@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170601045448.GB13397@umbus.fritz.box>
Message-Id: <20170607075332.GC27525@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] spapr: Add a "no HPT" encoding to
 HTAB migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com

On Thu, Jun 01, 2017 at 02:54:48PM +1000, David Gibson wrote:
> On Wed, May 31, 2017 at 04:56:44PM +0530, Bharata B Rao wrote:
> > Add a "no HPT" encoding (using value -1) to the HTAB migration
> > stream (in the place of HPT size) when the guest doesn't allocate HPT.
> > This will help the target side to match target HPT with the source HPT
> > and thus enable successful migration.
> > 
> > A few more fixes to enable TCG migration to work correctly are also
> > included in this commit:
> > 
> > - HTAB savevm handlers have a few asserts on kvm_enabled() when
> >   spapr->htab != 0. Convert these into conditional checks as it is now
> >   possible to have no HTAB with TCG radix guests.
> > - htab_save_setup() asserts for kvm_enabled() when spapr->htab != 0.
> >   Remove this as we can't assert this for TCG radix guests.
> > 
> > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> >               [no HPT encoding suggestion]
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> 
> Looks basically ok, but there are still some details to address.
> 
> > ---
> >  hw/ppc/spapr.c | 31 +++++++++++++++++--------------
> >  1 file changed, 17 insertions(+), 14 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index ab3aab1..b589ed4 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1559,17 +1559,18 @@ static int htab_save_setup(QEMUFile *f, void *opaque)
> >  {
> >      sPAPRMachineState *spapr = opaque;
> >  
> > -    /* "Iteration" header */
> > -    qemu_put_be32(f, spapr->htab_shift);
> > +    /* "Iteration" header: no-HPT or HPT size encoding */
> > +    if (!spapr->htab_shift) {
> > +        qemu_put_be32(f, -1);
> 
> We're already using htab_shift == 0 to represent no HPT in the runtime
> structure; we might as well do the same on the wire.  As a bonus it
> slightly simplifies the logic here.

Non-zero value of iteration header (which is htab_shift) results in
htab_load() at the target to reallocate HTAB.

zero value of iteration header is used by htab_save_iterate() and
htab_save_complete() to tell htab_load() not to freshly allocate HTAB
at the target.

Hence we can't use 0 value to mean no-HPT.

I have addressed the rest of the comments on asserts by ensuring that
those code paths are taken only when HPT is present. v5 has those
changes.

Regards,
Bharata.
