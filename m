Received: from eggs.gnu.org ([2001:4830:134:3::10]:52587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yasmins@linux.ibm.com>) id 1fimGQ-0005md-Ky
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 15:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yasmins@linux.ibm.com>) id 1fimGL-0002pX-Nr
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 15:49:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49900
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yasmins@linux.ibm.com>)
	id 1fimGL-0002p1-Gd
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 15:49:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6QJnNrk064509
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 15:49:24 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kfjpkcqy9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 15:49:23 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <yasmins@linux.ibm.com>;
	Thu, 26 Jul 2018 15:44:53 -0400
Date: Thu, 26 Jul 2018 16:44:43 -0300
From: Yasmin Beatriz <yasmins@linux.ibm.com>
References: <1532434384-12355-1-git-send-email-yasmins@linux.ibm.com>
	<20180726014020.GJ6830@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726014020.GJ6830@umbus.fritz.box>
Message-Id: <20180726194443.dnw75xlfjjtzcarm@yasmins-ThinkPad-T460>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: simplify bcdadd/sub functions
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

On Thu, Jul 26, 2018 at 11:40:20AM +1000, David Gibson wrote:
> On Tue, Jul 24, 2018 at 12:13:04PM +0000, Yasmin Beatriz wrote:
> > After solving a corner case in bcdsub, this patch simplifies the logic
> > of both bcdadd/sub instructions by removing some unnecessary local flags.
> > 
> > Signed-off-by: Yasmin Beatriz <yasmins@linux.ibm.com>
> > ---
> >  target/ppc/int_helper.c | 33 +++++++++------------------------
> >  1 file changed, 9 insertions(+), 24 deletions(-)
> > 
> > diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> > index fa18e6e..b8ac4bb 100644
> > --- a/target/ppc/int_helper.c
> > +++ b/target/ppc/int_helper.c
> > @@ -2671,16 +2671,14 @@ static int bcd_cmp_mag(ppc_avr_t *a, ppc_avr_t *b)
> >      return 0;
> >  }
> >  
> > -static int bcd_add_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
> > +static void bcd_add_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
> >                         int *overflow)
> >  {
> >      int carry = 0;
> >      int i;
> > -    int is_zero = 1;
> >      for (i = 1; i <= 31; i++) {
> >          uint8_t digit = bcd_get_digit(a, i, invalid) +
> >                          bcd_get_digit(b, i, invalid) + carry;
> > -        is_zero &= (digit == 0);
> >          if (digit > 9) {
> >              carry = 1;
> >              digit -= 10;
> > @@ -2689,26 +2687,20 @@ static int bcd_add_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
> >          }
> >  
> >          bcd_put_digit(t, digit, i);
> > -
> > -        if (unlikely(*invalid)) {
> > -            return -1;
> > -        }
> >      }
> >  
> >      *overflow = carry;
> > -    return is_zero;
> >  }
> >  
> > -static int bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
> > +static void bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
> >                         int *overflow)
> >  {
> >      int carry = 0;
> >      int i;
> > -    int is_zero = 1;
> > +
> >      for (i = 1; i <= 31; i++) {
> >          uint8_t digit = bcd_get_digit(a, i, invalid) -
> >                          bcd_get_digit(b, i, invalid) + carry;
> > -        is_zero &= (digit == 0);
> >          if (digit & 0x80) {
> >              carry = -1;
> >              digit += 10;
> > @@ -2717,14 +2709,9 @@ static int bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
> >          }
> >  
> >          bcd_put_digit(t, digit, i);
> > -
> > -        if (unlikely(*invalid)) {
> > -            return -1;
> > -        }
> >      }
> >  
> >      *overflow = carry;
> > -    return is_zero;
> >  }
> >  
> >  uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> > @@ -2734,25 +2721,25 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> >      int sgnb = bcd_get_sgn(b);
> >      int invalid = (sgna == 0) || (sgnb == 0);
> >      int overflow = 0;
> > -    int zero = 0;
> >      uint32_t cr = 0;
> >      ppc_avr_t result = { .u64 = { 0, 0 } };
> >  
> >      if (!invalid) {
> >          if (sgna == sgnb) {
> >              result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgna, ps);
> > -            zero = bcd_add_mag(&result, a, b, &invalid, &overflow);
> > -            cr = (sgna > 0) ? CRF_GT : CRF_LT;
> > +            bcd_add_mag(&result, a, b, &invalid, &overflow);
> > +            cr = bcd_cmp_zero(&result);
> >          } else if (bcd_cmp_mag(a, b) > 0) {
> >              result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgna, ps);
> > -            zero = bcd_sub_mag(&result, a, b, &invalid, &overflow);
> > +            bcd_sub_mag(&result, a, b, &invalid, &overflow);
> >              cr = (sgna > 0) ? CRF_GT : CRF_LT;
> >          } else if (bcd_cmp_mag(a, b) == 0) {
> >              result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(0, ps);
> > -            zero = bcd_sub_mag(&result, b, a, &invalid, &overflow);
> > +            bcd_sub_mag(&result, b, a, &invalid, &overflow);
> 
> I don't think you actually need the sub here, since you know the
> result is going to be zero.

Right. Will fix this in v2.

> Although.. in all of the different-sign cases aren't we effectively
> doing the subtraction twice - once in bcd_cmp_mag() then again in
> bcd_sub_mag()?

Actually no, bcd_cmp_mag() compares the magnitude between 'a' and 'b'
starting from the most significant digit and returns as soon as it finds
a difference between the two of them. It helps to decide whether we're
going to perform a - b or b - a.

Anyway, I think the following code can make it easier to understand:

int magnitude;
if (sgna == sgnb) {
    // same thing
} else {
    magnitude = bdc_cmp_mag(a, b);
    if (magnitude > 0) {
        // do a - b
    } else if (magnitude < 0) {
        // do b - a
    } else {
        // 0
    }
}

> > +            cr = CRF_EQ;
> >          } else {
> >              result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgnb, ps);
> > -            zero = bcd_sub_mag(&result, b, a, &invalid, &overflow);
> > +            bcd_sub_mag(&result, b, a, &invalid, &overflow);
> >              cr = (sgnb > 0) ? CRF_GT : CRF_LT;
> >          }
> >      }
> > @@ -2762,8 +2749,6 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> >          cr = CRF_SO;
> >      } else if (overflow) {
> >          cr |= CRF_SO;
> > -    } else if (zero) {
> > -        cr = CRF_EQ;
> >      }
> >  
> >      *r = result;
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
