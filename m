Received: from eggs.gnu.org ([2001:4830:134:3::10]:38123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cUEf6-00024A-CM
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:30:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cUEf5-0003bC-F7
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:30:04 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484802878-22681-1-git-send-email-bharata@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <03cf70f8-b852-a905-574c-ff96c106af5f@twiddle.net>
Date: Thu, 19 Jan 2017 07:29:54 -0800
MIME-Version: 1.0
In-Reply-To: <1484802878-22681-1-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com

On 01/18/2017 09:14 PM, Bharata B Rao wrote:
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
>
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

I believe you've missed the section in between that deals with round-to-largest 
or to infinity:

             if (    ( roundingMode == float_round_to_zero )
                  || ( zSign && ( roundingMode == float_round_up ) )
                  || ( ! zSign && ( roundingMode == float_round_down ) )
                ) {

The description in see in the manual on page 387 is more precise than what you 
quote above:

   # If IR is exact, choose IR.
   # Otherwise choose NL, and if Guard=1, Round=1 or Sticky=1,
   # the least significant bit of the result is set to 1.

The "choose NL" part means round-to-zero, which means that we do not overflow 
to infinity.  And since FLOAT128_MAX is already odd, we're done.

Otherwise this looks ok.


r~
