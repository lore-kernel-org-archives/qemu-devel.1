Received: from eggs.gnu.org ([2001:4830:134:3::10]:55914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS5dd-0006fT-Un
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS5da-00078s-Oc
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:36:45 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:44833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gS5da-00077S-IP
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:36:42 -0500
Received: by mail-pl1-x62a.google.com with SMTP id k8so7225179pls.11
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 11:36:42 -0800 (PST)
References: <cover.1543352682.git.alistair.francis@wdc.com>
	<0ee380a9ce2d7290523b5d06597c74ea14ff4174.1543352682.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d9994150-7232-638a-3519-830544604cac@linaro.org>
Date: Wed, 28 Nov 2018 11:36:38 -0800
MIME-Version: 1.0
In-Reply-To: <0ee380a9ce2d7290523b5d06597c74ea14ff4174.1543352682.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 08/24] riscv: tcg-target: Add the
 immediate encoders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 11/27/18 1:07 PM, Alistair Francis wrote:
> +void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
> +                              uintptr_t addr)
> +{
> +    intptr_t offset = (intptr_t)addr - (intptr_t)jmp_addr;
> +    tcg_debug_assert(offset == (int32_t)offset);
> +
> +    int32_t hi20 = ((offset + 0x800) >> 12) << 12;
> +    int32_t lo12 = offset - hi20;
> +
> +    atomic_set((uint32_t *)jmp_addr, encode_uimm20(hi20));
> +    atomic_set((uint32_t *)jmp_addr + 4, encode_imm12(lo12));
> +
> +    flush_icache_range(jmp_addr, jmp_addr + 8);
> +}

Two atomic_sets do not help.  You want a single 64-bit atomic_set updating both
insns simultaneously.  But since you're currently setting

> +#define TCG_TARGET_HAS_direct_jump      0

this code isn't used at all.  Better to simply remove it for now.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
