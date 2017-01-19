Received: from eggs.gnu.org ([2001:4830:134:3::10]:44423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUBYx-00015X-0s
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 07:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUBYv-0003Kw-Ug
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 07:11:31 -0500
Received: from mail-vk0-x229.google.com ([2607:f8b0:400c:c05::229]:33035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUBYv-0003KP-Gt
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 07:11:29 -0500
Received: by mail-vk0-x229.google.com with SMTP id k127so27885755vke.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 04:11:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484802878-22681-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1484802878-22681-1-git-send-email-bharata@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 12:11:08 +0000
Message-ID: <CAFEAcA9qwHQqbBk7Z0Uqh4+B_Osm4m=fz7pdNEptxW6m3sHi_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 19 January 2017 at 05:14, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> Power ISA 3.0 introduces a few quadruple precision floating point
> instructions that support round-to-add rounding mode. The
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
> - I am not fully sure if this the correct implementation for the above
>   described round-to-odd rounding method. Any help is appreciated.
> - Didn't bother to add round-to-odd to other floating point precision
>   variants as round-to-odd option is currently supported only for some
>   instructions that work on quad precision.

ARM has a couple of instructions that also want round-to-odd,
specifically for 32-bit results. So we should probably extend
it to those at some point (at the moment the target/arm code just
treats it like nearest-even, so gets inaccurate results).

>  fpu/softfloat.c         | 6 ++++++
>  include/fpu/softfloat.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index c295f31..05932a9 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1149,6 +1149,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
>      case float_round_down:
>          increment = zSign && zSig2;
>          break;
> +    case float_round_to_odd:
> +        increment = !(zSig1 & 0x1) && zSig2;
> +        break;

I think this is the right calculation, yes.
The ARM spec expresses the rounding operation in terms
of "force the LS bit of the mantissa to 1", but I think
doing it by setting increment like this helps us get
the corner cases right (like tininess detection).

The remaining part that your patch doesn't address is
the handling of rounding to infinity if the precise
result is too large to fit in the float128.
For ARM this is clearly defined in the spec: the
rounding pseudocode doesn't permit overflow-to-infinity.
This means the condition
            if (    ( roundingMode == float_round_to_zero )
                 || ( zSign && ( roundingMode == float_round_up ) )
                 || ( ! zSign && ( roundingMode == float_round_down ) )
which controls "do we return the maximum-float-value?"
needs an extra (roundingMode == float_round_to_odd) clause.

Hopefully those semantics work for the PPC case too?

>      default:
>          abort();
>      }
> @@ -1215,6 +1218,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
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
> index 842ec6b..1463062 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -180,6 +180,7 @@ enum {
>      float_round_up           = 2,
>      float_round_to_zero      = 3,
>      float_round_ties_away    = 4,
> +    float_round_to_odd       = 5,

Maybe worth a comment:
    /* Not an IEEE rounding mode: round to the closest odd mantissa value */

since all our other rounding modes are as defined in the IEEE spec.

>  };
>
>  /*----------------------------------------------------------------------------
> --

thanks
-- PMM
