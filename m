Received: from eggs.gnu.org ([2001:4830:134:3::10]:39090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cF88H-0004x6-TQ
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 18:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cF88E-0005VJ-N9
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 18:29:45 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:45746
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cF88E-0005VC-EB
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 18:29:42 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB8NHpvj053231
	for <qemu-devel@nongnu.org>; Thu, 8 Dec 2016 18:29:41 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277gu8h10c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 18:29:40 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 8 Dec 2016 21:29:38 -0200
Date: Thu, 8 Dec 2016 21:29:24 -0200
From: joserz@linux.vnet.ibm.com
References: <1481162828-2295-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1481162828-2295-6-git-send-email-joserz@linux.vnet.ibm.com>
	<20161208210614.GB13139@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161208210614.GB13139@umbus.fritz.box>
Message-Id: <20161208232924.GA17675@pacoca>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 5/6] target-ppc: Implement
 bcdtrunc. instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On Fri, Dec 09, 2016 at 08:06:14AM +1100, David Gibson wrote:
> On Thu, Dec 08, 2016 at 12:07:07AM -0200, Jose Ricardo Ziviani wrote:
> > bcdtrunc.: Decimal integer truncate. Given a BCD number in vrb and the
> > number of bytes to truncate in vra, the return register will have vrb
> > with such bits truncated.
> > 
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> 
> Um.. this is wrong on multiple accounts.  Have you actually tested
> this with any input at all?

yes I did, a lot but it's possible that I get the idea wrong.

> 
> > ---
> >  target-ppc/helper.h                 |  1 +
> >  target-ppc/int_helper.c             | 40 +++++++++++++++++++++++++++++++++++++
> >  target-ppc/translate/vmx-impl.inc.c |  5 +++++
> >  target-ppc/translate/vmx-ops.inc.c  |  4 ++--
> >  4 files changed, 48 insertions(+), 2 deletions(-)
> > 
> > diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> > index d9528eb..49965b0 100644
> > --- a/target-ppc/helper.h
> > +++ b/target-ppc/helper.h
> > @@ -395,6 +395,7 @@ DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
> >  DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
> >  DEF_HELPER_4(bcdus, i32, avr, avr, avr, i32)
> >  DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
> > +DEF_HELPER_4(bcdtrunc, i32, avr, avr, avr, i32)
> >  
> >  DEF_HELPER_2(xsadddp, void, env, i32)
> >  DEF_HELPER_2(xssubdp, void, env, i32)
> > diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
> > index cfef25f..dea08e6 100644
> > --- a/target-ppc/int_helper.c
> > +++ b/target-ppc/int_helper.c
> > @@ -3169,6 +3169,46 @@ uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> >      return cr;
> >  }
> >  
> > +uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
> > +{
> > +    uint64_t mask;
> > +    uint32_t bits;
> > +    uint32_t ox_flag = 0;
> > +    ppc_avr_t ret = *b;
> > +
> > +#if defined(HOST_WORDS_BIGENDIAN)
> > +    int upper = ARRAY_SIZE(a->u16) - 1;
> > +#else
> > +    int upper = 0;
> > +#endif
> > +
> > +    if (bcd_is_valid(b) == false) {
> > +        return CRF_SO;
> > +    }
> > +
> > +    bits = (a->u16[upper] & 31) << 2;
> 
> According to the ISA, the value here gives the number of digits to
> *retain*, you're treating it as the number of digits to clear.  You're
> also not accounting for the sign marker, which should be retained in
> any case.

I understood it is the number of bits to clear, I'll review it.

> 
> Finally, the ISA says the value in bits 48:63 are treated as length
> with no mention of being truncated to 5 bits.  Which means it's not
> clear what should happen if length > 31.  You'll need to check with
> the hardware people about this.

ok

> 
> > +    if (bits >= 64) {
> > +        if (ret.u64[HI_IDX] || (ret.u64[LO_IDX] >> (128 - bits))) {
> > +            ox_flag = CRF_SO;
> > +        }
> > +
> > +        mask = (uint64_t)-1 >> (bits - 64);
> > +        ret.u64[HI_IDX] = 0;
> > +        ret.u64[LO_IDX] &= mask;
> > +    } else {
> > +        if (ret.u64[HI_IDX] >> (64 - bits)) {
> > +            ox_flag = CRF_SO;
> > +        }
> > +
> > +        mask = (uint64_t)-1 >> bits;
> > +        ret.u64[HI_IDX] &= mask;
> > +    }
> > +    bcd_put_digit(&ret, bcd_preferred_sgn(bcd_get_sgn(b), ps), 0);
> > +    *r = ret;
> > +
> > +    return bcd_cmp_zero(&ret) | ox_flag;
> > +}
> > +
> >  void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
> >  {
> >      int i;
> > diff --git a/target-ppc/translate/vmx-impl.inc.c b/target-ppc/translate/vmx-impl.inc.c
> > index 451abb5..1683f42 100644
> > --- a/target-ppc/translate/vmx-impl.inc.c
> > +++ b/target-ppc/translate/vmx-impl.inc.c
> > @@ -1019,6 +1019,7 @@ GEN_BCD(bcdcpsgn);
> >  GEN_BCD(bcds);
> >  GEN_BCD(bcdus);
> >  GEN_BCD(bcdsr);
> > +GEN_BCD(bcdtrunc);
> >  
> >  static void gen_xpnd04_1(DisasContext *ctx)
> >  {
> > @@ -1097,6 +1098,10 @@ GEN_VXFORM_DUAL(vsubudm, PPC2_ALTIVEC_207, PPC_NONE, \
> >                  bcds, PPC_NONE, PPC2_ISA300)
> >  GEN_VXFORM_DUAL(vsubuwm, PPC_ALTIVEC, PPC_NONE, \
> >                  bcdus, PPC_NONE, PPC2_ISA300)
> > +GEN_VXFORM_DUAL(vsubsbs, PPC_ALTIVEC, PPC_NONE, \
> > +                bcdtrunc, PPC_NONE, PPC2_ISA300)
> > +GEN_VXFORM_DUAL(vsubuqm, PPC2_ALTIVEC_207, PPC_NONE, \
> > +                bcdtrunc, PPC_NONE, PPC2_ISA300)
> >  
> >  static void gen_vsbox(DisasContext *ctx)
> >  {
> > diff --git a/target-ppc/translate/vmx-ops.inc.c b/target-ppc/translate/vmx-ops.inc.c
> > index fa9c996..e6167a4 100644
> > --- a/target-ppc/translate/vmx-ops.inc.c
> > +++ b/target-ppc/translate/vmx-ops.inc.c
> > @@ -143,14 +143,14 @@ GEN_VXFORM(vaddsws, 0, 14),
> >  GEN_VXFORM_DUAL(vsububs, bcdadd, 0, 24, PPC_ALTIVEC, PPC_NONE),
> >  GEN_VXFORM_DUAL(vsubuhs, bcdsub, 0, 25, PPC_ALTIVEC, PPC_NONE),
> >  GEN_VXFORM(vsubuws, 0, 26),
> > -GEN_VXFORM(vsubsbs, 0, 28),
> > +GEN_VXFORM_DUAL(vsubsbs, bcdtrunc, 0, 28, PPC_NONE, PPC2_ISA300),
> >  GEN_VXFORM(vsubshs, 0, 29),
> >  GEN_VXFORM_DUAL(vsubsws, xpnd04_2, 0, 30, PPC_ALTIVEC, PPC_NONE),
> >  GEN_VXFORM_207(vadduqm, 0, 4),
> >  GEN_VXFORM_207(vaddcuq, 0, 5),
> >  GEN_VXFORM_DUAL(vaddeuqm, vaddecuq, 30, 0xFF, PPC_NONE, PPC2_ALTIVEC_207),
> > -GEN_VXFORM_207(vsubuqm, 0, 20),
> >  GEN_VXFORM_207(vsubcuq, 0, 21),
> > +GEN_VXFORM_DUAL(vsubuqm, bcdtrunc, 0, 20, PPC2_ALTIVEC_207, PPC2_ISA300),
> >  GEN_VXFORM_DUAL(vsubeuqm, vsubecuq, 31, 0xFF, PPC_NONE, PPC2_ALTIVEC_207),
> >  GEN_VXFORM(vrlb, 2, 0),
> >  GEN_VXFORM(vrlh, 2, 1),
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
