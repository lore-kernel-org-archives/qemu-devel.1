Received: from eggs.gnu.org ([209.51.188.92]:58058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grDkh-0004Yp-SR
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grDa2-0006bo-7s
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:08:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grDa1-0006Rr-S2
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:08:54 -0500
Received: by mail-wr1-x429.google.com with SMTP id a16so5963889wrv.0
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 19:08:48 -0800 (PST)
References: <20190205162253.9155-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <69586972-35c7-4941-4b65-6b49fed66532@linaro.org>
Date: Wed, 6 Feb 2019 03:08:43 +0000
MIME-Version: 1.0
In-Reply-To: <20190205162253.9155-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] softfloat: add float128_is_{normal,
 denormal}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 2/5/19 4:22 PM, David Hildenbrand wrote:
> +static inline bool float128_is_normal(float128 a)
> +{
> +    return ((a.high + (1ULL << 47)) & -1ULL >> 1) >= 1ULL << 48;

I believe this is off by one: 1 << 48 and >= 1 << 49.

The exponent is at [62:48].  The trick is adding 1, letting Inf+NaN overflow
into the sign, masking out the sign, and checking that the result >= 2 to
eliminate Inf+NaN (0) and Zero+Denormal (1).

I think this is clearer as

  (((a.high >> 48) + 1) & 0x7fff) >= 2.

It might be worth applying this to the other formats for clarity...


r~
