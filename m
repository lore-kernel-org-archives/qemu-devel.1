Received: from eggs.gnu.org ([2001:4830:134:3::10]:40432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZZk-0007bB-Aq
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZZg-0008Ky-Sx
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:34:04 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:33618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZZe-0008Iw-Vy
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:33:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id f19-v6so445014wmb.0
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 00:33:55 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<1fe9630dd4ad73b8581684cd0ed6d5fa2918390f.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <34cb4780-f35f-9bd5-7980-fae18e3e93dd@linaro.org>
Date: Fri, 16 Nov 2018 09:33:51 +0100
MIME-Version: 1.0
In-Reply-To: <1fe9630dd4ad73b8581684cd0ed6d5fa2918390f.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 11/23] riscv: tcg-target: Add the
 relocation functions
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

On 11/15/18 11:35 PM, Alistair Francis wrote:
> +static void reloc_sbimm12(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
> +{
> +    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
> +    tcg_debug_assert(offset == sextract32(offset, 1, 12) << 1);
> +
> +    code_ptr[0] |= encode_sbimm12(offset);
> +}

FYI, I have an in-flight patch for 4.0 that will make patch_reloc return a bool
for relocation success, which will move these asserts.

http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg02237.html


> +static void reloc_call(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
> +{
> +    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
> +    tcg_debug_assert(offset == (int32_t)offset);
> +
> +    int32_t hi20 = ((offset + 0x800) >> 12) << 12;
> +    int32_t lo12 = offset - hi20;
> +
> +    code_ptr[0] |= encode_uimm20(hi20);
> +    code_ptr[1] |= encode_imm12(lo12);
> +}
> +

This is ok for patching during generation, but it is not ok for
tb_target_set_jmp_target from patch 9.

Will the riscv-32 compiler use a FSTD insn to implement atomic_set for 64-bit?
 If not, you may be just better off using the indirect method.


r~
