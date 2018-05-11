Received: from eggs.gnu.org ([2001:4830:134:3::10]:55560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH7Iq-0003xE-KA
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH7Ip-0002W4-Oa
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:37:40 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH7Ip-0002Vj-Hw
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:37:39 -0400
Received: by mail-ot0-x244.google.com with SMTP id t1-v6so6031017oth.8
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:37:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180511071052.1443-1-ptesarik@suse.com>
References: <20180511071052.1443-1-ptesarik@suse.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 13:37:18 +0100
Message-ID: <CAFEAcA_o=ZcOrsoUQdB7gwQ_S9dbrtyM1EWniAO2qK8cnfLNNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] Fix conversion from uint64 to float128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Petr Tesarik <ptesarik@suse.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 11 May 2018 at 08:10, Petr Tesarik <ptesarik@suse.com> wrote:
> The significand is passed to normalizeRoundAndPackFloat128() as high
> first, low second. The current code passes the integer first, so the
> result is incorrectly shifted left by 64 bits.
>
> This bug affects the emulation of s390x instruction CXLGBR (convert
> from logical 64-bit binary-integer operand to extended BFP result).
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  fpu/softfloat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 70e0c40a1c..386805475b 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -3139,7 +3139,7 @@ float128 uint64_to_float128(uint64_t a, float_status *status)
>      if (a == 0) {
>          return float128_zero;
>      }
> -    return normalizeRoundAndPackFloat128(0, 0x406E, a, 0, status);
> +    return normalizeRoundAndPackFloat128(0, 0x406E, 0, a, status);
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
