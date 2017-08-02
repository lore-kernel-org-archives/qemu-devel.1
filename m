Received: from eggs.gnu.org ([2001:4830:134:3::10]:37347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dcqSu-0004n4-QQ
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dcqSr-0004Sm-MM
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dcqSr-0004RR-CA
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:01:17 -0400
Date: Wed, 2 Aug 2017 12:01:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170802120112.2594ef3b@gondolin>
In-Reply-To: <5aba0805-2645-0075-edcb-e9d5b3643dd2@linux.vnet.ibm.com>
References: <20170801075727.31335-1-bjsdjshi@linux.vnet.ibm.com>
	<20170801075727.31335-3-bjsdjshi@linux.vnet.ibm.com>
	<5aba0805-2645-0075-edcb-e9d5b3643dd2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pmorel@linux.vnet.ibm.com

On Tue, 1 Aug 2017 17:16:37 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

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

Just adding the new parameter is the minimum change, and we should keep
it consistent. I'm not convinced about converting to bool yet.

> 
> Btw. I find bool flags easy to mix up and difficult to read. I have no better
> idea how to write this (in C) though. I was considering throwing chain and
> solicited together into a single flags parameter, but looking at the client code
> it does not look like a good idea.

Yes, combining them would do nothing for the code.
