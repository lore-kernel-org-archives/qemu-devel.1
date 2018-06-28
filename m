Received: from eggs.gnu.org ([2001:4830:134:3::10]:49023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYWe5-0001go-Cy
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYWe1-0004e8-Er
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:07:33 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYWe1-0004dP-0A
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:07:29 -0400
Received: by mail-oi0-x244.google.com with SMTP id n84-v6so5093275oib.9
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 06:07:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627043328.11531-34-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 14:07:07 +0100
Message-ID: <CAFEAcA_ZfQ1y0=sWBqLGSbd5qoBvhSthUy_udDi-aE5U66DLLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 33/35] target/arm: Implement SVE dot
 product (indexed)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 27 June 2018 at 05:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v6: Rearrange the loops.  The compiler does well with this form
>     and hopefully they are also easier to read.
> ---

Definitely easier to read, thanks.

> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 35415bfb6c..e10b689454 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -726,7 +726,13 @@ UMIN_zzi        00100101 .. 101 011 110 ........ .....          @rdn_i8u
>  MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
>
>  # SVE integer dot product (unpredicated)
> -DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5
> +DOT_zzz         01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5      ra=%reg_movprfx

Shouldn't this have been in a different patch ?

> +
> +# SVE integer dot product (indexed)
> +DOT_zzx         01000100 101 index:2 rm:3 00000 u:1 rn:5 rd:5 \
> +                sz=0 ra=%reg_movprfx
> +DOT_zzx         01000100 111 index:1 rm:4 00000 u:1 rn:5 rd:5 \
> +                sz=1 ra=%reg_movprfx
>
>  # SVE floating-point complex add (predicated)
>  FCADD           01100100 esz:2 00000 rot:1 100 pg:3 rm:5 rd:5 \
> --
> 2.17.1
>

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
