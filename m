Received: from eggs.gnu.org ([2001:4830:134:3::10]:55793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1drmZe-00039u-7v
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1drmZZ-0006Xh-EU
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:54:02 -0400
Received: from bran.ispras.ru ([83.149.199.196]:44195 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1drmZZ-0006XJ-5m
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:53:57 -0400
Message-ID: <59B7F503.8010703@ispras.ru>
Date: Tue, 12 Sep 2017 17:53:55 +0300
From: Sergey Smolov <smolov@ispras.ru>
MIME-Version: 1.0
References: <59B7EBC5.9060908@ispras.ru>
	<CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
In-Reply-To: <CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] MIPS 'move' insn emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


On 12.09.2017 17:32, Peter Maydell wrote:
> On 12 September 2017 at 15:14, Sergey Smolov <smolov@ispras.ru> wrote:
>> I've the code I probably need to modify in target/mips/translate.c:
>>
>> [code]
>>
>> static void gen_logic(DisasContext *ctx, uint32_t opc,
>>                        int rd, int rs, int rt)
>> {
>> ...
>> } else if (rs != 0 && rt == 0) {
>>              tcg_gen_mov_tl(cpu_gpr[rd], cpu_gpr[rs]);
>> }
>>
>> [/code]
>>
>> I suppose that for my assembler program cpu_gpr[rs] here should contain 0x7
>> value at runtime. Is it possible to extract this value somehow? I've tried
>> the following constructions:
>>
>> GET_TCG_I32(cpu_gpr[rs])
>> ((CPUMIPSState *)tcg_ctx.cpu)->active_tc.gpr[rs]
>>
>> but they do not provide me the correct value.
> You can't do this in this bit of the code. The functions in
> translate.c are called at "translate time", when we convert
> MIPS assembly into x86 code to run on the host. At this point
> we don't know what the values in MIPS registers are, because
> we're generating code that will later be run multiple times
> perhaps with different values. The register contents are only
> known later, at "run time".
>
> thanks
> -- PMM

Thank you, Peter.

Generally speaking, is it possible at "run time" to detect write 
accesses to MIPS GPR registers?
If true, which parts of code should I look in?

-- 
Sincerely yours,
Sergey Smolov
