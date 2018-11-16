Received: from eggs.gnu.org ([2001:4830:134:3::10]:38200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZSo-0004l3-S4
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZSj-0003mO-O7
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:26:54 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZSa-0003iP-Hn
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:26:42 -0500
Received: by mail-wr1-x436.google.com with SMTP id e3-v6so23943615wrs.5
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 00:26:34 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<2d6d038f9949b5b39feb48e322be881f31a7f4e1.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a5b5dda4-77df-6e28-509f-3a0ab696f390@linaro.org>
Date: Fri, 16 Nov 2018 09:26:30 +0100
MIME-Version: 1.0
In-Reply-To: <2d6d038f9949b5b39feb48e322be881f31a7f4e1.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 09/23] riscv: tcg-target: Add the
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

On 11/15/18 11:35 PM, Alistair Francis wrote:
> +static int32_t encode_simm12(uint32_t imm)
> +{
> +    return ((imm << 20) >> 25) << 25 | ((imm << 27) >> 27) << 7;
> +}

I'm not fond of triple shifts like this, as it makes me count.
I'd be ok with a formulation like

    return ((imm & 0x1f) << 7) | ((imm & 0xfe) << (25 - 5));

but perhaps best as

    uint32_t ret = 0;
    ret = deposit32(ret, imm, 7, 5);
    ret = deposit32(ret, imm >> 5, 25, 7);

Similarly with encode_sbimm12, encode_uimm20 (which is a simple &), encode_ujimm12.


r~
