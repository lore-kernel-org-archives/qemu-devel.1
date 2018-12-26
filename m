Received: from eggs.gnu.org ([208.118.235.92]:36154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gc32T-0004N2-Iz
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 01:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gc32P-0003VK-94
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 01:51:33 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gc32O-0003IR-RB
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 01:51:29 -0500
Received: by mail-pf1-x441.google.com with SMTP id g62so7510296pfd.12
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 22:51:14 -0800 (PST)
References: <20181214174233.18027-1-cota@braap.org>
	<20181214174233.18027-3-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <319ebe3d-7035-cf19-013c-114fcef8ccb1@linaro.org>
Date: Wed, 26 Dec 2018 17:51:06 +1100
MIME-Version: 1.0
In-Reply-To: <20181214174233.18027-3-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/3] tcg: introduce dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 12/15/18 4:42 AM, Emilio G. Cota wrote:
> +#if TCG_TARGET_IMPLEMENTS_DYN_TLB
> +#define CPU_TLB_DYN_MIN_BITS 6
> +#define CPU_TLB_DYN_DEFAULT_BITS 8
> +/*
> + * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
> + * 2**34 == 16G of address space. This is roughly what one would expect a
> + * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
> + * Skylake's Level-2 STLB has 16 1G entries.
> + */
> +#define CPU_TLB_DYN_MAX_BITS 22

For 32-bit hosts, we need to limit this to (32 - TARGET_PAGE_BITS) so that we
do not require a double-word shift when implementing the tlb load.  We probably
want to restrict it even further because a 32-bit host may well not have 2**27
bytes of available memory.

For 64-bit hosts, we should limit this to (TARGET_VIRT_ADDR_SPACE_BITS -
TARGET_PAGE_BITS) so that we do not grow the tlb past the guest's address space.

> +    env->tlb_table[mmu_idx] = g_new(CPUTLBEntry, new_size);
> +    env->iotlb[mmu_idx] = g_new(CPUIOTLBEntry, new_size);

For 32-bit hosts, we should probably be prepared for this to fail; see above re
large tlb sizes.  If it fails, we should be able to go back to the previous tlb
size, since we just freed that memory.


r~
