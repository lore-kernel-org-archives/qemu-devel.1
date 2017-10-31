Received: from eggs.gnu.org ([2001:4830:134:3::10]:35507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9Wbk-0000OM-DO
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9Wbj-0001is-BE
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:29:32 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:47744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9Wbj-0001hM-3x
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 09:29:31 -0400
Received: by mail-wr0-x242.google.com with SMTP id y39so15968304wrd.4
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 06:29:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171031130223.220-1-Andrew.Baumann@microsoft.com>
References: <20171031130223.220-1-Andrew.Baumann@microsoft.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 13:29:09 +0000
Message-ID: <CAFEAcA9a0rK+ByrNskT6jajaLG1PKFk0RQzxNs_-Hd61zN96ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] arm: implement cache/shareability
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

On 31 October 2017 at 13:02, Andrew Baumann
<Andrew.Baumann@microsoft.com> wrote:
> On a successful address translation instruction, PAR is supposed to
> contain cacheability and shareability attributes determined by the
> translation. We previously returned 0 for these bits (in line with the
> general strategy of ignoring caches and memory attributes), but some
> guest OSes may depend on them.
>
> This patch collects the attribute bits in the page-table walk, and
> updates PAR with the correct attributes for all LPAE translations.
> Short descriptor formats still return 0 for these bits, as in the
> prior implementation.
>
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> ---
> v2:
>  * return attrs via out parameter from get_phys_addr, rather than MemTxAttrs
>  * move MAIR lookup/index inline, since it turned out to be simple
>  * implement attributes for stage 2 translations
>  * combine attributes from stages 1 and 2 when required
>
> v3:
>  * implement S2 allocation hints and check for cache-disabled
>  * fix stage 2 shareability bits
>  * fix combined allocation hints (always use stage 1 hints)
>  * remove LOG_UNIMP message
>
> There's unfortunately one new wrinkle in this revision: the spec for
> S2ConvertAttrsHints() calls S2CacheDisabled() and returns non-cached if the
> cache is disabled. I assumed that we ought to emulate this. However, it wasn't
> clear to me what to make of the "if ELUsingAArch32(EL2)" branch -- we have a
> cp15.hcr_el2, but no HCR2 register. I just left a TODO comment, but it's quite
> likely I've missed something.


> +/* Translate from the 4-bit stage 2 representation of
> + * memory attributes (without cache-allocation hints) to
> + * the 8-bit representation of the stage 1 MAIR registers
> + * (which includes allocation hints).
> + *
> + * ref: shared/translation/attrs/S2AttrDecode()
> + *      .../S2ConvertAttrsHints()
> + */
> +static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
> +{
> +    uint8_t hiattr = extract32(s2attrs, 2, 2);
> +    uint8_t loattr = extract32(s2attrs, 0, 2);
> +    uint8_t hihint = 0, lohint = 0;
> +
> +    if (hiattr != 0) { /* normal memory */
> +        /* TODO: to faithfully emulate S2CacheDisabled() for the case
> +         * when EL2 is aarch32, we should check HCR2 (not HCR_EL2), but
> +         * qemu doesn't presently model this register.
> +         */

We don't currently implement HCR2, but when we do it will be
in the top 32 bits of cp15.hcr_el2, because that's where
it's architecturally mapped. So the bit to be checked is
in the same place regardless (AArch32 HCR2.ID is bit 1, and
AArch64 HCR_EL2.ID is bit 33, and so on.) This is pretty frequently
true -- it's rare that you need to actually look in a different
place for aarch32 vs aarch64.

Actually checking this bit is a little bit odd for QEMU, because
mostly what we're implementing here is "we report in PAR the attrs
that the page tables say, even if that's not what the implementation
actually does", and "NC if HCR_EL2.CD is 1" is an "affects what
the implementation does" bit of behaviour.

That said, the ARM ARM is a bit vague in this area so following
the pseudocode here is probably safest.

> +        if ((env->cp15.hcr_el2 & HCR_CD) != 0) { /* cache disabled */
> +            hiattr = loattr = 1; /* non-cacheable */
> +        } else {
> +            if (hiattr != 1) { /* Write-through or write-back */
> +                hihint = 3; /* RW allocate */
> +            }
> +            if (loattr != 1) { /* Write-through or write-back */
> +                lohint = 3; /* RW allocate */
> +            }
> +        }
> +    }
> +
> +    return (hiattr << 6) | (hihint << 2) | (loattr << 2) | lohint;
> +}

thanks
-- PMM
