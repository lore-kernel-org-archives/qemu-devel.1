Received: from eggs.gnu.org ([2001:4830:134:3::10]:59867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gFF8y-000495-8g
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gFF8u-0001cD-3P
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:08:00 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:59624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gFF8t-0001a0-Ox
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:07:55 -0400
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-24-kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <eaf7c217-885e-9652-bfde-5e3cfd9e1e18@mail.uni-paderborn.de>
Date: Wed, 24 Oct 2018 11:07:51 +0200
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-24-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v2 23/29] target/riscv: Move
 gen_arith_imm() decoding into trans_* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org


On 10/20/18 9:14 AM, Bastian Koppelmann wrote:
> @@ -338,27 +375,63 @@ static bool trans_and(DisasContext *ctx, arg_and *a, uint32_t insn)
>   
>   static bool trans_addiw(DisasContext *ctx, arg_addiw *a, uint32_t insn)
>   {
> -    gen_arith_imm(ctx, OPC_RISC_ADDIW, a->rd, a->rs1, a->imm);
> -    return true;
> +#ifdef TARGET_RISCV64
> +    bool res = gen_arith_imm(ctx, a, &tcg_gen_add_tl);
> +    tcg_gen_ext32s_tl(cpu_gpr[a->rd], cpu_gpr[a->rd]);


This obviously does not work if a->rd is register zero which is never 
allocated.

Cheers,

Bastian
