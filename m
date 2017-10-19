Received: from eggs.gnu.org ([2001:4830:134:3::10]:50597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e54Ev-0007Vy-Nc
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e54Eq-0005rr-LQ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:23:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1e54Eq-0005qw-C6
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:23:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9J6KLpP129486
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:23:24 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpnjy375e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:23:24 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 02:23:23 -0400
Date: Thu, 19 Oct 2017 14:23:17 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-8-pasic@linux.vnet.ibm.com>
	<9f2bd0fe-1b01-2fce-a6a6-694c4242eb7d@redhat.com>
	<20171018120223.60291cd8.cohuck@redhat.com>
	<067c9d26-b39b-645b-a58e-4f1a96d7258b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <067c9d26-b39b-645b-a58e-4f1a96d7258b@linux.vnet.ibm.com>
Message-Id: <20171019062317.GF4612@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 7/7] s390x: refactor error handling for
 MSCH handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-18 13:01:03 +0200]:

> 
> 
> On 10/18/2017 12:02 PM, Cornelia Huck wrote:
> > On Wed, 18 Oct 2017 12:00:05 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> > 
> >> On 17.10.2017 16:04, Halil Pasic wrote:
> >>> Simplify the error handling of the MSCH.  Let the code detecting the
> >>> condition tell (in a less ambiguous way) how it's to be handled. No
> >>> changes in behavior.  
> >>
> >> ok, so you claim no changes in behavior ...
> >>
> >>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>> ---
> >>>  hw/s390x/css.c         | 18 +++++-------------
> >>>  include/hw/s390x/css.h |  2 +-
> >>>  target/s390x/ioinst.c  | 23 ++++-------------------
> >>>  3 files changed, 10 insertions(+), 33 deletions(-)
> >>>
> >>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >>> index b9e0329825..30fc236946 100644
> >>> --- a/hw/s390x/css.c
> >>> +++ b/hw/s390x/css.c
> >>> @@ -1347,28 +1347,24 @@ static void copy_schib_from_guest(SCHIB *dest, const SCHIB *src)
> >>>      }
> >>>  }
> >>>  
> >>> -int css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
> >>> +IOInstEnding css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
> >>>  {
> >>>      SCSW *s = &sch->curr_status.scsw;
> >>>      PMCW *p = &sch->curr_status.pmcw;
> >>>      uint16_t oldflags;
> >>> -    int ret;
> >>>      SCHIB schib;
> >>>  
> >>>      if (!(sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_DNV)) {
> >>> -        ret = 0;
> >>> -        goto out;
> >>> +        return IOINST_CC_EXPECTED;
> >>>      }
> >>>  
> >>>      if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
> >>> -        ret = -EINPROGRESS;
> >>> -        goto out;
> >>> +        return IOINST_CC_STATUS_PRESENT;
> >>>      }
> >>>  
> >>>      if (s->ctrl &
> >>>          (SCSW_FCTL_START_FUNC|SCSW_FCTL_HALT_FUNC|SCSW_FCTL_CLEAR_FUNC)) {
> >>> -        ret = -EBUSY;
> >>> -        goto out;
> >>> +        return IOINST_CC_STATUS_PRESENT;
> >>>      }  
> >>
> >> ... but here you change -EBUSY (which got mapped to CC=2) to
> >> CC_STATUS_PRESENT which means CC=1. So that's a change in behavior. i.e.
> >> this is either a bug, or you should update the patch description with a
> >> justification for this change in behavior.
> > 
> > Indeed, that's a bug. We still want cc 2.
> > 
> 
> Agree, it is a bug. It was OK in v1 but was already buggy in
> v2.
> 
> Conny can you fix this up as well please?
> 
> Thanks in advance!
> 
I saw Conny fixed this in her branch. So:
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

-- 
Dong Jia Shi
