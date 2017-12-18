Received: from eggs.gnu.org ([2001:4830:134:3::10]:43570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR4JE-0001Vg-4s
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR4JA-0007NI-6S
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:54:56 -0500
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:45021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR4J9-0007Lr-W8
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:54:52 -0500
Received: by mail-pg0-x22c.google.com with SMTP id j9so9751568pgc.11
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 14:54:51 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <29c85873-d2c2-6b21-c50d-d475e5af62b6@linaro.org>
Date: Mon, 18 Dec 2017 14:54:46 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 15/19] fpu/softfloat: re-factor float to
 int/uint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 12/11/2017 04:57 AM, Alex Bennée wrote:
> +        }
> +        if (p.exp < DECOMPOSED_BINARY_POINT) {
> +            return p.frac >> (DECOMPOSED_BINARY_POINT - p.exp);
> +        } else if (p.exp < 64) {
> +            return p.frac << (p.exp - DECOMPOSED_BINARY_POINT);
> +        } else {
> +            return UINT64_MAX;
> +        }
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static uint16_t uint16_pack_decomposed(decomposed_parts p, float_status *s)
> +{
> +    uint64_t r = uint64_pack_decomposed(p, s);
> +    return r > UINT16_MAX ? UINT16_MAX : r;
> +}
> +
> +static uint32_t uint32_pack_decomposed(decomposed_parts p, float_status *s)
> +{
> +    uint64_t r = uint64_pack_decomposed(p, s);
> +    return r > UINT32_MAX ? UINT32_MAX : r;
> +}

Missing float_flag_invalid for unsigned overflows.


r~
