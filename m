Received: from eggs.gnu.org ([2001:4830:134:3::10]:55783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cZfYd-0005RC-ON
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cZfYa-00017Y-EV
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:13:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cZfYa-00017K-4V
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:13:48 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v13F9W9d022918
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 10:13:46 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28c9093073-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 10:13:46 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Sat, 4 Feb 2017 01:13:43 +1000
Date: Fri, 3 Feb 2017 20:42:47 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1485946146-21639-1-git-send-email-bharata@linux.vnet.ibm.com>
	<CAFEAcA_gno6etAWKkssBYSzYethD7_qNQh6CJCdviTNPqn2x9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_gno6etAWKkssBYSzYethD7_qNQh6CJCdviTNPqn2x9Q@mail.gmail.com>
Message-Id: <20170203151246.GD12744@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v0] softfloat: Add
 float128_to_uint64_round_to_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On Fri, Feb 03, 2017 at 02:40:09PM +0000, Peter Maydell wrote:
> On 1 February 2017 at 10:49, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> > Implement float128_to_uint64() and use that to implement
> > float128_to_uint64_round_to_zero()
> >
> > This is required by xscvqpudz instruction of PowerPC ISA 3.0.
> >
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > ---
> >  fpu/softfloat.c         | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/fpu/softfloat.h |  2 ++
> >  2 files changed, 67 insertions(+)
> >
> > diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> > index c295f31..49a06c5 100644
> > --- a/fpu/softfloat.c
> > +++ b/fpu/softfloat.c
> > @@ -6110,6 +6110,71 @@ int64_t float128_to_int64_round_to_zero(float128 a, float_status *status)
> >
> >  /*----------------------------------------------------------------------------
> >  | Returns the result of converting the quadruple-precision floating-point
> > +| value `a' to the 64-bit unsigned integer format.  The conversion
> > +| is performed according to the IEC/IEEE Standard for Binary Floating-Point
> > +| Arithmetic---which means in particular that the conversion is rounded
> > +| according to the current rounding mode.  If `a' is a NaN, the largest
> > +| positive integer is returned.  Otherwise, if the conversion overflows, the
> > +| largest unsigned integer is returned. If 'a' is negative, the value is
> > +| rounded and zero is returned; negative values that do not round to zero
> > +| will raise the inexact exception.
> > +*----------------------------------------------------------------------------*/
> > +
> > +uint64_t float128_to_uint64(float128 a, float_status *status)
> > +{
> > +    flag aSign;
> > +    int32_t aExp, shiftCount;
> > +    uint64_t aSig0, aSig1;
> 
> I think we should have a float128_squash_input_denormal() function
> which we call here (compare float64_to_uint64).

I followed float128_to_int64() which doesn't have that _denormal() call.

> 
> > +
> > +    aSig1 = extractFloat128Frac1( a );
> 
> Can you use the QEMU coding style for this rather than following
> the softfloat weird one, please?

Sure, I will henceforth switch to QEMU coding style, I was under the
impression that we should stick to the existing style since almost
entire softfloat.c is in different style.

> 
> > +    aSig0 = extractFloat128Frac0( a );
> > +    aExp = extractFloat128Exp( a );
> > +    aSign = extractFloat128Sign( a );
> > +    if ( aExp ) aSig0 |= LIT64( 0x0001000000000000 );
> > +    shiftCount = 0x402F - aExp;
> > +    if ( shiftCount <= 0 ) {
> > +        if ( 0x403E < aExp ) {
> > +            float_raise(float_flag_invalid, status);
> > +            if (    ! aSign
> > +                 || (    ( aExp == 0x7FFF )
> > +                      && ( aSig1 || ( aSig0 != LIT64( 0x0001000000000000 ) ) )
> > +                    )
> > +               ) {
> > +                return LIT64( 0xFFFFFFFFFFFFFFFF );
> > +            }
> > +            return 0;
> > +        }
> > +        shortShift128Left( aSig0, aSig1, - shiftCount, &aSig0, &aSig1 );
> > +    }
> > +    else {
> > +        shift64ExtraRightJamming( aSig0, aSig1, shiftCount, &aSig0, &aSig1 );
> > +    }
> > +    return roundAndPackUint64(aSign, aSig0, aSig1, status);
> 
> I'm finding this a bit difficult to understand, because it doesn't
> follow the code pattern of (for instance) float64_to_uint64().
> Is it based on some other existing function?

As I said above, it is based on float128_to_int64()

Actually what I really need is float128_to_uint64_round_to_zero().

However it is a bit confusing as to which existing routine to follow here.
I see there are 3 different ways floatXX_to_uintYY_round_to_zero is done:

1. Eg float64_to_uint32_round_to_zero()
   Uses float64_to_uint64_round_to_zero()

2. Eg float128_to_int32_round_to_zero()
   Doesn't use float128_to_int32() but instead is implemented
   fully separately.

3. Eg float64_to_uint64_round_to_zero()
   Sets the rounding mode to round-to-zero
   Uses float64_to_uint64()

I don't know if the above variants came about during different points
in time or they are actually implemented that way due to some
subtlety involved. I am following the 3rd pattern above as
I found it to be easier for this particular case (float128_to_uint128)

In fact I need float128_to_uint32() also next, but haven't yet been
able to figure out which way to do it.

> 
> > +}
> > +
> > +/*----------------------------------------------------------------------------
> > +| Returns the result of converting the quadruple-precision floating-point
> > +| value `a' to the 64-bit unsigned integer format.  The conversion
> > +| is performed according to the IEC/IEEE Standard for Binary Floating-Point
> > +| Arithmetic, except that the conversion is always rounded toward zero.
> > +| according to the current rounding mode.  If `a' is a NaN, the largest
> > +| positive integer is returned.  Otherwise, if the conversion overflows, the
> > +| largest unsigned integer is returned. If 'a' is negative, the value is
> > +| rounded and zero is returned; negative values that do not round to zero
> > +| will raise the inexact exception.
> > +*----------------------------------------------------------------------------*/
> > +
> > +uint64_t float128_to_uint64_round_to_zero(float128 a, float_status *status)
> > +{
> > +    signed char current_rounding_mode = status->float_rounding_mode;
> > +    set_float_rounding_mode(float_round_to_zero, status);
> > +    uint64_t v = float128_to_uint64(a, status);
> > +    set_float_rounding_mode(current_rounding_mode, status);
> > +    return v;
> > +}
> 
> This function is OK, though our coding style would suggest putting
> the declaration of 'uint64_t v;' at the top of the function.

Sure will change in the next iteration when I switch to QEMU style.

Regards,
Bharata.
