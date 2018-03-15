Received: from eggs.gnu.org ([2001:4830:134:3::10]:59981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjraval123@gmail.com>) id 1ewJEq-0008A5-8j
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 23:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjraval123@gmail.com>) id 1ewJEp-0004LE-BZ
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 23:07:32 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:45329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bjraval123@gmail.com>)
	id 1ewJEo-0004Jp-VR
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 23:07:31 -0400
Received: by mail-lf0-x22c.google.com with SMTP id h127-v6so7866501lfg.12
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 20:07:30 -0700 (PDT)
MIME-Version: 1.0
From: Brijen Raval <bjraval123@gmail.com>
Date: Thu, 15 Mar 2018 03:07:17 +0000
Message-ID: <CAGaT8w45tJ32EVj20RFjmG9=WvZBfAuF_j3BgXsFy5ZmPef-Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] ARM64 Interrupt handling on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am booting up a custom kernel on QEMU ARM64, upon completion of its
initial boot up it looks like it enters the arch_idle() state

I enabled the -d int logging to understand what is going on, I see the
following repeated many times continuosly here after

Taking exception 5 [IRQ]
...from EL1 to EL1
...with ESR 0x15/0x56000000
...with ELR 0xffffffff0000349c
...to EL1 PC 0xffffffff00008280 PSTATE 0x3c5

Here's the dissassembly for the relevant piece of code:

 ffffffff00003498 <arch_idle>:
 arch_idle():
 ../../kernel/arch/arm64/arch.cpp:182
 ffffffff00003498:       d503207f        wfi
 ffffffff0000349c:       d65f03c0        ret

I am trying to understand what exceptions are occurring exactly when kernel
is idle (timer?). According to above ELR is pointing to arch_idle(), but I
believe "wfi" instruction would not be an IRQ but a sync abort which is
handle differently right?

Also from ESR, it looks like a SVC instruction but if I am not wrong for
IRQs ESRs are not updated (considered)

One more thing, is there a way in QEMU I could find out what exception 5 is
corresponding to?
