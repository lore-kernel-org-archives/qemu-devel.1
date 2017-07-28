Received: from eggs.gnu.org ([2001:4830:134:3::10]:49061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dazeS-0008SM-Vq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dazeP-0000pS-RN
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:25:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40475
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dazeP-0000ov-K0
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:25:33 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6S7NxiI142371
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 03:25:32 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2byuckuge6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 03:25:32 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 28 Jul 2017 03:25:32 -0400
Date: Fri, 28 Jul 2017 15:25:26 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-3-bjsdjshi@linux.vnet.ibm.com>
	<20170727132259.7102a715@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170727132259.7102a715@gondolin>
Message-Id: <20170728072526.GD15504@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/css: generate solicited crw for
 rchp completion signaling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

* Cornelia Huck <cohuck@redhat.com> [2017-07-27 13:22:59 +0200]:

[...]

> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
[...]

> > @@ -2028,7 +2028,7 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
> >      }
> >  }
> >  
> > -void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid)
> > +void css_queue_crw(uint8_t rsc, uint8_t erc, int s, int chain, uint16_t rsid)
> 
> 's' is not a very speaking name...
> 
> >  {
> >      CrwContainer *crw_cont;
> >  
> > @@ -2040,6 +2040,9 @@ void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid)
> >          return;
> >      }
> >      crw_cont->crw.flags = (rsc << 8) | erc;
> > +    if (s) {
> > +        crw_cont->crw.flags |= CRW_FLAGS_MASK_S;
> 
> ...as it obviously causes the S flag to be set ;) Let's call it 'solicited'?
Sure. Will adopt.

> 
> > +    }
> >      if (chain) {
> >          crw_cont->crw.flags |= CRW_FLAGS_MASK_C;
> >      }
> > @@ -2086,9 +2089,9 @@ void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
> >      }
> >      chain_crw = (channel_subsys.max_ssid > 0) ||
> >              (channel_subsys.max_cssid > 0);
> > -    css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, chain_crw ? 1 : 0, schid);
> > +    css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, 0, chain_crw ? 1 : 0, schid);
> >      if (chain_crw) {
> > -        css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, 0,
> > +        css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, 0, 0,
> >                        (guest_cssid << 8) | (ssid << 4));
> >      }
> >      /* RW_ERC_IPI --> clear pending interrupts */
> > @@ -2103,7 +2106,7 @@ void css_generate_chp_crws(uint8_t cssid, uint8_t chpid)
> >  void css_generate_css_crws(uint8_t cssid)
> >  {
> >      if (!channel_subsys.sei_pending) {
> > -        css_queue_crw(CRW_RSC_CSS, CRW_ERC_EVENT, 0, cssid);
> > +        css_queue_crw(CRW_RSC_CSS, CRW_ERC_EVENT, 0, 0, cssid);
> 
> Should we want to support OS-triggered channel path vary (via SCLP or
> otherwise) in the future,
Yes! I had a prototype of series to handle the OS-triggered chp vary,
and that needs...

> we'll probably need a version that generates a solicited crw.
...the new interface with the solicited bit param, which is provided by
patch #3:
void css_generate_chp_crws(uint8_t cssid, uint8_t chpid,
                           int hotplugged, int add, int s);

BTW, I need to renew the legal clearance before sending them out...

> 
> >      }
> >      channel_subsys.sei_pending = true;
> >  }
> > diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> > index 5c5fe6b202..d03b4ffeac 100644
> > --- a/include/hw/s390x/css.h
> > +++ b/include/hw/s390x/css.h
> > @@ -150,7 +150,7 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src);
> >  void css_inject_io_interrupt(SubchDev *sch);
> >  void css_reset(void);
> >  void css_reset_sch(SubchDev *sch);
> > -void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid);
> > +void css_queue_crw(uint8_t rsc, uint8_t erc, int s, int chain, uint16_t rsid);
> >  void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
> >                             int hotplugged, int add);
> >  void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
> 
> Otherwise, patch looks good.
Thanks.

So, I only need to s/s/solicited for the new version of this one?

> 

-- 
Dong Jia Shi
