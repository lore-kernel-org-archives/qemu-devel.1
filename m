Received: from eggs.gnu.org ([2001:4830:134:3::10]:51976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhdb-0004i5-4N
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:10:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhda-0006eG-3Z
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:10:34 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNhdZ-0006St-DF
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:10:33 -0500
Received: by mail-oi1-x244.google.com with SMTP id 192-v6so20219182oii.6
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:10:22 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<ccb312eb986d846b1b0aa0be062833e5ae1bb5f4.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <687076b9-a5ca-2821-3e24-8b08363f1b5c@linaro.org>
Date: Fri, 16 Nov 2018 18:10:12 +0100
MIME-Version: 1.0
In-Reply-To: <ccb312eb986d846b1b0aa0be062833e5ae1bb5f4.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 17/23] riscv: tcg-target: Add direct load
 and store instructions
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

On 11/15/18 11:36 PM, Alistair Francis wrote:
> +    tcg_out_opc_reg(s, OPC_ADD, base, TCG_GUEST_BASE_REG, addr_regl);

Should avoid this when guest_base == 0, which happens fairly regularly for a
64-bit guest.

> +        /* Prefer to load from offset 0 first, but allow for overlap.  */
> +        if (TCG_TARGET_REG_BITS == 64) {
> +            tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
> +        } else {
> +            tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
> +            tcg_out_opc_imm(s, OPC_LW, hi, base, 4);
> +        }

Comment sounds like two lines of code that's missing.

> +    const TCGMemOp bswap = opc & MO_BSWAP;
> +
> +    /* TODO: Handle byte swapping */

Should assert rather than emit bad code.

I do still plan to change tcg to allow backends to *not* handle byte swapping
if they don't want.  This will make the i386 and arm32 backends less icky.


r~
