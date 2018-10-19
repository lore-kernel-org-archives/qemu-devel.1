Received: from eggs.gnu.org ([2001:4830:134:3::10]:43943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDWhh-0000DJ-Ox
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDWhd-00073k-QS
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:28:45 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:54340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDWhd-00070x-Gl
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:28:41 -0400
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-17-kbastian@mail.uni-paderborn.de>
	<ed4c028f-12b8-d940-c4ce-49b59c36a06e@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <86d7b325-80e1-1783-fb9b-b2071f1795cc@mail.uni-paderborn.de>
Date: Fri, 19 Oct 2018 17:28:38 +0200
MIME-Version: 1.0
In-Reply-To: <ed4c028f-12b8-d940-c4ce-49b59c36a06e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH 16/28] target/riscv: Convert quadrant 1 of
 RVXC insns to decodetree
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


On 10/13/18 8:53 PM, Richard Henderson wrote:
> On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
>> +static bool trans_c_addi(DisasContext *ctx, arg_c_addi *a, uint16_t insn)
>> +{
>> +    if (a->imm == 0) {
>> +        return true;
>> +    }
> return false, I think.


Those are HINTS, which means the instruction in valid, but does not 
affect state, so true is correct. If I do return false, then Linux does 
not boot anymore :)


>
>> +    arg_jal arg = { .rd = 1, .imm = a->imm };
>> +    return trans_jal(ctx, &arg, insn);
>> +#else
>> +    /* C.ADDIW */
>> +    arg_addiw arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
>> +    return trans_addiw(ctx, &arg, insn);
>> +#endif
>> +}
>> +
>> +static bool trans_c_li(DisasContext *ctx, arg_c_li *a, uint16_t insn)
>> +{
>> +    if (a->rd == 0) {
>> +        return true;
>> +    }
> return false.


Likewise.


>
>> +static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a,
>> +        uint16_t insn)
>> +{
>> +    if (a->rd == 2) {
>> +        /* C.ADDI16SP */
>> +        arg_addi arg = { .rd = 2, .rs1 = 2, .imm = a->imm_addi16sp };
>> +        return trans_addi(ctx, &arg, insn);
>> +    } else if (a->imm_lui != 0) {
>> +        if (a->rd == 0) {
>> +            return true;
>> +        }
> I think it should be
>
>    } else if (a->imm_lui != 0 && a->rd != 0) {

Likewise.


Cheers,

Bastian
