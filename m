Received: from eggs.gnu.org ([2001:4830:134:3::10]:56521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9Fh4-00046l-Ob
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 15:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9Fgy-0007nD-1u
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 15:25:49 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:48635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9Fgx-0007mk-O0
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 15:25:47 -0400
Received: by mail-wm0-x22f.google.com with SMTP id p75so18049247wmg.3
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 12:25:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171020214918.18944-1-Andrew.Baumann@microsoft.com>
References: <20171020214918.18944-1-Andrew.Baumann@microsoft.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2017 19:25:25 +0000
Message-ID: <CAFEAcA-bW6CtLTN0omLoL7x7r996rY9BS1MvH4KdfS-2z6g1LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] arm: implement cache/shareability
 attribute bits for PAR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 20 October 2017 at 22:49, Andrew Baumann
<Andrew.Baumann@microsoft.com> wrote:
> On a successful address translation instruction, PAR is supposed to
> contain cacheability and shareability attributes determined by the
> translation. We previously returned 0 for these bits (in line with the
> general strategy of ignoring caches and memory attributes), but some
> guest OSes may depend on them.
>
> This patch collects the attribute bits in the page-table walk, and
> updates PAR with the correct attributes for all LPAE
> translations. Short descriptor formats still return 0 for these bits,
> as in the prior implementation, but now log an unimplemented message.
>
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> ---
> v2:
>  * return attrs via out parameter from get_phys_addr, rather than MemTxAttrs
>  * move MAIR lookup/index inline, since it turned out to be simple
>  * implement attributes for stage 2 translations
>  * combine attributes from stages 1 and 2 when required

Hi. This is looking pretty good, but I have a few comments below,
and we're pretty much at the softfreeze date (KVM Forum last week
meant I didn't get much code review done, unfortunately). Would
you be too sad if this missed 2.11 ?

> Attributes for short PTE formats remain unimplemented; there's a LOG_UNIMP for
> this case, but it's likely to be noisy for guests that trigger it -- do we need
> a one-shot mechanism for the log statement?

I think we should just drop that LOG_UNIMP.

> @@ -8929,6 +8939,28 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>           */
>          txattrs->secure = false;
>      }
> +
> +    if (cacheattrs != NULL) {
> +        if (mmu_idx == ARMMMUIdx_S2NS) {
> +            /* Translate from the 4-bit stage 2 representation of
> +             * memory attributes (without cache-allocation hints) to
> +             * the 8-bit representation of the stage 1 MAIR registers
> +             * (which includes allocation hints).
> +             */
> +            uint8_t memattr = extract32(attrs, 0, 4);
> +            cacheattrs->attrs = (extract32(memattr, 2, 2) << 4)
> +                              | (extract32(memattr, 0, 2) << 2);

Pseudocode S2ConvertAttrsHints() specifies some hint bit defaults
(no-allocate for NC; RW-allocate for WT or WB) -- do we want to
follow that?

> +            cacheattrs->shareability = extract32(attrs, 4, 2);

Are you sure this is the right bit offset for the shareability bits?
I think 4,2 is the S2AP (access) bits, and the SH bits are in 6,2, same
as for stage 1 descriptors.

> +        } else {
> +            /* Index into MAIR registers for cache attributes */
> +            uint8_t attrindx = extract32(attrs, 0, 3);
> +            uint64_t mair = env->cp15.mair_el[regime_el(env, mmu_idx)];
> +            assert(attrindx <= 7);
> +            cacheattrs->attrs = extract64(mair, attrindx * 8, 8);
> +            cacheattrs->shareability = extract32(attrs, 6, 2);
> +        }
> +    }
> +
>      *phys_ptr = descaddr;
>      *page_size_ptr = page_size;
>      return false;
> @@ -9490,6 +9522,89 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
>      return false;
>  }
>
> +/* Combine either inner or outer cacheability attributes for normal
> + * memory, according to table D4-42 of ARM DDI 0487B.b (the ARMv8 ARM).
> + *
> + * NB: only stage 1 includes allocation hints (RW bits), leading to
> + * some asymmetry.
> + */
> +static uint8_t combine_cacheattr_nibble(uint8_t s1, uint8_t s2)
> +{
> +    if (s1 == 4 || s2 == 4) {
> +        /* non-cacheable has precedence */
> +        return 4;
> +    } else if (extract32(s1, 2, 2) == 0 || extract32(s1, 2, 2) == 2) {
> +        /* stage 1 write-through takes precedence */
> +        return s1;
> +    } else if (extract32(s2, 2, 2) == 2) {
> +        /* stage 2 write-through takes precedence */
> +        return s2;
> +    } else { /* write-back */
> +        return s1;
> +    }

The v8A ARM ARM pseudocode CombineS1S2AttrHints() says that the hint
bits always come from s1 regardless of whose attrs won.

(I was hoping you could write this function as something like a
MAX or MIN, but the complexities of the writethrough-transient
encoding and the hint bits mean it doesn't work out.)

> +}
> +
> +/* Combine S1 and S2 cacheability/shareability attributes, per D4.5.4
> + *
> + * @s1:      Attributes from stage 1 walk
> + * @s2:      Attributes from stage 2 walk
> + */
> +static ARMCacheAttrs combine_cacheattrs(ARMCacheAttrs s1, ARMCacheAttrs s2)
> +{
> +    uint8_t s1lo = extract32(s1.attrs, 0, 4), s2lo = extract32(s2.attrs, 0, 4);
> +    uint8_t s1hi = extract32(s1.attrs, 4, 4), s2hi = extract32(s2.attrs, 4, 4);
> +    ARMCacheAttrs ret;
> +
> +    /* Combine shareability attributes (table D4-43) */
> +    if (s1.shareability == 2 || s2.shareability == 2) {
> +        /* if either are outer-shareable, the result is outer-shareable */
> +        ret.shareability = 2;
> +    } else if (s1.shareability == 3 || s2.shareability == 3) {
> +        /* if either are inner-shareable, the result is inner-shareable */
> +        ret.shareability = 3;
> +    } else {
> +        /* both non-shareable */
> +        ret.shareability = 0;
> +    }

You can play bit games with the format here, because
what we're effectively implementing is "whichever is last in
the order '0, 3, 2' wins", which is
   ret.shareability = MIN(s1.shareability ^ 1, s2.shareability ^ 1) ^ 1;
(since the xor with 1 transforms (0,3,2) to (1,2,3) and is self-inverse).
Is that better than the if ladder above? Not entirely sure :-)

> +    /* Combine memory type and cacheability attributes */
> +    if (s1hi == 0 || s2hi == 0) {
> +        /* Device has precedence over normal */
> +        if (s1lo == 0 || s2lo == 0) {
> +            /* nGnRnE has precedence over anything */
> +            ret.attrs = 0;
> +        } else if (s1lo == 4 || s2lo == 4) {
> +            /* non-Reordering has precedence over Reordering */
> +            ret.attrs = 4;  /* nGnRE */
> +        } else if (s1lo == 8 || s2lo == 8) {
> +            /* non-Gathering has precedence over Gathering */
> +            ret.attrs = 8;  /* nGRE */
> +        } else {
> +            ret.attrs = 0xc; /* GRE */
> +        }

Isn't this if-ladder equivalent to just "ret.attrs = MIN(s1lo, s2lo);" ?

> +
> +        /* Any location for which the resultant memory type is any
> +         * type of Device memory is always treated as Outer Shareable.
> +         */
> +        ret.shareability = 2;
> +    } else { /* Normal memory */
> +        /* Outer/inner cacheability combine independently */
> +        ret.attrs = combine_cacheattr_nibble(s1hi, s2hi) << 4
> +                  | combine_cacheattr_nibble(s1lo, s2lo);
> +
> +        if (ret.attrs == 0x44) {
> +            /* Any location for which the resultant memory type is Normal
> +             * Inner Non-cacheable, Outer Non-cacheable is always treated
> +             * as Outer Shareable.
> +             */
> +            ret.shareability = 2;
> +        }
> +    }
> +
> +    return ret;
> +}

thanks
-- PMM
