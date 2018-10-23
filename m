Received: from eggs.gnu.org ([2001:4830:134:3::10]:45222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsKd-0000sL-QO
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsKM-0000K2-4f
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:46:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEsKL-0000JD-GZ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:46:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id t10-v6so695206wrn.10
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 01:46:13 -0700 (PDT)
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-24-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de17314d-0148-0e89-6c31-ae1c59f62b02@linaro.org>
Date: Tue, 23 Oct 2018 09:46:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-24-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/20/18 8:14 AM, Bastian Koppelmann wrote:
>  static bool trans_srli(DisasContext *ctx, arg_srli *a, uint32_t insn)
>  {
> -    gen_arith_imm(ctx, OPC_RISC_SHIFT_RIGHT_I, a->rd, a->rs1, a->shamt);
> +    if (a->rd != 0) {
> +        TCGv t = tcg_temp_new();
> +        gen_get_gpr(t, a->rs1);
> +        tcg_gen_extract_tl(t, t, a->shamt, 64 - a->shamt);

tcg_gen_shri_tl(t, t, a->shamt);

This is a mis-translation of the original code which handled srliw too.
You should be able to see this assert on riscv32.

>  static bool trans_srai(DisasContext *ctx, arg_srai *a, uint32_t insn)
>  {
> -    gen_arith_imm(ctx, OPC_RISC_SHIFT_RIGHT_I, a->rd, a->rs1, a->shamt | 0x400);
> +    if (a->rd != 0) {
> +        TCGv t = tcg_temp_new();
> +        gen_get_gpr(t, a->rs1);
> +        tcg_gen_sextract_tl(t, t, a->shamt, 64 - a->shamt);

Similarly.


r~
