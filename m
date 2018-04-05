Received: from eggs.gnu.org ([2001:4830:134:3::10]:54200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f3vlW-0000OQ-Tj
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 23:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f3vlV-00056G-Vo
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 23:40:46 -0400
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:36382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f3vlV-00054y-OU
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 23:40:45 -0400
Received: by mail-pl0-x229.google.com with SMTP id 91-v6so17294203pld.3
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 20:40:45 -0700 (PDT)
References: <20180405013321.3129-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2ecf3678-6f4e-4683-b439-40e62ded2ae5@linaro.org>
Date: Thu, 5 Apr 2018 13:40:37 +1000
MIME-Version: 1.0
In-Reply-To: <20180405013321.3129-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix preadv/pwritev offsets
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

On 04/05/2018 11:33 AM, Max Filippov wrote:
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
> +        *hhigh = (unsigned long)(thigh >> HOST_LONG_BITS);
> +#endif

This third clause does not look right.

It might have been thigh >> HOST_LONG_BITS, which is good for the specific
cases (32, 64) that we will always have.  But you'd certainly want to not
pretend otherwise by only checking relative sizes.


r~
