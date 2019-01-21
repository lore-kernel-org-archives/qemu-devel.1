Received: from eggs.gnu.org ([209.51.188.92]:51191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glVYb-0001GS-Sn
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1glVYY-00061r-2Y
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 04:07:47 -0500
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
	<20190118131456.32451-25-kbastian@mail.uni-paderborn.de>
	<50d95ed2-d8a4-0a05-f67c-0c18b5e87a33@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <037af0d2-b694-bd7d-0762-a6e2845482ac@mail.uni-paderborn.de>
Date: Mon, 21 Jan 2019 10:07:40 +0100
MIME-Version: 1.0
In-Reply-To: <50d95ed2-d8a4-0a05-f67c-0c18b5e87a33@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v4 24/35] target/riscv: Move
 gen_arith_imm() decoding into trans_* functions
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


On 1/20/19 2:24 AM, Richard Henderson wrote:
> On 1/19/19 12:14 AM, Bastian Koppelmann wrote:
>>   static bool trans_slli(DisasContext *ctx, arg_slli *a)
>>   {
>> -    gen_arith_imm(ctx, OPC_RISC_SLLI, a->rd, a->rs1, a->shamt);
>> +    if (a->rd != 0) {
>> +        TCGv t = tcg_temp_new();
>> +        gen_get_gpr(t, a->rs1);
>> +
>> +        if (a->shamt >= TARGET_LONG_BITS) {
>> +            return false;
>> +        }
> I think the shmat test should be first, so that
>
> 	slli	r0, r1, 99
>
> produces SIGILL instead of translating to a nop.


Oh, that is a very good catch. Thanks.


Cheers,

Bastian
