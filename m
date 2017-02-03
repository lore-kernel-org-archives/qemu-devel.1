Received: from eggs.gnu.org ([2001:4830:134:3::10]:43704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZcOr-0005DI-CY
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZcOq-0007tG-G7
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:51:33 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZcOq-0007sg-9d
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:51:32 -0500
Received: by mail-wm0-x230.google.com with SMTP id v77so24192375wmv.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 03:51:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485504213-21632-2-git-send-email-bharata@linux.vnet.ibm.com>
References: <1485504213-21632-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1485504213-21632-2-git-send-email-bharata@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 11:51:10 +0000
Message-ID: <CAFEAcA9WZeX8BnDz5g2K7iv7U-=fenvUkspoYqbhkjVx-iEDCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/2] softfloat: Handle float64
 rounding properly for underflow case
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

On 27 January 2017 at 08:03, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> When rounding a floating point result to float64 precision, the
> existing code doesn't re-calculate the required round increment
> for the underflow case. Fix this.
>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  fpu/softfloat.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index c295f31..b04699c 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -651,6 +651,23 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
>              if (isTiny && roundBits) {
>                  float_raise(float_flag_underflow, status);
>              }
> +            switch (roundingMode) {
> +            case float_round_nearest_even:
> +            case float_round_ties_away:
> +                roundIncrement = 0x200;
> +                break;
> +            case float_round_to_zero:
> +                roundIncrement = 0;
> +                break;
> +            case float_round_up:
> +                roundIncrement = zSign ? 0 : 0x3ff;
> +                break;
> +            case float_round_down:
> +                roundIncrement = zSign ? 0x3ff : 0;
> +                break;
> +            default:
> +                abort();
> +            }
>          }
>      }
>      if (roundBits) {

When does this give a different value to what roundIncrement
was before? As far as I can see the only data-dependency
here is on zSign, and underflowing doesn't affect zSign.

thanks
-- PMM
