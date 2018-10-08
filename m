Received: from eggs.gnu.org ([2001:4830:134:3::10]:50744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9Kys-0001T6-Cn
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9Kyn-00049Z-ST
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:09:10 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9Kyn-00049L-Lf
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:09:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id v133-v6so7119699pgb.2
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 19:09:05 -0700 (PDT)
References: <20181006214508.5331-1-cota@braap.org>
	<20181006214508.5331-3-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4dc1591e-adc9-eaaa-deea-07fd7f3470a4@linaro.org>
Date: Sun, 7 Oct 2018 19:09:01 -0700
MIME-Version: 1.0
In-Reply-To: <20181006214508.5331-3-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 2/6] cputlb: do not evict invalid entries to
 the vtlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/6/18 2:45 PM, Emilio G. Cota wrote:
> Currently we evict an entry to the victim TLB when it doesn't match
> the current address. But it could be that there's no match because
> the current entry is invalid. Do not evict the entry to the vtlb
> in that case.
> 
> This change will help us keep track of the TLB's use rate.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/exec/cpu-all.h | 14 ++++++++++++++
>  accel/tcg/cputlb.c     |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 117d2fbbca..d938dedafc 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -362,6 +362,20 @@ static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
>      return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
>  }
>  
> +/**
> + * tlb_is_valid - return true if at least one of the addresses is valid
> + * @te: pointer to CPUTLBEntry
> + *
> + * This is useful when we don't have a particular address to compare against,
> + * and we just want to know whether any entry holds valid data.
> + */
> +static inline bool tlb_is_valid(const CPUTLBEntry *te)
> +{
> +    return !(te->addr_read & TLB_INVALID_MASK) ||
> +           !(te->addr_write & TLB_INVALID_MASK) ||
> +           !(te->addr_code & TLB_INVALID_MASK);
> +}

No, I think you misunderstand.

First, TLB_INVALID_MASK is only ever set for addr_write, in response to
PAGE_WRITE_INV.  Second, an entry that is invalid for write is still valid for
read+exec.  So there is benefit to swapping it out to the victim cache.

This is used by the s390x target to make the "lowpage" read-only, which is a
special architected 512 byte range within pages 0 and 1.  This is done by
forcing writes, but not reads, back through tlb_fill.


r~
