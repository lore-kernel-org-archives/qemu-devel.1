Received: from eggs.gnu.org ([2001:4830:134:3::10]:47305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUWR3-0001z8-7T
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUWR1-0000Gn-Ui
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:28:45 -0500
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:35906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUWR1-0000GT-H6
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:28:43 -0500
Received: by mail-vk0-x230.google.com with SMTP id t8so48676352vke.3
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 02:28:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484903866-17940-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1484903866-17940-1-git-send-email-bharata@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 10:28:22 +0000
Message-ID: <CAFEAcA97fSC6DoaF41ifh-L5S1XYfJmG+3a_Njw3UJ=sULk6ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 20 January 2017 at 09:17, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> Power ISA 3.0 introduces a few quadruple precision floating point
> instructions that support round-to-odd rounding mode. The
> round-to-odd mode is explained as under:
>
> Let Z be the intermediate arithmetic result or the operand of a convert
> operation. If Z can be represented exactly in the target format, the
> result is Z. Otherwise the result is either Z1 or Z2 whichever is odd.
> Here Z1 and Z2 are the next larger and smaller numbers representable
> in the target format respectively.
>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
> Changes in v1:
> - Addressed rounding to infinity in roundAndPackFloat128().
> - Added 64bit round to odd implementation(roundAndPackFloat64()) as
>   it is needed by xscvqpdp instruction of Power ISA 3.0.
>
> v0: http://patchwork.ozlabs.org/patch/716956/
>
>  fpu/softfloat.c         | 10 ++++++++++
>  include/fpu/softfloat.h |  2 ++
>  2 files changed, 12 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index c295f31..b9b36ad 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -623,6 +623,9 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
>      case float_round_down:
>          roundIncrement = zSign ? 0x3ff : 0;
>          break;
> +    case float_round_to_odd:
> +        roundIncrement = (zSig & 0x200) ? 0 : 0x3ff;

Are you sure that should be 0x200 and not 0x400 ?

> +        break;
>      default:
>          abort();
>      }

This isn't sufficient, because it won't do the right thing
in the code which is picking between "round to infinity" and
"round to largest/smallest representable number". That's
phrased differently from the Float128 code but it's still
there:

            return packFloat64( zSign, 0x7FF, - ( roundIncrement == 0 ));

will generate a result with an all-zeros mantissa for
roundIncrement == 0 (ie go to infinity) and an all-ones
mantissa otherwise (ie go to largest-representable).
That works for the existing cases but it doesn't work
for round_to_odd.

How are you testing these patches? You ought to be able
to compare the results against a known-good implementation
for a bunch of these corner cases and a lot of random
input values, which is the best way to be confident there
aren't bugs in them. (risu should be able to do this since
it supports PPC now, though it can miss things depending
on the number of iterations you ask it to do.)

> @@ -1149,6 +1152,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
>      case float_round_down:
>          increment = zSign && zSig2;
>          break;
> +    case float_round_to_odd:
> +        increment = !(zSig1 & 0x1) && zSig2;
> +        break;
>      default:
>          abort();
>      }
> @@ -1168,6 +1174,7 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
>              if (    ( roundingMode == float_round_to_zero )
>                   || ( zSign && ( roundingMode == float_round_up ) )
>                   || ( ! zSign && ( roundingMode == float_round_down ) )
> +                 || ( roundingMode == float_round_to_odd )
>                 ) {
>                  return
>                      packFloat128(
> @@ -1215,6 +1222,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
>              case float_round_down:
>                  increment = zSign && zSig2;
>                  break;
> +            case float_round_to_odd:
> +                increment = !(zSig1 & 0x1) && zSig2;
> +                break;
>              default:
>                  abort();
>              }
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 842ec6b..8a39028 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -180,6 +180,8 @@ enum {
>      float_round_up           = 2,
>      float_round_to_zero      = 3,
>      float_round_ties_away    = 4,
> +    /* Not an IEEE rounding mode: round to the closest odd mantissa value */
> +    float_round_to_odd       = 5,
>  };
>
>  /*----------------------------------------------------------------------------

thanks
-- PMM
