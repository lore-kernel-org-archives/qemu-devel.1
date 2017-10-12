Received: from eggs.gnu.org ([2001:4830:134:3::10]:46146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e2WIq-0005Wq-B4
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e2WIn-0003rf-8G
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:45:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1e2WIm-0003qi-Vn
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:45:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9C5iYqs005743
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 01:44:55 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dj18133ff-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 01:44:55 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 11 Oct 2017 23:44:54 -0600
Date: Thu, 12 Oct 2017 13:44:50 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-4-pasic@linux.vnet.ibm.com>
	<20171011034756.GC4754@bjsdjshi@linux.vnet.ibm.com>
	<99b11584-bc55-acef-bb39-dca4c7cb3833@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b11584-bc55-acef-bb39-dca4c7cb3833@linux.vnet.ibm.com>
Message-Id: <20171012054450.GC29193@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/8] s390x: improve error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-11 12:54:51 +0200]:

> 
> 
> On 10/11/2017 05:47 AM, Dong Jia Shi wrote:
> > * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-04 17:41:39 +0200]:
> > 
> >> Simplify the error handling of the SSCH and RSCH handler avoiding
> >> arbitrary and cryptic error codes being used to tell how the instruction
> >> is supposed to end.  Let the code detecting the condition tell how it's
> >> to be handled in a less ambiguous way.  It's best to handle SSCH and RSCH
> >> in one go as the emulation of the two shares a lot of code.
> >>
> >> For passthrough this change isn't pure refactoring, but changes the
> >> way kernel reported EFAULT is handled. After clarifying the kernel
> >> interface we decided that EFAULT shall be mapped to unit exception.
> >> Same goes for unexpected error codes.
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >> ---
> >>
> >> AFAIR we decided in the previous round to rather do transformation
> >> and fixing in one patch than touch stuff twice. Hence this patch
> >> ain't pure transformation any more.
> >> ---
> >>  hw/s390x/css.c              | 83 +++++++++++++--------------------------------
> >>  hw/s390x/s390-ccw.c         | 11 +++---
> >>  hw/vfio/ccw.c               | 30 ++++++++++++----
> >>  include/hw/s390x/css.h      | 24 +++++++++----
> >>  include/hw/s390x/s390-ccw.h |  2 +-
> >>  target/s390x/ioinst.c       | 53 ++++-------------------------
> >>  6 files changed, 77 insertions(+), 126 deletions(-)
> >>
> >> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >> index 4f47dbc8b0..b2978c3bae 100644
> >> --- a/hw/s390x/css.c
> >> +++ b/hw/s390x/css.c
> >> @@ -1003,12 +1003,11 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
> >>
> >>  }
> >>
> >> -static int sch_handle_start_func_passthrough(SubchDev *sch)
> >> +static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
> >>  {
> >>
> >>      PMCW *p = &sch->curr_status.pmcw;
> >>      SCSW *s = &sch->curr_status.scsw;
> >> -    int ret;
> >>
> >>      ORB *orb = &sch->orb;
> >>      if (!(s->ctrl & SCSW_ACTL_SUSP)) {
> >> @@ -1022,31 +1021,11 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
> >>       */
> >>      if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
> >>          !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
> >> -        return -EINVAL;
> >> +        sch_gen_unit_exception(sch);
> >> +        css_inject_io_interrupt(sch);
> >> +        return (IOInstEnding){.cc = 0};
> > This behavior change is not mentioned in the commit message. Right?
> > 
> No this particular change is not. Should I mention it explicitly?
I think so.

> Maybe "Same goes for unexpected error codes and absence of required
> ORB flags."
Sounds good for me.

[...]

-- 
Dong Jia Shi
