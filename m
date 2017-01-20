Received: from eggs.gnu.org ([2001:4830:134:3::10]:34783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cUVNg-0000AY-65
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cUVNd-0006NF-0W
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:21:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cUVNc-0006Mu-NH
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:21:08 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0K9JOh0068471
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:21:07 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
	by mx0a-001b2d01.pphosted.com with ESMTP id 283b5b2708-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:21:06 -0500
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 20 Jan 2017 14:51:02 +0530
Date: Fri, 20 Jan 2017 14:50:54 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1484802878-22681-1-git-send-email-bharata@linux.vnet.ibm.com>
	<03cf70f8-b852-a905-574c-ff96c106af5f@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03cf70f8-b852-a905-574c-ff96c106af5f@twiddle.net>
Message-Id: <20170120092054.GA21081@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v0] softfloat: Add round-to-odd
 rounding mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com

On Thu, Jan 19, 2017 at 07:29:54AM -0800, Richard Henderson wrote:
> On 01/18/2017 09:14 PM, Bharata B Rao wrote:
> > Power ISA 3.0 introduces a few quadruple precision floating point
> > instructions that support round-to-add rounding mode. The
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
> > - I am not fully sure if this the correct implementation for the above
> >   described round-to-odd rounding method. Any help is appreciated.
> > - Didn't bother to add round-to-odd to other floating point precision
> >   variants as round-to-odd option is currently supported only for some
> >   instructions that work on quad precision.
> > 
> >  fpu/softfloat.c         | 6 ++++++
> >  include/fpu/softfloat.h | 1 +
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> > index c295f31..05932a9 100644
> > --- a/fpu/softfloat.c
> > +++ b/fpu/softfloat.c
> > @@ -1149,6 +1149,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
> >      case float_round_down:
> >          increment = zSign && zSig2;
> >          break;
> > +    case float_round_to_odd:
> > +        increment = !(zSig1 & 0x1) && zSig2;
> > +        break;
> >      default:
> >          abort();
> >      }
> > @@ -1215,6 +1218,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
> >              case float_round_down:
> >                  increment = zSign && zSig2;
> >                  break;
> > +            case float_round_to_odd:
> > +                increment = !(zSig1 & 0x1) && zSig2;
> > +                break;
> >              default:
> >                  abort();
> >              }
> 
> I believe you've missed the section in between that deals with
> round-to-largest or to infinity:
> 
>             if (    ( roundingMode == float_round_to_zero )
>                  || ( zSign && ( roundingMode == float_round_up ) )
>                  || ( ! zSign && ( roundingMode == float_round_down ) )
>                ) {

Addresed in v1. Thanks Richard and Peter for pointing this out.

> 
> The description in see in the manual on page 387 is more precise than what
> you quote above:

Right. I quoted from page 385 as it is more concise for patch
description. However if you think the more precise definition of page
387 is appropriate in commit, I can put it.

Regards,
Bharata.
