Received: from eggs.gnu.org ([2001:4830:134:3::10]:59555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yasmins@linux.vnet.ibm.com>) id 1fflsd-0003s0-2D
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yasmins@linux.vnet.ibm.com>) id 1fflsZ-0003L7-TZ
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:48:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yasmins@linux.vnet.ibm.com>)
	id 1fflsZ-0003Km-Bi
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:48:27 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6ICi2fw053126
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 08:48:25 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ka3x14w5f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 08:48:25 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <yasmins@linux.vnet.ibm.com>;
	Wed, 18 Jul 2018 06:48:24 -0600
Date: Wed, 18 Jul 2018 09:48:12 -0300
From: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
References: <1531767792-17705-1-git-send-email-yasmins@linux.ibm.com>
	<20180718022202.GC2102@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718022202.GC2102@umbus.fritz.box>
Message-Id: <20180718124812.2kx4juuwu5pxdoqk@yasmins-ThinkPad-T460>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: bcdsub fix sign when result is
 zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net

On Wed, Jul 18, 2018 at 12:22:02PM +1000, David Gibson wrote:
> On Mon, Jul 16, 2018 at 07:03:12PM +0000, Yasmin Beatriz wrote:
> > When the result of bcdsub is equal to zero, the result sign may be
> > set to negative in some cases, and this does not follow the Power ISA
> > specifications as to decimal integer arithmetic instructions.
> > 
> > Signed-off-by: Yasmin Beatriz <yasmins@linux.ibm.com>
> 
> The fix looks correct, but since this has been broken forever and
> we're in hard freeze I'm going to apply for 3.1, not 3.0.
> 
> Fwiw, I think the surrounding logic can probably be simplified a
> little as well - I think this is now the only case with a zero result,
> so I think the 'zero' local can probably be removed.

You are right. I am working on this and will send a new patch very soon.
Thank you for the note.
 
> > ---
> >  target/ppc/int_helper.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> > index 03d37da..fa18e6e 100644
> > --- a/target/ppc/int_helper.c
> > +++ b/target/ppc/int_helper.c
> > @@ -2747,6 +2747,9 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> >              result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgna, ps);
> >              zero = bcd_sub_mag(&result, a, b, &invalid, &overflow);
> >              cr = (sgna > 0) ? CRF_GT : CRF_LT;
> > +        } else if (bcd_cmp_mag(a, b) == 0) {
> > +            result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(0, ps);
> > +            zero = bcd_sub_mag(&result, b, a, &invalid, &overflow);
> >          } else {
> >              result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgnb, ps);
> >              zero = bcd_sub_mag(&result, b, a, &invalid, &overflow);
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
