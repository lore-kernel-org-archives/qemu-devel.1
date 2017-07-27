Received: from eggs.gnu.org ([2001:4830:134:3::10]:40484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1daXDZ-0003gK-R4
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1daXDW-0005Aa-LH
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:03:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50795
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1daXDW-0005AE-Fj
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:03:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6R13rgk028880
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 21:03:53 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2by2jwg7sy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 21:03:53 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 26 Jul 2017 21:03:52 -0400
Date: Thu, 27 Jul 2017 09:03:46 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
	<20170725224442.13383-2-pasic@linux.vnet.ibm.com>
	<20170726033121.GP7483@bjsdjshi@linux.vnet.ibm.com>
	<af44463e-9a90-d769-32d7-53e43852cb89@linux.vnet.ibm.com>
	<7067811a-825b-adbb-78a9-5d06083f50ec@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7067811a-825b-adbb-78a9-5d06083f50ec@linux.vnet.ibm.com>
Message-Id: <20170727010346.GT7483@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/css: check ccw address validity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-07-26 18:45:34 +0200]:

[...]

> >>> @@ -946,6 +953,17 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
> >>>          suspend_allowed = true;
> >>>      }
> >>>      sch->last_cmd_valid = false;
> >>> +    if (sch->channel_prog & (CCW1_ADDR_MASK |
> >>> +                             sch->ccw_fmt_1 ? 0 : 0xff000000)) {
> >> I have problem in recognizing the operator precedence here:
> >>     (CCW1_ADDR_MASK | sch->ccw_fmt_1 ? 0 : 0xff000000)
> >>
> >> Bitwise '|' has higher precedence than '?:', so the above equals to:
> >>     (CCW1_ADDR_MASK | sch->ccw_fmt_1) ? 0 : 0xff000000
> >>
> >> So you will always get a '0', no?
> >>
> > 
> > I'm afraid you are right. Good catch! This was supposed to be
> > (CCW1_ADDR_MASK | (sch->ccw_fmt_1 ? 0 : 0xff000000))
> > 
> > 
> >>> +            /* generate channel program check */
> >>> +            s->ctrl &= ~SCSW_ACTL_START_PEND;
> >>> +            s->cstat = SCSW_CSTAT_PROG_CHECK;
> >>> +            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
> >>> +            s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
> >>> +                    SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
> >>> +            s->cpa = sch->channel_prog + 8;
> >>> +            return;
> >>> +    }
> >> I think you could let css_interpret_ccw() do the sanity check on its
> >> @ccw_addr parameter when (sch->last_cmd_valid == false), to reuse the
> >> code of generating channel program check.
> >>
> > 
> > I'm working on factoring out the code manipulating SCSW (among others). If we
> > do that this will look nicer. What you propose is certainly viable, althoug
> > maybe little less straight forward.
> > 
> > Yet another option would be to use a label and jump into the loop (AFAIR that
> > would be also valid).
> > 
> > Let us see what is Connie's opinion.
> > 
> 
> After re-examining the PoP I'm inclined to say we have to check this on every
> iteration because of how "main-storage location is unavailable" is defined in
> this context: the definition depends on the ccw format.
Sounds natural!

> There is nothing about this in the ccw chaining section of the pop but
> it can be found in the I/O interrupts chapter.
> 
> I think I will have to redo this patch :/
Ok.

> 
> Regards,
> Halil
> 
> > 
> >>>      do {
> >>>          ret = css_interpret_ccw(sch, sch->channel_prog, suspend_allowed);
> >>>          switch (ret) {
> >>> -- 
> >>> 2.11.2
> >>>
> >>
> > 
> > 
> 
> 

-- 
Dong Jia Shi
