Received: from eggs.gnu.org ([2001:4830:134:3::10]:54596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f3vno-0001bs-3P
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 23:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f3vnn-00073e-HC
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 23:43:08 -0400
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:41599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f3vnn-00073X-AZ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 23:43:07 -0400
Received: by mail-pl0-x229.google.com with SMTP id bj1-v6so14860785plb.8
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 20:43:07 -0700 (PDT)
References: <20180405014135.3235-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e1b21f62-098d-405d-40b8-fac6bdf941df@linaro.org>
Date: Thu, 5 Apr 2018 13:43:00 +1000
MIME-Version: 1.0
In-Reply-To: <20180405014135.3235-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix preadv/pwritev offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 04/05/2018 11:41 AM, Max Filippov wrote:
> +static void target_low_high_to_host_low_high(abi_ulong tlow,
> +                                             abi_ulong thigh,
> +                                             unsigned long *hlow,
> +                                             unsigned long *hhigh)
> +{
> +#if TARGET_LONG_BITS == HOST_LONG_BITS
> +        *hlow = tlow;
> +        *hhigh = thigh;
> +#elif TARGET_LONG_BITS < HOST_LONG_BITS
> +        *hlow = tlow | (unsigned long)thigh << TARGET_LONG_BITS;
> +        *hhigh = 0;
> +#else
> +        *hlow = (unsigned long)tlow;
> +        *hhigh = (unsigned long)(tlow >> HOST_LONG_BITS);
> +#endif

It might still be worth a check for HOST_LONG_BITS >= 2 * TARGET_LONG_BITS and
#error otherwise.  Or explicit checks vs 32 & 64 if you like.


r~
