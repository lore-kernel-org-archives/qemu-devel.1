Received: from eggs.gnu.org ([209.51.188.92]:50965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glVXc-0000hk-Ql
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glVXa-0005Uf-Sd
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:06:48 -0500
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
	<20190118131456.32451-13-kbastian@mail.uni-paderborn.de>
	<8eb4c646-4580-c2f0-653c-55a2350a6309@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <f71b9f43-373c-9715-b34c-b6c2678afe57@mail.uni-paderborn.de>
Date: Mon, 21 Jan 2019 10:06:38 +0100
MIME-Version: 1.0
In-Reply-To: <8eb4c646-4580-c2f0-653c-55a2350a6309@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v4 12/35] target/riscv: Convert RV32F insns
 to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org


On 1/19/19 10:51 PM, Richard Henderson wrote:
> On 1/19/19 12:14 AM, Bastian Koppelmann wrote:
>> +static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
>> +{
>> +    REQUIRE_FPU;
>> +    if (a->rs1 == a->rs2) { /* FNEG */
>> +        tcg_gen_xori_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], INT32_MIN);
>> +    } else {
>> +        TCGv_i64 t0 = tcg_temp_new_i64();
>> +        tcg_gen_not_i64(t0, cpu_fpr[a->rs2]);
>> +        tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
>> +        tcg_temp_free_i64(t0);
>> +    }
>> +    return true;
>> +}
>> +
>> +static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
>> +{
>> +    REQUIRE_FPU;
>> +    if (a->rs1 == a->rs2) { /* FABS */
>> +        tcg_gen_andi_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], ~INT32_MIN);
> Not an issue with this patch set, since you are just moving existing code.
>
> However, while I'm thinking about it:
>
> It just occured to me that these uses of INT32_MIN are not ideal, in that they
> are (signed) -0x80000000 and not 0x0000000080000000ull.
>
> In particular, FNEG will remove the NaN-box of the 32-bit value.
>
> Similarly with the construction of fsgnjn_s wrt not + deposit.  It might be
> better to simply xor the sign bit rather than not the whole 64-bit value.
>
> Have you tried using RISU to compare these sorts of results vs real hardware,
> or spike?


No I haven't run it against spike or real hardware. My tests consist of 
'does fedora still boot without errors' and running the riscv-tests.


Cheers,

Bastian
