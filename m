Received: from eggs.gnu.org ([2001:4830:134:3::10]:44795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9dhr-00007v-AF
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 17:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9dho-0002XD-6k
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 17:36:35 -0400
Received: from mail-pl0-x232.google.com ([2607:f8b0:400e:c01::232]:46801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9dho-0002Wy-0s
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 17:36:32 -0400
Received: by mail-pl0-x232.google.com with SMTP id 59-v6so5911655plc.13
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 14:36:31 -0700 (PDT)
References: <20180420155045.18862-1-alex.bennee@linaro.org>
	<20180420155045.18862-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de6303ae-5bcf-75bc-0078-7985bbcecd8b@linaro.org>
Date: Fri, 20 Apr 2018 11:36:26 -1000
MIME-Version: 1.0
In-Reply-To: <20180420155045.18862-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] accel/tcg: convert 4/8 byte access
 and remove softmmu_template
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 04/20/2018 05:50 AM, Alex Bennée wrote:
> +tcg_target_ulong __attribute__((flatten)) helper_le_ldq_mmu(CPUArchState *env,
> +                                                            target_ulong addr,
> +                                                            TCGMemOpIdx oi,
> +                                                            uintptr_t retaddr)
> +{
> +    return load_helper(env, addr, 8, false, false, oi, retaddr);
> +}

This doesn't work for 32-bit host.

You really do have to mind the block comment that you copied and use uint64_t,
both in load_helper and as the return value here.

> +#ifdef TARGET_WORDS_BIGENDIAN
> +#define NEED_BE_BSWAP 0
> +#define NEED_LE_BSWAP 1
> +#else
> +#define NEED_BE_BSWAP 1
> +#define NEED_LE_BSWAP 0
> +#endif

Why have two variables for this?


r~
