Received: from eggs.gnu.org ([2001:4830:134:3::10]:47970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@git.antfield.fr>) id 1d45SV-0005OE-Bg
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@git.antfield.fr>) id 1d45SU-0001Fi-Fs
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:57:15 -0400
From: Luc MICHEL <luc.michel@git.antfield.fr>
Date: Fri, 28 Apr 2017 14:56:31 +0200
Message-Id: <20170428125632.5704-1-luc.michel@git.antfield.fr>
Subject: [Qemu-devel] [PATCH 0/1] target/arm: add data cache invalidation
 cp15 instruction to cortex-r5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc MICHEL <luc.michel@git.antfield.fr>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-trivial@nongnu.org

This patch adds the cp15, CRn=15, opc1=0, CRm=5, opc2=0 coprocessor instruction
to the cortex-r5. As stated in the TRM, this instruction invalidates all the
data cache. This trivial patch implements it as NOP as cache operations are not
implemented in QEMU.

The documentation is here:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0460d/Bgbdbdjc.html

Tested using this minimal program:
 .global _start
 
 .section .text
 _start:
   mcr p15, 0, r1, c15, c5, 0
 
 idle:
   wfi
   b idle

Before implementation:
 IN: 
 0x00008000:  ee0f1f15      mcr 15, 0, r1, cr15, cr5, {0}

 Taking exception 1 [Undefined Instruction]
 ...from EL1 to EL1
 ...with ESR 0x0/0x2000000

After implementation:
 IN: 
 0x00008000:  ee0f1f15      mcr 15, 0, r1, cr15, cr5, {0}
 0x00008004:  e320f003      wfi

Luc MICHEL (1):
  target/arm: add data cache invalidation cp15 instruction to cortex-r5

 target/arm/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.12.2
