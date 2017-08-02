Received: from eggs.gnu.org ([2001:4830:134:3::10]:37757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dciLH-0001sN-5q
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 21:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dciLC-0005Zq-7T
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 21:20:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dciLB-0005Z0-Sa
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 21:20:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v721Im5C002016
	for <qemu-devel@nongnu.org>; Tue, 1 Aug 2017 21:20:48 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c2v82ygqr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 21:20:48 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 2 Aug 2017 11:20:45 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v721Kg8G24183012
	for <qemu-devel@nongnu.org>; Wed, 2 Aug 2017 11:20:42 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v721KfBQ002779
	for <qemu-devel@nongnu.org>; Wed, 2 Aug 2017 11:20:42 +1000
Date: Wed, 2 Aug 2017 09:20:41 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170801075727.31335-1-bjsdjshi@linux.vnet.ibm.com>
	<20170801075727.31335-3-bjsdjshi@linux.vnet.ibm.com>
	<5aba0805-2645-0075-edcb-e9d5b3643dd2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aba0805-2645-0075-edcb-e9d5b3643dd2@linux.vnet.ibm.com>
Message-Id: <20170802012041.GC24907@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] s390x/css: generate solicited crw
 for rchp completion signaling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pmorel@linux.vnet.ibm.com

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-08-01 17:16:37 +0200]:

> 
> 
> On 08/01/2017 09:57 AM, Dong Jia Shi wrote:
> [..]
> > --- a/hw/s390x/css.c
> > +++ b/hw/s390x/css.c
> > @@ -1745,10 +1745,10 @@ int css_do_rchp(uint8_t cssid, uint8_t chpid)
> >      }
> > 
> >      /* We don't really use a channel path, so we're done here. */
> > -    css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT,
> > +    css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 1,
> >                    channel_subsys.max_cssid > 0 ? 1 : 0, chpid);
> >      if (channel_subsys.max_cssid > 0) {
> > -        css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 0, real_cssid << 8);
> > +        css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 1, 0, real_cssid << 8);
> >      }
> >      return 0;
> >  }
> > @@ -2028,7 +2028,8 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
> >      }
> >  }
> > 
> > -void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid)
> > +void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
> > +                   int chain, uint16_t rsid)
> 
> I think you could make the parameters solicited and chain bool (AFAIU
> they are conceptually bool) for clearer semantic. If you go with that
> you could also get rid of the superfluous ternary operator ( we have
> stuff like some_cond ? 1 : 0 for the chain parameter in more than
> one place.
> 
> Btw. I find bool flags easy to mix up and difficult to read. I have no better
> idea how to write this (in C) though. I was considering throwing chain and
> solicited together into a single flags parameter, but looking at the client code
> it does not look like a good idea.
I think I just need to get used to differet tastes. ;)

> 
> Besides the cosmetic considerations above LGTM
Thanks!

-- 
Dong Jia Shi
