Received: from eggs.gnu.org ([209.51.188.92]:41563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1tjF-0008CU-3H
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1tjE-0001px-Gu
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:10:33 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:39118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1tjE-0001os-5d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:10:32 -0500
Received: by mail-pg1-x52c.google.com with SMTP id h8so11347226pgp.6
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 06:10:31 -0800 (PST)
References: <20190307121539.12842-1-david@redhat.com>
	<20190307121539.12842-28-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6caab30c-42bb-1eae-4f6b-577505764b8f@linaro.org>
Date: Thu, 7 Mar 2019 06:10:27 -0800
MIME-Version: 1.0
In-Reply-To: <20190307121539.12842-28-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 27/32] s390x/tcg: Provide
 probe_write_access helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 3/7/19 4:15 AM, David Hildenbrand wrote:
> +void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
> +                        uintptr_t ra)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    if (!h2g_valid(addr) || !h2g_valid(addr + len - 1)) {
> +        s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
> +    }

You need

  || page_check_range(addr, len, PAGE_WRITE) < 0

as well.


r~
