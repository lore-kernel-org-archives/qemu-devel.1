Received: from eggs.gnu.org ([2001:4830:134:3::10]:57997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIGWU-0005m5-Hc
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIGWT-0004jl-3c
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:40:30 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:45014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIGWS-0004jD-VF
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:40:29 -0400
Received: by mail-ot0-x244.google.com with SMTP id g7-v6so15030110otj.11
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 09:40:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504171540.25813-14-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
	<20180504171540.25813-14-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 17:40:07 +0100
Message-ID: <CAFEAcA9d0cHfO4+9BcrA=rgmcQpP86c9obGVEAHFp1cSj5Wj5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 13/24] hw/arm/smmu-common: VMSAv8-64 page
 table walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 4 May 2018 at 18:15, Peter Maydell <peter.maydell@linaro.org> wrote:
> From: Eric Auger <eric.auger@redhat.com>
>
> This patch implements the page table walk for VMSAv8-64.

Hi Eric;

> + * get_block_pte_address - return block descriptor output address and block size
> + * ARM ARM Figure D4-16 VMSAv8-64 level0, level1, and level 2 descriptor formats
> + */
> +static inline hwaddr get_block_pte_address(uint64_t pte, int level,
> +                                           int granule_sz, uint64_t *bsz)
> +{
> +    int n = (granule_sz - 3) * (4 - level) + 3;
> +
> +    *bsz = 1 << n;

Coverity (CID 1391010) points out that this can overflow if n > 31,
because it's only doing 32-bit arithmetic.
I think this is possible for some page table formats, so using
"1ULL" rather than "1" should make coverity happy.

Incidentally, isn't
   int n = (granule_sz - 3) * (4 - level) + 3;
equivalent to
   int n = level_shift(level, granule_sz);
?

> +    return PTE_ADDRESS(pte, n);
> +}

thanks
-- PMM
