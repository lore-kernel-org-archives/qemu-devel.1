Received: from eggs.gnu.org ([2001:4830:134:3::10]:60536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDSWR-00030r-RK
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDSWG-0005Qs-CK
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:00:46 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:54916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDSWD-0005LH-FX
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:00:39 -0400
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-5-kbastian@mail.uni-paderborn.de>
	<7cd20102-7198-2755-3ef5-eca7716ac61e@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <da430247-4273-6df4-3629-99140c0995bc@mail.uni-paderborn.de>
Date: Fri, 19 Oct 2018 13:00:33 +0200
MIME-Version: 1.0
In-Reply-To: <7cd20102-7198-2755-3ef5-eca7716ac61e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 04/28] target/riscv: Convert RVXI
 arithmetic insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

Hi Richard,

On 10/12/18 8:46 PM, Richard Henderson wrote:
> On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
>> +static bool trans_andi(DisasContext *ctx, arg_andi *a, uint32_t insn)
>> +{
>> +    gen_arith_imm(ctx, OPC_RISC_ANDI, a->rd, a->rs1, a->imm);
>> +    return true;
>> +}
>> +static bool trans_slli(DisasContext *ctx, arg_slli *a, uint32_t insn)
>> +{
>> +    if (a->rd != 0) {
>> +        TCGv t = tcg_temp_new();
>> +        gen_get_gpr(t, a->rs1);
>> +
>> +        if (a->shamt >= TARGET_LONG_BITS) {
>> +            gen_exception_illegal(ctx);
>> +            return true;
>> +        }
>> +        tcg_gen_shli_tl(t, t, a->shamt);
>> +
>> +        gen_set_gpr(a->rd, t);
>> +        tcg_temp_free(t);
>> +    } /* NOP otherwise */
>> +    return true;
>> +}
> Spacing.  Any reason why trans_slli (and the other shifts) aren't using
> gen_arith_imm as well?


Their opcode is not uniquely defined in instmap.h, just a generic 
OPC_RISC_SHIFT_RIGHT_IW. I guess I can give the opcode as a magic value 
for now.


Cheers,

Bastian
