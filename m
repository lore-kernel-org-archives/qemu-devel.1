Received: from eggs.gnu.org ([2001:4830:134:3::10]:49631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS6cv-0006N1-Lb
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS6cp-0002Rk-UU
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:40:05 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:39109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gS6co-0002Po-BR
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:39:59 -0500
Received: by mail-pg1-x533.google.com with SMTP id w6so10017553pgl.6
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 12:39:58 -0800 (PST)
References: <cover.1543352682.git.alistair.francis@wdc.com>
	<287a8dbdfa046fc269b0f238076f25157733c66a.1543352682.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f5b9a911-038f-800d-9a7c-fe2dddbc237b@linaro.org>
Date: Wed, 28 Nov 2018 12:39:54 -0800
MIME-Version: 1.0
In-Reply-To: <287a8dbdfa046fc269b0f238076f25157733c66a.1543352682.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 24/24] WIP: Try to patch longer branches
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

On 11/27/18 1:10 PM, Alistair Francis wrote:
> +        if (short_jmp) {
> +            reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
> +        } else {
> +            /* Invert the condition */
> +            insn = insn ^ (1 << 12);
> +            /* Clear the offset */
> +            insn &= 0xFFF;
> +            /* Set the offset to the PC + 8 */
> +            insn |= ((unsigned int)(code_ptr + 8)) << 12;

This isn't a pc-relative value you're storing.

    reloc_sbimm12(code_ptr, code_ptr + 2);

> +            /* Overwrite the NOP with jal x0,value */
> +            insn = encode_uj(OPC_JAL, TCG_REG_ZERO, value);

This isn't pc-relative either.  Perhaps best as

    code_ptr[1] = encode_uj(OPC_JAL, TCG_REG_ZERO, 0);
    reloc_jimm20(code_ptr + 1, (tcg_insn_unit *)value);


r~
