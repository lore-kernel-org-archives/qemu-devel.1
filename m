Received: from eggs.gnu.org ([2001:4830:134:3::10]:59661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4FOt-0004DQ-Mm
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4FOo-0000Up-8j
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:06:27 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:52600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4FOo-0000UO-1R
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:06:22 -0400
Received: by mail-pf0-x235.google.com with SMTP id e64so1768pfk.9
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 17:06:21 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-21-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1f63c357-6071-158b-f174-adafbffa704f@linaro.org>
Date: Mon, 16 Oct 2017 17:06:18 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 20/30] softfloat: half-precision
 compare functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> +int float16_eq(float16 a, float16 b, float_status *status)
> +{
> +    uint32_t av, bv;
> +    a = float16_squash_input_denormal(a, status);
> +    b = float16_squash_input_denormal(b, status);
> +
> +    if (    ( ( extractFloat16Exp( a ) == 0x1F ) && extractFloat16Frac( a ) )
> +         || ( ( extractFloat16Exp( b ) == 0x1F ) && extractFloat16Frac( b ) )

float16_is_any_nan

> +       ) {
> +        float_raise(float_flag_invalid, status);
> +        return 0;
> +    }
> +    av = float16_val(a);
> +    bv = float16_val(b);
> +    return ( av == bv ) || ( (uint32_t) ( ( av | bv )<<1 ) == 0 );

For this trick to work you have to truncate to uint16_t not uint32_t.
It might be easier to read as

  a == b || float16_is_zero(a | b)

That said, I wonder if it wouldn't be better to implement all of these in terms
of float16_compare, rather than duplicating all of this code.


r~
