Received: from eggs.gnu.org ([2001:4830:134:3::10]:54940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cPFrM-0006fB-JO
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cPFrJ-00047x-E5
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:46:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36193
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cPFrJ-00047N-7W
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:46:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v05Lj5ia063040
	for <qemu-devel@nongnu.org>; Thu, 5 Jan 2017 16:46:03 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27st07jqqt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 16:46:03 -0500
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 5 Jan 2017 19:46:01 -0200
Date: Thu, 5 Jan 2017 19:45:52 -0200
From: joserz@linux.vnet.ibm.com
References: <1482166064-18121-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1482166064-18121-2-git-send-email-joserz@linux.vnet.ibm.com>
	<8cb9e1d4-3dca-8a32-9f0d-2173bea52771@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cb9e1d4-3dca-8a32-9f0d-2173bea52771@redhat.com>
Message-Id: <20170105214552.GA15064@pacoca>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4 1/6] target-ppc: Implement
 unsigned quadword left/right shift and unit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Hello Eric,

Thank you very much for your review. Please, read my responses and
questions below.

Happy 2017.

On Tue, Jan 03, 2017 at 09:20:37AM -0600, Eric Blake wrote:
> On 12/19/2016 10:47 AM, Jose Ricardo Ziviani wrote:
> > This commit implements functions to right and left shifts and the
> > unittest for them. Such functions is needed due to instructions
> > that requires them.
> > 
> > Today, there is already a right shift implementation in int128.h
> > but it's designed for signed numbers.
> > 
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > ---
> 
> > +static const test_data test_ltable[] = {
> > +    { 1223ULL, 0, 1223ULL,   0, 0, false },
> > +    { 1ULL,    0, 2ULL,   0, 1, false },
> > +    { 1ULL,    0, 4ULL,   0, 2, false },
> > +    { 1ULL,    0, 16ULL,  0, 4, false },
> > +    { 1ULL,    0, 256ULL, 0, 8, false },
> > +    { 1ULL,    0, 65536ULL, 0, 16, false },
> > +    { 1ULL,    0, 2147483648ULL, 0, 31, false },
> > +    { 1ULL,    0, 35184372088832ULL, 0, 45, false },
> > +    { 1ULL,    0, 1152921504606846976ULL, 0, 60, false },
> > +    { 1ULL,    0, 0, 1ULL, 64, false },
> > +    { 1ULL,    0, 0, 65536ULL, 80, false },
> > +    { 1ULL,    0, 0, 9223372036854775808ULL, 127, false },
> 
> I concur with the request to write these tests in hex.

OK

> 
> > +    { 0ULL,    1, 0, 0, 64, true },
> > +    { 0x8888888888888888ULL, 0x9999999999999999ULL,
> > +        0x8000000000000000ULL, 0x9888888888888888ULL, 60, true },
> > +    { 0x8888888888888888ULL, 0x9999999999999999ULL,
> > +        0, 0x8888888888888888ULL, 64, true },
> > +    { 0x8ULL, 0, 0, 0x8ULL, 64, false },
> > +    { 0x8ULL, 0, 0, 0x8000000000000000ULL, 124, false },
> > +    { 0x1ULL, 0, 0, 0x4000000000000000ULL, 126, false },
> > +    { 0x1ULL, 0, 0, 0x8000000000000000ULL, 127, false },
> > +    { 0x1ULL, 0, 0x1ULL, 0, 128, true },
> 
> Do we really want this to be well-defined behavior?  Or would it be
> better to require shift to be in the bounded range [0,127] and assert()
> that it is always in range?  At least your testsuite ensures that if we
> want it to be well-defined, we won't go breaking it.

I prefer to write more testcases and let the functions as is, making the
caller responsible to complain about the shift if necessary.

> 
> > +    { 0, 0, 0ULL, 0, 200, false },
> 
> If you are going to support shifts larger than 127, your testsuite
> should include a shift of a non-zero number.  Also, if you are going to
> implicitly truncate the shift value into range, then accepting a signed
> shift might be nicer (as there are cases where it is easier to code a
> shift by -1 than it is a shift by 127).

Correct me if I'm wrong: Actually the caller can use the function like:

urshift(low, high, (uint32_t)-1);

And I'll get "shift == UINT_MAX", which truncates to 127 after "&= 127".
I don't need to use a signed integer necessarily, right?

> 
> > +++ b/util/host-utils.c
> > @@ -26,6 +26,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/host-utils.h"
> >  
> > +#ifndef CONFIG_INT128
> >  /* Long integer helpers */
> >  static inline void mul64(uint64_t *plow, uint64_t *phigh,
> >                           uint64_t a, uint64_t b)
> > @@ -158,4 +159,47 @@ int divs128(int64_t *plow, int64_t *phigh, int64_t divisor)
> >  
> >      return overflow;
> >  }
> > +#endif
> 
> How is the addition of this #ifndef related to the rest of the patch?  I
> almost wonder if it needs two patches (one to compile the file
> regardless of 128-bit support, the other to add new 128-bit shifts); if
> not, mentioning it in the commit message doesn't hurt.
> 

Right, I put this thing in a new patch. It's clearer indeed.

> >  
> > +void urshift(uint64_t *plow, uint64_t *phigh, uint32_t shift)
> 
> Comments on the function contract would be much appreciated (for
> example, what range must shift belong to, and the fact that the shift is
> modifying the value in-place, and that the result is always zero-extended).

OK

> 
> > +{
> > +    shift &= 127;
> 
> This says you allow any shift value (whether negative or beyond 127);
> either the testsuite must cover this, or you should tighten the contract
> and assert that the callers pass a value in range.

I prefer to let this function flexible and let the caller decides
whether to assert it or not before calling these functions. But I'm
totally open to assert it if you prefer.

I'm writing the testcase to cover it.

> 
> > +    uint64_t h = *phigh >> (shift & 63);
> > +    if (shift == 0) {
> > +        return;
> 
> Depending on the compiler, this may waste the work of computing h; maybe
> you can float this conditional first.

OK

> 
> > +    } else if (shift >= 64) {
> > +        *plow = h;
> > +        *phigh = 0;
> > +    } else {
> > +        *plow = (*plow >> (shift & 63)) | (*phigh << (64 - (shift & 63)));
> > +        *phigh = h;
> > +    }
> 
> At any rate, the math looks correct.

\o/ :D

> 
> > +}
> > +
> > +void ulshift(uint64_t *plow, uint64_t *phigh, uint32_t shift, bool *overflow)
> 
> Again, doc comments are useful, including what overflow represents, and
> a repeat of the question on whether a signed shift amount makes sense if
> you intend to allow silent truncation of the shift value.

OK. About the signed shift I wrote the question above.

> 
> > +{
> > +    uint64_t low = *plow;
> > +    uint64_t high = *phigh;
> > +
> > +    if (shift > 127 && (low | high)) {
> > +        *overflow = true;
> > +    }
> > +    shift &= 127;
> > +
> > +    if (shift == 0) {
> > +        return;
> > +    }
> > +
> > +    urshift(&low, &high, 128 - shift);
> > +    if (low > 0 || high > 0) {
> 
> Can't this be written 'if (low | high)' as above?

Oh yeah

> 
> > +        *overflow = true;
> > +    }
> > +
> > +    if (shift >= 64) {
> > +        *phigh = *plow << (shift & 63);
> > +        *plow = 0;
> > +    } else {
> > +        *phigh = (*plow >> (64 - (shift & 63))) | (*phigh << (shift & 63));
> > +        *plow = *plow << shift;
> > +    }
> > +}
> > 
> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 
