Received: from eggs.gnu.org ([2001:4830:134:3::10]:37102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1foWgh-0007w5-UB
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 12:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1foWgg-0000uX-U9
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 12:24:23 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1foWgg-0000uD-P4
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 12:24:22 -0400
Received: by mail-qk0-x243.google.com with SMTP id t79-v6so8430860qke.4
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 09:24:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180810193129.1556-7-richard.henderson@linaro.org>
References: <20180810193129.1556-1-richard.henderson@linaro.org>
	<20180810193129.1556-7-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Sat, 11 Aug 2018 18:24:21 +0200
Message-ID: <CABoDooN+mCfWKGL6QG-ofJaCJHfCuNPgaTTX5W8ppwevgRF03w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 6/6] softfloat: Fix missing inexact for
 floating-point add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Fri, Aug 10, 2018 at 9:31 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> For 0x1.0000000000003p+0 + 0x1.ffffffep+14 = 0x1.0001fffp+15
> we dropped the sticky bit and so failed to raise inexact.
>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Laurent

> ---
>  fpu/softfloat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 8cd2400081..7d63cffdeb 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -701,7 +701,7 @@ static FloatParts addsub_floats(FloatParts a, FloatParts b, bool subtract,
>              }
>              a.frac += b.frac;
>              if (a.frac & DECOMPOSED_OVERFLOW_BIT) {
> -                a.frac >>= 1;
> +                shift64RightJamming(a.frac, 1, &a.frac);
>                  a.exp += 1;
>              }
>              return a;
> --
> 2.17.1
>
