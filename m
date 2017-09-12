Received: from eggs.gnu.org ([2001:4830:134:3::10]:37123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1drlxU-0000eY-I2
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1drlxQ-0004i9-Ey
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:14:36 -0400
Received: from bran.ispras.ru ([83.149.199.196]:39848 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1drlxQ-0004fj-6e
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:14:32 -0400
Received: from [10.10.2.131] (castle.intra.ispras.ru [10.10.2.131])
	by smtp.ispras.ru (Postfix) with ESMTP id 12BDB203D1
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 17:14:29 +0300 (MSK)
Message-ID: <59B7EBC5.9060908@ispras.ru>
Date: Tue, 12 Sep 2017 17:14:29 +0300
From: Sergey Smolov <smolov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] MIPS 'move' insn emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Hello, List!

I run MIPS assembler program on QEMU. The program is just a sample, here 
is the code:

.text
     addiu $8, $zero, 0x7
     move $9, $8
     sll $8, $8, 3
     add $8, $8, $9

The program finishes on QEMU with the following values for registers, 
and it's ok:

$8 - 0x3f
$9 - 0x7

Now I want to implement some logging features for MIPS assembler 
programs. For example, I want to write a record to log every time the 
'move' instruction writes some value to GPR register.

I've the code I probably need to modify in target/mips/translate.c:

[code]

static void gen_logic(DisasContext *ctx, uint32_t opc,
                       int rd, int rs, int rt)
{
...
} else if (rs != 0 && rt == 0) {
             tcg_gen_mov_tl(cpu_gpr[rd], cpu_gpr[rs]);
}

[/code]

I suppose that for my assembler program cpu_gpr[rs] here should contain 
0x7 value at runtime. Is it possible to extract this value somehow? I've 
tried the following constructions:

GET_TCG_I32(cpu_gpr[rs])
((CPUMIPSState *)tcg_ctx.cpu)->active_tc.gpr[rs]

but they do not provide me the correct value. Could you help me in 
solving this problem?

Thanks in advance,
  Sergey Smolov
