Received: from eggs.gnu.org ([2001:4830:134:3::10]:57597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cUXVH-0006lu-Na
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cUXVD-000709-Nl
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:37:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cUXVD-0006zj-DX
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:37:07 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0KBXlsZ061333
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 06:37:06 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 283bmf5xy0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 06:37:05 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 20 Jan 2017 21:37:03 +1000
Date: Fri, 20 Jan 2017 17:06:06 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1484903866-17940-1-git-send-email-bharata@linux.vnet.ibm.com>
	<CAFEAcA97fSC6DoaF41ifh-L5S1XYfJmG+3a_Njw3UJ=sULk6ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA97fSC6DoaF41ifh-L5S1XYfJmG+3a_Njw3UJ=sULk6ig@mail.gmail.com>
Message-Id: <20170120113606.GB21081@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1] softfloat: Add round-to-odd
 rounding mode
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

On Fri, Jan 20, 2017 at 10:28:22AM +0000, Peter Maydell wrote:
> On 20 January 2017 at 09:17, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> > Power ISA 3.0 introduces a few quadruple precision floating point
> > instructions that support round-to-odd rounding mode. The
> > round-to-odd mode is explained as under:
> >
> > Let Z be the intermediate arithmetic result or the operand of a convert
> > operation. If Z can be represented exactly in the target format, the
> > result is Z. Otherwise the result is either Z1 or Z2 whichever is odd.
> > Here Z1 and Z2 are the next larger and smaller numbers representable
> > in the target format respectively.
> >
> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > ---
> > Changes in v1:
> > - Addressed rounding to infinity in roundAndPackFloat128().
> > - Added 64bit round to odd implementation(roundAndPackFloat64()) as
> >   it is needed by xscvqpdp instruction of Power ISA 3.0.
> >
> > v0: http://patchwork.ozlabs.org/patch/716956/
> >
> >  fpu/softfloat.c         | 10 ++++++++++
> >  include/fpu/softfloat.h |  2 ++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> > index c295f31..b9b36ad 100644
> > --- a/fpu/softfloat.c
> > +++ b/fpu/softfloat.c
> > @@ -623,6 +623,9 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
> >      case float_round_down:
> >          roundIncrement = zSign ? 0x3ff : 0;
> >          break;
> > +    case float_round_to_odd:
> > +        roundIncrement = (zSig & 0x200) ? 0 : 0x3ff;
> 
> Are you sure that should be 0x200 and not 0x400 ?

You are right, it should have been 0x400 as we are discarding lower
10 precision bits. The even or odd check should have been for
the next higher significant bit to that of these 10 discarded bits.

> 
> > +        break;
> >      default:
> >          abort();
> >      }
> 
> This isn't sufficient, because it won't do the right thing
> in the code which is picking between "round to infinity" and
> "round to largest/smallest representable number". That's
> phrased differently from the Float128 code but it's still
> there:
> 
>             return packFloat64( zSign, 0x7FF, - ( roundIncrement == 0 ));
> 
> will generate a result with an all-zeros mantissa for
> roundIncrement == 0 (ie go to infinity) and an all-ones
> mantissa otherwise (ie go to largest-representable).
> That works for the existing cases but it doesn't work
> for round_to_odd.

Based on my understanding of your and Richard's clarification, we
shouldn't overflow to infinity in round-to-odd mode. Like I did for 128 bit
case where we return the max possible value in the similar situation, I
suppose we should explicitly take care of returning max 64bit value here
for round-to-odd case ?

> 
> How are you testing these patches? You ought to be able
> to compare the results against a known-good implementation
> for a bunch of these corner cases and a lot of random
> input values, which is the best way to be confident there
> aren't bugs in them. (risu should be able to do this since
> it supports PPC now, though it can miss things depending
> on the number of iterations you ask it to do.)

I have been manually checking the result of new PPC instructions like
xsdivqp[o], xsmulqp[o], xscvqpdp[0]. But that is clearly not enough.
Let me look at RISU and do a more thorough corner cases testing
before posting the next version.

Thanks for your review.

Regards,
Bharata.
