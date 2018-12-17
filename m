Received: from eggs.gnu.org ([2001:4830:134:3::10]:60490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gZ1a8-0004xc-Oj
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gZ1a3-0004O0-OE
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:41:48 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gZ1a0-0004Jo-1h
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:41:43 -0500
Date: Mon, 17 Dec 2018 17:41:33 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181217224133.GA17293@flamenco>
References: <20181214174233.18027-1-cota@braap.org>
	<20181214174233.18027-3-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214174233.18027-3-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] tcg: introduce dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Fri, Dec 14, 2018 at 12:42:32 -0500, Emilio G. Cota wrote:
> +static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
> +{
> +    CPUTLBDesc *desc = &env->tlb_d[mmu_idx];
> +    size_t old_size = tlb_n_entries(env, mmu_idx);
> +    size_t rate;
> +    size_t new_size = old_size;
(snip)
> +    if (desc->n_used_entries > desc->window.max_entries) {
> +        desc->window.max_entries = desc->n_used_entries;
> +    }
> +    rate = desc->window.max_entries * 100 / old_size;
> +
> +    if (rate == 100) {
> +        new_size = MIN(old_size << 2, 1 << CPU_TLB_DYN_MAX_BITS);
> +    } else if (rate > 70) {
> +        new_size = MIN(old_size << 1, 1 << CPU_TLB_DYN_MAX_BITS);

I won't resend a v6 until v5 gets any comments, but I just
want to point out that after doing some more benchmarking,
quadrupling the size here is unnecessary; in fact, perf is 1% better
on average if we just double the TLB size when rate > 70.

		Emilio
