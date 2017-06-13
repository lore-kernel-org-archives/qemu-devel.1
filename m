Received: from eggs.gnu.org ([2001:4830:134:3::10]:46372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dKdko-0000nG-Nf
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 00:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dKdkk-0004c6-QK
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 00:48:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53882
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dKdkk-0004bm-Jq
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 00:48:30 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5D4i7dr106787
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 00:48:29 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2b28ta9dfq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 00:48:29 -0400
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 13 Jun 2017 14:48:26 +1000
Date: Tue, 13 Jun 2017 10:18:18 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1497245555-32472-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1497245555-32472-2-git-send-email-bharata@linux.vnet.ibm.com>
	<20170612091044.GE18542@umbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170612091044.GE18542@umbus>
Message-Id: <20170613044818.GE27525@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/2] spapr: Add a "no HPT" encoding to
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

On Mon, Jun 12, 2017 at 05:10:44PM +0800, David Gibson wrote:
> On Mon, Jun 12, 2017 at 11:02:34AM +0530, Bharata B Rao wrote:
> > Add a "no HPT" encoding (using value -1) to the HTAB migration
> > stream (in the place of HPT size) when the guest doesn't allocate HPT.
> > This will help the target side to match target HPT with the source HPT
> > and thus enable successful migration.
> > 
> > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > ---
> >  hw/ppc/spapr.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 8b541d9..c425499 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1558,13 +1558,19 @@ static int htab_save_setup(QEMUFile *f, void *opaque)
> >      sPAPRMachineState *spapr = opaque;
> >  
> >      /* "Iteration" header */
> > -    qemu_put_be32(f, spapr->htab_shift);
> > +    if (!spapr->htab_shift) {
> > +        qemu_put_be32(f, -1);
> > +    } else {
> > +        qemu_put_be32(f, spapr->htab_shift);
> > +    }
> >  
> >      if (spapr->htab) {
> >          spapr->htab_save_index = 0;
> >          spapr->htab_first_pass = true;
> >      } else {
> > -        assert(kvm_enabled());
> > +        if (spapr->htab_shift) {
> > +            assert(kvm_enabled());
> > +        }
> >      }
> >  
> >  
> > @@ -1710,7 +1716,12 @@ static int htab_save_iterate(QEMUFile *f, void *opaque)
> >      int rc = 0;
> >  
> >      /* Iteration header */
> > -    qemu_put_be32(f, 0);
> > +    if (!spapr->htab_shift) {
> > +        qemu_put_be32(f, -1);
> > +        return 0;
> > +    } else {
> > +        qemu_put_be32(f, 0);
> > +    }
> >  
> >      if (!spapr->htab) {
> >          assert(kvm_enabled());
> > @@ -1744,7 +1755,12 @@ static int htab_save_complete(QEMUFile *f, void *opaque)
> >      int fd;
> >  
> >      /* Iteration header */
> > -    qemu_put_be32(f, 0);
> > +    if (!spapr->htab_shift) {
> > +        qemu_put_be32(f, -1);
> > +        return 0;
> > +    } else {
> > +        qemu_put_be32(f, 0);
> > +    }
> 
> Do you actually need the modifications for _iterate and _complete?  I
> would have thought you just wouldn't need to send any more of the HPT
> stream at all after sending the -1 header.  

_setup, _iterate, _complete handler routines for HTAB always get interspersed
with similar routines for ram savevm handlers as per what I have seen.
And moreover these are called by the core migration code and hence we they get
called, we need these changes to ensure that we don't attempt to send HPT
stream.

> 
> We should also adjust the downtime estimation logic so we don't allow
> for transferring an HPT that isn't there.

I will have to check that out.

> 
> >      if (!spapr->htab) {
> >          int rc;
> > @@ -1788,6 +1804,11 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
> >  
> >      section_hdr = qemu_get_be32(f);
> >  
> > +    if (section_hdr == -1) {
> > +        spapr_free_hpt(spapr);
> > +        return 0;
> > +    }
> 
> Strictly speaking we probably shouldn't just return here.  We should
> wait and see if there is more data in the stream.

Because of the way the source sends data (with HPT data getting
interspersed with ram data, I don't think we can say for sure if
we got or will get any HPT data following the no-HPT indication.

> Any actual content
> (i.e. section_hdr == 0 sections) would be an error at this point.
> However, a reset to an HPT guest would be represented by a new
> non-zero section header, then more data.  This isn't urgent, but it
> would be nice to fix at some point.

Sure.

Regards,
Bharata.
