Received: from eggs.gnu.org ([2001:4830:134:3::10]:35807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e285m-0006GZ-Gz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 23:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e285j-0000w2-74
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 23:53:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54930
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1e285j-0000vf-1V
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 23:53:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9B3rpuO125794
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 23:53:51 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dh2gs05as-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 23:53:51 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 21:53:48 -0600
Date: Wed, 11 Oct 2017 11:53:45 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-4-pasic@linux.vnet.ibm.com>
	<20171010081310.GA4754@bjsdjshi@linux.vnet.ibm.com>
	<e2f89019-2def-c0bc-960c-9c7d06de30ec@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2f89019-2def-c0bc-960c-9c7d06de30ec@linux.vnet.ibm.com>
Message-Id: <20171011035345.GE5350@bjsdjshi@linux.vnet.ibm.com>
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

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-10 12:06:23 +0200]:

> 
> 
> On 10/10/2017 10:13 AM, Dong Jia Shi wrote:
> > * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-04 17:41:39 +0200]:
> > 
> > [...]
> > 
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
> > Last cycle, we agreed to add some log here. Sth. like:
> > warn_report("vfio-ccw requires PFCH and C64 flags set...");
> > 
> > I promised to do a fix for this piece of code. But since this patch
> > already fixed it, I guess what I have to do is to add the log only? Or
> > you would like to add it by yourself? ;)
> > 
> 
> I think I forgot this one. Should there be a v3 I could add this too.
> Otherwise I would not mind if you do it on top.
> 
[...]

> >> @@ -1084,16 +1063,15 @@ int do_subchannel_work_passthrough(SubchDev *sch)
> >>          /* TODO: Halt handling */
> >>          sch_handle_halt_func(sch);
> >>      } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
> >> -        ret = sch_handle_start_func_passthrough(sch);
> >> +        return sch_handle_start_func_passthrough(sch);
> >>      }
> >> -
> >> -    return ret;
> >> +    return (IOInstEnding){.cc = 0};
> >>  }
> >>
> >> -static int do_subchannel_work(SubchDev *sch)
> >> +static IOInstEnding do_subchannel_work(SubchDev *sch)
> >>  {
> >>      if (!sch->do_subchannel_work) {
> >> -        return -EINVAL;
> >> +        return (IOInstEnding){.cc = 1};
> > This keeps the logic here as-is, so it is right.
> > 
> 
> Yep.
> 
> > Anybody agrees that also adding an assert() here?
> 
> With automated regression testing in place I'm for it, without
> I feel uncomfortable doing it myself. You could do this
> on top if you like.
Got it.

Marked. I will look back after this series.

[...]

> 
> Except for the missing warning are you OK with the rest
> of the patch? I would like to re-claim your r-b (dropped
> because changes weren't just minor).

I replied to the patch thread - the main part looks good to me.

I will save my r-b for the next round. ;)

-- 
Dong Jia Shi
