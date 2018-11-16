Received: from eggs.gnu.org ([2001:4830:134:3::10]:34580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZGD-00087n-4f
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZG9-0004a0-Us
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:13:53 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZG9-0004Wu-Nv
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:13:49 -0500
Received: by mail-wr1-x42c.google.com with SMTP id l9so10999723wrt.13
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 00:13:42 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<1d5f88588063393fe28b689ce9501715022052ed.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <922cee1e-1f34-d351-75f1-b171b7ef4576@linaro.org>
Date: Fri, 16 Nov 2018 09:13:38 +0100
MIME-Version: 1.0
In-Reply-To: <1d5f88588063393fe28b689ce9501715022052ed.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 08/23] riscv: tcg-target: Add support for
 the constraints
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
> +    case 'L':
> +        /* qemu_ld/qemu_st constraint */
> +        ct->ct |= TCG_CT_REG;
> +        ct->u.regs = 0xffffffff;
> +        /* qemu_ld/qemu_st uses TCG_REG_TMP0 */
> +#if defined(CONFIG_SOFTMMU)
> +        /* tcg_out_tlb_load uses TCG_REG_TMP0/TMP1 and TCG_REG_L0/L1 */
> +        /* tcg_regset_reset_reg(ct->u.regs, TCG_REG_TMP0); */
> +        /* tcg_regset_reset_reg(ct->u.regs, TCG_REG_TMP1); */
> +        tcg_regset_reset_reg(ct->u.regs, TCG_REG_TMP2);

Normally TMP registers are reserved and do not need to be mentioned in
constraints at all.

> +    if ((ct & TCG_CT_CONST_S12) && val >= -2048 && val <= 2047) {
> +        return 1;
> +    }
> +    if ((ct & TCG_CT_CONST_N12) && val >= -2047 && val <= 2048) {
> +        return 1;
> +    }

Clearer as val == sextracttl(val, 0, 12)
and -val == sextracttl(-val, 0, 12)?


r~
